package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.CallInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository  //数据库
public interface CallInfoDao extends JpaRepository<CallInfo, Long> {
    List<CallInfo> findByName(String name);

    CallInfo findByDateAndTimeFrameAndDepartmentAndName(String date, String timeFrame, String department, String name);

    List<CallInfo> findByNameAndDate(String name, String formattedDate);

    List<CallInfo> findByApproved(int approved);

    List<CallInfo> findByDateAndDepartmentAndName(String date, String department, String doctorName);
}