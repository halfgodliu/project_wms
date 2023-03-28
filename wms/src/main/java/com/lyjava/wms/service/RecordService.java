package com.lyjava.wms.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.lyjava.wms.pojo.Record;
import com.baomidou.mybatisplus.extension.service.IService;
import com.lyjava.wms.pojo.RecordRes;

/**
* @author 86198
* @description 针对表【t_record】的数据库操作Service
* @createDate 2023-02-02 15:13:22
*/
public interface RecordService extends IService<Record> {
    IPage pageRes(IPage<Record> page, Wrapper queryWrapper);
}
