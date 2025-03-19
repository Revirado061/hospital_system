/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : hospital_system

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 02/07/2024 03:16:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `uid` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住址',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号码',
  `approved` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否审批通过',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '222', '110126199110221212', '管理员', '北京邮电大学', '12512341234', 1);
INSERT INTO `admin` VALUES (2, 'admin02', '111111', '110127199402041318', '管理员01', '北京市海淀区西土城路09号', '13818649727', 1);
INSERT INTO `admin` VALUES (3, 'admin03', '888888', '110126199110089852', '管理员02', '北京市海淀区西土城路09号北京邮电大学家属区', '13518645497', 1);
INSERT INTO `admin` VALUES (4, 'blackjack', '111111', '110126199110089853', 'admin4', '北京市海淀区西土城路09号北京邮电大学家属区', '13518645498', 1);
INSERT INTO `admin` VALUES (6, 'admin111', '123456', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for call_information
-- ----------------------------
DROP TABLE IF EXISTS `call_information`;
CREATE TABLE `call_information`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专家姓名',
  `department` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专家所属部门\r\n',
  `date` date NULL DEFAULT NULL COMMENT '出诊时间',
  `time_frame` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL COMMENT '挂号数量',
  `approved` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否审核通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '出诊信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of call_information
-- ----------------------------
INSERT INTO `call_information` VALUES (1, 'doctor01', '肿瘤科', '2024-07-05', '上午', 41, 1);
INSERT INTO `call_information` VALUES (2, 'doctor01', '肿瘤科', '2024-07-03', '下午', 50, 1);
INSERT INTO `call_information` VALUES (3, 'doctor03', '儿科', '2024-07-05', '上午', 37, 1);
INSERT INTO `call_information` VALUES (4, 'doctor03', '儿科', '2024-07-05', '上午', 33, 1);
INSERT INTO `call_information` VALUES (5, 'doctor05', '耳鼻喉科', '2024-07-03', '下午', 48, 1);
INSERT INTO `call_information` VALUES (6, 'doctor06', '急诊科', '2024-07-04', '下午', 60, 1);
INSERT INTO `call_information` VALUES (7, 'doctor07', '肿瘤科', '2024-07-05', '上午', 50, 1);
INSERT INTO `call_information` VALUES (10, 'doctor09', '口腔科', '2024-07-04', '上午', 47, 1);
INSERT INTO `call_information` VALUES (11, 'doctor11', '精神科', '2024-07-05', '上午', 47, 1);
INSERT INTO `call_information` VALUES (12, 'doctor12', '妇产科', '2024-07-04', '上午', 37, 1);
INSERT INTO `call_information` VALUES (13, 'doctor13', '皮肤科', '2024-07-03', '上午', 31, 1);
INSERT INTO `call_information` VALUES (14, 'doctor14', '肿瘤科', '2024-07-05', '上午', 31, 1);
INSERT INTO `call_information` VALUES (15, 'doctor24', '皮肤科', '2024-07-04', '下午', 43, 1);
INSERT INTO `call_information` VALUES (16, 'doctor16', '妇产科', '2024-07-05', '下午', 54, 1);
INSERT INTO `call_information` VALUES (17, 'doctor17', '急诊科', '2024-07-05', '下午', 38, 1);
INSERT INTO `call_information` VALUES (18, 'doctor18', '康复科', '2024-07-04', '上午', 39, 1);
INSERT INTO `call_information` VALUES (19, 'doctor19', '外科', '2024-07-05', '下午', 41, 1);
INSERT INTO `call_information` VALUES (20, 'doctor20', '感染科', '2024-07-03', '下午', 32, 1);
INSERT INTO `call_information` VALUES (22, 'doctor22', '口腔科', '2024-07-05', '下午', 58, 1);
INSERT INTO `call_information` VALUES (23, 'doctor22', '口腔科', '2024-07-04', '上午', 43, 1);
INSERT INTO `call_information` VALUES (24, 'doctor24', '皮肤科', '2024-07-04', '上午', 45, 1);
INSERT INTO `call_information` VALUES (25, 'doctor25', '口腔科', '2024-07-04', '上午', 42, 0);
INSERT INTO `call_information` VALUES (26, 'doctor26', '肿瘤科', '2024-07-03', '下午', 39, 1);
INSERT INTO `call_information` VALUES (27, 'doctor27', '儿科', '2024-07-04', '上午', 56, 1);
INSERT INTO `call_information` VALUES (28, 'doctor28', '康复科', '2024-07-04', '上午', 38, 1);
INSERT INTO `call_information` VALUES (29, 'doctor29', '妇产科', '2024-07-05', '下午', 43, 1);
INSERT INTO `call_information` VALUES (30, 'doctor30', '感染科', '2024-07-04', '上午', 46, 1);
INSERT INTO `call_information` VALUES (31, 'doctor31', '急诊科', '2024-07-03', '上午', 34, 1);
INSERT INTO `call_information` VALUES (32, 'doctor32', '感染科', '2024-07-04', '下午', 47, 1);
INSERT INTO `call_information` VALUES (33, 'doctor33', '内科', '2024-07-05', '上午', 30, 1);
INSERT INTO `call_information` VALUES (34, 'doctor34', '肿瘤科', '2024-07-03', '上午', 60, 1);
INSERT INTO `call_information` VALUES (35, 'doctor35', '内科', '2024-07-04', '上午', 35, 1);
INSERT INTO `call_information` VALUES (36, 'doctor36', '耳鼻喉科', '2024-07-03', '下午', 41, 1);
INSERT INTO `call_information` VALUES (37, 'doctor37', '康复科', '2024-07-03', '上午', 41, 1);
INSERT INTO `call_information` VALUES (38, 'doctor38', '急诊科', '2024-07-03', '上午', 60, 1);
INSERT INTO `call_information` VALUES (39, 'doctor39', '妇产科', '2024-07-05', '下午', 33, 1);
INSERT INTO `call_information` VALUES (40, 'doctor40', '中医科', '2024-07-03', '上午', 49, 1);
INSERT INTO `call_information` VALUES (41, 'doctor41', '精神科', '2024-07-04', '下午', 32, 1);
INSERT INTO `call_information` VALUES (42, 'doctor42', '内科', '2024-07-03', '上午', 55, 1);
INSERT INTO `call_information` VALUES (43, 'doctor37', '康复科', '2024-07-04', '上午', 35, 1);
INSERT INTO `call_information` VALUES (44, 'doctor44', '口腔科', '2024-07-03', '下午', 34, 1);
INSERT INTO `call_information` VALUES (45, 'doctor45', '外科', '2024-07-04', '下午', 34, 1);
INSERT INTO `call_information` VALUES (46, 'doctor46', '中医科', '2024-07-03', '下午', 56, 1);
INSERT INTO `call_information` VALUES (47, 'doctor46', '中医科', '2024-07-04', '下午', 53, 1);
INSERT INTO `call_information` VALUES (48, 'doctor48', '精神科', '2024-07-04', '上午', 60, 1);
INSERT INTO `call_information` VALUES (49, 'doctor49', '皮肤科', '2024-07-03', '下午', 35, 1);

-- ----------------------------
-- Table structure for change_log
-- ----------------------------
DROP TABLE IF EXISTS `change_log`;
CREATE TABLE `change_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `modifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `operation_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `account_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `after_change` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of change_log
-- ----------------------------
INSERT INTO `change_log` VALUES (2, 'admin', '删除', '医生', 'chaoqiu', 'account=\'chaoqiu , password=\'n4yxhH , ID=\'210404195504207726 , name=\'doctor50 , address=\'北京市东城区陈街y座号 , phone=\'13880924072 , age=53 , sex=\'女 , hospital=\'北京朝阳医院 , department=\'外科 , title=\'研究员 , speciality=\'烧伤外科');
INSERT INTO `change_log` VALUES (3, 'admin', '更改', '管理员', 'admin', 'account=admin , password=222 , ID=110126199110221212 , name=管理员 , address=北京邮电大学 , phone=yon12512341234');

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `uid` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住址',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号码',
  `age` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '年龄',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `hospital` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在医院',
  `department` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '科室',
  `title` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `speciality` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专长',
  `approved` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否审批通过',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医生' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (1, 'junhuang', '98zTNccc7a', '653023199405160790', 'doctor01', '北京市朝阳区汕尾路I座号', '15976356707', 38, '男', '北京积水潭医院', '康复科', '主任医师', '中风康复', 1);
INSERT INTO `doctor` VALUES (2, 'yongcheng', 'aizb44VNV0mMlSv4c', '421000198206295613', 'doctor02', '北京市顺义区江路Z座号', '14544324031', 63, '男', '北京同仁医院', '中医科', '教授', '推拿', 0);
INSERT INTO `doctor` VALUES (3, 'bwen', 'hq6EqSQ_fqKHK', '410900200003045282', 'doctor03', '北京市西城区哈尔滨街Y座号', '15215625429', 47, '男', '北京天坛医院', '放射科', '研究员', 'X光', 1);
INSERT INTO `doctor` VALUES (4, 'guiyingkang', '6rfl1VDtGMTm81tTpSC', '440784197009219359', 'doctor04', '北京市顺义区陈路y座号', '14507721039', 34, '男', '北京同仁医院', '耳鼻喉科', '副教授', '喉部疾病', 1);
INSERT INTO `doctor` VALUES (5, 'ftao', 'G04puCEHKGWoTB1', '610201199901228945', 'doctor05', '北京市怀柔区南宁路z座号', '15929401024', 66, '女', '北京安贞医院', '放射科', '主治医生', 'CT', 1);
INSERT INTO `doctor` VALUES (6, 'yuyan', 'NrkhV_F', '370104199801143470', 'doctor06', '北京市丰台区海门街h座号', '15723782056', 26, '女', '北京大学人民医院', '康复科', '主任医师', '外伤后康复', 1);
INSERT INTO `doctor` VALUES (7, 'xiulanfang', 'i86926ju3M0tM', '21028119870905604X', 'doctor07', '北京市丰台区太原街f座号', '15002709265', 60, '男', '北京大学第三医院', '口腔科', '助理教授', '牙周病', 1);
INSERT INTO `doctor` VALUES (8, 'xiuying96', '3LxZ4Vd', '23040320040508862X', 'doctor08', '北京市延庆区钟路Y座号', '15668173799', 51, '男', '北京协和医院', '肿瘤科', '教授', '癌症康复', 1);
INSERT INTO `doctor` VALUES (9, 'phuang', 'OEGPkexuGfeOy', '330781194408167076', 'doctor09', '北京市延庆区陈街n座号', '13719940675', 54, '男', '北京朝阳医院', '精神科', '研究员', '抑郁症', 1);
INSERT INTO `doctor` VALUES (10, 'duanyang', 'TnjxQ6sVh', '520601197108024470', 'doctor10', '北京市怀柔区戴街F座号', '13665920154', 70, '女', '北京积水潭医院', '内科', '住院医生', '肾内科', 0);
INSERT INTO `doctor` VALUES (11, 'hzhong', 'YWE2ds', '610824194110245698', 'doctor11', '北京市门头沟区郝街s座号', '13934630433', 49, '女', '北京大学人民医院', '外科', '助理教授', '普通外科', 1);
INSERT INTO `doctor` VALUES (12, 'guiying13', 'UchQmo3opXYoy9', '410101197108279534', 'doctor12', '北京市密云区刘街O座号', '13621812910', 69, '女', '北京天坛医院', '肿瘤科', '主治医生', '癌症康复', 1);
INSERT INTO `doctor` VALUES (13, 'minhao', 'vDh6Ap', '440802197108061578', 'doctor13', '北京市通州区昆明路b座号', '18870469182', 57, '男', '北京天坛医院', '口腔科', '教授', '牙周病', 1);
INSERT INTO `doctor` VALUES (14, 'gaolei', '_wtvL7TMmOSljyCEB', '150925197702097996', 'doctor14', '北京市延庆区卢街D座号', '14597614062', 28, '男', '北京大学人民医院', '放射科', '副教授', 'CT', 1);
INSERT INTO `doctor` VALUES (15, 'yan56', '2ilbGmJ68', '41128219680117006X', 'doctor15', '北京市昌平区兰州路h座号', '18519942269', 47, '男', '北京安贞医院', '中医科', '副教授', '中药', 0);
INSERT INTO `doctor` VALUES (16, 'jie87', 'u_zBWNwmpGCZS4', '220282198107225246', 'doctor16', '北京市怀柔区辽阳路Z座号', '18569212656', 45, '女', '北京同仁医院', '口腔科', '研究员', '牙周病', 1);
INSERT INTO `doctor` VALUES (17, 'jingzhong', 'uJJZxaUwU1pfcJ', '610702194704058677', 'doctor17', '北京市密云区巢湖街V座号', '18144238950', 61, '女', '北京大学人民医院', '妇产科', '研究员', '妇科疾病', 1);
INSERT INTO `doctor` VALUES (18, 'lizhong', 'I1V8kem', '371700197212018160', 'doctor18', '北京市海淀区张路Z座号', '18987135772', 50, '男', '北京大学人民医院', '皮肤科', '主任医师', '皮炎', 1);
INSERT INTO `doctor` VALUES (19, 'qchang', '32_41M', '419001193510236457', 'doctor19', '北京市朝阳区单街z座号', '15969826805', 38, '女', '北京大学人民医院', '内科', '主治医生', '血液内科', 1);
INSERT INTO `doctor` VALUES (20, 'xdeng', 'FyR1t8dmnGrGw6ugWA', '141028194908212094', 'doctor20', '北京市延庆区天津路Z座号', '14505460004', 57, '男', '北京大学第三医院', '急诊科', '助理教授', '紧急医疗', 1);
INSERT INTO `doctor` VALUES (21, 'gangxu', 'WqKsRyzZV', '654326200104124886', 'doctor21', '北京市怀柔区何街K座号', '15573261853', 69, '女', '北京大学第三医院', '精神科', '住院医生', '焦虑症', 1);
INSERT INTO `doctor` VALUES (22, 'vyu', '2NrKauZmXk', '52022119851122610X', 'doctor22', '北京市朝阳区重庆街q座号', '13950957852', 33, '女', '北京积水潭医院', '放射科', '主治医生', 'CT', 1);
INSERT INTO `doctor` VALUES (23, 'min23', '6ALS_hiCBQMTz', '370685200507096950', 'doctor23', '北京市西城区罗路O座号', '18273550962', 39, '女', '北京朝阳医院', '放射科', '副主任医师', 'MRI', 0);
INSERT INTO `doctor` VALUES (24, 'ping06', 'WqfXD4', '513424197205195321', 'doctor24', '北京市西城区长沙路W座号', '15548866591', 48, '女', '北京朝阳医院', '耳鼻喉科', '住院医生', '喉部疾病', 1);
INSERT INTO `doctor` VALUES (25, 'minlei', 'vyM809Z5hbCrgXj9', '360401197807144139', 'doctor25', '北京市房山区北京路i座号', '13023736823', 28, '女', '北京朝阳医院', '口腔科', '主任医师', '牙齿种植', 1);
INSERT INTO `doctor` VALUES (26, 'qiangzhu', 'dgg1gWWxZ4wbXSIKV', '120200200005105464', 'doctor26', '北京市延庆区王路O座号', '15593150842', 26, '男', '北京大学第三医院', '皮肤科', '教授', '痤疮', 1);
INSERT INTO `doctor` VALUES (27, 'yqiu', 'KvlW31Pi7e', '420111194610085023', 'doctor27', '北京市密云区张街G座号', '13711231639', 30, '男', '北京同仁医院', '中医科', '住院医生', '中药', 1);
INSERT INTO `doctor` VALUES (28, 'juan92', 'CSnnn6HY1', '370283197208235958', 'doctor28', '北京市房山区香港路K座号', '18920866682', 55, '女', '北京朝阳医院', '眼科', '主治医生', '近视', 1);
INSERT INTO `doctor` VALUES (29, 'taoxia', 'fvoAr2u3GdEF', '340406197206154831', 'doctor29', '北京市平谷区淮安街e座号', '18811033760', 45, '男', '北京大学人民医院', '外科', '研究员', '神经外科', 1);
INSERT INTO `doctor` VALUES (30, 'xiulan29', '74S7yHZoa1N7gV1h', '350481194907013044', 'doctor30', '北京市朝阳区南昌路T座号', '14711436789', 53, '男', '北京天坛医院', '皮肤科', '助理教授', '皮炎', 1);
INSERT INTO `doctor` VALUES (31, 'jing48', 'qVcd6oCvyi_umPY', '469005198304046369', 'doctor31', '北京市石景山区黎街C座号', '18276936614', 33, '女', '北京同仁医院', '放射科', '主任医师', 'CT', 1);
INSERT INTO `doctor` VALUES (32, 'xiongxia', '7vTYuSorgL7kDKk', '511302196412264430', 'doctor32', '北京市怀柔区常街H座号', '18158918899', 58, '男', '北京同仁医院', '眼科', '主任医师', '白内障', 1);
INSERT INTO `doctor` VALUES (33, 'xiuyingtian', 'xzxxxg5ar1n3IDlj', '230407194004162486', 'doctor33', '北京市东城区宜都路T座号', '18749208458', 62, '男', '北京同仁医院', '精神科', '主治医生', '抑郁症', 1);
INSERT INTO `doctor` VALUES (34, 'wmo', 'oqPlJakzXi3bD1zwr', '450109200212304843', 'doctor34', '北京市密云区黄街a座号', '13674157353', 56, '男', '北京大学人民医院', '妇产科', '主治医生', '分娩服务', 1);
INSERT INTO `doctor` VALUES (35, 'pengguiying', 'xqiKAo1mfyUW', '34132219700428094X', 'doctor35', '北京市平谷区柳州街Y座号', '18238407026', 59, '女', '北京协和医院', '中医科', '主治医生', '推拿', 1);
INSERT INTO `doctor` VALUES (36, 'fangwei', 'XdKAVilTF', '220281198512193851', 'doctor36', '北京市房山区宁德街U座号', '13880493264', 30, '男', '北京积水潭医院', '感染科', '副主任医师', '寄生虫感染', 1);
INSERT INTO `doctor` VALUES (37, 'suguiying', 'PK9nMTXp7fJnEMEPk', '610626196612094608', 'doctor37', '北京市房山区广州路a座号', '13580504731', 70, '女', '北京天坛医院', '皮肤科', '主任医师', '皮炎', 1);
INSERT INTO `doctor` VALUES (38, 'zengyan', '798V1', '420921195408012518', 'doctor38', '北京市密云区张家港街k座号', '14770869894', 39, '女', '北京协和医院', '精神科', '副教授', '焦虑症', 1);
INSERT INTO `doctor` VALUES (39, 'yang36', '8pt4itSBahnB0dX', '530323196005318459', 'doctor39', '北京市大兴区王路I座号', '15911315152', 66, '男', '北京大学人民医院', '急诊科', '住院医生', '紧急医疗', 1);
INSERT INTO `doctor` VALUES (40, 'nliang', 'bzsQiOnlH', '36072819760523903X', 'doctor40', '北京市西城区太原街L座号', '15829381502', 56, '男', '北京同仁医院', '感染科', '副主任医师', '细菌感染', 1);
INSERT INTO `doctor` VALUES (41, 'ofang', 't2jrZS', '320312196705145482', 'doctor41', '北京市延庆区李路t座号', '15290991794', 33, '女', '北京同仁医院', '康复科', '副主任医师', '外伤后康复', 1);
INSERT INTO `doctor` VALUES (42, 'tanguiying', 'ySYDMaU87He6', '370829198908047447', 'doctor42', '北京市顺义区卢路r座号', '15043071133', 34, '男', '北京安贞医院', '中医科', '助理教授', '推拿', 1);
INSERT INTO `doctor` VALUES (43, 'yong66', 'eq2HdQIYq44TTs', '430681195010313574', 'doctor43', '北京市门头沟区申路C座号', '15345795096', 50, '女', '北京积水潭医院', '眼科', '副主任医师', '青光眼', 0);
INSERT INTO `doctor` VALUES (44, 'fang02', 'Szs5KJE6citg6ts', '522322199610014223', 'doctor44', '北京市西城区呼和浩特街S座号', '15783811653', 54, '女', '北京大学人民医院', '皮肤科', '研究员', '痤疮', 1);
INSERT INTO `doctor` VALUES (45, 'zwu', 'yO_61mZJtbB8jGD', '451323199904157534', 'doctor45', '北京市东城区邱路R座号', '14586022647', 60, '女', '北京同仁医院', '眼科', '助理教授', '近视', 1);
INSERT INTO `doctor` VALUES (46, 'yan22', 'MDotsOEary2', '431123199601064774', 'doctor46', '北京市东城区东莞路S座号', '13565011874', 33, '男', '北京天坛医院', '康复科', '主任医师', '中风康复', 1);
INSERT INTO `doctor` VALUES (47, 'jiaxiulan', 'TMli5Btl5IwYJhc', '331181197310114082', 'doctor47', '北京市海淀区上海街n座号', '15124972217', 35, '男', '北京天坛医院', '外科', '研究员', '心胸外科', 0);
INSERT INTO `doctor` VALUES (48, 'naxiang', 'kLa45sI', '411000198006196328', 'doctor48', '北京市通州区张路Z座号', '13414515857', 39, '女', '北京同仁医院', '妇产科', '研究员', '分娩服务', 1);
INSERT INTO `doctor` VALUES (49, 'xiulancheng', 'dfFMylxqsQHA', '360124193801079321', 'doctor49', '北京市延庆区沈阳街W座号', '13407631323', 48, '女', '北京大学第三医院', '中医科', '助理教授', '中药', 1);
INSERT INTO `doctor` VALUES (51, 'doctor999', '123456', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for patient
-- ----------------------------
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient`  (
  `uid` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住址',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号码',
  `age` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '年龄',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `record` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '病例',
  `approved` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否审批通过',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '患者' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of patient
-- ----------------------------
INSERT INTO `patient` VALUES (1, 'yantan', 'q8HUTVmxF4ef', '330801199003027063', 'patient1', '北京市大兴区深圳街o座号', '13826804203', 83, '男', '暴食症', 1);
INSERT INTO `patient` VALUES (2, 'ming29', '7PRzGL2a8vOGRowUJySM', '360825195202104728', 'patient2', '北京市房山区江街q座号', '18879746816', 67, '男', '帕金森病', 1);
INSERT INTO `patient` VALUES (3, 'bxue', 'D_lFLSLOmg1frhqlLEp', '370700198211211907', 'patient3', '北京市怀柔区李路O座号', '13436748116', 87, '女', '腱鞘炎', 1);
INSERT INTO `patient` VALUES (4, 'gaoxiulan', '5Wkj0g08QeF9', '522633196806119870', 'patient4', '北京市海淀区海口路h座号', '13539083583', 91, '女', '癫痫', 0);
INSERT INTO `patient` VALUES (5, 'ming18', 'RcOUFx2bC', '220302193906303600', 'patient5', '北京市延庆区史路W座号', '18731891530', 45, '男', '带状疱疹', 1);
INSERT INTO `patient` VALUES (6, 'juan73', 'ZEk4EYkWxiAl6T2A1B', '210103195006054867', 'patient6', '北京市朝阳区赵路v座号', '13396382050', 98, '男', '偏头痛', 0);
INSERT INTO `patient` VALUES (7, 'taosong', 'YRABEW2D1x', '420104194104062079', 'patient7', '北京市密云区拉萨街q座号', '13251282758', 91, '女', '低血压', 1);
INSERT INTO `patient` VALUES (8, 'ojin', 'To0wnjQHpiWAtU6', '330604197607149503', 'patient8', '北京市丰台区张街I座号', '18869135162', 31, '女', '咳嗽', 1);
INSERT INTO `patient` VALUES (9, 'xiangjun', '4Z8LEnkTweIkNHL', '420500197703210846', 'patient9', '北京市密云区王街v座号', '15093787348', 99, '女', '阿尔茨海默病', 0);
INSERT INTO `patient` VALUES (10, 'tao37', '2NQV2D', '320684195205297176', 'patient10', '北京市顺义区张家港路p座号', '18547009357', 63, '女', '牛皮癣', 1);
INSERT INTO `patient` VALUES (11, 'haochao', 'iYmHzmj', '141122195207231403', 'patient11', '北京市门头沟区佛山街S座号', '13687754466', 18, '女', '多发性硬化', 0);
INSERT INTO `patient` VALUES (12, 'lduan', 'cGVSyO', '130924196208172255', 'patient12', '北京市顺义区秦路i座号', '15272481561', 49, '女', '勃起功能障碍', 0);
INSERT INTO `patient` VALUES (13, 'nye', 'Sa7h6m1B23Ut2x39g', '150100194703101649', 'patient13', '北京市海淀区李街c座号', '18858835487', 97, '女', '阿尔茨海默病', 0);
INSERT INTO `patient` VALUES (14, 'jliang', 'JMtKZMFcZv6CvJrZ', '632722194001259262', 'patient14', '北京市昌平区沈路U座号', '18561336894', 52, '男', '结肠炎', 1);
INSERT INTO `patient` VALUES (15, 'guiying02', 'Vjz6QGRk', '211000196010256286', 'patient15', '北京市平谷区拉萨街o座号', '13338711804', 36, '男', '腱鞘炎', 0);
INSERT INTO `patient` VALUES (16, 'yang99', 'V9p_aNOP', '520122194008247846', 'patient16', '北京市平谷区潜江路j座号', '18874932055', 6, '女', '心律失常', 0);
INSERT INTO `patient` VALUES (17, 'hyan', 'MJ1f1TSxxHYSdx1wD', '430501195204109056', 'patient17', '北京市昌平区齐齐哈尔路Z座号', '13644248163', 90, '男', '肺气肿', 0);
INSERT INTO `patient` VALUES (18, 'juan12', '1d9zCDlME', '210321197811068404', 'patient18', '北京市平谷区兴城路J座号', '18666926194', 46, '女', '腮腺炎', 1);
INSERT INTO `patient` VALUES (19, 'mhe', 'ui1RNcXLrGPCJ2', '420113199009252594', 'patient19', '北京市东城区李街w座号', '13717197455', 90, '女', '甲状腺功能减退', 1);
INSERT INTO `patient` VALUES (20, 'jie70', 'zXULe51VE4SfNmom', '35010219990827460X', 'patient20', '北京市顺义区李街m座号', '15936891299', 69, '女', '颈椎病', 1);
INSERT INTO `patient` VALUES (21, 'xiuying95', 'O2CfcWk2fjUf', '220402199101198762', 'patient21', '北京市丰台区黄街s座号', '13721158152', 91, '女', '静脉曲张', 1);
INSERT INTO `patient` VALUES (22, 'pingfu', 'qiz6_VRJguUp', '420801197412027040', 'patient22', '北京市平谷区田路u座号', '15313954674', 80, '男', '乳腺癌', 1);
INSERT INTO `patient` VALUES (23, 'xliang', 'F12dd5RJ', '360902194008236379', 'patient23', '北京市门头沟区宁德街M座号', '15127276195', 45, '女', '糖尿病', 1);
INSERT INTO `patient` VALUES (24, 'cliu', 'Rl3R161n2Sf8ee', '150206200112177379', 'patient24', '北京市东城区陈街x座号', '13619840654', 42, '男', '精神分裂症', 1);
INSERT INTO `patient` VALUES (25, 'jie73', '9Ofs74lS96_O', '210213196310145889', 'patient25', '北京市东城区海门路U座号', '15287930599', 44, '女', '高血压', 1);
INSERT INTO `patient` VALUES (26, 'xyan', 'hExcBlPUKddqS8gf', '410103193610273634', 'patient26', '北京市密云区柳路X座号', '13388935587', 23, '男', '创伤后应激障碍', 0);
INSERT INTO `patient` VALUES (27, 'jie66', 'Q8MhdYL5javYQfWWWWcG', '15252619421030180X', 'patient27', '北京市大兴区佛山街z座号', '13449203799', 53, '女', '鼻窦炎', 1);
INSERT INTO `patient` VALUES (28, 'xiaxiuying', 'JNID7VvDgAat0', '341623196211159972', 'patient28', '北京市海淀区张街p座号', '15292358689', 1, '男', '牛皮癣', 1);
INSERT INTO `patient` VALUES (29, 'lianglei', 'eFlKIX9g3i', '530321197301281963', 'patient29', '北京市延庆区谢街V座号', '18261107452', 73, '男', '胰腺炎', 1);
INSERT INTO `patient` VALUES (30, 'ndai', 'vOFGLOK0qzdG6j24Mi', '321301197604054844', 'patient30', '北京市大兴区甘路j座号', '18121857824', 95, '女', '紧张性头痛', 1);
INSERT INTO `patient` VALUES (31, 'aliang', 'L8jh4w88NsqP1IWI', '130424198707169845', 'patient31', '北京市密云区呼和浩特街X座号', '13536323451', 0, '男', '痛风', 0);
INSERT INTO `patient` VALUES (32, 'liliao', 'VMzpfQNooCpEk', '220502193812140215', 'patient32', '北京市密云区西安街E座号', '15658414518', 93, '男', '子宫肌瘤', 1);
INSERT INTO `patient` VALUES (33, 'ocao', 'YtMenH76duc0jM8kp', '211401195911043257', 'patient33', '北京市大兴区高路p座号', '15063227957', 62, '男', '痤疮', 1);
INSERT INTO `patient` VALUES (34, 'yongwei', 'BHP7PRAN', '321300198006139838', 'patient34', '北京市大兴区西宁街h座号', '15792993200', 13, '女', '红斑狼疮', 0);
INSERT INTO `patient` VALUES (35, 'lqiu', 'ZnnuQ8WX5_cqPm', '340801198609049352', 'patient35', '北京市海淀区嘉禾街f座号', '15027691903', 26, '男', '强迫症', 0);
INSERT INTO `patient` VALUES (36, 'gang86', 'T3StbTClz', '230201194605309624', 'patient36', '北京市门头沟区王街M座号', '14514719010', 20, '女', '感冒', 1);
INSERT INTO `patient` VALUES (37, 'ekang', 'pJrICby387', '41130019770504232X', 'patient37', '北京市朝阳区蒙街A座号', '13697340045', 91, '男', '暴食症', 1);
INSERT INTO `patient` VALUES (38, 'xiuyingdeng', 'cDuIK5iBnx', '130302200002061101', 'patient38', '北京市昌平区陈街e座号', '14568920279', 13, '女', '骨关节炎', 1);
INSERT INTO `patient` VALUES (39, 'xieping', '7liXn1J7', '654025199204013691', 'patient39', '北京市昌平区佛山路h座号', '15825590374', 98, '女', '腰椎间盘突出', 0);
INSERT INTO `patient` VALUES (40, 'yanxue', 'NdzO0SPk6L', '410526198607286118', 'patient40', '北京市海淀区哈尔滨路D座号', '18238830663', 69, '女', '感冒', 1);
INSERT INTO `patient` VALUES (41, 'min20', 'LTmoYJe0H5QeBE6kxCA3', '230602196509227191', 'patient41', '北京市门头沟区西安路A座号', '13635861681', 90, '男', '阿尔茨海默病', 1);
INSERT INTO `patient` VALUES (42, 'gcheng', '1gTvcwMNsZ', '513327197302286923', 'patient42', '北京市门头沟区刘街V座号', '13705914384', 40, '女', '带状疱疹', 0);
INSERT INTO `patient` VALUES (43, 'gongyong', 'zzAsUZHais_LDC', '50024219630428818X', 'patient43', '北京市怀柔区辽阳路I座号', '15982396286', 46, '女', '鼻炎', 1);
INSERT INTO `patient` VALUES (44, 'mengjuan', 'xKfOx9dd18dFx2BuyenI', '42052619930626152X', 'patient44', '北京市昌平区石街b座号', '15546313606', 67, '男', '肾结石', 0);
INSERT INTO `patient` VALUES (45, 'jinghuang', '_mtGRSE', '140922194809236672', 'patient45', '北京市门头沟区重庆路U座号', '15942841762', 25, '女', '咳嗽', 1);
INSERT INTO `patient` VALUES (46, 'ming93', '_AJtj5GM0J', '511304198811227890', 'patient46', '北京市通州区黄街h座号', '13043456620', 100, '女', '尿路感染', 1);
INSERT INTO `patient` VALUES (47, 'leilai', 'XIj_ya', '43100320030722310X', 'patient47', '北京市通州区香港街w座号', '18169926871', 27, '女', '肌腱炎', 1);
INSERT INTO `patient` VALUES (48, 'houyong', 'eNfSGvr4RUTbYqXARCJ', '410704194304196646', 'patient48', '北京市大兴区曹街f座号', '13582168886', 18, '男', '低血压', 1);
INSERT INTO `patient` VALUES (49, 'guiying40', 'xiLrA', '530925193605158964', 'patient49', '北京市丰台区易街G座号', '18878342511', 66, '男', '脂溢性皮炎', 0);
INSERT INTO `patient` VALUES (50, 'leicai', 'qyckBwibC2Lx', '460108195907288781', 'patient50', '北京市房山区钱街k座号', '15393463238', 62, '女', '红斑狼疮', 1);

-- ----------------------------
-- Table structure for registration_information
-- ----------------------------
DROP TABLE IF EXISTS `registration_information`;
CREATE TABLE `registration_information`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `date` date NULL DEFAULT NULL COMMENT '挂号预约的时间',
  `time_frame` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时段',
  `department` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '科室',
  `patient_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '患者名称',
  `doctor_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专家名称',
  `register_time` timestamp NULL DEFAULT NULL COMMENT '挂号成功的时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '挂号信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of registration_information
-- ----------------------------
INSERT INTO `registration_information` VALUES (1, '2024-07-01', '下午', '放射科', 'patient01', 'doctor01', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (2, '2024-07-02', '上午', '耳鼻喉科', 'patient02', 'doctor02', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (3, '2024-07-01', '下午', '外科', 'patient03', 'doctor03', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (4, '2024-07-03', '下午', '急诊科', 'patient04', 'doctor04', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (5, '2024-07-03', '下午', '皮肤科', 'patient05', 'doctor05', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (6, '2024-07-03', '上午', '放射科', 'patient06', 'doctor06', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (7, '2024-07-01', '上午', '眼科', 'patient07', 'doctor07', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (8, '2024-07-01', '上午', '儿科', 'patient08', 'doctor08', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (9, '2024-07-03', '上午', '急诊科', 'patient09', 'doctor09', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (10, '2024-07-01', '下午', '妇产科', 'patient10', 'doctor10', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (11, '2024-07-01', '上午', '中医科', 'patient11', 'doctor11', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (12, '2024-07-03', '下午', '放射科', 'patient12', 'doctor12', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (13, '2024-07-02', '下午', '感染科', 'patient13', 'doctor13', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (14, '2024-07-02', '上午', '口腔科', 'patient14', 'doctor14', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (15, '2024-07-03', '上午', '康复科', 'patient15', 'doctor15', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (16, '2024-07-03', '上午', '中医科', 'patient16', 'doctor16', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (17, '2024-07-01', '下午', '肿瘤科', 'patient17', 'doctor17', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (18, '2024-07-03', '上午', '放射科', 'patient18', 'doctor18', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (19, '2024-07-01', '上午', '妇产科', 'patient19', 'doctor19', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (20, '2024-07-02', '上午', '肿瘤科', 'patient20', 'doctor20', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (21, '2024-07-03', '下午', '耳鼻喉科', 'patient21', 'doctor21', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (22, '2024-07-01', '上午', '中医科', 'patient22', 'doctor22', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (23, '2024-07-01', '下午', '耳鼻喉科', 'patient23', 'doctor23', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (24, '2024-07-02', '下午', '耳鼻喉科', 'patient24', 'doctor24', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (25, '2024-07-02', '下午', '皮肤科', 'patient25', 'doctor25', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (26, '2024-07-01', '上午', '急诊科', 'patient26', 'doctor26', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (27, '2024-07-03', '下午', '急诊科', 'patient27', 'doctor27', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (28, '2024-07-03', '上午', '外科', 'patient28', 'doctor28', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (29, '2024-07-03', '下午', '口腔科', 'patient29', 'doctor29', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (30, '2024-07-02', '下午', '急诊科', 'patient30', 'doctor30', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (31, '2024-07-03', '下午', '中医科', 'patient31', 'doctor31', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (32, '2024-07-02', '下午', '外科', 'patient32', 'doctor32', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (33, '2024-07-02', '下午', '急诊科', 'patient33', 'doctor33', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (34, '2024-07-02', '上午', '中医科', 'patient34', 'doctor34', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (35, '2024-07-02', '上午', '急诊科', 'patient35', 'doctor35', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (36, '2024-07-02', '下午', '肿瘤科', 'patient36', 'doctor36', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (37, '2024-07-02', '下午', '妇产科', 'patient37', 'doctor37', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (38, '2024-07-02', '下午', '妇产科', 'patient38', 'doctor38', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (39, '2024-07-02', '下午', '口腔科', 'patient39', 'doctor39', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (40, '2024-07-01', '上午', '外科', 'patient40', 'doctor40', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (41, '2024-07-02', '下午', '口腔科', 'patient41', 'doctor41', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (42, '2024-07-01', '下午', '康复科', 'patient42', 'doctor42', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (43, '2024-07-03', '上午', '儿科', 'patient43', 'doctor43', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (44, '2024-07-02', '下午', '皮肤科', 'patient44', 'doctor44', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (45, '2024-07-03', '上午', '儿科', 'patient45', 'doctor45', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (46, '2024-07-01', '下午', '中医科', 'patient46', 'doctor46', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (47, '2024-07-02', '上午', '急诊科', 'patient47', 'doctor47', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (48, '2024-07-03', '下午', '感染科', 'patient48', 'doctor48', '2024-06-30 00:00:00');
INSERT INTO `registration_information` VALUES (49, '2024-07-01', '上午', '急诊科', 'patient49', 'doctor49', '2024-06-28 00:00:00');
INSERT INTO `registration_information` VALUES (50, '2024-07-02', '下午', '皮肤科', 'patient50', 'doctor50', '2024-06-29 00:00:00');
INSERT INTO `registration_information` VALUES (51, '2024-07-05', '上午', '肿瘤科', 'yantan', 'doctor01', '2024-07-01 20:58:16');
INSERT INTO `registration_information` VALUES (52, '2024-07-05', '上午', '肿瘤科', 'yantan', 'doctor01', '2024-07-01 20:59:51');
INSERT INTO `registration_information` VALUES (53, '2024-07-05', '上午', '肿瘤科', 'patient1', 'doctor01', '2024-07-01 21:07:48');
INSERT INTO `registration_information` VALUES (54, '2024-07-05', '上午', '肿瘤科', 'patient1', 'doctor01', '2024-07-01 21:08:29');
INSERT INTO `registration_information` VALUES (55, '2024-07-05', '上午', '肿瘤科', 'patient1', 'doctor01', '2024-07-01 21:08:31');
INSERT INTO `registration_information` VALUES (56, '2024-07-05', '上午', '肿瘤科', 'patient1', 'doctor01', '2024-07-01 22:19:27');

SET FOREIGN_KEY_CHECKS = 1;
