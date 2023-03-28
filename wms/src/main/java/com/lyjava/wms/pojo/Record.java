package com.lyjava.wms.pojo;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * 
 * @TableName t_record
 */
@TableName(value ="t_record")
@Data
public class Record implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 
     */
    private Integer goodsId;

    /**
     * ȡ
     */
    private Integer userId;

    /**
     * 
     */
    private Integer adminId;

    /**
     * 
     */
    private Integer count;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT)//插入的时候自动填充
    @JsonFormat(timezone = "GMT+8",pattern = "yy-MM-dd HH-mm-ss")//格式化时间
    private Date createtime;

    /**
     * 
     */
    private String remark;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    //判断是入库还是出库，'1'表示入库，'2'表示出库
    @TableField(exist = false)//表示不会作用域数据库表
    private String addOrSub;
}