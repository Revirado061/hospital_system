package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.Log;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository  //数据库
public interface LogDao extends JpaRepository<Log, Long> {
}