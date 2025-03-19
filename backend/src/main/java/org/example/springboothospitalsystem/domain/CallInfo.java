package org.example.springboothospitalsystem.domain;

import jakarta.persistence.*;
import org.springframework.stereotype.Service;

@Table(name = "call_information")  //说明此实体类对应于数据库的diary表
@Entity  //说明此类是个实体类
@Service
public class CallInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String department;
    private String date;
    private String timeFrame;
    private int quantity;  //挂号数量
    private int approved;  //是否审核通过


    public CallInfo() {
    }

    public CallInfo(Long id, String name, String department, String date, String timeFrame, int quantity, int approved) {
        this.id = id;
        this.name = name;
        this.department = department;
        this.date = date;
        this.timeFrame = timeFrame;
        this.quantity = quantity;
        this.approved = approved;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTimeFrame() {
        return timeFrame;
    }

    public void setTimeFrame(String timeFrame) {
        this.timeFrame = timeFrame;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getApproved() {
        return approved;
    }

    public void setApproved(int approved) {
        this.approved = approved;
    }

}
