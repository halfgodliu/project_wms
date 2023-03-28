package com.lyjava.wms.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lyjava.wms.pojo.Record;
import com.lyjava.wms.service.RecordService;
import com.lyjava.wms.mapper.RecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @author 86198
* @description 针对表【t_record】的数据库操作Service实现
* @createDate 2023-02-02 15:13:22
*/
@Service
public class RecordServiceImpl extends ServiceImpl<RecordMapper, Record>
    implements RecordService{

    @Autowired
    private RecordMapper recordMapper;

    @Override
    public IPage pageRes(IPage<Record> page, Wrapper queryWrapper) {
        return recordMapper.pageRes(page,queryWrapper);
    }
}




