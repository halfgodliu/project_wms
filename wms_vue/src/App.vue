<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>


//import Index from "@/components/Index";

export default {
  name: 'App',
  components: {
  },
  data(){
    return{
      user:JSON.parse(sessionStorage.getItem('CurUser')),
    }
  },
  watch:{
    //使用监视解决刷新后动态路由丢失问题，
    '$store.state.menu':{
      handler(val,old){//刷新后val里面有要添加路由数据，old中为空
        //判断当old（旧数据）为空并且this.user及其id有值时，调用方法设置路由
        if(!old&&this.user&&this.user.id){
          //调用store/index.js中的方法重新将路由添加进去
          this.$store.commit("setMenu",val)
        }
      },
      immediate:true,
    }
  }
}
</script>

<style>
  #app{
    height: 100%;
  }
</style>
