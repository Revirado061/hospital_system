<template>
  <div class="layout-container">
    <el-card class="box-card" style="width: 400px">
      <div slot="header" class="clearfix">
        <span>患者信息</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleEdit">{{ editing ? '取消' : '修改内容' }}</el-button>
      </div>
      <!-- 展示信息部分 -->
      <div v-if="!editing">
        <div v-for="(value, key) in patientFields" :key="key" class="text item">
          {{ key + "：" + value }}
        </div>
      </div>
      <!-- 编辑表单部分 -->
      <el-form v-show="editing" :model="tempPatientInfo" label-width="100px">
        <el-form-item label='账号'>
          <el-input v-model="tempPatientInfo.account"></el-input>
        </el-form-item>
        <el-form-item label='密码'>
          <el-input v-model="tempPatientInfo.password"></el-input>
        </el-form-item>
        <el-form-item label="身份证号">
          <el-input v-model="tempPatientInfo.id"></el-input>
          </el-form-item>
          <el-form-item label="姓名">
            <el-input v-model="tempPatientInfo.name"></el-input>
          </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="tempPatientInfo.address"></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="tempPatientInfo.phone"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input-number v-model="tempPatientInfo.age"></el-input-number>
        </el-form-item>
        <el-form-item label="性别">
          <el-input v-model="tempPatientInfo.sex"></el-input>
        </el-form-item>
        <el-form-item label="病史记录">
          <el-input v-model="tempPatientInfo.record"></el-input>
        </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="saveInfo">保存</el-button>
          </el-form-item>
      </el-form>
    </el-card>
    <el-table :data="registrationInfo"  class="registration-table">
      <el-table-column prop="id" label="序号" align="center"></el-table-column>
      <el-table-column prop="date" label="就诊日期" align="center"></el-table-column>
      <el-table-column prop="timeFrame" label="时间段" align="center"></el-table-column>
      <el-table-column prop="department" label="科室" align="center"></el-table-column>
      <el-table-column prop="doctorName" label="专家姓名" align="center"></el-table-column>
      <el-table-column prop="registerTime" label="挂号日期" align="center"></el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      editing: false,
      patientInfo: {
        account: '',
        password: '',
        id: '',
        name: '',
        address: '',
        phone: ''
      },
      patientName:'',
      tempPatientInfo: {},
      registrationInfo:[] // 挂号信息
    };
  },
  computed: {
    patientFields() {
      return {
        '账号': this.patientInfo.account,
        '密码': this.patientInfo.password,
        '身份证号': this.patientInfo.id,
        '姓名': this.patientInfo.name,
        '地址': this.patientInfo.address,
        '联系电话': this.patientInfo.phone,
        '年龄':this.patientInfo.age,
        '性别':this.patientInfo.sex,
        '病史记录':this.patientInfo.record,
      };
    },
  },
    mounted() {
      this.getPatientName();
      this.getInfo();
      this.getGuahao();
    },
    methods: {
      getPatientName(){
        this.patientName = this.$store.getters.userAccount
        console.log(this.patientName)
      },
      getInfo() {
        axios.post('/api/patient/getInfo', null, {params: {account: this.patientName}})
            .then(response => {
              this.patientInfo = response.data.data;
              this.tempPatientInfo = response.data.data;
            })
        console.log(this.patientInfo)
      },
      getGuahao(){
        axios.post('/api/patient/getMyGuahao', null, {params: {account: this.patientName}})
            .then(response => {
              this.registrationInfo = response.data.data
            })
      },
      toggleEdit() {
        this.editing = !this.editing;
      },
      saveInfo() {
        axios.post('/api/patient/change', this.tempPatientInfo, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
            .then(response => {
              // 处理响应，例如可以设置一个状态表示信息已成功保存
              console.log('Info updated successfully');
              console.log(response)
            })
            .catch(error => {
              // 处理错误
              console.error('Failed to save info:', error);
            });
        this.editing = false
        this.$message({
          type:"success",
          message:'成功提交修改信息，修改成功'
        })
      }
    }
  }
</script>

<style>
.layout-container {
  display: flex;
  justify-content: space-between; /* 使元素间有间隙 */
  padding: 20px;
}
.box-card {
  flex: 1; /* 卡片占据1份空间 */
  margin-right: 20px; /* 卡片和表格之间的间距 */
}
.registration-table {
  flex: 1; /* 表格占据1份空间 */
  width: 100%; /* 让表格宽度自适应 */
}
.box-card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.text.item {
  margin: 10px;
}
</style>
