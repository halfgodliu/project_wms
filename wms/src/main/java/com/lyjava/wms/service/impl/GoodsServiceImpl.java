package com.lyjava.wms.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lyjava.wms.pojo.Goods;
import com.lyjava.wms.service.GoodsService;
import com.lyjava.wms.mapper.GoodsMapper;
import org.springframework.stereotype.Service;

/**
* @author 86198
* @description 针对表【t_goods】的数据库操作Service实现
* @createDate 2023-02-01 20:57:58
*/
@Service
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods>
    implements GoodsService{

}




