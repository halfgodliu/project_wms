package com.lyjava.wms.common;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

//填充策略（我要给createtime自动填充日期，需要写这个）
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {
    //插入的时候的填充策略
    @Override
    public void insertFill(MetaObject metaObject) {
        //插入的时候给createtime属性自动填充当前时间
        this.setFieldValByName("createtime",new Date(),metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {

    }
}
