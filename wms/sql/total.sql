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



DROP TABLE IF EXISTS t_menu;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL,
  `menuCode` varchar(8) DEFAULT NULL COMMENT '菜单编码',
  `menuName` varchar(16) DEFAULT NULL COMMENT '菜单名字',
  `menuLevel` varchar(2) DEFAULT NULL COMMENT '菜单级别',
  `menuParentCode` varchar(8) DEFAULT NULL COMMENT '菜单的父code',
  `menuClick` varchar(16) DEFAULT NULL COMMENT '点击触发的函数',
  `menuRight` varchar(8) DEFAULT NULL COMMENT '权限 0超级管理员，1表示管理员，2表示普通用户，可以用逗号组合使用',
  `menuComponent` varchar(200) DEFAULT NULL,
  `menuIcon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `t_menu` VALUES (1, '001', 'adminmanage', '1', NULL, 'Admin', '0', 'admin/AdminManage.vue', 'el-icon-s-custom');
INSERT INTO `t_menu` VALUES (2, '002', 'usermanage', '1', NULL, 'User', '0,1', 'user/UserManage.vue', 'el-icon-user-solid');
INSERT INTO `t_menu` VALUES (3, '003', 'storagemanage', '1', NULL, 'Storage', '0,1', 'storage/StorageManage.vue', 'el-icon-office-building');
INSERT INTO `t_menu` VALUES (4, '004', 'goodstypemanage', '1', NULL, 'GoodsType', '0,1', 'goodstype/GoodsTypeManage.vue', 'el-icon-menu');
INSERT INTO `t_menu` VALUES (5, '005', 'goodsmanage', '1', NULL, 'Goods', '0,1,2', 'goods/GoodsManage.vue', 'el-icon-s-goods');
INSERT INTO `t_menu` VALUES (6, '006', 'recordmanage', '1', NULL, 'Record', '0,1,2', 'record/RecordManage.vue', 'el-icon-s-order');



DROP TABLE IF EXISTS `t_storage`;
CREATE TABLE `t_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '仓库名',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_goodsType`;
CREATE TABLE `t_goodsType` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '分类名',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '货名',
  `storage` int(11) NOT NULL COMMENT '仓库',
  `goodsType` int(11) NOT NULL COMMENT '分类',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_record`;
CREATE TABLE `t_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) NOT NULL COMMENT '货品id',
  `user_id` int(11) DEFAULT NULL COMMENT '取货人/补货人id',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `createtime` datetime DEFAULT NULL COMMENT '操作时间',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*select
	r.*,g.name goods_name,s.name storage_name,gt.name goodstype_name,
	(select u.name from t_user u where u.id=r.user_id) user_name,
	(select u.name from t_user u where u.id=r.admin_id) admin_name
from t_record r 
join t_goods g on r.goods_id=g.id 
join t_storage s on g.storage=s.id 
join t_goodstype gt on g.goodsType=gt.id*/