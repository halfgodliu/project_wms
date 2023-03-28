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



DROP TABLE IF EXISTS t_menu;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL,
  `menuCode` varchar(8) DEFAULT NULL COMMENT '�˵�����',
  `menuName` varchar(16) DEFAULT NULL COMMENT '�˵�����',
  `menuLevel` varchar(2) DEFAULT NULL COMMENT '�˵�����',
  `menuParentCode` varchar(8) DEFAULT NULL COMMENT '�˵��ĸ�code',
  `menuClick` varchar(16) DEFAULT NULL COMMENT '��������ĺ���',
  `menuRight` varchar(8) DEFAULT NULL COMMENT 'Ȩ�� 0��������Ա��1��ʾ����Ա��2��ʾ��ͨ�û��������ö������ʹ��',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` varchar(100) NOT NULL COMMENT '�ֿ���',
  `remark` varchar(1000) DEFAULT NULL COMMENT '��ע',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_goodsType`;
CREATE TABLE `t_goodsType` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` varchar(100) NOT NULL COMMENT '������',
  `remark` varchar(1000) DEFAULT NULL COMMENT '��ע',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` varchar(100) NOT NULL COMMENT '����',
  `storage` int(11) NOT NULL COMMENT '�ֿ�',
  `goodsType` int(11) NOT NULL COMMENT '����',
  `count` int(11) DEFAULT NULL COMMENT '����',
  `remark` varchar(1000) DEFAULT NULL COMMENT '��ע',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `t_record`;
CREATE TABLE `t_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '����',
  `goods_id` int(11) NOT NULL COMMENT '��Ʒid',
  `user_id` int(11) DEFAULT NULL COMMENT 'ȡ����/������id',
  `admin_id` int(11) DEFAULT NULL COMMENT '������id',
  `count` int(11) DEFAULT NULL COMMENT '����',
  `createtime` datetime DEFAULT NULL COMMENT '����ʱ��',
  `remark` varchar(1000) DEFAULT NULL COMMENT '��ע',
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