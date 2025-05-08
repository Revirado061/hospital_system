# 医院管理系统

这是一个基于Spring Boot + Vue.js的现代化医院管理系统，旨在提供全面的医院管理解决方案。

## 功能特点

### 用户管理
- 多角色支持：管理员、医生、患者
- 用户注册与审批流程
- 个人信息管理
- 密码修改

### 医生管理
- 医生信息管理
- 科室分配
- 职称管理
- 专长设置
- 出诊信息管理

### 患者管理
- 患者信息管理
- 病历记录
- 预约挂号
- 就诊记录

### 系统管理
- 用户权限控制
- 操作日志记录
- 数据统计分析

## 技术栈

### 后端
- Spring Boot
- MySQL
- MyBatis
- Maven

### 前端
- Vue.js
- Element UI
- Axios
- Vue Router

## 系统要求

- JDK 1.8+
- MySQL 8.0+
- Node.js 12+
- Maven 3.6+

## 安装说明

1. 克隆项目
```bash
git clone [项目地址]
```

2. 数据库配置
- 创建数据库：hospital_system
- 导入数据库脚本：hospital_system.sql

3. 后端配置
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

4. 前端配置
```bash
cd fronted
npm install
npm run serve
```

## 使用说明

1. 访问系统
- 前端地址：http://localhost:8080
- 后端地址：http://localhost:8081

2. 默认账号
- 管理员：admin/222
- 医生：junhuang/98zTNccc7a
- 患者：yantan/q8HUTVmxF4ef

## 项目结构

```
hospital_system/
├── backend/          # 后端项目
│   ├── src/         # 源代码
│   └── pom.xml      # Maven配置
├── fronted/         # 前端项目
│   ├── src/        # 源代码
│   └── package.json # 依赖配置
└── hospital_system.sql # 数据库脚本
```

## 开发团队

- 后端开发：[开发者姓名]
- 前端开发：[开发者姓名]
- 数据库设计：[开发者姓名]

## 许可证

[许可证类型] 