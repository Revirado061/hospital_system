package org.example.springboothospitalsystem.service;

import org.example.springboothospitalsystem.domain.CallInfo;
import org.example.springboothospitalsystem.domain.Patient;
import org.example.springboothospitalsystem.domain.RegistInfo;

import java.util.List;

public interface PatientService {

    Patient getInfo(String account);

    Patient loginService(String account, String password);

    Patient registService(Patient patient);

    void change(String account, String password, String ID, String name, String address, String phone,
                int age, String sex, String record);

    /*挂号*/ void guahao(Long id, String account);

    List<RegistInfo> getLog();

    List<Patient> getAllPatient(int choice);

    List<RegistInfo> getMyGuahao(String account);

    List<CallInfo> showApprovedCall();

    List<CallInfo> callInfoFilter(String date, String department, String doctorName);

    void preheatCache();
}
