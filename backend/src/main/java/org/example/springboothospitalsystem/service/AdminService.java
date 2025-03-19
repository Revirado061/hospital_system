package org.example.springboothospitalsystem.service;

import org.example.springboothospitalsystem.domain.Admin;
import org.example.springboothospitalsystem.domain.Log;

import java.util.List;

public interface AdminService {
    Admin getInfo(String account);

    Admin loginService(String account, String password);

    Admin registService(Admin admin);

    void changeOriginalPassword(String account, String newPassword);

    /*更改管理员账户信息*/
    void change(String account, String password, String ID, String name, String address, String phone);

    void delete(String type, String account);

    List<Admin> getAllAdmin(int choice);

    void checkNewUser(String type, String account, boolean choice);

    void checkCallInformation(Long id, boolean choice);

    List<Log> getLog();
}
