package org.example.springboothospitalsystem.service;

import org.example.springboothospitalsystem.domain.Admin;
import org.example.springboothospitalsystem.domain.Doctor;
import org.example.springboothospitalsystem.domain.CallInfo;
import org.example.springboothospitalsystem.domain.Doctor;

import java.util.List;

public interface DoctorService {
    Doctor getInfo(String account);

    Doctor loginService(String account, String password);

    Doctor registService(Doctor doctor);

    void postCallInformation(CallInfo callInfo);

    void deleteCallInformation(Long id);

    List<CallInfo> checkCallInformation(String startDate, String endDate, String account);

    void change(String account, String password, String ID, String name, String address, String phone, int age,
                String sex, String hospital, String department, String title, String speciality);

    /*获取所有待审批的挂号信息*/
    List<CallInfo> getNewCallInfo();

    List<Doctor> getAllDoctor(int choice);

    List<CallInfo> showAllCall(String account);
}
