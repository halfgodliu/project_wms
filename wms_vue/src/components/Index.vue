<template>
  <el-container style="height: 100vh; border: 1px solid #eee">
    <el-aside :width="aside_width" height="100%" style="background-color: rgb(238, 241, 246);margin-left: -1px">
      <Aside></Aside>
    </el-aside>

    <el-container style="height: 100%">
      <el-header style="text-align: right; font-size: 12px">
        <Header></Header>
      </el-header>

      <el-main style="height: 100%">
<!--        <Main></Main>-->
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Aside from "@/components/Aside";
import Header from "@/components/Header";
/*import Main from "@/components/Main";*/
export default {
  name: "Index",
  data(){
    return{
      aside_width:"200px"
    }
  },
  methods:{
    changeWidth(data){
      if (data){
        this.aside_width = "64px"
      }else {
        this.aside_width = "200px"
      }
    }
  },
  components: {/*Main,*/ Header, Aside},
  mounted() {//挂载完毕之后绑定事件
    this.$bus.$on("getIsCollapse",this.changeWidth)
  },
  /*beforeDestroy() {//销毁之前解绑，避免占用资源
    this.$bus.off("getIsCollapse")
  }*/
}
</script>

<style scoped>
  .el-header {
    background-color: #B3C0D1;
    color: #333;
    line-height: 60px;
  }

  .el-main{
    padding: 10px;
  }

  .el-aside {
    color: #333;
  }
</style>