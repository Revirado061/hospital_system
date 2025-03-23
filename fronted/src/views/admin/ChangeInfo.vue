<!--记录修改的信息-->

<template>
  <div>
    <div class="title">
      <h2>记录修改信息</h2>
    </div>
    <div class="table-panel">
      <el-table v-if="logShow" :data="operationLogs" style="width: 100%">
        <el-table-column prop="id" label="序号" width="120" align="center"></el-table-column>
        <el-table-column prop="modifier" label="修改者" width="120"></el-table-column>
        <el-table-column prop="operationType" label="操作类型" width="120"></el-table-column>
        <el-table-column prop="accountType" label="账户类型" width="120"></el-table-column>
        <el-table-column prop="account" label="账号" width="120"></el-table-column>
        <el-table-column prop="afterChange" label="修改后" width="600"></el-table-column>
      </el-table>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data(){
    return{
      logShow: true,
      operationLogs: [
        {
          id: 1,
          modifier: "admin",
          operationType: "删除",
          accountType: "管理员",
          account: "admin02",
          before: "admin02 654321 110127200012041428 管理员02 北京市海淀区西土城路08号 15318649157",
          after: "----------------------"
        },]
    }
  },
  mounted() {
    this.loadAll()
  },
  methods:{
    loadAll(){
      axios.post('/api/admin/log')
          .then(Response => {
            this.operationLogs = Response.data.data
          })
    }
  }
}
</script>



<style scoped>

</style>
