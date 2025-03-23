<template>
  <div>
    <div class="top-panel">
      <el-form label-width="50px" :inline="true">
        <el-row>
          <el-form-item>
            <el-date-picker
                v-model="dateRange"
                type="daterange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd"
                @change="handleDateChange"
            >
            </el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button type="success" @click="searchCall(dateRange)">搜索</el-button>
          </el-form-item>
          <el-form-item>
            <el-button type="success" @click="newCall">新增出诊信息</el-button>
          </el-form-item>
          <el-form-item>
            <el-button type="success" @click="showAll">显示所有出诊信息</el-button>
          </el-form-item>
        </el-row>
      </el-form>
    </div>
    <div class="table-panel">
      <el-table :data="tableData" style="width: 100%" border>
        <el-table-column prop="id" label="ID" width="80"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="department" label="部门"></el-table-column>
        <el-table-column prop="date" label="日期"></el-table-column>
        <el-table-column prop="timeFrame" label="时间段"></el-table-column>
        <el-table-column prop="quantity" label="挂号数量"></el-table-column>
        <el-table-column label="审批状态">
          <template slot-scope="scope">
            <el-tag
                :type="scope.row.approved === 1 ? 'success' : 'info'"
                :effect="scope.row.approved === 1 ? 'plain' : 'dark'"
            >
              {{ scope.row.approved === 1 ? '已审批' : '未通过' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleView(scope.row)">查看</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="other">
      <!-- 查看信息的对话框 -->
      <el-dialog :visible.sync="dialogVisible" title="出诊信息">
        <div>
          <p><strong>ID：</strong>{{ selectedRow.id }}</p>
          <p><strong>姓名：</strong>{{ selectedRow.name }}</p>
          <p><strong>部门：</strong>{{ selectedRow.department }}</p>
          <p><strong>日期：</strong>{{ selectedRow.date }}</p>
          <p><strong>时间段：</strong>{{ selectedRow.timeFrame }}</p>
          <p><strong>挂号数量：</strong>{{ selectedRow.quantity }}</p>
          <p><strong>审批状态：</strong>
            <el-tag
                :type="selectedRow.approved === 1 ? 'success' : 'info'"
                :effect="selectedRow.approved === 1 ? 'plain' : 'dark'"
            >
              {{ selectedRow.approved === 1 ? '已审批' : '未通过' }}
            </el-tag>
          </p>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">关闭</el-button>
        </span>
      </el-dialog>

      <!-- 新增出诊信息对话框 -->
      <div>
        <el-dialog :visible.sync="addDialogVisible" title="新增出诊信息">
          <el-form :model="newConsultation" :rules="rules" ref="newConsultationForm">
            <el-form-item label="姓名">
              <el-input v-model="newConsultation.name"></el-input>
            </el-form-item>
            <el-form-item label="部门">
              <el-input v-model="newConsultation.department"></el-input>
            </el-form-item>
            <el-row :gutter="20">
              <el-col :span="8">
                <el-form-item label="出诊时间" prop="date">
                  <el-date-picker v-model="newConsultation.date" type="date" placeholder="选择日期"
                                  format="yyyy-MM-dd"
                                  value-format="yyyy-MM-dd"
                  ></el-date-picker>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item label="时间段" prop="timeFrame">
                  <el-select v-model="newConsultation.timeFrame" placeholder="选择时间段">
                    <el-option label="上午" value="上午"></el-option>
                    <el-option label="下午" value="下午"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item label="挂号数量" prop="quantity">
                  <el-input v-model="newConsultation.quantity" type="number"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
          <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAddSubmit(newConsultation)">提交</el-button>
      </span>
        </el-dialog>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
const axiosInstance = axios.create({
  baseURL: 'http://localhost:8081', // 设置为你的后端服务器的基础 URL
  headers: {
    'Content-Type': 'application/json'
  }
});
export default {
  axiosInstance,
  data() {
    return {
      dateRange: [],
      selectedDate: '',
      tableData: [
        {
          id: 3,
          name: '医生02',
          department: '外科',
          date: '28/5/2024',
          timeFrame: '下午',
          quantity: 8,
          approved: 1,
        },
        // 更多数据...
      ],
      doctorName:'',
      doctor:{},
      selectedRow: {},
      dialogVisible: false,
      addDialogVisible: false,
      newConsultation: {
        name: '',
        department: '',
        date: '',
        timeFrame: '',
        quantity: ''
      },
      rules: {
        name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
        department: [{ required: true, message: '请输入部门', trigger: 'blur' }],
        date: [{ required: true, message: '请选择日期', trigger: 'change' }],
        timeFrame: [{ required: true, message: '请选择时间段', trigger: 'change' }],
        quantity: [{ required: true, message: '请输入挂号数量', trigger: 'blur' }]
      }
    };
  },
  computed:{
    dateOnly() {
      if (!this.dateStr) return '';
      // 分割字符串，提取日期部分
      const formattedDateStr = `Formatted Date: ${this.dateStr}`;
      return formattedDateStr.split('Formatted Date: ')[1];
    }
  },
  mounted() {
    this.getDoctorName();
    this.getInfo();
    this.showAll();
  },
  methods: {
    formatDate(dateStr) {
      const date = new Date(dateStr);
      const year = date.getFullYear();
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const day = date.getDate().toString().padStart(2, '0');
      return `${year}-${month}-${day}`;
    },
    getDoctorName(){
      this.doctorName = this.$store.getters.userAccount
    },
    getInfo() {
      axios.post('/api/doctor/getInfo', null, {params: {account: this.doctorName}})
          .then(response => {
            this.doctor = response.data.data
          })
      console.log(this.doctor.name)
    },
    showAll(){  //查看该医生自己的所有出诊信息，包括没审批的
      axios.post('/api/doctor/showAllCall', null, {params: {account: this.doctorName}})
          .then(response => {
            this.tableData = response.data.data
          })
    },
    handleDateChange(value) {
      console.log('Selected Date Range:', value);
      // 在这里处理日期范围变化的逻辑，例如筛选数据
    },
    handleDateChange2(value) {
      console.log('Selected Date:', value);
      // 在这里处理日期变化的逻辑，例如查询数据
    },
    searchCall(date) {
      console.log(date)
      axios.post('/api/doctor/check',null,{
        params:{
          startDate:this.dateRange[0],
          endDate:this.dateRange[1],
          account:this.doctorName,
        }
      }).then(Response => {
        this.tableData = Response.data.data
      })
    },
    newCall() {
      this.addDialogVisible = true;
    },
    handleAddSubmit() {
      // 提取日期部分
      const dateStr = this.newConsultation.date;
      if (dateStr) {
        this.newConsultation.date = dateStr.split('Formatted Date: ')[1] || dateStr;
      }
      console.log(this.newConsultation.date)
      console.log(this.newConsultation.timeFrame)
      // 提交数据
      axios.post('/api/doctor/post', null,{
        params:{
          name:this.newConsultation.name,
          timeFrame:this.newConsultation.timeFrame,
          quantity:this.newConsultation.quantity,
          date:this.newConsultation.date,
          department:this.newConsultation.department,
        }
      })
          .then(response => {
            console.log("提交成功:", response.data);
            this.addDialogVisible = false;
            // 清空表单
            this.newConsultation = {
              name: '',
              department: '',
              date: '',
              timeFrame: '',
              quantity: ''
            };
            // 处理提交成功的逻辑
          })
          .catch(error => {
            console.error("提交失败:", error);
          });
    },
    handleView(row) {
      this.selectedRow = row;
      this.dialogVisible = true;
    },
    handleDelete(row) {
      console.log(row)
      this.$confirm('你确定要删除吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        axios.post('/api/doctor/delete',null,{params:{id:row.id}})
        this.$message({
          type: 'success',
          message: '删除成功！！'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    }
  },

};
</script>

<style scoped>
</style>
