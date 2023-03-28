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