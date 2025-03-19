package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository  //数据库
public interface PatientDao extends JpaRepository<Patient, Long> {
    Patient findByAccount(String account);

    Patient findByAccountAndPassword(String account, String password);

    List<Patient> findByApproved(int approved);
}