DROP TABLE IF EXISTS `t_goodsType`;


CREATE TABLE `t_goodsType` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` varchar(100) NOT NULL COMMENT '������',
  `remark` varchar(1000) DEFAULT NULL COMMENT '��ע',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;