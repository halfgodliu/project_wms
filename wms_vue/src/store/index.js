import Vue from "vue"
import Vuex from "vuex"
import router,{resetRouter} from "../router/Index"
import createPersistedState from 'vuex-persistedstate'
Vue.use(Vuex)

//用于动态添加路由
function addNewRoute(menuList){
    let routes = router.options.routes//先获取路由器中的数据
    routes.forEach(routeItem=>{//遍历路由器中的一级路由
        if (routeItem.path=="/Index"){//找到需要动态添加子路由的一级路由
            menuList.forEach(menu=>{//遍历导航菜单数据
                //编写子路由
                let childRoute = {
                    path:"/"+menu.menuclick,
                    name:menu.menuname,
                    meta:{
                        title:menu.menuname
                    },
                    component:()=>import('../components/'+menu.menucomponent)
                }
                routeItem.children.push(childRoute)//将编写好的子路由放到"/Index"对应的一级路由中
            })
        }
    })
    resetRouter();//重置（清空）路由器，避免内容重复而出现警告
    router.addRoutes(routes)//将编写好的路由放到路由器中
}

const state = {
    menu:[]
}
const mutations = {
    setMenu(state,menuList){
        state.menu=menuList
        addNewRoute(menuList)//动态添加路由
    }
}
const getters = {
    getMenu(state){
        return state.menu
    }
}

export default new Vuex.Store({
    state,mutations,getters,
    plugins:[createPersistedState()]//解决vuex浏览器刷新丢失数据问题
})