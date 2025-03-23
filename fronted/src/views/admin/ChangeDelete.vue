<template>
  <div>
    <div class="top-panel">
      <el-select  v-model="value" placeholder="请选择修改删除的对象" style="padding-right: 30px">
        <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value">
        </el-option>
      </el-select>
      <el-button type="primary" @click="handleClick(value)" style="padding-left: 20px">请选择</el-button>
    </div>
    <div class="table-panel">
      <div class="doctor">
        <el-table v-if="doctorShow" :data="doctors" style="width: 100%">
          <el-table-column prop="account" label="账号" width="120"></el-table-column>
          <el-table-column prop="password" label="密码" width="120"></el-table-column>
          <el-table-column prop="id" label="身份证号" width="180"></el-table-column>
          <el-table-column prop="name" label="姓名" width="120"></el-table-column>
          <el-table-column prop="address" label="住址" width="200"></el-table-column>
          <el-table-column prop="phone" label="电话" width="150"></el-table-column>
          <el-table-column prop="age" label="年龄" width="80"></el-table-column>
          <el-table-column prop="sex" label="性别" width="80"></el-table-column>
          <el-table-column prop="hospital" label="医院" width="200"></el-table-column>
          <el-table-column prop="department" label="科室" width="120"></el-table-column>
          <el-table-column prop="title" label="职称" width="120"></el-table-column>
          <el-table-column prop="speciality" label="专长" width="120"></el-table-column>
          <el-table-column label="操作" width="180">
            <template slot-scope="scope">
              <el-button size="mini" type="danger" @click="handleDeleteDoctor(scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>

<!--        <el-dialog :visible.sync="doctorDialog" title="编辑医生信息">-->
<!--          <el-form :model="editDoctor" label-width="100px">-->
<!--            <el-form-item label="账号">-->
<!--              <el-input v-model="editDoctor.account"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="密码">-->
<!--              <el-input v-model="editDoctor.password" type="password"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="身份证号">-->
<!--              <el-input v-model="editDoctor.id"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="姓名">-->
<!--              <el-input v-model="editDoctor.name"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="住址">-->
<!--              <el-input v-model="editDoctor.address"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="电话">-->
<!--              <el-input v-model="editDoctor.phone"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="年龄">-->
<!--              <el-input-number v-model="editDoctor.age"></el-input-number>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="性别">-->
<!--              <el-input v-model="editDoctor.sex"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="医院">-->
<!--              <el-input v-model="editDoctor.hospital"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="科室">-->
<!--              <el-input v-model="editDoctor.department"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="职称">-->
<!--              <el-input v-model="editDoctor.title"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="专长">-->
<!--              <el-input v-model="editDoctor.speciality"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item>-->
<!--              <el-button type="primary" @click="saveInfoDoctor">保存</el-button>-->
<!--            </el-form-item>-->
<!--          </el-form>-->
<!--        </el-dialog>-->
      </div>
      <div class="patient">
        <el-table v-if="patientShow" :data="patients" style="width: 100%">
          <el-table-column prop="account" label="账号" width="120"></el-table-column>
          <el-table-column prop="password" label="密码" width="120"></el-table-column>
          <el-table-column prop="id" label="身份证号" width="180"></el-table-column>
          <el-table-column prop="name" label="姓名" width="120"></el-table-column>
          <el-table-column prop="address" label="住址" width="200"></el-table-column>
          <el-table-column prop="phone" label="电话" width="150"></el-table-column>
          <el-table-column prop="age" label="年龄" width="80"></el-table-column>
          <el-table-column prop="sex" label="性别" width="80"></el-table-column>
          <el-table-column prop="record" label="病历" width="300"></el-table-column>
          <el-table-column label="操作" width="180">
            <template slot-scope="scope">
              <el-button size="mini" type="danger" @click="handleDeletePatient(scope.row, 'patient')">删除</el-button>
            </template>
          </el-table-column>
        </el-table>

<!--      &lt;!&ndash; 编辑患者信息对话框 &ndash;&gt;-->
<!--      <el-dialog :visible.sync="patientDialog" title="编辑患者信息">-->
<!--        <el-form :model="editPatient" label-width="100px">-->
<!--          <el-form-item label="账号">-->
<!--            <el-input v-model="editPatient.account"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="密码">-->
<!--            <el-input v-model="editPatient.password" type="password"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="身份证号">-->
<!--            <el-input v-model="editPatient.id" disabled></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="姓名">-->
<!--            <el-input v-model="editPatient.name"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="住址">-->
<!--            <el-input v-model="editPatient.address"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="电话">-->
<!--            <el-input v-model="editPatient.phone"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="年龄">-->
<!--            <el-input-number v-model="editPatient.age"></el-input-number>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="性别">-->
<!--            <el-input v-model="editPatient.sex"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="病历">-->
<!--            <el-input v-model="editPatient.record"></el-input>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-button type="primary" @click="saveInfoPatient('patient')">保存</el-button>-->
<!--          </el-form-item>-->
<!--        </el-form>-->
<!--      </el-dialog>-->
      </div>
      <div class="admin">
          <el-table v-if="adminShow" :data="admins" style="width: 100%">
            <el-table-column prop="account" label="账号" width="120"></el-table-column>
            <el-table-column prop="password" label="密码" width="120"></el-table-column>
            <el-table-column prop="id" label="身份证号" width="180"></el-table-column>
            <el-table-column prop="name" label="姓名" width="120"></el-table-column>
            <el-table-column prop="address" label="住址" width="200"></el-table-column>
            <el-table-column prop="phone" label="电话" width="150"></el-table-column>
            <el-table-column label="操作" width="180">
              <template slot-scope="scope">
                <el-button size="mini" type="danger" @click="handleDeleteAdmin(scope.row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>

<!--        &lt;!&ndash; 编辑管理员信息对话框 &ndash;&gt;-->
<!--        <el-dialog :visible.sync="adminDialog" title="编辑管理员信息">-->
<!--          <el-form :model="editAdmin" label-width="100px">-->
<!--            <el-form-item label="账号">-->
<!--              <el-input v-model="editAdmin.account"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="密码">-->
<!--              <el-input v-model="editAdmin.password" type="password"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="身份证号">-->
<!--              <el-input v-model="editAdmin.id" disabled></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="姓名">-->
<!--              <el-input v-model="editAdmin.name"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="住址">-->
<!--              <el-input v-model="editAdmin.address"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item label="电话">-->
<!--              <el-input v-model="editAdmin.phone"></el-input>-->
<!--            </el-form-item>-->
<!--            <el-form-item>-->
<!--              <el-button type="primary" @click="saveAdminInfo">保存</el-button>-->
<!--            </el-form-item>-->
<!--          </el-form>-->
<!--        </el-dialog>-->
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data(){
    return{
      doctorShow:true,
      patientShow:false,
      adminShow:false,
      value:'',
      options:[
          {label:'医生',value:'doctor'},
          {label:'病人',value:'patient'},
          {label:'管理员',value:'admin'},
      ],
      doctorDialog:false,
      patientDialog:false,
      adminDialog:false,
      doctors: [
        {
          uid: 3,
          account: "doctor03",
          password: "666666",
          id: "110122198305235844",
          name: "医生03",
          address: "北京市昌平区沙河镇南丰路5号",
          phone: "18765952356",
          age: 41,
          sex: "女",
          hospital: "北京市昌平区第一人民医院",
          department: "急诊科",
          title: "医士",
          speciality: "护理",
          approved: 1
        },],
      patients: [
        {
          uid: 1,
          account: "patient01",
          password: "222222",
          id: "100110200406072222",
          name: "小明",
          address: "北京邮电大学",
          phone: "13512341234",
          age: 20,
          sex: "男",
          record: "患者有夜盲症",
          approved: 1
        },],
      admins:[
        {
          uid: 2,
          account: "admin02",
          password: "111111",
          id: "110127199402041318",
          name: "管理员01",
          address: "北京市海淀区西土城路09号",
          phone: "13818649727",
          approved: 1
        },
      ],
      editDoctor: {},
      editPatient: {},
      editAdmin:{},
    }
  },
  mounted() {
    this.loadDoctor()
  },
  methods: {
    handleChangeAdmin(row){
      console.log(row)

    },
    loadDoctor(){
      axios.post('/api/admin/getAllDoctor',null,{
        params:{choice:1}
      }).then(Response =>
          this.doctors = Response.data.data)
    },
    loadPatient(){
      axios.post('/api/admin/getAllPatient',null,{
        params:{choice:1}
      }).then(Response =>
          this.patients = Response.data.data)
    },
    loadAdmin(){
      axios.post('/api/admin/getAllAdmin',null,{
        params:{choice:1}
      }).then(Response =>
          this.admins = Response.data.data)
    },
    handleClick(value){
      if(value === 'doctor'){
        this.doctorShow = true
        this.patientShow = false
        this.adminShow = false
        this.loadDoctor()
      }
      else if(value === 'patient'){
        this.patientShow = true
        this.doctorShow = false
        this.adminShow = false
        this.loadPatient()
      }

      else if( value === 'admin'){
        this.adminShow = true
        this.patientShow = false
        this.doctorShow = false
        this.loadAdmin()
      }
    },
    handleDeleteDoctor(row) {
      axios.post('/api/admin/delete',null,{
        params:{
          type:'doctor',
          account:row.account
        }
      })
      const index = this.doctors.indexOf(row);
      if (index !== -1) {
        this.doctors.splice(index, 1);
        this.$message({
          type: 'success',
          message: '用户删除成功'
        });
      }
    },
    handleDeletePatient(row) {
      axios.post('/api/admin/delete',null,{
        params:{
          type:'patient',
          account:row.account
        }
      })
      const index = this.doctors.indexOf(row);
      if (index !== -1) {
        this.doctors.splice(index, 1);
        this.$message({
          type: 'success',
          message: '用户删除成功'
        });
      }
    },
    handleDeleteAdmin(row) {
      axios.post('/api/admin/delete',null,{
        params:{
          type:'admin',
          account:row.account
        }
      })
      const index = this.admins.indexOf(row);
      if (index !== -1) {
        this.admins.splice(index, 1);
        this.$message({
          type: 'success',
          message: '管理员删除成功'
        });
      }
    },
  }
}

</script>



<style scoped>

</style>
