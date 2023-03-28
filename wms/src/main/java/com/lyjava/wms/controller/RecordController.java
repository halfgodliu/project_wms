package com.lyjava.wms.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lyjava.wms.common.QueryPageParam;
import com.lyjava.wms.common.Result;
import com.lyjava.wms.pojo.Goods;
import com.lyjava.wms.pojo.Record;
import com.lyjava.wms.service.GoodsService;
import com.lyjava.wms.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/record")
public class RecordController {

    @Autowired
    private RecordService recordService;
    @Autowired
    private GoodsService goodsService;
    //查询所有
    @GetMapping("/list")
    public Result list(){
        List<Record> list = recordService.list();
        return list.size()>0 ? Result.suc(list) : Result.fail();
    }

    //列表分页
    @PostMapping("/listPage")
    public Result listPage(@RequestBody QueryPageParam queryPageParam){
        //取出其它条件参数
        HashMap param = queryPageParam.getParam();
        String name = (String) param.get("name");
        String storage = (String) param.get("storage");
        String goodstype = (String) param.get("goodstype");
        String roleId = String.valueOf(param.get("roleId"));
        String userId = String.valueOf(param.get("userId"));
        //在前端将数字类型转化为字符串类型就可以下面这样写
        /*String roleId = (String) param.get("roleId");
        String userId = (String) param.get("userId");*/

        //获取分页参数
        Page<Record> page = new Page<>();
        page.setCurrent(queryPageParam.getPageNum());
        page.setSize(queryPageParam.getPageSize());

        //设置条件构造器
        QueryWrapper<Record> queryWrapper = new QueryWrapper<>();
        if ("2".equals(roleId)){
            queryWrapper.eq("r.user_id",userId);
        }
        if (StringUtils.isNotBlank(name) && !"null".equals(name)){
            queryWrapper.like("g.name",name);
        }
        if (StringUtils.isNotBlank(storage)){
            queryWrapper.eq("s.id",storage);
        }
        if (StringUtils.isNotBlank(goodstype)){
            queryWrapper.eq("gt.id",goodstype);
        }
        queryWrapper.orderByAsc("r.id");

        //可以不用写返回值，数据会直接存到传入的参数page里面
        //recordService.page(page, lambdaQueryWrapper);
        //pageRes：自定义的分页查询（自带的分页查询无法满足需求），会查询其他表中需要的数据
        recordService.pageRes(page, queryWrapper);

        //将总记录条数和当前页的数据返回
        return Result.suc(page.getTotal(),page.getRecords());
    }

    //添加记录和修改物品数量的方法
    @PostMapping("/save")
    public Result save(@RequestBody Record record){
        Integer count = record.getCount();
        //判断是入库还是出库,'1'表示入库，'2'表示出库
        if ("2".equals(record.getAddOrSub())){
            count = -count;
            record.setCount(count);
        }
        //要先获取该物品的数量，加上入库数量/减去出库数量，然后更新物品数量
        Goods goods = goodsService.getById(record.getGoodsId());
        Integer newCount = goods.getCount()+count;
        goods.setCount(newCount);

        boolean flag = goodsService.updateById(goods);
        boolean flag1 = recordService.save(record);

        return flag&&flag1 ? Result.suc() : Result.fail();
    }
}
