<template>
  <div>
    <div class="top-panel">
      <el-form label-width="50px">
        <el-row>
          <el-col :span="5">
            <el-form-item label="日期">
              <el-date-picker
                  v-model="dateStr"
                  type="date"
                  format="yyyy-MM-dd"
                  value-format="yyyy-MM-dd"
                  placeholder="请选择日期"
                  :picker-options="pickerOptions"
                  style="width: 200px; float: left"
              ></el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="5">
            <el-form-item label="科室">
              <el-select v-model="departmentStr" filterable placeholder="请选择">
                <el-option
                    v-for="item in typeOptions"
                    :key="item"
                    :label="item"
                    :value="item"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="5">
            <el-form-item label="专家">
              <el-input
                  v-model="nameStr"
                  placeholder="请输入名称"
                  style="width: 200px; float: left"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item style="width: 450px; float: left">
              <div class="button-group">
                <el-button type="success" @click="SearchHandle(dateOnly,nameStr,departmentStr)">搜索</el-button>
                <el-button type="success" @click="showAll">显示所有挂号信息</el-button>
              </div>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </div>
    <div class="main-panel">
      <el-main>
        <el-table :data="tableData" style="width: 100%">
          <el-table-column prop="id" label="序号" align="center"></el-table-column>
          <el-table-column prop="date" label="挂号日期" align="center"></el-table-column>
          <el-table-column prop="timeFrame" label="时间段" align="center"></el-table-column>
          <el-table-column prop="department" label="科室" align="center"></el-table-column>
          <el-table-column prop="name" label="专家姓名" align="center"></el-table-column>
          <el-table-column prop="quantity" label="剩余数量" align="center"></el-table-column>
          <el-table-column  label="是否有号" align="center">
            <template #default="scope">
              <el-tag v-if="scope.row.quantity > 0" type="success">有号</el-tag>
              <el-tag v-else type="info">满号</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center">
            <template #default="scope">
              <el-button
                  @click="register(scope.$index, scope.row)"
                  type="primary"
                  :disabled="!scope.row.quantity"
              >
                挂号
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-main>
    </div>
    <div class="showOrNo">
      <!-- 支付页面 -->
      <el-dialog title="支付页面" :visible.sync="showPaymentDialog" width="30%">
        <div>请确认支付信息</div>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cancelPayment">取消</el-button>
          <el-button type="primary" @click="confirmPayment">确认</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  mounted() {
    this.loadAll();
  },
  data() {
    return {
      showPaymentDialog:false,
      tableData:[],
      dateStr: '',
      DateStr:'',
      nameStr: '',
      departmentStr: '',
      typeOptions: ['全部', '肿瘤科', '内科', '外科','妇产科','儿科','眼科','耳鼻喉科','口腔科','皮肤科','中医科',
        '急诊科','康复科','精神科','感染科','放射科'],
      pickerOptions: {
        disabledDate(time) {
          const today = new Date();
          const endDate = new Date(today.getTime() + 2 * 24 * 60 * 60 * 1000);
          return time < today.setHours(0, 0, 0, 0) || time > endDate.setHours(23, 59, 59, 999);
        }
      },
      selectedDoctor:{}
    }
  },
  computed:{
    dateOnly() {
      if (!this.dateStr) return '';
      // 分割字符串，提取日期部分
      const formattedDateStr = `Formatted Date: ${this.dateStr}`;
      return formattedDateStr.split('Formatted Date: ')[1];
    }

  },
  methods: {
    chakan(date){
      console.log(date)
      console.log(typeof(date))
    },
    extractDate(formattedDateStr) {
      // 分割字符串，提取日期部分
      let datePart = formattedDateStr.split('Formatted Date: ')[1];
      console.log(datePart)
      return datePart;
    },
    formatDate(dateStr) {
      const date = new Date(dateStr);
      const year = date.getFullYear();
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const day = date.getDate().toString().padStart(2, '0');
      return `${year}-${month}-${day}`;
    },
    register(index, doctor) {
      this.selectedDoctor = doctor;
      this.se
      this.showPaymentDialog = true;
    },
    confirmPayment() {
      this.showPaymentDialog = false;

      // 减少 selectedDoctor 的数量
      if (this.selectedDoctor.quantity > 0) {
        this.selectedDoctor.quantity--;
      }

      // 更新 tableData 中对应医生的数量
      const doctorIndex = this.tableData.findIndex(doc => doc.id === this.selectedDoctor.id);
      if (doctorIndex !== -1) {
        this.$set(this.tableData, doctorIndex, { ...this.selectedDoctor });
      }

      this.$message({
        message: '支付完成，挂号成功',
        type: 'success'
      });
      // 这里可以添加实际支付的逻辑
    },
    cancelPayment() {
      this.showPaymentDialog = false;
      this.$message({
        message: '支付已取消',
        type: 'info'
      });
    },
    SearchHandle(dateStr, nameStr, departmentStr) {
      console.log(dateStr); // 输出格式化后的日期字符串
      console.log(departmentStr); // 输出格式化后的日期字符串
      console.log(nameStr); // 输出格式化后的日期字符串
      // 搜索逻辑
      axios.post('/api/patient/filter', null, {
        params: {
          date: dateStr,
          department: departmentStr,
          doctorName: nameStr,
        }
      }).then(response => {
        this.tableData = response.data.data;
        console.log("结果是什么呀")
      }).catch(error => {
        console.error("搜索失败:", error);
      });
    },
    showAll() {
      axios.post('/api/patient/allCall',null)
          .then(Response =>{
            this.tableData = Response.data.data
          })
    },
    loadAll() {
      // 加载所有数据的逻辑
      axios.post('/api/patient/allCall',null)
          .then(Response =>{
            this.tableData = Response.data.data
          })
    },
    dateStrChanged(newDate) {
      if (newDate) {
        const date = new Date(newDate);
        const formattedDate = date.toLocaleDateString('en-CA'); // 'en-CA' 语言区域代码格式为 YYYY-MM-DD
        console.log(`Formatted Date: ${formattedDate}`);
        console.log(typeof (formattedDate))
      }
    }
  },
  watch: {
    dateStr(newDate) {
      this.dateStrChanged(newDate);
    }
  }
}
</script>

<style scoped>
/* 样式可以根据需要添加 */
</style>
