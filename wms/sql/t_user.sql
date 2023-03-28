drop table if exists t_user;

create table t_user(
	id bigint(20) auto_increment primary key comment '主键',
	user_no varchar(20) not null comment '账号',
	password varchar(20) not null comment '密码',
	name varchar(10) not null comment '姓名',
	sex int null comment '性别',
	age int comment '年龄',
	phone varchar(11) comment '手机号',
	role_id int comment '角色 0超级管理员 1管理员 2普通用户',
	availd int comment '是否有效 1有效 其它无效'
)charset = utf8;

insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value(1111,111111,'ly',1,22,123456,0,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value(2222,222222,'zhangsan',1,20,2222,1,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value(3333,333333,'lisi',1,20,3333,1,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value('user1',444444,'xiaohong',2,12,4444,2,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value('user2',555555,'xiaoming',1,14,5555,2,1);