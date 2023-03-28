<template>
  <div>
    <!--传参查询和新增-->
    <div style="margin-bottom: 5px">
      <!--根据根据名字模糊查询-->
      <el-input v-model="queryName" placeholder="请输入分类名" @keyup.enter.native="loadPost"
                style="width: 200px"
                suffix-icon="el-icon-edit"></el-input>
      <!--对所写和所选择的内容进行查询和清空的按钮-->
      <el-button type="primary" round style="margin-left: 8px" @click="loadPost">查询</el-button>
      <el-button type="success" round @click="reSetQuery">清空</el-button>
      <!--新增按钮-->
      <el-button type="primary" style="margin-left: 40px" @click="insert">新增</el-button>
    </div>
    <!--列表（主体部分）-->
    <el-table :data="tableData"
              :header-cell-style="{background:'lightgray', color:'white'}"
              border><!--下面的prop要和数据里面的属性名对应上-->
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="name" label="分类名" width="150">
      </el-table-column>
      <el-table-column prop="remark" label="备注">
      </el-table-column>
      <!--列表中的操作栏-->
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="small" type="primary" @click="mod(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除该分类吗？" style="margin-left: 10px"
                         @confirm="del(scope.row.id)">
            <el-button slot="reference" type="danger" >删除</el-button>
          </el-popconfirm>
          <!--          <el-button size="small" type="danger" @click="del">删除</el-button>-->
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
    <!--点击新增时的对话框-->
    <el-dialog
        title="新增"
        :visible.sync="insertBox"
        width="30%"
        center>
      <span>
        <!--收集数据的表单-->
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
          <el-form-item label="分类名" prop="name">
            <el-col :span="19">
              <el-input v-model="form.name"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-col :span="19">
              <el-input type="textarea" v-model="form.remark"></el-input>
            </el-col>
          </el-form-item>
        </el-form>
      </span>
      <!--对话框底部的取消和确认按钮-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="insertBox = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "GoodsTypeManage",
  data() {
    return{
      tableData:null,//查询到的数据（当前页）
      pageNum:1,//当前页数
      pageSize:10,//每页数据条数
      pageTotal:0,//数据总条数
      queryName:'',//要模糊查询的姓名字段
      insertBox:false,//是否弹出新增用的对话框
      form:{//放在表单上的数据
        id:'',
        name:'',
        remark:'',
      },
      rules: {//用于验证新增表单格式等是否正确
        name: [
          { required: true, message: '请输入分类名', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
        ],
      }
    }
  },
  methods:{
    mod(row){//修改（编辑，更新）的方法
      this.insertBox=true
      this.$nextTick(()=>{
        this.form.id=row.id;
        this.form.name=row.name;
        this.form.remark=row.remark;
      })
    },
    del(id){//删除
      this.$axios.get(this.$httpUrl+'/goodstype/delete?id='+id).then(res=>res.data).then(res=>{
        if (res.code==200){//先判断数据是否获取成功
          this.$message({//成功后消息提示成功
            message: '删除成功！！！',
            type: 'success'
          });
          this.loadPost();
        }else {
          this.$message.error('删除失败');
        }
      })
    },
    resetForm(){//重置新增表单
      this.$refs.form.resetFields();
    },
    insert(){//弹出新增框的方法
      this.insertBox=true;
      this.$nextTick(()=>{//$nextTick作用：第一次不会执行，等到下一次调用的时候再执行
        this.resetForm()
      })
    },
    doMod(){//进行修改（编辑）操作
      this.$axios.post(this.$httpUrl+'/goodstype/update',this.form).then(res=>res.data).then(res=>{
        if (res.code==200){//先判断数据是否获取成功
          this.$message({//成功后消息提示成功
            message: '更新成功！！！',
            type: 'success'
          });
          this.insertBox=false;
          this.loadPost();
        }else {
          this.$message.error('更新失败');
        }
      })
    },
    doSave(){//将新增数据发送到后端保存
      this.$axios.post(this.$httpUrl+'/goodstype/insert',this.form).then(res=>res.data).then(res=>{
        if (res.code==200){//先判断数据是否获取成功
          this.$message({//成功后消息提示成功
            message: '添加成功！！！',
            type: 'success'
          });
          this.insertBox=false;
          this.loadPost();
        }else {
          this.$message.error('添加失败');
        }
      })
    },
    save(){//将填写好的新增数据发送到后端保存的方法，后面修改也会用到
      this.$refs.form.validate((valid) => {//发送到后端之前先验证表单数据格式等
        if (valid) {//格式等没有问题后再发送到后端
          if (this.form.id){//这里其实可以通过后端saveOrUpdate()方法来完成（这里没有用）
            this.doMod();
          }else {
            this.doSave();
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    reSetQuery(){//清空（重置）查询参数
      this.queryName='';
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
      this.$axios.post(this.$httpUrl+'/goodstype/listPage',{
        pageNum:this.pageNum,
        pageSize:this.pageSize,
        param:{//要查询的条件参数
          name:this.queryName,
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