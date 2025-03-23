<!--审批页信息-->
<!--新注册用户的审批-->
<template>
  <div>
    <div class="title">
      <h2>注册用户审批</h2>
   </div>
    <div class="table-panel">
      <el-table :data="tableData" style="width: 100%" border>
        <el-table-column
            width="150px"
            prop="type"
            label="类别"
            align="center"
            :filters="categoryFilters"
            :filter-method="filterCategory"
            filter-placement="bottom-end">
          <template slot-scope="scope">
            <el-tag
                :type="tagColor(scope.row.type)"
                disable-transitions>{{scope.row.type}}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="account" label="账号"></el-table-column>
        <el-table-column label="审批状态">
          <el-tag type="success">待审核</el-tag>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button size="mini" @click="checkNewUser(scope.row,scope.row.type, scope.row.account, true)">同意</el-button>
            <el-button size="mini" type="danger" @click="checkNewUser(scope.row,scope.row.type, scope.row.account, false)">拒绝</el-button>
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
      categoryFilters:[
        {text:'医生',value:'医生'},
        {text:'病人',value:'病人'},
        {text:'管理员',value:'admin'},
      ],
      tableData: [
        {
          type:'医生',
          account: '12345',
          chocie:false,
        },
        {
          type:'病人',
          account: '124345',
          chocie:false,
        }],

    }
  },
  mounted() {
    this.loadAll()
  },
  methods:{
    loadAll(){
      axios.post('/api/admin/getAllAdmin', null, {
        params: { choice: 0 }
      }).then(response => {
        const adminData = response.data.data.map(item => {
          item.type = '管理员';
          return item;
        });
        this.tableData = adminData;
      });

      axios.post('/api/admin/getAllDoctor', null, {
        params: { choice: 0 }
      }).then(response => {
        const doctorData = response.data.data.map(item => {
          item.type = '医生';
          return item;
        });
        this.tableData = this.tableData.concat(doctorData);
      });

      axios.post('/api/admin/getAllPatient', null, {
        params: { choice: 0 }
      }).then(response => {
        const patientData = response.data.data.map(item => {
          item.type = '病人';
          return item;
        });
        this.tableData = this.tableData.concat(patientData);
      });
    },
    checkNewUser(row, type, account, choice) {
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
    },
    removeRow(row) {
      const index = this.tableData.indexOf(row);
      if (index !== -1) {
        this.tableData.splice(index, 1);
      }
    },
    filterCategory(value, row) {
      return row.type === value;
    },
    tagColor(type){
      if(type === '医生')
        return 'success'
      else if(type === '管理员')
        return 'primary'
      else if(type === '病人')
        return 'warning'
    },
  }
}
</script>



<style scoped>

</style>
