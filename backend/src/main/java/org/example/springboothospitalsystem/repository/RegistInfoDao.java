package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.RegistInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository  //数据库
public interface RegistInfoDao extends JpaRepository<RegistInfo, Long> {
    List<RegistInfo> findByPatientName(String patientName);
}
