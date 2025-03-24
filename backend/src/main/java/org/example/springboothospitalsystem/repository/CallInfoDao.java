package org.example.springboothospitalsystem.repository;

import org.example.springboothospitalsystem.domain.CallInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import java.util.List;

@Repository
public interface CallInfoDao extends JpaRepository<CallInfo, Long> {
    List<CallInfo> findByName(String name);

    CallInfo findByDateAndTimeFrameAndDepartmentAndName(String date, String timeFrame, String department, String name);

    List<CallInfo> findByNameAndDate(String name, String formattedDate);

    List<CallInfo> findByApproved(int approved);

    List<CallInfo> findByDateAndDepartmentAndName(String date, String department, String doctorName);

    @Modifying
    @Query("UPDATE CallInfo c SET c.quantity = :quantity, c.version = :version WHERE c.id = :id AND c.version = :version")
    int updateQuantityByVersion(@Param("id") Long id, @Param("quantity") int quantity, @Param("version") int version);
}