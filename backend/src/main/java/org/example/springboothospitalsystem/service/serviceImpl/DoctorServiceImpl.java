package org.example.springboothospitalsystem.service.serviceImpl;

import jakarta.annotation.Resource;
import org.example.springboothospitalsystem.domain.Doctor;
import org.example.springboothospitalsystem.domain.CallInfo;
import org.example.springboothospitalsystem.domain.Log;
import org.example.springboothospitalsystem.repository.CallInfoDao;
import org.example.springboothospitalsystem.repository.DoctorDao;
import org.example.springboothospitalsystem.repository.LogDao;
import org.example.springboothospitalsystem.service.DoctorService;
import org.springframework.stereotype.Service;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;

import java.util.ArrayList;
import java.util.List;

@Service
public class DoctorServiceImpl implements DoctorService{
    @Resource
    private DoctorDao doctorDao;
    private CallInfoDao callInfoDao;
    private LogDao logDao;

    public DoctorServiceImpl(DoctorDao doctorDao, CallInfoDao callInfoDao, LogDao logDao) {
        this.doctorDao = doctorDao;
        this.callInfoDao = callInfoDao;
        this.logDao = logDao;
    }

    @Override
    public Doctor getInfo(String account) {
        Doctor doctor = doctorDao.findByAccount(account);
        return doctor;
    }

    @Override
    public Doctor loginService(String account, String password) {
        // 如果账号密码都对则返回登录的用户对象，若有一个错误则返回null
        Doctor doctor = doctorDao.findByAccountAndPassword(account, password);
        // 重要信息置空
        if(doctor != null){
            doctor.setPassword("");
        }
        return doctor;
    }

    @Override
    public Doctor registService(Doctor doctor) {
        if(doctorDao.findByAccount(doctor.getAccount())!=null) {
            // 无法注册
            return null;
        }
        else {
            Doctor newDoctor = doctorDao.save(doctor);
            if (newDoctor != null) {
                newDoctor.setPassword("");
            }
            return newDoctor;
        }
    }
    
    
    /*手动发布出诊信息*/
    @Override
    public void postCallInformation(CallInfo callInfo){
        callInfoDao.save(callInfo);
    }

    @Override
    public void deleteCallInformation(Long id){
        CallInfo callInfo = callInfoDao.findById(id).orElse(null);
        callInfoDao.delete(callInfo);
    }


    @Override
    public List<CallInfo> checkCallInformation(String start, String end, String account){
        List<CallInfo> list = new ArrayList<>();
        Doctor doctor = doctorDao.findByAccount(account);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(start, formatter);
        LocalDate endDate = LocalDate.parse(end, formatter);

        for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
            String formattedDate = date.format(formatter);
            list.addAll(callInfoDao.findByNameAndDate(doctor.getName(), formattedDate));
        }
        return list;
    }

    @Override
    public void change(String account, String password, String ID, String name, String address, String phone, int age,
                       String sex, String hospital, String department, String title, String speciality){
        Doctor doctor = doctorDao.findByAccount(account);
        doctor.setPassword(password);
        doctor.setID(ID);
        doctor.setName(name);
        doctor.setAddress(address);
        doctor.setPhone(phone);
        doctor.setAge(age);
        doctor.setSex(sex);
        doctor.setHospital(hospital);
        doctor.setDepartment(department);
        doctor.setTitle(title);
        doctor.setSpeciality(speciality);
        doctorDao.save(doctor);
        String after = doctor.toString();
        Log newLog = new Log("admin", "更改", "doctor", doctor.getAccount(), after);
        logDao.save(newLog);
    }

    /*获取所有待审批的挂号信息*/
    @Override
    public List<CallInfo> getNewCallInfo() {
        return callInfoDao.findByApproved(0);
    }

    @Override
    public List<Doctor> getAllDoctor(int choice) {
        return doctorDao.findByApproved(choice);
    }

    @Override
    public List<CallInfo> showAllCall(String account) {
        String name = doctorDao.findByAccount(account).getName();
        return callInfoDao.findByName(name);
    }


}
