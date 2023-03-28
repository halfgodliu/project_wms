package com.lyjava.wms.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lyjava.wms.pojo.User;
import com.lyjava.wms.service.UserService;
import com.lyjava.wms.mapper.UserMapper;
import org.springframework.stereotype.Service;

/**
* @author 86198
* @description 针对表【t_user】的数据库操作Service实现
* @createDate 2023-01-13 16:34:40
*/
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User>
    implements UserService{

}




