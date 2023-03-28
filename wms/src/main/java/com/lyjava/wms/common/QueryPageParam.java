package com.lyjava.wms.common;

import lombok.Data;

import java.util.HashMap;

/**
 * 封装分页的入参
 */
@Data
public class QueryPageParam {
    private static final int PAGE_SIZE = 10;
    private static final int PAGE_NUM = 1;

    //当传入的参数中没有pageSize和pageNum参数时，默认这两个参数值为10和1
    private int pageSize = PAGE_SIZE;
    private int pageNum = PAGE_NUM;

    //传入的其它条件参数放到这里面
    private HashMap param = new HashMap();
}
