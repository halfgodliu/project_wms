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