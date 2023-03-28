package com.lyjava.wms.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.lyjava.wms.pojo.Record;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
* @author 86198
* @description 针对表【t_record】的数据库操作Mapper
* @createDate 2023-02-02 15:13:21
* @Entity com.lyjava.wms.pojo.Record
*/
@Repository
public interface RecordMapper extends BaseMapper<Record> {

    IPage pageRes(IPage<Record> page, @Param(Constants.WRAPPER) Wrapper ew);
}




