package com.lyjava.wms.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lyjava.wms.common.QueryPageParam;
import com.lyjava.wms.common.Result;
import com.lyjava.wms.pojo.Menu;
import com.lyjava.wms.pojo.User;
import com.lyjava.wms.service.MenuService;
import com.lyjava.wms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @GetMapping
    public String hello(){
        return "测试！！！";
    }

    @Autowired
    private UserService userService;
    @Autowired
    private MenuService menuService;

    //查询所有
    @GetMapping("/list")
    public Result list(){
        List<User> list = userService.list();
        return list.size()>0 ? Result.suc(list) : Result.fail();
    }

    //根据id查询
    @GetMapping("/selectById")
    public Result selectById(@RequestParam Long id){
        User user = userService.getById(id);
        return user!=null ? Result.suc(user) : Result.fail();
    }
    //新增
    @PostMapping("/insert")
    public Result insert(@RequestBody User user){
        boolean flag = userService.save(user);
        return flag ? Result.suc() : Result.fail();
    }
    //更新
    @PostMapping("/update")
    public Result update(@RequestBody User user){
        boolean flag = userService.updateById(user);
        return flag ? Result.suc() : Result.fail();
    }
    //删除
    @GetMapping("/delete")
    public Result delete(@RequestParam Long id){
        boolean flag = userService.removeById(id);
        return flag ? Result.suc() : Result.fail();
    }

    //列表分页
    @PostMapping("/listPage")
    public Result listPage(@RequestBody QueryPageParam queryPageParam){
        //取出其它条件参数
        HashMap param = queryPageParam.getParam();
        String name = (String) param.get("name");
        String sex = (String) param.get("sex");
        String roleId = (String) param.get("roleId");

        //获取分页参数
        Page<User> page = new Page<>();
        page.setCurrent(queryPageParam.getPageNum());
        page.setSize(queryPageParam.getPageSize());

        //设置条件构造器
        LambdaQueryWrapper<User> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(name) && !"null".equals(name)){
            lambdaQueryWrapper.like(User::getName,name);
        }
        if (StringUtils.isNotBlank(sex)){
            lambdaQueryWrapper.eq(User::getSex,sex);
        }
        if (StringUtils.isNotBlank(roleId)){
            lambdaQueryWrapper.eq(User::getRoleId,roleId);
        }

        //可以不用写返回值，数据会直接存到传入的参数page里面
        userService.page(page, lambdaQueryWrapper);

        //将总记录条数和当前页的数据返回
        return Result.suc(page.getTotal(),page.getRecords());
    }

    //查询账号是否存在
    @GetMapping("/findByUserNo")
    public Result findByUserNo(@RequestParam String userNo){
        List<User> list = userService.lambdaQuery().eq(User::getUserNo, userNo).list();
        return list.size()>0 ? Result.suc(list) : Result.fail();

    }

    //登录
    @PostMapping("/login")
    public Result login(@RequestBody User user){
        //查询对应账号和密码的用户
        List<User> list = userService.lambdaQuery().eq(User::getUserNo, user.getUserNo())
                .eq(User::getPassword,user.getPassword()).list();
        if (list.size()>0){//如果查询到的用户不为0，说明账号和密码正确
            User user1 = list.get(0);
            //查询符合用户权限的得导航菜单
            List<Menu> menuList = menuService.lambdaQuery().like(Menu::getMenuright,user1.getRoleId()).list();
            HashMap res = new HashMap();
            res.put("user",user1);
            res.put("menu",menuList);
            return Result.suc(res);//将存有用户数据的导航菜单数据的集合返回给前端
        }
        return Result.fail();//未查询到用户数据则执行该语句
    }
}
