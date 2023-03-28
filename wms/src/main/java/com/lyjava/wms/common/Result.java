package com.lyjava.wms.common;

import lombok.Data;

//封装返回给前端的数据
@Data
public class Result {
    private int code;//编码 200/400
    private String msg;//成功、失败
    private Long total;//总记录条数
    private Object data;//数据

    //失败时调用fail方法
    public static Result fail(){
        return result(400,"失败",0L,null);
    }

    //成功时调用suc方法
    public static Result suc(){
        return result(200,"成功",0L,null);
    }
    public static Result suc(Object data){
        return result(200,"成功",0L,data);
    }
    public static Result suc(Long total,Object data){
        return result(200,"成功",total,data);
    }

    //私有方法，方便封装要返回的数据
    private static Result result(int code,String msg,Long total,Object data){
        Result res = new Result();
        res.setCode(code);
        res.setMsg(msg);
        res.setTotal(total);
        res.setData(data);
        return res;
    }
}
