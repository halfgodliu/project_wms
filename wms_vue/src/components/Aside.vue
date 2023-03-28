<template>
  <el-menu
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
      default-active="/Home"
      style="height: 100%;"
      :collapse="isCollapse"
      :collapse-transition=false
      router>
    <el-menu-item index="/Home">
      <i class="el-icon-s-home"></i>
      <span slot="title">首页</span>
    </el-menu-item>
    <el-menu-item :index="'/'+item.menuclick" v-for="(item,index) in menu" :key='index'>
      <i :class="item.menuicon"></i>
      <span slot="title">{{item.menuname}}</span>
    </el-menu-item>
  </el-menu>
</template>

<script>
  export default {
    name: "Aside",
    data(){
      return{
        isCollapse:false,//是否折叠
      }
    },
    computed:{
      menu(){
        return this.$store.state.menu;
      }
    },
    methods:{
      changeCollapse(data){//通过全局事件总线获取到数据之后决定是否折叠
        this.isCollapse = data
      }
    },
    mounted() {//挂载完毕之后绑定事件
      this.$bus.$on("getIsCollapse",this.changeCollapse)
    },
    /*beforeDestroy() {//销毁之前解绑，避免占用资源
      this.$bus.off("getIsCollapse")
    }*/
  }
</script>

<style scoped>

</style>