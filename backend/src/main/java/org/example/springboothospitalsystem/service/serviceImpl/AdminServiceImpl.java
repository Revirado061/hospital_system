package org.example.springboothospitalsystem.service.serviceImpl;

import jakarta.annotation.Resource;
import org.example.springboothospitalsystem.domain.*;
import org.example.springboothospitalsystem.repository.*;
import org.example.springboothospitalsystem.service.AdminService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Resource
    private AdminDao adminDao;
    private DoctorDao doctorDao;
    private PatientDao patientDao;
    private CallInfoDao callInfoDao;
    private LogDao logDao;

    public AdminServiceImpl(AdminDao adminDao, DoctorDao doctorDao, PatientDao patientDao, CallInfoDao callInfoDao, LogDao logDao) {
        this.adminDao = adminDao;
        this.doctorDao = doctorDao;
        this.patientDao = patientDao;
        this.callInfoDao = callInfoDao;
        this.logDao = logDao;
    }

    @Override
    public Admin getInfo(String account) {
        Admin admin = adminDao.findByAccount(account);
        return admin;
    }

    @Override
    public Admin loginService(String account, String password) {
        // 如果账号密码都对则返回登录的用户对象，若有一个错误则返回null
        Admin admin = adminDao.findByAccountAndPassword(account, password);
        // 重要信息置空
        if(admin != null){
            admin.setPassword("");
        }
        return admin;
    }

    @Override
    public Admin registService(Admin admin) {
        if(adminDao.findByAccount(admin.getAccount())!=null) {
            // 无法注册
            return null;
        }
        else {
            Admin newAdmin = adminDao.save(admin);
            if (newAdmin != null) {
                newAdmin.setPassword("");
            }
            return newAdmin;
        }
    }

    /*第一次登录强制改密码*/
    @Override
    public void changeOriginalPassword(String account, String newPassword){
        Admin admin = adminDao.findByAccount(account);
        admin.setPassword(newPassword);
        adminDao.save(admin);
    }

    /*更改管理员账户信息*/
    @Override
    public void change(String account, String password, String ID, String name, String address, String phone){
        Admin admin = adminDao.findByAccount(account);
        admin.setPassword(password);
        admin.setID(ID);
        admin.setName(name);
        admin.setAddress(address);
        admin.setPhone(phone);
        adminDao.save(admin);
        String after = admin.toString();
        Log newLog = new Log("admin", "更改", "管理员", admin.getAccount(), after);
        logDao.save(newLog);
    }

    @Override
    public void delete(String type, String account){
        String after;
        Log newLog;
        switch(type){
            case "admin":
                Admin deleteAdmin = adminDao.findByAccount(account);
                if(deleteAdmin != null){
                    adminDao.delete(deleteAdmin);
                    newLog = new Log("admin", "删除", "管理员", deleteAdmin.getAccount(), null);
                    logDao.save(newLog);
                }
                break;
            case "doctor":
                Doctor deleteDoctor = doctorDao.findByAccount(account);
                if(deleteDoctor != null){
                    doctorDao.delete(deleteDoctor);
                    newLog = new Log("admin", "删除", "医生", deleteDoctor.getAccount(), null);
                    logDao.save(newLog);
                }
                break;
            case "patient":
                Patient deletePatient = patientDao.findByAccount(account);
                if(deletePatient != null){
                    patientDao.delete(deletePatient);
                    newLog = new Log("admin", "删除", "患者", deletePatient.getAccount(), null);
                    logDao.save(newLog);
                }
                break;
        }
    }

    @Override
    public List<Admin> getAllAdmin(int choice){
        return adminDao.findByApproved(choice);
    }

    @Override
    public void checkNewUser(String type, String account, boolean choice){  //审核
        switch(type){
            case "admin":
                Admin checkAdmin = adminDao.findByAccount(account);
                if(choice == false){
                    adminDao.delete(checkAdmin);
                }else{
                    checkAdmin.setApproved(1);
                    adminDao.save(checkAdmin);
                }
                break;
            case "doctor":
                Doctor checkDoctor = doctorDao.findByAccount(account);
                if(choice == false){
                    doctorDao.delete(checkDoctor);
                }else{
                    checkDoctor.setApproved(1);
                    doctorDao.save(checkDoctor);
                }
                break;
            case "patient":
                Patient checkPatient = patientDao.findByAccount(account);
                if(choice == false){
                    patientDao.delete(checkPatient);
                }else{
                    checkPatient.setApproved(1);
                    patientDao.save(checkPatient);
                }
                break;
        }
    }

    @Override
    public void checkCallInformation(Long id, boolean choice){
        CallInfo callInfo = callInfoDao.findById(id).orElse(null);
        if(callInfo != null){
            if(!choice){
                callInfoDao.delete(callInfo);
            }else{
                callInfo.setApproved(1);
                callInfoDao.save(callInfo);
            }
        }
    }

    @Override
    public List<Log> getLog(){
        return logDao.findAll();
    }



}
