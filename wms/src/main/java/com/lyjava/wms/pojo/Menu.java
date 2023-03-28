package com.lyjava.wms.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @TableName t_menu
 */
@TableName(value ="t_menu")
@Data
public class Menu implements Serializable {
    /**
     * 
     */
    @TableId
    private Integer id;

    /**
     * 
     */
    private String menucode;

    /**
     * 
     */
    private String menuname;

    /**
     * 
     */
    private String menulevel;

    /**
     * 
     */
    private String menuparentcode;

    /**
     * 
     */
    private String menuclick;

    /**
     * Ȩ
     */
    private String menuright;

    /**
     * 
     */
    private String menucomponent;

    /**
     * 
     */
    private String menuicon;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}