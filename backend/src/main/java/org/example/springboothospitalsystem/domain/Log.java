package org.example.springboothospitalsystem.domain;

import jakarta.persistence.*;
import org.springframework.stereotype.Service;

@Table(name = "change_log")
@Entity  //说明此类是个实体类
@Service
public class Log {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String modifier;  //更改/删除人
    private String operation_type;  //操作类型
    private String account_type; //被更改者类型
    private String account; //被更改者账号
    private String after_change;  //更改后所有信息

    public Log() {
    }

    public Log(String modifier, String operation_type, String account_type, String account, String after_change) {
        this.modifier = modifier;
        this.operation_type = operation_type;
        this.account_type = account_type;
        this.account = account;
        this.after_change = after_change;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getOperationType() {
        return operation_type;
    }

    public void setOperationType(String operation_type) {
        this.operation_type = operation_type;
    }

    public String getAccountType() {
        return account_type;
    }

    public void setAccountType(String account_type) {
        this.account_type = account_type;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAfterChange() {
        return after_change;
    }

    public void setAfterChange(String after_change) {
        this.after_change = after_change;
    }
}
