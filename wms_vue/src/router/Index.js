/*路由器*/
import VueRouter from 'vue-router';

const router = new VueRouter({
    mode:'history',
    routes:[
        {//登录
            path:"/",
            name:'login',
            component:()=>import('../components/Login')
        },
        {//
            path:"/Index",
            name:'index',
            component:()=>import('../components/Index'),
            children:[
                {//首页（个人中心）
                    path:"/Home",
                    name:'home',
                    meta:{
                        title:"首页"
                    },
                    component:()=>import('../components/Home')
                },
                /*{//管理员管理
                    path:"/Admin",
                    name:'admin',
                    meta:{
                        title:"管理员管理"
                    },
                    component:()=>import('../components/admin/AdminManage')
                },
                {//用户管理
                    path:"/User",
                    name:'user',
                    meta:{
                        title:"用户管理"
                    },
                    component:()=>import('../components/user/UserManage')
                },*/
            ]
        },
    ]
})

//解决点击个人中心之后报错问题
const VueRouterPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(to){
    return VueRouterPush.call(this,to).catch(err=>err)
}
//用于重置路由，解决动态路由中路由重复而出现警告
export function resetRouter() {
    router.matcher = new VueRouter({
        mode:'history',
        routes: []
    }).matcher
}

export default router;

