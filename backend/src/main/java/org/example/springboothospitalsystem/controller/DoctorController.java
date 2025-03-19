package org.example.springboothospitalsystem.controller;

import jakarta.annotation.Resource;
import org.example.springboothospitalsystem.domain.Admin;
import org.example.springboothospitalsystem.domain.Doctor;
import org.example.springboothospitalsystem.domain.CallInfo;
import org.example.springboothospitalsystem.service.DoctorService;
import org.example.springboothospitalsystem.utils.Result;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/doctor")  //是这个控制器类的基路由
public class DoctorController {
    
    @Resource
    private DoctorService doctorService;

    @PostMapping("/getInfo")  //获取本账号的基本信息
    public Result<Doctor> getInfoController(@RequestParam("account") String account){
        Doctor doctor = doctorService.getInfo(account);
        return new Result<>(doctor);
    }

    @PostMapping("/login")
    public Result<Doctor> loginController(@RequestParam("account") String account, @RequestParam("password") String password){
        Doctor doctor = doctorService.loginService(account, password);
        if(doctor!=null){
            return Result.success(doctor,"登录成功！");
        }else{
            return Result.error("123","账号或密码错误！");
        }
    }

    @PostMapping("/register")
    public Result<Doctor> registController(@RequestParam("account") String account, @RequestParam("password") String password){
        Doctor newDoctor = new Doctor(account, password, null, null, null, null, 0, 0, null, null, null, null, null);
        Doctor doctor = doctorService.registService(newDoctor);
        if(doctor!=null){
            return Result.success(doctor,"注册成功！");
        }else{
            return Result.error("456","用户名已存在！");
        }
    }

    /*更改医生账户信息*/
    @RequestMapping("/change")
    public void changeController(@RequestBody Map<String, Object> info){
        String account = (String) info.get("account");
        String password = (String) info.get("password");
        String ID = (String) info.get("ID");
        String name = (String) info.get("name");
        String address = (String) info.get("address");
        String phone = (String) info.get("phone");
        int age = (int) info.get("age");
        String sex = (String) info.get("sex");
        String hospital = (String) info.get("hospital");
        String department = (String) info.get("department");
        String title = (String) info.get("title");
        String speciality = (String) info.get("speciality");
        doctorService.change(account, password, ID, name, address, phone, age, sex, hospital, department, title, speciality);
    }

    @RequestMapping("/post") //发布出诊信息
    public void postController(@RequestParam("name") String name,
                               @RequestParam("department") String department,
                               @RequestParam("date") String date,
                               @RequestParam("timeFrame") String timeFrame,
                               @RequestParam("quantity") int quantity){
        CallInfo callInfo = new CallInfo();
        callInfo.setName(name);
        callInfo.setDepartment(department);
        callInfo.setDate(date);
        callInfo.setTimeFrame(timeFrame);
        callInfo.setQuantity(quantity);
        callInfo.setApproved(0);
        doctorService.postCallInformation(callInfo);
    }

    @RequestMapping("/delete") //删除出诊信息
    public void deleteController(@RequestParam Long id){
        doctorService.deleteCallInformation(id);
    }

    @RequestMapping("/showAllCall") //查看该医生自己的所有出诊信息，包括没审批的
    public Result<List> showAllCallController(@RequestParam("account") String account){
        List<CallInfo> list = doctorService.showAllCall(account);
        return new Result<>(list);
    }

    @RequestMapping("/check") //查看一段时间内的出诊信息
    public Result<List> checkController(@RequestParam("startDate") String startDate,
                                        @RequestParam("endDate") String endDate,
                                        @RequestParam("account") String account){
        List<CallInfo> list = doctorService.checkCallInformation(startDate, endDate, account);
        return new Result<>(list);
    }
}
