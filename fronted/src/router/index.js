// 此文件专门负责项目的路由

import VueRouter from "vue-router"

// 引入组件
import Login from '../views/login/Login'
import Register from '../views/register/Register'
import PatientHome from "@/views/home/patientHome.vue";
import DoctorHome from "@/views/home/doctorhome.vue";
import AdiminHome from "@/views/home/adminhome.vue"
import PatientInfo from "@/views/patient/PatientInfo.vue";
import Registration from "@/views/patient/Registration.vue";
import Change from "@/views/doctor/Change.vue";
import DoctorInfo from "@/views/doctor/doctorInfo.vue";
import AdminInfo from "@/views/admin/adminInfo.vue";
import ApprovalInfo from "@/views/admin/ApproalInfo.vue";
import ChangeInfo from "@/views/admin/ChangeInfo.vue";
import CallApproval from  "@/views/admin/CallApproval.vue";
import ChangeDelete from  "@/views/admin/ChangeDelete.vue";
import Try from "@/views/try.vue";
// 创建并暴露一个路由器
export default new VueRouter({
    mode: 'history',    // 路由模式，该模式不会在地址中显示井号#
    routes: [
        {
            path: '/',          // 路径
            redirect: '/login'  // 重定向
        },
        {
            path: '/login',     // 路径
            component: Login    // 跳转到的组件
        },
        {
            path: '/register',     // 路径
            component: Register    // 跳转到的组件
        },
        {
            path:'/try',
            component:Try
        },
        {
            path: '/patienthome',     // 路径
            component: PatientHome,
            meta:{title: '患者首页'},
            redirect:'/patientinfo',
            children:[
                {
                    path:'/patientinfo',
                    meta:{title:'个人信息'},
                    component:PatientInfo
                },
                {
                    path:'/registration',
                    meta:{title:'挂号信息'},
                    component:Registration
                },
            ]// 跳转到的组件
        },
        {
            path:'/adminhome',
            component:AdiminHome,
            meta:{title: '管理员首页'},
            redirect:'/admininfo',
            children:[
                {
                    path:'/admininfo',
                    meta:{title:'个人信息'},
                    component:AdminInfo
                },
                {
                    path:'/approvalinfo',
                    meta:{title:'注册审批'},
                    component:ApprovalInfo
                },
                {
                    path:'/changeinfo',
                    meta:{title:'记录页面'},
                    component:ChangeInfo
                },
                {
                    path:'/callapproval',
                    meta:{title:'出诊审批'},
                    component:CallApproval
                },
                {
                    path:'/changedelete',
                    meta:{title:'修改删除'},
                    component:ChangeDelete
                }
            ]// 跳转到的组件
        },
        {
            path:'/doctorhome',
            component:DoctorHome,
            meta:{title: '医生首页'},
            redirect:'/doctorinfo',
            children:[
                {
                    path:'/doctorinfo',
                    meta:{title:'个人信息'},
                    component:DoctorInfo
                },
                {
                    path:'/change',
                    meta:{title:'修改挂号信息'},
                    component:Change
                },
            ]
        },
    ]
})
