<template>
  <div>
    <el-card class="box-card">
      <h2>注册</h2>
      <el-form
          :model="ruleForm"
          status-icon
          :rules="rules"
          ref="ruleForm"
          label-position="left"
          label-width="80px"
          class="demo-ruleForm"
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
        <el-form-item label="密码" prop="pass">
          <el-input
              type="password"
              v-model="ruleForm.pass"
              autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="password">
          <el-input
              type="password"
              v-model="ruleForm.password"
              autocomplete="off"
          ></el-input>
        </el-form-item>
      </el-form>
      <div class="btnGroup">
        <el-button type="primary" @click="submitForm('ruleForm',ruleForm.identity)"
        >提交</el-button
        >
        <el-button @click="resetForm('ruleForm')">重置</el-button>
        <el-button @click="goBack">返回</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.ruleForm.checkPass !== "") {
          this.$refs.ruleForm.validateField("checkPass");
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.ruleForm.pass) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      ruleForm: {
        uname: "",
        pass: "",
        password: "",
        identity: '',
      },
      rules: {
        uname: [
          { required: true, message: "用户名不能为空！", trigger: "blur" },
        ],
        pass: [{ required: true, validator: validatePass, trigger: "blur" }],
        password: [
          { required: true, validator: validatePass2, trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    submitForm(formName, identity) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          let _this = this;
            if (identity === '患者') {
              this.axios({
                url:'/api/patient/register',
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
                  this.$router.push('/login');
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
              this.$router.push('/doctorhome');
            } else if (identity === '管理员') {
              this.axios({
                url:'/api/admin/register',
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
                  this.$router.push('/login');
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
          } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    goBack() {
      this.$router.go(-1);
    },
  },
};
</script>

<style scoped>
.box-card {
  margin: auto auto;
  width: 400px;
}
</style>
