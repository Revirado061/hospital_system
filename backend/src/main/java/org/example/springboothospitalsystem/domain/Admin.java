package org.example.springboothospitalsystem.domain;

import jakarta.persistence.*;
import org.springframework.stereotype.Service;

@Table(name = "admin")  //说明此实体类对应于数据库的diary表
@Entity  //说明此类是个实体类
@Service
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long uid;
    private String account;
    private String password;
    private String ID;
    private String name;
    private String address;
    private String phone;
    private int approved;  //是否审核通过

    public Admin() {

    }

    public Admin(String account, String password, String ID, String name, String address, String phone, int approved) {
        this.account = account;
        this.password = password;
        this.ID = ID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.approved = approved;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getApproved() {
        return approved;
    }

    public void setApproved(int approved) {
        this.approved = approved;
    }


    @Override
    public String toString() {
        return "account=" + account + " " +
                ", password=" + password + " " +
                ", ID=" + ID + " " +
                ", name=" + name + " " +
                ", address=" + address + " " +
                ", phone=yon" + phone;
    }
}
