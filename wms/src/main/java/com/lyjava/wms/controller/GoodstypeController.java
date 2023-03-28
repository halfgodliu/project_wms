package com.lyjava.wms.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lyjava.wms.common.QueryPageParam;
import com.lyjava.wms.common.Result;
import com.lyjava.wms.pojo.Goodstype;
import com.lyjava.wms.service.GoodstypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/goodstype")
public class GoodstypeController {
    
    @Autowired
    private GoodstypeService goodstypeService;

    //查询所有
    @GetMapping("/list")
    public Result list(){
        List<Goodstype> list = goodstypeService.list();
        return list.size()>0 ? Result.suc(list) : Result.fail();
    }

    //新增
    @PostMapping("/insert")
    public Result insert(@RequestBody Goodstype goodstype){
        boolean flag = goodstypeService.save(goodstype);
        return flag ? Result.suc() : Result.fail();
    }
    //更新
    @PostMapping("/update")
    public Result update(@RequestBody Goodstype goodstype){
        boolean flag = goodstypeService.updateById(goodstype);
        return flag ? Result.suc() : Result.fail();
    }
    //删除
    @GetMapping("/delete")
    public Result delete(@RequestParam Long id){
        boolean flag = goodstypeService.removeById(id);
        return flag ? Result.suc() : Result.fail();
    }

    //列表分页
    @PostMapping("/listPage")
    public Result listPage(@RequestBody QueryPageParam queryPageParam){
        //取出其它条件参数
        HashMap param = queryPageParam.getParam();
        String name = (String) param.get("name");

        //获取分页参数
        Page<Goodstype> page = new Page<>();
        page.setCurrent(queryPageParam.getPageNum());
        page.setSize(queryPageParam.getPageSize());

        //设置条件构造器
        LambdaQueryWrapper<Goodstype> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(name) && !"null".equals(name)){
            lambdaQueryWrapper.like(Goodstype::getName,name);
        }

        //可以不用写返回值，数据会直接存到传入的参数page里面
        goodstypeService.page(page, lambdaQueryWrapper);

        //将总记录条数和当前页的数据返回
        return Result.suc(page.getTotal(),page.getRecords());
    }
}
