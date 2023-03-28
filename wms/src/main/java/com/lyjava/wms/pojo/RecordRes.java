package com.lyjava.wms.pojo;

import lombok.Data;

/*在Record的基础上添加了几个属性*/
@Data
public class RecordRes extends Record {

    private String goodsName;
    private String storageName;
    private String goodstypeName;
    private String adminName;
    private String userName;

}
