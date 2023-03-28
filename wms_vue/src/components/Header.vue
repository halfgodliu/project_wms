<template>
  <div style="display: flex;line-height: 60px">
    <div style="margin-top: 5px">
      <i :class="isFlod" style="font-size: 25px;cursor: pointer" @click="flod"></i>
    </div>
    <div style="flex: 1;text-align: center;font-size: 25px">欢迎使用仓库管理系统</div>
    <el-dropdown>
      <div>
        <span>{{user.name}}</span>
        <i class="el-icon-arrow-down" style="margin-right: 15px"></i>
      </div>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item @click.native="toUser()">个人中心</el-dropdown-item>
        <el-dropdown-item @click.native="logout()">退出登录</el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>

<script>
export default {
  name: "Header",
  data(){
    return{
      isCollapse:false,
      isFlod:"el-icon-s-fold",
      //这里从session取出来的数据字符串，要转为JSON格式才行
      user:JSON.parse(sessionStorage.getItem('CurUser')),
    }
  },
  methods: {
    toUser(){
      this.$router.push("/Home")
    },
    logout(){//退出登录
      this.$confirm('确定退出登录吗？','提示',{
        confirmButtonText:'确认',//确认按钮的文字
        type:"warning",
        center:true,//是否居中
      }).then(()=>{

        this.$message({//消息提示
          message: '退出登录成功',
          type: 'success'
        });
        this.$router.push('/')//返回登录页面
        sessionStorage.clear()//清空session中的用户数据
      }).catch(()=>{
        this.$message({//消息提示
          message: '已取消退出',
          type: 'info'
        });
      })
    },
    flod(){
      this.isCollapse = !this.isCollapse//每次点击都变化是否折叠收起菜单
      this.$bus.$emit("getIsCollapse",this.isCollapse)//将折叠状态传给其他组件
      if (!this.isCollapse){//不展开的时候修改图标
        this.isFlod = "el-icon-s-fold"
      }else {
        this.isFlod = "el-icon-s-unfold"
      }
    }
  },
  created() {
    //创建完毕之后直接跳转到个人中心
    this.$router.push("/Home")
  }
}
</script>

<style scoped>

</style>