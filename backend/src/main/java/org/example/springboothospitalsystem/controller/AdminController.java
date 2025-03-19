package org.example.springboothospitalsystem.controller;

import jakarta.annotation.Resource;
import org.aspectj.weaver.ast.Call;
import org.example.springboothospitalsystem.domain.*;
import org.example.springboothospitalsystem.service.AdminService;
import org.example.springboothospitalsystem.service.DoctorService;
import org.example.springboothospitalsystem.service.PatientService;
import org.example.springboothospitalsystem.utils.Result;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")  //是这个控制器类的基路由
public class AdminController {
    @Resource
    private AdminService adminService;
    @Resource
    private DoctorService doctorService;
    @Resource
    private PatientService patientService;

    @PostMapping("/getInfo")  //获取本账号的基本信息
    public Result<Admin> getInfoController(@RequestParam("account") String account){
        Admin admin = adminService.getInfo(account);
        return new Result<>(admin);
    }

    @PostMapping("/login")
    public Result<Admin> loginController(@RequestParam("account") String account, @RequestParam("password") String password){
        Admin admin = adminService.loginService(account, password);
        if(admin!=null){
            return Result.success(admin,"登录成功！");
        }else{
            return Result.error("123","账号或密码错误！");
        }
    }

    @PostMapping("/register")
    public Result<Admin> registController(@RequestParam("account") String account,
                                          @RequestParam("password") String password){
        Admin newAdmin = new Admin(account, password, null, null, null, null, 0);
        Admin admin = adminService.registService(newAdmin);
        if(admin!=null){
            return Result.success(admin,"注册成功！");
        }else{
            return Result.error("456","用户名已存在！");
        }
    }

    /*管理员第一次登录强制改密码*/
    @RequestMapping("/forcedChange")
    public void forcedChangeController(@RequestParam("account") String account,
                                       @RequestParam("password") String password){
        adminService.changeOriginalPassword(account, password);
    }

    /*删除账户信息*/
    @RequestMapping("/delete")
    public void deleteController(@RequestParam("type") String type,
                                 @RequestParam("account") String account){
        adminService.delete(type, account);
    }

    /*更改管理员账户信息*/
    @RequestMapping("/change")
    public void changeController(@RequestBody Map<String, Object> info){
        String account = (String) info.get("account");
        String password = (String) info.get("password");
        String ID = (String) info.get("ID");
        String name = (String) info.get("name");
        String address = (String) info.get("address");
        String phone = (String) info.get("phone");
        adminService.change(account, password, ID, name, address, phone);
    }

    /*获取所有待审批或审批通过的管理员*/
    @RequestMapping("/getAllAdmin")
    public Result<List> getNewAdminController(@RequestParam("choice") int choice){  //0表示获取未审核的账号，1表示获取审核通过的账号
        List<Admin> list = adminService.getAllAdmin(choice);
        return new Result<>(list);
    }

    /*获取所有待审批或审批通过的医生*/
    @RequestMapping("/getAllDoctor")
    public Result<List> getNewDoctorController(@RequestParam("choice") int choice){
        List<Doctor> list = doctorService.getAllDoctor(choice);
        return new Result<>(list);
    }

    /*获取所有待审批或审批通过的病人*/
    @RequestMapping("/getAllPatient")
    public Result<List> getNewPatientController(@RequestParam("choice") int choice){
        List<Patient> list =  patientService.getAllPatient(choice);
        return new Result<>(list);
    }

    /*获取所有待审批的挂号信息*/
    @RequestMapping("/getNewCallInfo")
    public Result<List> getNewCallInfoController(){
        List<CallInfo> list = doctorService.getNewCallInfo();
        return new Result<>(list);
    }

    /*新用户审批*/
    @RequestMapping("/checkNewUser")
    public void checkNewUserController(@RequestParam("type") String type,
                                       @RequestParam("account") String account,
                                       @RequestParam("choice") boolean choice){
        adminService.checkNewUser(type, account, choice);
    }

    /*出诊信息审批*/
    @RequestMapping("/checkCallInfo")
    public void checkCallInfoController(@RequestParam("id") Long id,
                                        @RequestParam("choice") boolean choice){
        adminService.checkCallInformation(id, choice);
    }

    /*展示修改和删除日志*/
    @RequestMapping("/log")
    public Result<List> showLogController(){
        List<Log> list = adminService.getLog();
        return new Result<>(list);
    }

}
