package org.example.springboothospitalsystem.domain;

import jakarta.persistence.*;
import org.springframework.stereotype.Service;

@Table(name = "patient")
@Entity  //说明此类是个实体类
@Service
public class Patient{
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
    private int age;
    private String sex;
    private String record;  //病历

    public Patient() {

    }

    public Patient(String account, String password, String ID, String name, String address, String phone, int approved, int age, String sex, String record) {
        this.account = account;
        this.password = password;
        this.ID = ID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.approved = approved;
        this.age = age;
        this.sex = sex;
        this.record = record;
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

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record;
    }

    @Override
    public String toString() {
        return "account=" + account + " " +
                ", password=" + password + " " +
                ", ID=" + ID + " " +
                ", name=" + name + " " +
                ", address=" + address + " " +
                ", phone=" + phone + " " +
                ", age=" + age + " " +
                ", sex=" + sex + " " +
                ", record=" + record;
    }
}
