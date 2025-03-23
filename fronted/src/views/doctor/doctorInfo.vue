<template>
  <div class="main">
    <el-card class="box-card" style="width: 600px">
      <div slot="header" class="clearfix">
        <span>医生信息</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleEdit">{{ editing ? '取消' : '修改内容' }}</el-button>
      </div>
      <!-- 展示信息部分 -->
      <div v-if="!editing">
        <div v-for="(value, key) in doctorFields" :key="key" class="text item">
          {{ key + "：" + value }}
        </div>
      </div>
      <!-- 编辑表单部分 -->
      <el-form v-show="editing" :model="tempDoctorInfo" label-width="100px">
        <el-form-item label="账号">
          <el-input v-model="tempDoctorInfo.account"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="tempDoctorInfo.password"></el-input>
        </el-form-item>
        <el-form-item label="身份证号">
          <el-input v-model="tempDoctorInfo.id"></el-input>
        </el-form-item>
        <el-form-item label="名字">
          <el-input v-model="tempDoctorInfo.name"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="tempDoctorInfo.address"></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="tempDoctorInfo.phone"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input-number v-model="tempDoctorInfo.age"></el-input-number>
        </el-form-item>
        <el-form-item label="性别">
          <el-input v-model="tempDoctorInfo.sex"></el-input>
        </el-form-item>
        <el-form-item label="医院">
          <el-input type="textarea" v-model="tempDoctorInfo.hospital"></el-input>
        </el-form-item>
        <el-form-item label="科室">
          <el-input type="textarea" v-model="tempDoctorInfo.department"></el-input>
        </el-form-item>
        <el-form-item label="职称">
          <el-input type="textarea" v-model="tempDoctorInfo.title"></el-input>
        </el-form-item>
        <el-form-item label="擅长">
          <el-input type="textarea" v-model="tempDoctorInfo.speciality"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="saveInfo">保存</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return{
      editing: false,
      doctor:{
      },
      doctorName:'',
      tempDoctorInfo:{},
    }
  },
  computed:{
    doctorFields() {
      return {
        '账号': this.doctor.account,
        '密码': this.doctor.password,
        '身份证号': this.doctor.id,
        '名字': this.doctor.name,
        '地址': this.doctor.address,
        '联系电话': this.doctor.phone,
        '年龄': this.doctor.age,
        '性别': this.doctor.sex,
        '医院': this.doctor.hospital,
        '科室': this.doctor.department,
        '职称': this.doctor.title,
        '擅长': this.doctor.speciality
      };
    }
  },
  mounted() {
    this.getDoctorName();
    this.getInfo();
  },
  methods: {
    getDoctorName(){
      this.doctorName = this.$store.getters.userAccount
    },
    getInfo() {
      axios.post('/api/doctor/getInfo', null, {params: {account: this.doctorName}})
          .then(response => {
            this.doctor = response.data.data
            this.tempDoctorInfo = response.data.data
          })
      console.log(this.doctor.name)
    },
    toggleEdit() {
      this.editing = !this.editing;
    },
    saveInfo() {
      axios.post('/api/doctor/change', this.tempDoctorInfo, {
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


<style scoped>
.main {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 300px; /* 添加左右间隔 */
}

.box-card {
  width: 600px;
}
</style>
