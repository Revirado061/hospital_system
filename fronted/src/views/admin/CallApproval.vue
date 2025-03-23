<template>
  <div>
    <div class="title">
      <h2>医生出诊审批</h2>
    </div>
    <div class="table-panel">
      <el-table :data="tableData" style="width: 100%" border>
        <el-table-column prop="id" label="序号"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="date" label="日期"></el-table-column>
        <el-table-column prop="timeFrame" label="时间段"></el-table-column>
        <el-table-column prop="quantity" label="挂号数量"></el-table-column>
        <el-table-column prop="department" label="科室"></el-table-column>
        <el-table-column label="审批状态">
            <el-tag type="success">待审核</el-tag>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleChange(scope.row,true)">同意</el-button>
            <el-button size="mini" type="danger" @click="handleChange(scope.row,false)">拒绝</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>


<script>
import axios from "axios";
export default {
  data() {
    return {
      tableData: [],
    }
  },
  mounted() {
    this.loadAll()
  },
  methods:{
    loadAll(){
      // 加载所有数据的逻辑
      axios.post('/api/admin/getNewCallInfo',null)
          .then(Response =>{
            this.tableData = Response.data.data
          })
    },
    handleChange(row,choice) {
      axios.post('/api/admin/checkCallInfo', null, {
        params: {
          id: row.id,
          choice: choice
        }
      }).then(response => {
        console.log('User checked successfully:', response);

        // 根据 choice 显示不同的消息
        if (choice === true) {
          this.$message({
            type: "success",
            message: '已通过审批',
          });
        } else if (choice === false) {
          this.$message({
            type: "warning",
            message: '已拒绝审批',
          });
        }

        // 移除行
        this.removeRow(row);
      })
    },
    // handleAgree(row){
    //   console.log(row)
    //   this.$message({
    //     type:"success",
    //     message:'同意审批'
    //   })
    //   this.removeRow(row);
    // },
    // handleReject(row){
    //   this.$message({
    //     type:'warning',
    //     message:"拒绝审批"
    //   })
    //   this.removeRow(row);
    // },
    removeRow(row) {
      const index = this.tableData.indexOf(row);
      if (index !== -1) {
        this.tableData.splice(index, 1);
      }
    }
  }
}
</script>



<style scoped>

</style>
