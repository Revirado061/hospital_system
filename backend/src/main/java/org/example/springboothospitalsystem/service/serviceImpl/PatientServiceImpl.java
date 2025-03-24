package org.example.springboothospitalsystem.service.serviceImpl;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import org.example.springboothospitalsystem.domain.*;
import org.example.springboothospitalsystem.repository.CallInfoDao;
import org.example.springboothospitalsystem.repository.LogDao;
import org.example.springboothospitalsystem.repository.PatientDao;
import org.example.springboothospitalsystem.repository.RegistInfoDao;
import org.example.springboothospitalsystem.service.PatientService;
import org.example.springboothospitalsystem.utils.RedisCacheUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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

    @Autowired
    private RedisCacheUtils redisCacheUtils;

    public PatientServiceImpl(PatientDao patientDao, CallInfoDao callInfoDao, RegistInfoDao registInfoDao, LogDao logDao) {
        this.patientDao = patientDao;
        this.callInfoDao = callInfoDao;
        this.registInfoDao = registInfoDao;
        this.logDao = logDao;
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
        // 从 Redis 缓存中获取 CallInfo 对象
        String key = "callInfo:" + id;
        CallInfo callInfo = (CallInfo) redisCacheUtils.get(key);
        if (callInfo == null) {
            // 如果缓存中没有，从数据库中获取
            callInfo = callInfoDao.findById(id).orElse(null);
            if (callInfo != null) {
                // 更新缓存
                redisCacheUtils.set(key, callInfo, 60, TimeUnit.MINUTES);
            }
        }

        if (callInfo != null && callInfo.getQuantity() > 0) {
            int currentVersion = callInfo.getVersion();
            callInfo.setQuantity(callInfo.getQuantity() - 1);
            callInfo.setVersion(currentVersion + 1);

            // 更新数据库
            int updated = callInfoDao.updateQuantityByVersion(id, callInfo.getQuantity(), currentVersion);
            if (updated > 0) {
                // 更新成功
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

                // 更新缓存
                redisCacheUtils.set(key, callInfo, 60, TimeUnit.MINUTES);
            } else {
                // 更新失败，说明有其他请求已经更新了库存
                throw new RuntimeException("挂号失败，当前号源已被抢完");
            }
        } else {
            throw new RuntimeException("挂号失败，当前号源已被抢完");
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

    @Override
    public int getCallInfoQuantity(Long callInfoId) {
        CallInfo callInfo = callInfoDao.findById(callInfoId).orElse(null);
        return callInfo.getQuantity();
    }
}