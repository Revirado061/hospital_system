<template>
  <div>
    <el-button type="primary" @click="checkNewUser('医生', '12345', true)">检查新用户</el-button>
  </div>
</template>

<script>
import axios from "axios";
export default {
  methods: {
    checkNewUser(type, account, choice) {
      const url = '/api/admin/checkNewUser';
      const params = {
        type: type,
        account: account,
        choice: choice
      };
      console.log('Requesting Check New User:', url, params);

      axios.post(url, null, {
        params: params
      }).then(response => {
        console.log('User checked successfully:', response);
        // 在这里处理成功响应，例如显示一个消息或更新UI
      }).catch(error => {
        console.error('检查新用户请求失败:', error);
        if (error.response) {
          console.error('Response Data:', error.response.data);
          console.error('Response Status:', error.response.status);
          console.error('Response Headers:', error.response.headers);
        } else if (error.request) {
          console.error('Request Data:', error.request);
        } else {
          console.error('Error Message:', error.message);
        }
      });
    }
  }
};
</script>
