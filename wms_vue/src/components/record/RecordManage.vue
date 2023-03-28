<template>
  <div>
    <!--传参查询和新增-->
    <div style="margin-bottom: 5px">
      <!--根据根据名字模糊查询-->
      <el-input v-model="queryName" placeholder="请输入物品名" @keyup.enter.native="loadPost"
                style="width: 200px"
                suffix-icon="el-icon-edit"></el-input>
      <!--根据仓库查询-->
      <el-select v-model="queryStorage" placeholder="仓库" style="width: 90px">
        <el-option
            v-for="item in storageData"
            :key="item.id"
            :label="item.name"
            :value="item.id">
        </el-option>
      </el-select>
      <!--根据分类查询-->
      <el-select v-model="queryGoodsType" placeholder="分类" style="width: 90px">
        <el-option
            v-for="item in goodsTypeData"
            :key="item.id"
            :label="item.name"
            :value="item.id">
        </el-option>
      </el-select>
      <!--对所写和所选择的内容进行查询和清空的按钮-->
      <el-button type="primary" round style="margin-left: 8px" @click="loadPost">查询</el-button>
      <el-button type="success" round @click="reSetQuery">清空</el-button>
    </div>
    <!--列表（主体部分）-->
    <el-table :data="tableData"
              :header-cell-style="{background:'lightgray', color:'white'}"
              border><!--下面的prop要和数据里面的属性名对应上-->
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="goodsName" label="物品名" width="120">
      </el-table-column>
      <el-table-column prop="storageName" label="仓库" width="100">
      </el-table-column>
      <el-table-column prop="goodstypeName" label="分类" width="100">
      </el-table-column>
      <el-table-column prop="userName" label="申请人" width="100">
      </el-table-column>
      <el-table-column prop="adminName" label="操作人" width="100">
      </el-table-column>
      <el-table-column prop="count" label="数量" width="100">
      </el-table-column>
      <el-table-column prop="createtime" label="操作时间" width="150">
      </el-table-column>
      <el-table-column prop="remark" label="备注">
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
    name: "RecordManage",
    data() {
      return{
        user:JSON.parse(sessionStorage.getItem('CurUser')),//获取登录的用户数据
        goodsTypeData:null,//存储物品类型数据
        storageData:null,//存储仓库数据
        tableData:null,//查询到的数据（当前页）
        pageNum:1,//当前页数
        pageSize:10,//每页数据条数
        pageTotal:0,//数据总条数
        queryName:'',//要模糊查询的姓名字段
        queryStorage:'',//要查询的仓库名
        queryGoodsType:'',//要查询的分类名
        insertBox:false,//是否弹出新增用的对话框
        form:{//放在表单上的数据
          id:'',
          name:'',
          storage:'',
          goodstype:'',
          count:0,
          remark:'',
        },
      }
    },
    methods:{
      reSetQuery(){//清空（重置）查询参数
        this.queryName='';
        this.queryStorage='';
        this.queryGoodsType='';
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
      loadStorage(){//加载所有仓库的数据，方便将仓库id显示为仓库名
        this.$axios.get(this.$httpUrl+'/storage/list').then(res=>res.data).then(res=>{
          if (res.code==200){//先判断数据是否获取成功
            this.storageData=res.data
          }else {
            alert("获取数据失败，请重试！！！")
          }
        })
      },
      loadGoodsType(){//加载所有仓库的数据，方便将仓库id显示为仓库名
        this.$axios.get(this.$httpUrl+'/goodstype/list').then(res=>res.data).then(res=>{
          if (res.code==200){//先判断数据是否获取成功
            this.goodsTypeData=res.data
          }else {
            alert("获取数据失败，请重试！！！")
          }
        })
      },
      loadPost(){//传入分页和条件参数，获取分页数据
        this.$axios.post(this.$httpUrl+'/record/listPage',{
          pageNum:this.pageNum,
          pageSize:this.pageSize,
          param:{//要查询的条件参数
            name:this.queryName,
            storage:this.queryStorage+'',
            goodstype:this.queryGoodsType+'',
            roleId:this.user.roleId+"",
            userId:this.user.id+"",
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
      this.loadStorage()//获取仓库数据
      this.loadGoodsType()//获取物品分类数据
      //挂载之前执行，把数据加载出来
      this.loadPost()
    }
  }
</script>

<style scoped>

</style>