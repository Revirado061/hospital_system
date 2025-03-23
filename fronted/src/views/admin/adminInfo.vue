<!--自己的信息-->
<template>
  <div class="main">
    <el-card class="box-card" style="width: 600px">
      <div slot="header" class="clearfix">
        <span>管理员信息</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleEdit">{{ editing ? '取消' : '修改内容' }}</el-button>
      </div>
      <!-- 展示信息部分 -->
      <div v-if="!editing">
        <div v-for="(value, key) in doctorFields" :key="key" class="text item">
          {{ key + "：" + value }}
        </div>
      </div>
      <!-- 编辑表单部分 -->
      <el-form v-show="editing" :model="changeInfo" label-width="100px">
        <el-form-item label="账号">
          <el-input v-model="changeInfo.account"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="changeInfo.password"></el-input>
        </el-form-item>
        <el-form-item label="身份证号">
          <el-input v-model="changeInfo.id"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="changeInfo.name"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="changeInfo.address"></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="changeInfo.phone"></el-input>
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
      info:{},
      changeInfo1:{},
      changeInfo: {
        account: '',
        password: '',
        id: '',
        name: '',
        address: '',
        phone: ''
      },
      adminName:'',
    }
  },
  computed:{
    doctorFields() {
      return {
        '账号':this.info.account,
        '密码':this.info.password,
        '身份证号': this.info.id,
        '姓名': this.info.name,
        '地址': this.info.address,
        '联系电话': this.info.phone,
      };
    }
  },
  mounted() {
    this.getAdminName();
    this.getInfo();
  },
  methods: {
    getAdminName(){
      this.adminName = this.$store.getters.userAccount
      console.log(this.adminName)
    },
    getInfo(){
      axios.post('/api/admin/getInfo',null,{params:{account:this.adminName}})
          .then(response => {
            this.info = response.data.data
            this.changeInfo = response.data.data
          })
    },
    toggleEdit() {
      this.editing = !this.editing;
    },
    saveInfo() {
      axios.post('/api/admin/change', this.changeInfo, {
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
    },
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
