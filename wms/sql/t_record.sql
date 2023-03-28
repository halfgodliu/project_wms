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