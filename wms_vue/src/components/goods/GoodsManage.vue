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
      <!--新增按钮-->
      <el-button type="primary" style="margin-left: 30px" @click="insert" v-if="user.roleId!=2">新增</el-button>
      <!--出入库按钮-->
      <el-button type="primary" round plain style="margin-left: 30px" @click="inGoods" v-if="user.roleId!=2">入库</el-button>
      <el-button type="primary" round plain style="margin-left: 5px" @click="outGoods" v-if="user.roleId!=2">出库</el-button>
    </div>
    <!--列表（主体部分）-->
    <el-table :data="tableData"
              :header-cell-style="{background:'lightgray', color:'white'}"
              highlight-current-row
              @current-change="selectCurrentChange"
              border><!--下面的prop要和数据里面的属性名对应上-->
      <el-table-column prop="id" label="ID" width="100">
      </el-table-column>
      <el-table-column prop="name" label="物品名" width="150">
      </el-table-column>
      <el-table-column prop="storage" label="仓库" width="120" :formatter="formatStorage">
      </el-table-column>
      <el-table-column prop="goodstype" label="分类" width="120" :formatter="formatGoodsType">
      </el-table-column>
      <el-table-column prop="count" label="数量" width="120">
      </el-table-column>
      <el-table-column prop="remark" label="备注">
      </el-table-column>
      <!--列表中的操作栏-->
      <el-table-column label="操作" v-if="user.roleId!=2">
        <template slot-scope="scope">
          <el-button size="small" type="primary" @click="mod(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除该物品吗？" style="margin-left: 10px"
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
        :visible.sync="insertDialog"
        width="30%"
        center>
      <span>
        <!--收集数据的表单-->
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
          <el-form-item label="物品名" prop="name">
            <el-col :span="19">
              <el-input v-model="form.name"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="仓库" prop="storage">
            <el-col :span="19">
              <el-select v-model="form.storage" placeholder="仓库" style="width: 90px">
                <el-option
                    v-for="item in storageData"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id">
                </el-option>
              </el-select>
            </el-col>
          </el-form-item>
          <el-form-item label="分类" prop="goodstype">
            <el-col :span="19">
              <el-select v-model="form.goodstype" placeholder="分类" style="width: 90px">
                <el-option
                    v-for="item in goodsTypeData"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id">
                </el-option>
              </el-select>
            </el-col>
          </el-form-item>
          <el-form-item label="数量" prop="count">
            <el-col :span="19">
              <el-input v-model="form.count"></el-input>
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
        <el-button @click="insertDialog = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </span>
    </el-dialog>
    <!--点击出入库时的对话框-->
    <el-dialog
        title="出入库"
        :visible.sync="inOutDialog"
        width="30%"
        center>
      <!--出入库时选择申请人弹出的对话框（内层嵌套对话框）-->
      <el-dialog
          width="70%"
          title="选择申请人"
          :visible.sync="innerDialog"
          append-to-body>
        <!--SelectUser组件-->
        <SelectUser @selectUser="doSelectUser"></SelectUser>
        <span slot="footer" class="dialog-footer">
          <el-button @click="innerDialog = false">取 消</el-button>
          <el-button type="primary" @click="confirmUser">确 定</el-button>
        </span>
      </el-dialog>
      <span>
        <!--收集出入库数据的表单-->
        <el-form ref="inOutForm" :model="inOutForm" :rules="inOutRules" label-width="80px">
          <el-form-item label="物品名" prop="goodsName">
            <el-col :span="19">
              <el-input v-model="inOutForm.goodsName" readonly></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="申请人" prop="userName">
            <el-col :span="19">
              <el-input v-model="inOutForm.userName" @click.native="selectUser" readonly></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="数量" prop="count">
            <el-col :span="19">
              <el-input v-model="inOutForm.count"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-col :span="19">
              <el-input type="textarea" v-model="inOutForm.remark"></el-input>
            </el-col>
          </el-form-item>
        </el-form>
      </span>
      <!--出入库对话框底部的取消和确认按钮-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="inOutDialog = false">取 消</el-button>
        <el-button type="primary" @click="inOut">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  import SelectUser from "@/components/user/SelectUser";
  export default {
    name: "GoodsManage",
    components:{SelectUser},
    data() {
      //对表单物品数量进行验证
      let checkCount = (rule, value, callback) => {
        if(value>9999){
          callback(new Error('数量输⼊过⼤'));
        }else{
          callback();
        }
      };
      return{
        user:JSON.parse(sessionStorage.getItem('CurUser')),//获取登录的用户数据
        applyUser:{},//出入库中申请人的数据（从SelectUser组件中获取的）
        rowCurrent:{},//选中的那一行数据
        goodsTypeData:null,//存储物品类型数据
        storageData:null,//存储仓库数据
        tableData:null,//查询到的数据（当前页）
        pageNum:1,//当前页数
        pageSize:10,//每页数据条数
        pageTotal:0,//数据总条数
        queryName:'',//要模糊查询的姓名字段
        queryStorage:'',//要查询的仓库名
        queryGoodsType:'',//要查询的分类名
        insertDialog:false,//是否弹出新增用的对话框
        inOutDialog:false,//是否弹出出入库的对话框
        innerDialog:false,//是否弹出选择申请人的对话框
        form:{//放在表单上的数据
          id:'',
          name:'',
          storage:'',
          goodstype:'',
          count:0,
          remark:'',
        },
        inOutForm:{//放在出入库表单上的数据
          goodsId:'',
          goodsName:'',
          adminId:'',
          userId:'',
          userName:'',
          count:'',
          remark:'',
          addOrSub:'1',//'1'表示入库，'2'表示出库
        },
        inOutRules:{//用于验证出入库表单格式等是否正确
          userName: [
            { required: true, message: '请选择申请人', trigger: 'blur' },
          ],
          count: [
            {required: true, message: '请输⼊数量', trigger: 'blur'},
            {pattern: /^([1-9][0-9]*){1,4}$/,message: '数量必须为正整数字',trigger: "blur"},
            {validator:checkCount,trigger: 'blur'}
          ],
        },
        rules: {//用于验证新增表单格式等是否正确
          name: [
            { required: true, message: '请输入物品名', trigger: 'blur' },
            { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
          ],
          storage: [
            { required: true, message: '请选择仓库', trigger: 'blur' },
          ],
          goodstype: [
            { required: true, message: '请选择分类', trigger: 'blur' },
          ],
          count: [
            {required: true, message: '请输⼊数量', trigger: 'blur'},
            {pattern: /^([1-9][0-9]*){1,4}$/,message: '数量必须为正整数字',trigger: "blur"},
            {validator:checkCount,trigger: 'blur'}
          ],
        }
      }
    },
    methods:{
      confirmUser(){//点击申请人对话框（内层嵌套对话框）确认按钮后执行
        this.inOutForm.userId=this.applyUser.id;
        this.inOutForm.userName=this.applyUser.name;
        this.innerDialog=false
      },
      doSelectUser(data){//在子组件中选择好用户后触发的事件
        this.applyUser=data
      },
      selectUser(){//出入库时点击申请人时触发（选择申请人）
        this.innerDialog=true
      },
      selectCurrentChange(row){//选中列表中的某行物品数据时触发
        this.rowCurrent=row
      },
      formatStorage(row){//显示仓库名（而不是仓库id）
        let temp =  this.storageData.find(item=>{//找到该物品仓库id所对应的仓库名
          return item.id == row.storage
        })
        return temp.name
      },
      formatGoodsType(row){//显示仓库名（而不是仓库id）
        let temp =  this.goodsTypeData.find(item=>{//找到该物品分类id所对应的分类名
          return item.id == row.goodstype
        })
        return temp.name
      },
      mod(row){//修改（编辑，更新）的方法
        this.insertDialog=true
        this.$nextTick(()=>{
          this.form.id=row.id;
          this.form.name=row.name;
          this.form.storage=row.storage;
          this.form.goodstype=row.goodstype;
          this.form.count=row.count;
          this.form.remark=row.remark;
        })
      },
      del(id){//删除
        this.$axios.get(this.$httpUrl+'/goods/delete?id='+id).then(res=>res.data).then(res=>{
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
      resetInOutForm(){//重置出入库表单
        this.$refs.inOutForm.resetFields();
      },
      resetForm(){//重置新增表单
        this.$refs.form.resetFields();
      },
      inGoods(){//入库的方法
        if (!this.rowCurrent||!this.rowCurrent.id){
          alert("请选择物品");
          return;
        }
        this.inOutDialog=true
        this.$nextTick(()=>{//$nextTick作用：第一次不会执行，等到下一次调用的时候再执行
          this.resetInOutForm()
        });
        this.inOutForm.goodsId=this.rowCurrent.id;
        this.inOutForm.goodsName=this.rowCurrent.name;
        this.inOutForm.adminId=this.user.id;
        this.inOutForm.addOrSub="1";//表示入库
      },
      outGoods(){//出库的方法
        if (!this.rowCurrent||!this.rowCurrent.id){
          alert("请选择物品");
          return;
        }
        this.inOutDialog=true
        this.$nextTick(()=>{//$nextTick作用：第一次不会执行，等到下一次调用的时候再执行
          this.resetInOutForm()
        });
        this.inOutForm.goodsId=this.rowCurrent.id;
        this.inOutForm.goodsName=this.rowCurrent.name;
        this.inOutForm.adminId=this.user.id;
        this.inOutForm.addOrSub="2";//表示入库
      },
      insert(){//弹出新增框的方法
        this.insertDialog=true;
        this.$nextTick(()=>{//$nextTick作用：第一次不会执行，等到下一次调用的时候再执行
          this.resetForm()
        })
      },
      doInOut(){//将出入库的数据发送到后端保存
        this.$axios.post(this.$httpUrl+'/record/save',this.inOutForm).then(res=>res.data).then(res=>{
          if (res.code==200){//先判断数据是否获取成功
            this.$message({//成功后消息提示成功
              message: '添加成功！！！',
              type: 'success'
            });
            this.inOutDialog=false;
            this.loadPost();
          }else {
            this.$message.error('添加失败');
          }
        })
      },
      inOut(){//点击出入库的确认按钮后执行
        this.$refs.inOutForm.validate((valid) => {//发送到后端之前先验证表单数据格式等
          if (valid) {//格式等没有问题后再发送到后端
            this.doInOut();
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      doMod(){//进行修改（编辑）操作
        this.$axios.post(this.$httpUrl+'/goods/update',this.form).then(res=>res.data).then(res=>{
          if (res.code==200){//先判断数据是否获取成功
            this.$message({//成功后消息提示成功
              message: '更新成功！！！',
              type: 'success'
            });
            this.insertDialog=false;
            this.loadPost();
          }else {
            this.$message.error('更新失败');
          }
        })
      },
      doSave(){//将新增数据发送到后端保存
        this.$axios.post(this.$httpUrl+'/goods/insert',this.form).then(res=>res.data).then(res=>{
          if (res.code==200){//先判断数据是否获取成功
            this.$message({//成功后消息提示成功
              message: '添加成功！！！',
              type: 'success'
            });
            this.insertDialog=false;
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
        this.$axios.post(this.$httpUrl+'/goods/listPage',{
          pageNum:this.pageNum,
          pageSize:this.pageSize,
          param:{//要查询的条件参数
            name:this.queryName,
            storage:this.queryStorage+'',
            goodstype:this.queryGoodsType+'',
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