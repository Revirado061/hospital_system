package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository  //数据库
public interface AdminDao extends JpaRepository<Admin, Long>{
    Admin findByAccountAndPassword(String account, String password);

    Admin findByAccount(String account);

    List<Admin> findByApproved(int approved);
}

