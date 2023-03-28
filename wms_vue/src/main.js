import Vue from 'vue'
import App from './App.vue'
/*//局部引入element-ui
import { Button, Select } from 'element-ui';*/
//全局引入element-ui
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/global.css';//引入全局样式
import axios from "axios";
import VueRouter from 'vue-router';
import router from './router/Index'
import store from './store/index'//引入store（使用vuex）

/*//局部引入element-ui
Vue.component(Button.name, Button);
Vue.component(Select.name, Select);*/
//全局引入element-ui
Vue.use(ElementUI,{size:'small'});
Vue.use(VueRouter)
Vue.prototype.$axios=axios
//把地址不会变得部分设成全局，避免后面重复写
Vue.prototype.$httpUrl='http://localhost:8090'

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App),
  beforeCreate() {
    Vue.prototype.$bus = this//安装全局事件总线
  }
}).$mount('#app')
