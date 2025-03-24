package org.example.springboothospitalsystem.service.serviceImpl;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import org.example.springboothospitalsystem.domain.*;
import org.example.springboothospitalsystem.repository.CallInfoDao;
import org.example.springboothospitalsystem.repository.LogDao;
import org.example.springboothospitalsystem.repository.PatientDao;
import org.example.springboothospitalsystem.repository.RegistInfoDao;
import org.example.springboothospitalsystem.service.PatientService;
import org.example.springboothospitalsystem.utils.KafkaConsumer;
import org.example.springboothospitalsystem.utils.KafkaProducer;
import org.example.springboothospitalsystem.utils.RedisCacheUtils;
import org.example.springboothospitalsystem.utils.RedisLockUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.Set;

@Service
public class PatientServiceImpl implements PatientService {
    @Resource
    private PatientDao patientDao;
    @Resource
    private CallInfoDao callInfoDao;
    @Resource
    private RegistInfoDao registInfoDao;
    @Resource
    private LogDao logDao;
    @Resource
    private RedisCacheUtils redisCacheUtils;
    @Resource
    private RedisLockUtils redisLockUtils;
    @Resource
    private KafkaProducer kafkaProducer;

    @Autowired
    public PatientServiceImpl(PatientDao patientDao, CallInfoDao callInfoDao, RegistInfoDao registInfoDao, LogDao logDao, RedisCacheUtils redisCacheUtils, RedisLockUtils redisLockUtils, KafkaProducer kafkaProducer) {
        this.patientDao = patientDao;
        this.callInfoDao = callInfoDao;
        this.registInfoDao = registInfoDao;
        this.logDao = logDao;
        this.redisCacheUtils = redisCacheUtils;
        this.redisLockUtils = redisLockUtils;
        this.kafkaProducer = kafkaProducer;
    }


    @Override
    public Patient getInfo(String account) {
        Patient patient = patientDao.findByAccount(account);
        return patient;
    }

    @Override
    public Patient loginService(String account, String password) {
        Patient patient = patientDao.findByAccountAndPassword(account, password);
        if (patient != null) {
            patient.setPassword("");
        }
        return patient;
    }

    @Override
    public Patient registService(Patient patient) {
        if (patientDao.findByAccount(patient.getAccount()) != null) {
            return null;
        } else {
            Patient newPatient = patientDao.save(patient);
            if (newPatient != null) {
                newPatient.setPassword("");
            }
            return newPatient;
        }
    }

    @Override
    public void change(String account, String password, String ID, String name, String address, String phone,
                       int age, String sex, String record) {
        Patient patient = patientDao.findByAccount(account);
        patient.setPassword(password);
        patient.setID(ID);
        patient.setName(name);
        patient.setAddress(address);
        patient.setPhone(phone);
        patient.setAge(age);
        patient.setSex(sex);
        patient.setRecord(record);
        String after = patient.toString();
        Log newLog = new Log("admin", "更改", "患者", patient.getAccount(), after);
        logDao.save(newLog);
    }

    @Override
    @Transactional
    public void guahao(Long id, String account) {
        String lockKey = "lock:callInfo:" + id; // 锁的键
        String lockValue = UUID.randomUUID().toString(); // 锁的值，用于标识锁的持有者
        try {
            // 尝试获取锁
            if (redisLockUtils.tryLock(lockKey, lockValue, 30, TimeUnit.SECONDS)) {
                CallInfo callInfo = callInfoDao.findById(id).orElse(null);
                if (callInfo != null && callInfo.getQuantity() > 0) {
                    callInfo.setQuantity(callInfo.getQuantity() - 1);
                    callInfoDao.save(callInfo);
                    LocalDateTime today = LocalDateTime.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String registerTime = today.format(formatter);
                    String date = callInfo.getDate();
                    String timeFrame = callInfo.getTimeFrame();
                    String department = callInfo.getDepartment();
                    String patientName = patientDao.findByAccount(account).getName();
                    String doctorName = callInfo.getName();
                    RegistInfo registInfo = new RegistInfo(date, timeFrame, department, patientName, doctorName, registerTime);
                    registInfoDao.save(registInfo);
                    System.out.println("Successfully processed guahao request for id: " + id + " and account: " + account);
                } else {
                    System.err.println("No available slots or callInfo not found for id: " + id);
                }
            } else {
                // 获取锁失败，可以在这里处理重试逻辑或者直接返回错误信息
                System.err.println("Failed to acquire lock for id: " + id);
            }
        } catch (Exception e) {
            System.err.println("Error processing guahao request: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // 释放锁
            redisLockUtils.unlock(lockKey, lockValue);
        }
    }

    @Override
    public List<RegistInfo> getLog() {
        return registInfoDao.findAll();
    }

    @Override
    public List<Patient> getAllPatient(int choice) {
        return patientDao.findByApproved(choice);
    }

    @Override
    public List<RegistInfo> getMyGuahao(String account) {
        String patientName = patientDao.findByAccount(account).getName();
        List<RegistInfo> list = registInfoDao.findByPatientName(patientName);
        return list;
    }

    public List<CallInfo> showApprovedCall() {
        List<CallInfo> list = new ArrayList<>();
        Set<String> keys = redisCacheUtils.keys("callInfo:*");
        if (keys != null) {
            for (String key : keys) {
                CallInfo callInfo = (CallInfo) redisCacheUtils.get(key);
                if (callInfo != null) {
                    list.add(callInfo);
                }
            }
        }
        return list;
    }


    @Override
    public List<CallInfo> callInfoFilter(String date, String department, String doctorName) {
        List<CallInfo> list = callInfoDao.findByDateAndDepartmentAndName(date, department, doctorName);
        List<CallInfo> result = new ArrayList<>();
        for (CallInfo callInfo : list) {
            if (callInfo.getApproved() == 1) {
                result.add(callInfo);
            }
        }
        return result;
    }

    @PostConstruct
    public void init() {
        preheatCache();
    }

    @Override
    public void preheatCache() {
        List<CallInfo> callInfos = callInfoDao.findByApproved(1);
        for (CallInfo callInfo : callInfos) {
            String key = "callInfo:" + callInfo.getId();
            redisCacheUtils.set(key, callInfo, 60, TimeUnit.MINUTES); // 缓存有效期为60分钟
        }
    }
}