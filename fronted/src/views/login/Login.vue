<template>
  <div>
    <el-card class="box-card">
      <h2>专家挂号系统</h2>
      <el-form
          :model="ruleForm"
          status-icon
          :rules="rules"
          ref="ruleForm"
          label-position="left"
          label-width="70px"
          class="login-from"
      >
        <el-form-item label="登陆身份">
          <el-radio-group v-model="ruleForm.identity">
            <el-radio label="患者"></el-radio>
            <el-radio label="医生"></el-radio>
            <el-radio label="管理员"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="用户名" prop="uname">
          <el-input v-model="ruleForm.uname"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input
              type="password"
              v-model="ruleForm.password"
              autocomplete="off"
          ></el-input>
        </el-form-item>
      </el-form>
      <div class="btnGroup">
        <el-button type="primary" @click="submitForm('ruleForm', ruleForm.identity)"
        >登录</el-button>
        <el-button @click="resetForm2('ruleForm')">重置</el-button>
        <router-link to="/register">
          <el-button style="margin-left:10px">注册</el-button>
        </router-link>
      </div>
    </el-card>

    <!-- 重置密码卡片 -->
    <el-dialog title="重置密码" :visible.sync="showResetPassword">
      <el-form :model="resetForm" :rules="resetRules" ref="resetForm" label-width="100px">
        <el-form-item label="新密码" prop="newPassword">
          <el-input type="password" v-model="resetForm.newPassword" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input type="password" v-model="resetForm.confirmPassword" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showResetPassword = false">取消</el-button>
        <el-button type="primary" @click="resetPassword">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      ruleForm: {
        uname: "",
        password: "",
        identity: '',
      },
      rules: {
        uname: [
          { required: true, message: "用户名不能为空！", trigger: "blur" },
        ],
        password: [
          { required: true, message: "密码不能为空！", trigger: "blur" },
        ],
      },
      showResetPassword: false,
      resetForm: {
        newPassword: "",
        confirmPassword: ""
      },
      changePassword:'',
      resetRules: {
        newPassword: [
          { required: true, message: "新密码不能为空！", trigger: "blur" },
        ],
        confirmPassword: [
          { required: true, message: "确认密码不能为空！", trigger: "blur" },
          { validator: (rule, value, callback) => {
              if (value !== this.resetForm.newPassword) {
                callback(new Error("两次输入密码不一致！"));
              } else {
                callback();
              }
            }, trigger: "blur" }
        ],
      },
      firstLogin: false,
    };
  },
  methods: {
    submitForm(formName, identity) {
      this.$store.dispatch('updateAccount', this.ruleForm.uname);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          let _this = this;
          if (identity === '管理员' && this.ruleForm.uname === 'admin' && this.ruleForm.password === 'admin') {
            this.firstLogin = true;
            this.showResetPassword = true;
            console.log(_this.changePassword)
          }
          else {
            if (identity === '患者') {
              this.axios({
                url:'/api/patient/login',
                method: "post",
                params: {
                  account: _this.ruleForm.uname,
                  password:_this.ruleForm.password
                }
              }).then((res) => {
                if (res.data.code === "0") {  // 当响应的编码为 0 时，说明登录成功
                  // 将用户信息存储到sessionStorage中
                  sessionStorage.setItem("userInfo", JSON.stringify(res.data.data));
                  // 跳转页面到首页
                  this.$router.push('/patienthome');
                  // 显示后端响应的成功信息
                  this.$message({
                    message: res.data.msg,
                    type: "success",
                  });
                } else {  // 当响应的编码不为 0 时，说明登录失败
                  // 显示后端响应的失败信息
                  this.$message({
                    message: res.data.msg,
                    type: "warning",
                  });
                }
              })

            } else if (identity === '医生') {
              this.axios({
                url:'/api/doctor/login',
                method: "post",
                params: {
                  account: _this.ruleForm.uname,
                  password:_this.ruleForm.password
                }
              }).then((res) => {
                if (res.data.code === "0") {  // 当响应的编码为 0 时，说明登录成功
                  // 将用户信息存储到sessionStorage中
                  sessionStorage.setItem("userInfo", JSON.stringify(res.data.data));
                  // 跳转页面到首页
                  this.$router.push('/doctorhome');
                  // 显示后端响应的成功信息
                  this.$message({
                    message: res.data.msg,
                    type: "success",
                  });
                } else {  // 当响应的编码不为 0 时，说明登录失败
                  // 显示后端响应的失败信息
                  this.$message({
                    message: res.data.msg,
                    type: "warning",
                  });
                }
              })
            } else if (identity === '管理员') {
              this.axios({
                url:'/api/admin/login',
                method: "post",
                params: {
                  account: _this.ruleForm.uname,
                  password:_this.ruleForm.password
                }
              }).then((res) => {
                if (res.data.code === "0") {  // 当响应的编码为 0 时，说明登录成功
                  // 将用户信息存储到sessionStorage中
                  sessionStorage.setItem("userInfo", JSON.stringify(res.data.data));
                  // 跳转页面到首页
                  this.$router.push('/adminhome');
                  // 显示后端响应的成功信息
                  this.$message({
                    message: res.data.msg,
                    type: "success",
                  });
                } else {  // 当响应的编码不为 0 时，说明登录失败
                  // 显示后端响应的失败信息
                  this.$message({
                    message: res.data.msg,
                    type: "warning",
                  });
                }
              })

            }
          }
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    // eslint-disable-next-line vue/no-dupe-keys
    resetForm2(formName) {
      this.$refs[formName].resetFields();
    },
    resetPassword() {
      this.$refs.resetForm.validate((valid) => {
        if (valid) {
          this.changePassword = this.resetForm.newPassword;
          console.log(this.changePassword)
          this.$message({
            message: '密码已成功重置，请重新登录',
            type: 'success'
          });

          // 重置表单
          this.ruleForm.password = '';
          this.resetForm.newPassword = '';
          this.resetForm.confirmPassword = '';
          this.showResetPassword = false;

          if (this.firstLogin) {
            this.firstLogin = false;
            // 重定向到登录页面或其他操作
          }
        }
      });
    }
  }
};
</script>

<style scoped>
.box-card {
  margin: auto auto;
  width: 400px;
}
.login-from {
  margin: auto auto;
}
</style>
