<template>
  <div>
    <!--传参查询和新增-->
    <div style="margin-bottom: 5px">
      <!--根据根据名字模糊查询-->
      <el-input v-model="queryName" placeholder="请输入名字" @keyup.enter.native="loadPost"
                style="width: 200px"
                suffix-icon="el-icon-edit"></el-input>
      <!--根据性别查询-->
      <el-select v-model="querySex" placeholder="性别" style="width: 100px">
        <el-option
            v-for="item in sexs"
            :key="item.value"
            :label="item.label"
            :value="item.value">
        </el-option>
      </el-select>
      <!--对所写和所选择的内容进行查询和清空的按钮-->
      <el-button type="primary" round style="margin-left: 8px" @click="loadPost">查询</el-button>
      <el-button type="success" round @click="reSetQuery">清空</el-button>
    </div>
    <!--列表（主体部分）-->
    <el-table :data="tableData"
              :header-cell-style="{background:'lightgray', color:'white'}"
              highlight-current-row
              @current-change="selectUser"
              border><!--下面的prop要和数据里面的属性名对应上-->
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="userNo" label="账号" width="150">
      </el-table-column>
      <el-table-column prop="name" label="姓名" width="150">
      </el-table-column>
      <el-table-column prop="sex" label="性别" width="80">
        <template slot-scope="scope">
          <el-tag
              :type="scope.row.sex === 1 ? 'primary' : 'success'"
              disable-transitions>{{scope.row.sex === 1 ? '男' : '女'}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="age" label="年龄" width="80">
      </el-table-column>
      <el-table-column prop="phone" label="手机号" width="150">
      </el-table-column>
      <el-table-column prop="roleId" label="类别">
        <template slot-scope="scope">
          <el-tag
              :type="scope.row.roleId === 0 ? 'danger' : (scope.row.roleId === 1 ? 'primary' : 'success')"
              disable-transitions>{{scope.row.roleId === 0 ? '超级管理员' : (scope.row.roleId === 1 ? '管理员' : '普通用户')}}</el-tag>
        </template>
      </el-table-column>
    </el-table>
    <!--分页查询，可以选择每页数据量和跳转页数-->
    <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="pageNum"
        :page-sizes="[2, 5, 10, 20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="pageTotal">
    </el-pagination>
  </div>
</template>

<script>
export default {
  name: "SelectUser",
  data() {
    return{
      tableData:null,//查询到的数据（当前页）
      pageNum:1,//当前页数
      pageSize:10,//每页数据条数
      pageTotal:0,//数据总条数
      queryName:'',//要模糊查询的姓名字段
      querySex:null,
      sexs: [{//性别选择
        value: '1',
        label: '男'
      }, {
        value: '2',
        label: '女'
      }],
    }
  },
  methods:{
    selectUser(row){//选中用户时触发
      this.$emit("selectUser",row)//将选中的那行用户数据传给父组件
      console.log(row)
    },
    reSetQuery(){//清空（重置）查询参数
      this.queryName='';
      this.querySex=null;
      this.loadPost();
    },
    handleSizeChange(val) {//分页查询方法，修改每页条数后执行
      console.log(`每页 ${val} 条`);
      this.pageSize = val;
      //每次pageSize变化pageNum都跳回第一页，并且重新发送一次请求，获取最新的分页数据
      this.pageNum = 1;
      this.loadPost();
    },
    handleCurrentChange(val) {//分页查询方法，修改当前页数后执行
      console.log(`当前页: ${val}`);
      this.pageNum = val;
      //当前页发生变化时发送一次请求，获取最新的分页数据
      this.loadPost();
    },
    loadPost(){//传入分页和条件参数，获取分页数据
      this.$axios.post(this.$httpUrl+'/user/listPage',{
        pageNum:this.pageNum,
        pageSize:this.pageSize,
        param:{//要查询的条件参数
          name:this.queryName,
          sex:this.querySex,
          roleId:'2'
        }
      }).then(res=>res.data).then(res=>{
        if (res.code==200){//先判断数据是否获取成功
          this.tableData=res.data
          this.pageTotal=res.total//总数据条数
        }else {
          alert("获取数据失败，请重试！！！")
        }
      })
    }
  },
  beforeMount() {
    //挂载之前执行，把数据加载出来
    this.loadPost()
  }
}
</script>

<style scoped>

</style>