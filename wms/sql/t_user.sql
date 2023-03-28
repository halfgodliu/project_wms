drop table if exists t_user;

create table t_user(
	id bigint(20) auto_increment primary key comment '����',
	user_no varchar(20) not null comment '�˺�',
	password varchar(20) not null comment '����',
	name varchar(10) not null comment '����',
	sex int null comment '�Ա�',
	age int comment '����',
	phone varchar(11) comment '�ֻ���',
	role_id int comment '��ɫ 0��������Ա 1����Ա 2��ͨ�û�',
	availd int comment '�Ƿ���Ч 1��Ч ������Ч'
)charset = utf8;

insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value(1111,111111,'ly',1,22,123456,0,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value(2222,222222,'zhangsan',1,20,2222,1,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value(3333,333333,'lisi',1,20,3333,1,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value('user1',444444,'xiaohong',2,12,4444,2,1);
insert into t_user(user_no,password,name,sex,age,phone,role_id,availd) value('user2',555555,'xiaoming',1,14,5555,2,1);