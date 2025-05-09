package org.example.springboothospitalsystem.controller;

import jakarta.annotation.Resource;
import org.example.springboothospitalsystem.domain.*;
import org.example.springboothospitalsystem.service.PatientService;
import org.example.springboothospitalsystem.utils.RedisCacheUtils;
import org.example.springboothospitalsystem.utils.Result;
import org.example.springboothospitalsystem.utils.KafkaProducer;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/patient")  // 是这个控制器类的基路由
public class PatientController {

    @Resource
    private PatientService patientService;
    @Resource
    private RedisCacheUtils redisCacheUtils;
    @Resource
    private KafkaProducer kafkaProducer; // 注入 KafkaProducer

    @PostMapping("/getInfo")  // 获取本账号的基本信息
    public Result<Patient> getInfoController(@RequestParam("account") String account) {
        Patient patient = patientService.getInfo(account);
        return new Result<>(patient);
    }

    @PostMapping("/getMyGuahao")  // 获取本账号挂号信息
    public Result<List> getGuaHaoController(@RequestParam("account") String account) {
        List<RegistInfo> list = patientService.getMyGuahao(account);
        return new Result<>(list);
    }

    @PostMapping("/login")
    public Result<Patient> loginController(@RequestParam("account") String account,
                                           @RequestParam("password") String password) {
        Patient patient = patientService.loginService(account, password);
        if (patient != null) {
            return Result.success(patient, "登录成功！");
        } else {
            return Result.error("123", "账号或密码错误！");
        }
    }

    @PostMapping("/register")
    public Result<Patient> registController(@RequestParam("account") String account,
                                            @RequestParam("password") String password) {
        Patient newPatient = new Patient(account, password, null, null, null, null, 0, 0, null, null);
        Patient patient = patientService.registService(newPatient);
        if (patient != null) {
            return Result.success(patient, "注册成功！");
        } else {
            return Result.error("456", "用户名已存在！");
        }
    }

    /* 修改病人信息 */
    @RequestMapping("/change")
    public void changeController(@RequestBody Map<String, Object> info) {
        String account = (String) info.get("account");
        String password = (String) info.get("password");
        String ID = (String) info.get("ID");
        String name = (String) info.get("name");
        String address = (String) info.get("address");
        String phone = (String) info.get("phone");
        int age = (int) info.get("age");
        String sex = (String) info.get("sex");
        String record = (String) info.get("record");
        patientService.change(account, password, ID, name, address, phone, age, sex, record);
    }

    @RequestMapping("/allCall") // 展示所有 approved == 1 的号源
    public Result<List> allCallController() {
        List<CallInfo> list = patientService.showApprovedCall();
        return new Result<>(list);
    }

    @RequestMapping("/filter") // 筛选挂号信息
    public Result<List> filterController(@RequestParam("date") String date,
                                         @RequestParam("department") String department,
                                         @RequestParam("doctorName") String doctorName) {
        List<CallInfo> list = patientService.callInfoFilter(date, department, doctorName);
        return new Result<>(list);
    }

    @RequestMapping("/guahao") // 挂号
    public Result<Void> guahaoController(@RequestParam("id") Long id,
                                         @RequestParam("account") String account) {
        try {
            // 将挂号请求发送到 Kafka 队列中
            kafkaProducer.send("guahao-topic", id + "," + account);
            return Result.success(null, "挂号请求已发送，正在处理中...");
        } catch (Exception e) {
            return Result.error("500", "挂号请求发送失败：" + e.getMessage());
        }
    }

    /* 展示所有挂号信息 */
    @RequestMapping("/log")
    public Result<List> showLogController() {
        List<RegistInfo> list = patientService.getLog();
        return new Result<>(list);
    }
}