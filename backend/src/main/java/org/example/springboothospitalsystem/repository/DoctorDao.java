package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.Admin;
import org.example.springboothospitalsystem.domain.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository  //数据库
public interface DoctorDao extends JpaRepository<Doctor, Long> {
    Doctor findByAccountAndPassword(String account, String password);

    Doctor findByAccount(String account);

    List<Doctor> findByApproved(int approved);
}
