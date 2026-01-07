/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : aircraft-booking-system

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 16/06/2025 23:14:48
*/
CREATE DATABASE IF NOT EXISTS `aircraft-booking-system` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `aircraft-booking-system`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dic_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段',
  `dic_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `code_index` int(0) NULL DEFAULT NULL COMMENT '编码',
  `index_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码名字  Search111 ',
  `super_id` int(0) NULL DEFAULT NULL COMMENT '父字段id',
  `beizhu` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 139 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES (103, 'chat_types', '数据类型', 1, '问题', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (104, 'chat_types', '数据类型', 2, '回复', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (105, 'zhuangtai_types', '状态', 1, '未回复', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (106, 'zhuangtai_types', '状态', 2, '已回复', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (107, 'forum_state_types', '帖子状态', 1, '发帖', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (108, 'forum_state_types', '帖子状态', 2, '回帖', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (109, 'shangxia_types', '上下架', 1, '上架', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (110, 'shangxia_types', '上下架', 2, '下架', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (111, 'hangban_types', '航班状态', 1, '正常', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (112, 'hangban_types', '航班状态', 2, '航班取消', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (113, 'jipiao_types', '航班类型', 1, '波音B787', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (114, 'jipiao_types', '航班类型', 2, '波音B777', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (115, 'jipiao_types', '航班类型', 3, '波音B737', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (116, 'jipiao_collection_types', '收藏表类型', 1, '收藏', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (117, 'jipiao_order_types', '订单类型', 101, '已预约', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (118, 'jipiao_order_types', '订单类型', 102, '已退票', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (119, 'jipiao_order_types', '订单类型', 103, '待取票', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (120, 'jipiao_order_types', '订单类型', 104, '已取票', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (121, 'sex_types', '性别类型', 1, '男', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (122, 'sex_types', '性别类型', 2, '女', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (123, 'news_types', '新闻类型', 1, '社会新闻', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (124, 'news_types', '新闻类型', 2, '通知公告', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (125, 'news_types', '新闻类型', 3, '民航新闻', NULL, NULL, '2025-02-17 14:38:29');
INSERT INTO `dictionary` VALUES (126, 'jipiao_types', '航班类型', 4, '波音B747', NULL, '', '2025-02-16 23:08:32');
INSERT INTO `dictionary` VALUES (127, 'jipiao_types', '航班类型', 5, '空客A319', NULL, '', '2025-02-16 23:08:51');
INSERT INTO `dictionary` VALUES (128, 'jipiao_types', '航班类型', 6, '空客A320', NULL, '', '2025-02-16 23:09:14');
INSERT INTO `dictionary` VALUES (129, 'jipiao_types', '航班类型', 7, '空客A330', NULL, '', '2025-02-16 23:09:57');
INSERT INTO `dictionary` VALUES (130, 'jipiao_types', '航班类型', 8, '空客A350', NULL, '', '2025-02-16 23:10:15');
INSERT INTO `dictionary` VALUES (131, 'jipiao_types', '航班类型', 9, '巴西航空E190', NULL, '', '2025-02-16 23:10:33');
INSERT INTO `dictionary` VALUES (132, 'jipiao_types', '航班类型', 10, '巴西航空E195', NULL, '', '2025-02-16 23:10:48');
INSERT INTO `dictionary` VALUES (133, 'jipiao_types', '航班类型', 11, '商飞C919', NULL, '', '2025-02-16 23:11:23');
INSERT INTO `dictionary` VALUES (139, 'news_types', '新闻类型', NULL, '娱乐新闻', NULL, '娱乐新闻', '2025-04-22 09:55:21');

-- ----------------------------
-- Table structure for jipiao
-- ----------------------------
DROP TABLE IF EXISTS `jipiao`;
CREATE TABLE `jipiao`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `jipiao_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '航班标题 Search111 ',
  `jipiao_photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '航班照片',
  `jipiao_types` int(0) NULL DEFAULT NULL COMMENT '航班类型 Search111',
  `jipiao_new_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '现价',
  `jipiao_chufadi` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出发地',
  `jipiao_mudidi` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目的地',
  `jipiao_time` timestamp(0) NULL DEFAULT NULL COMMENT '出发时间',
  `zuowei_number` int(0) NULL DEFAULT NULL COMMENT '座位',
  `shangxia_types` int(0) NULL DEFAULT NULL COMMENT '是否上架 ',
  `hangban_types` int(0) NULL DEFAULT NULL COMMENT '航班状态 Search111',
  `jipiao_delete` int(0) NULL DEFAULT NULL COMMENT '逻辑删除',
  `jipiao_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '航班详情',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间  show1 show2 photoShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '航班信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jipiao
-- ----------------------------
INSERT INTO `jipiao` VALUES (1, 'JN6354', 'upload/jipiao1.jpg', 11, 321.76, '出发地1', '目的地1', '2025-02-17 14:38:39', 20, 1, 1, 1, '<p>航班详情1</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (2, 'OJ2562', 'upload/jipiao2.jpg', 10, 73.91, '出发地2', '目的地2', '2025-02-17 14:38:39', 20, 1, 2, 1, '<p>航班详情2</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (3, 'KH2536', 'upload/jipiao3.jpg', 2, 142.30, '出发地3', '目的地3', '2025-03-15 14:38:39', 20, 1, 2, 1, '<p>航班详情3</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (4, 'JH7522', 'upload/jipiao4.jpg', 5, 248.59, '出发地4', '目的地4', '2025-04-18 14:38:39', 20, 1, 1, 1, '<p>航班详情4</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (5, 'JK3385', 'upload/jipiao5.jpg', 6, 33.81, '出发地5', '目的地5', '2025-04-26 14:38:39', 20, 1, 1, 1, '<p>航班详情5</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (6, 'GF2545', 'upload/jipiao6.jpg', 5, 399.54, '出发地6', '目的地6', '2025-05-02 14:38:39', 20, 1, 2, 1, '<p>航班详情6</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (7, 'WS5324', 'upload/jipiao7.jpg', 3, 497.62, '出发地7', '目的地7', '2025-04-18 14:38:39', 20, 1, 2, 1, '<p>航班详情7</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (8, 'LG9856', 'upload/jipiao8.jpg', 2, 245.57, '出发地8', '目的地8', '2025-06-01 14:38:39', 20, 1, 2, 1, '<p>航班详情8</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (9, 'TY8622', 'upload/jipiao9.jpg', 1, 317.00, '出发地9', '目的地9', '2025-02-17 14:38:39', 20, 1, 1, 1, '<p>航班详情9</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (10, 'ZK7892', 'upload/jipiao10.jpg', 2, 218.25, '出发地10', '目的地10', '2025-03-15 14:38:39', 20, 1, 1, 1, '<p>航班详情10</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (11, 'ZM5632', 'upload/jipiao11.jpg', 2, 407.30, '出发地11', '目的地11', '2025-02-28 14:38:39', 20, 1, 1, 1, '<p>航班详情11</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (12, 'RY5503', 'upload/jipiao12.jpg', 2, 382.31, '出发地12', '目的地12', '2025-03-15 14:38:39', 20, 1, 1, 1, '<p>航班详情12</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (13, 'RY8867', 'upload/jipiao13.jpg', 3, 184.55, '长乐国际机场', '首都国际机场', '2025-02-21 23:22:15', 40, 1, 1, 1, '<p>航班详情13</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (14, 'RY8869', 'upload/jipiao14.jpg', 1, 347.72, '厦门高崎机场', '北京大兴国际机场', '2025-02-18 23:20:51', 60, 1, 1, 1, '<p>航班详情14</p>', '2025-02-03 14:38:39');
INSERT INTO `jipiao` VALUES (28, 'sdsd', 'upload/1740592557314.JPG', 11, 123.00, 'asas', 'asas', NULL, 34, 1, 1, 2, NULL, '2025-02-27 01:55:57');
INSERT INTO `jipiao` VALUES (29, '飒飒', 'upload/1742477428867.png', 11, 5555.00, '飒飒', '水水水水', '2025-03-12 00:00:00', 300, 1, 1, 2, NULL, '2025-03-20 21:30:29');

-- ----------------------------
-- Table structure for jipiao_collection
-- ----------------------------
DROP TABLE IF EXISTS `jipiao_collection`;
CREATE TABLE `jipiao_collection`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `jipiao_id` int(0) NULL DEFAULT NULL COMMENT '航班',
  `yonghu_id` int(0) NULL DEFAULT NULL COMMENT '用户',
  `jipiao_collection_types` int(0) NULL DEFAULT NULL COMMENT '类型',
  `insert_time` timestamp(0) NULL DEFAULT NULL COMMENT '收藏时间',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间 show3 photoShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '航班收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jipiao_collection
-- ----------------------------
INSERT INTO `jipiao_collection` VALUES (1, 1, 1, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (3, 3, 3, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (5, 5, 2, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (7, 7, 3, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (8, 8, 2, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (10, 10, 2, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (11, 11, 3, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (12, 12, 2, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (15, 7, 1, 1, '2025-02-21 14:38:39', '2025-02-21 14:38:39');
INSERT INTO `jipiao_collection` VALUES (20, 13, 3, 1, '2025-02-21 14:38:39', '2025-02-17 23:39:00');
INSERT INTO `jipiao_collection` VALUES (22, 5, 3, 1, '2025-02-21 14:38:39', '2025-02-17 23:50:08');
INSERT INTO `jipiao_collection` VALUES (23, 14, 3, 1, '2025-02-22 01:21:43', '2025-02-22 01:21:43');

-- ----------------------------
-- Table structure for jipiao_order
-- ----------------------------
DROP TABLE IF EXISTS `jipiao_order`;
CREATE TABLE `jipiao_order`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `jipiao_order_uuid_number` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号 Search111 ',
  `jipiao_id` int(0) NULL DEFAULT NULL COMMENT '机票',
  `yonghu_id` int(0) NULL DEFAULT NULL COMMENT '用户',
  `jipiao_order_true_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付价格 ',
  `jipiao_order_types` int(0) NULL DEFAULT NULL COMMENT '订单类型  Search111 ',
  `buy_zuowei_number` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预定座位',
  `buy_zuowei_time` date NULL DEFAULT NULL COMMENT '订购日期',
  `insert_time` timestamp(0) NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间 show3',
  `is_pay` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未支付' COMMENT '支付状态',
  `order_pay_order` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付宝订单号',
  `jieshuanshijian` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '机票预订' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jipiao_order
-- ----------------------------
INSERT INTO `jipiao_order` VALUES (1, '1680506886036', 13, 1, 369.10, 104, '16,26', '2025-02-21', '2025-01-01 15:28:06', '2025-01-09 15:28:06', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (2, '1680507622703', 14, 1, 695.44, 104, '4,5', '2025-02-21', '2025-01-16 15:40:23', '2025-01-17 15:40:23', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (3, '1739633849225', 9, 1, 1585.00, 104, '1,2,3,4,5', '2025-02-15', '2025-02-15 23:37:29', '2025-01-17 15:40:23', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (4, '1739807538052', 5, 3, 101.43, 104, '1,2,3', '2025-02-17', '2025-02-17 23:52:18', '2025-02-17 23:52:18', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (5, '1739807989254', 11, 3, 814.60, 104, '1,2', '2025-02-17', '2025-02-17 23:59:49', '2025-02-17 23:59:49', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (6, '1739808024919', 12, 3, 764.62, 102, '11,13', '2025-02-18', '2025-02-18 00:00:25', '2025-02-18 00:00:25', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (7, '1742451752274', 12, 3, 764.62, 102, '1,2', '2025-03-20', '2025-03-20 14:22:32', '2025-03-20 14:22:32', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (8, '1742477257569', 12, 3, 1146.93, 104, '3,4,5', '2025-03-20', '2025-03-20 21:27:38', '2025-03-20 21:27:38', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (9, '1750084041227', 12, 3, 382.31, 101, '3', '2025-06-16', '2025-06-16 22:27:21', '2025-06-16 22:27:21', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (10, '1750084076587', 11, 3, 407.30, 101, '8', '2025-06-16', '2025-06-16 22:27:57', '2025-06-16 22:27:57', '未支付', NULL, NULL);
INSERT INTO `jipiao_order` VALUES (11, '1750084143177', 14, 3, 347.72, 101, '6', '2025-06-16', '2025-06-16 22:29:03', '2025-06-16 22:29:03', '未支付', NULL, NULL);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `news_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '新闻标题  Search111 ',
  `news_types` int(0) NULL DEFAULT NULL COMMENT '新闻类型  Search111 ',
  `news_photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '新闻图片',
  `insert_time` timestamp(0) NULL DEFAULT NULL COMMENT '添加时间',
  `news_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '新闻详情',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间 show1 show2 nameShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '民航新闻' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, '深航关于调整国内航线燃油附加费的公告', 3, 'upload/news1.jpg', '2025-02-17 14:38:39', '<p>尊敬的旅客：</p><p>&nbsp;&nbsp;&nbsp;自2025年2月5日零时起销售的客票,深圳航空将调整国内航线旅客运输燃油附加费。具体内容如下:</p><p>&nbsp;&nbsp;&nbsp;一、航线距离800公里（含）以下航线燃油附加每航段收费标准为人民币20元,航线距离800公里以上航线燃油附加每航段收费标准为人民币40元。</p><p>&nbsp;&nbsp;&nbsp;二、婴儿旅客免收国内航线旅客运输燃油附加费；儿童（含无成人陪伴儿童）、革命伤残军人和因公致残的人民警察国内航段旅客运输燃油附加费继续实行减半收取，即航线距离800公里（含）以下航线燃油附加每航段收费标准为人民币10元，航线距离800公里以上航线燃油附加每航段收费标准为人民币20元。具体收取金额以系统自动计算结果为准。</p><p>&nbsp;&nbsp;&nbsp;三、2025年2月5日零时前已出票国内航线客票不再补收燃油附加费，2025年2月5日（不含）以前销售的国内客票，如在2025年2月5日（含）以后进行变更，不再按新标准补收燃油附加差价。</p><p>&nbsp;</p><p class=\"ql-align-right\">深圳航空有限责任公司</p><p class=\"ql-align-right\">2025年2月2日</p><p>&nbsp;</p><p>&nbsp;</p>', '2025-02-17 14:38:39');
INSERT INTO `news` VALUES (2, '行李运输规定-人体器官运输服务', 2, 'upload/news2.jpg', '2025-02-14 14:38:39', '<p>尊敬的旅客：</p><p>为遵循“生命优先、特事特办”的人道主义精神，在保障航空运输安全的前提下，首都航空在限定条件下提供人体器官运输服务。</p><p>人体器官在航空运输中，可能会由于包装、保存以及因天气、空管、军事活动、公共安全等不可控因素导致航班不正常，如延误、取消、返航或备降等发生器官损坏、过期等问题，如无证据证明首航有过错，则运输中造成的损失首都航空一律免责。</p><p>如您决定选择首都航空进行航空运输，为了您及携带的人体器官顺利成行，请您仔细阅读以下说明，祝您有一个顺畅的旅行！</p><p>一、适用范围</p><p>人体器官是指由各种细胞或组织构成的、并执行一定功能的生物体的分化结构，如人体不可再生的心脏、肝脏、肾脏、肺脏、胰腺、四肢、眼球、耳朵等，除此之外还包括人体细胞、角膜、骨髓等人体组织。</p><p>二、适用航线</p><p>适用于首都航空（JD）国内自营航班（包机及代码共享航班除外）。</p><p>三、申请运输及办理要求</p><p>1、由于需要对人体器官运输服务进行事先安排也为了您有更加充分的时间做包装及文件准备，人体捐献器官获取组织（Organ Procurement Organization，以下简称OPO）工作人员应至少在航班计划起飞时间前4小时，通过拨打首都航空24小时订票服务热线95375或联系首都航空直属售票处申请。</p><p>2、申请运输同意许可后，您需携带符合首航运输人体器官包装要求的行李、所需运输证明文件前往首都航空值机柜台办理人体器官运输手续。</p><p>3、如您携带的人体器官行李超出手提行李的范围，应按占座行李进行购票。</p><p>4、在办理人体器官运输手续时，您需要仔细阅读并认真填写《<a href=\"https://www.jdair.net/fecms.pub.bucket.jd/20230606/4.%E3%80%8A%E4%BA%BA%E4%BD%93%E5%99%A8%E5%AE%98%E8%BF%90%E8%BE%93%E5%8D%8F%E8%AE%AE%E3%80%8B.pdf\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: transparent; color: rgb(234, 66, 55);\">人体器官运输协议书</a>》并接受航空运输可能存在的风险。</p><p>四、运输条件</p><p>1、运输方式：仅接受旅客将人体器官作为客舱行李（手提行李或占座行李）运输，且在器官运输过程中由旅客自行照管。</p><p>2、首都航空不承运将医疗废物（指诊疗过程中产生的人体废弃物如残肢，以及医学实验动物尸体等）作为行李运输。</p><p>3、以下情况首都航空不能提供人体器官运输服务</p><p>（1）旅客携带的人体器官包装非专业的、不符合首航承运要求的运输容器。</p><p>（2）旅客未完成运输准备，包括运输证明文件不齐全及出具证明文件的医院资质不符合要求等。</p><p>（3）旅客拒绝填写《人体器官运输协议书》。</p><p>五、文件要求</p><p>为了您旅途顺畅，请按照如下要求准备运输相关文件。</p><p>1、携带人体捐献器官的旅客需出示由OPO出具的《移植中心器官接收确认书》。</p><p>2、您可登录“国家卫生健康委员会网站（<a href=\"http://www.nhc.gov.cn/wjw/index.shtml#_blank\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: transparent; color: rgb(234, 66, 55);\">请点击此处进入</a>）-服务-名单查询”获取具有人体器官移植执业资格的医疗机构名单的最新信息。</p><p>六、包装注意事项</p><p>专业运输容器对于安全运输人体器官至关重要，在此，我们特别提示您认真参阅包装要求：</p><p>1、使用专业的运输容器，需有效保温、防震，方便携带、密封性好（不会散发异味、不会渗漏液体）。</p><p>2、容器外观不会对其他旅客造成影响，且不会因为飞行过程中机舱气压变化、飞机颠簸而导致器官损坏，并在容器外显著位置张贴人体捐献器官运输专用标志。</p><p>七、特殊情况须知</p><p>1、无法按原定计划时间出行</p><p>（1）如航班临时延误且您尚未办理值机手续，请您告知首航工作人员航班延误对您携带人体器官出行是否会有影响以及机票变更要求，工作人员将协助您办理机票退改签手续。</p><p>（2）如您办理值机手续后航班发生临时延误，首航工作人员将会告知您航班延误信息，请您根据航班信息告知工作人员机票是否退改签要求，工作人员将协助您办理机票手续。</p><p>（3）当您出行的机场因天气、空管、公共安全等不可控因素导致大面积航班延误时，建议您选择其他交通工具，首航工作人员将协助您转乘及办理退票。</p><p>2、OPO工作人员未携带《确认书》或《确认书》无法通过查验</p><p>当OPO工作人员未携带《确认书》时，首航工作人员将拨打国家卫计委人体捐献器官转运旅客通道24小时应急电话核实相关情况，并可要求相关人员提供《确认书》副本。</p><p>《确认书》无法通过查验的，则我司将OPO工作人员视为普通旅客，无需为其开通绿色通道，按照正常程序开展安全检查、行李运输等工作，由此造成的损失，由OPO工作人员自行承担。</p><p>附件：<a href=\"https://www.jdair.net/fecms.pub.bucket.jd/20230606/5.%E3%80%8A%E7%A7%BB%E6%A4%8D%E4%B8%AD%E5%BF%83%E5%99%A8%E5%AE%98%E6%8E%A5%E6%94%B6%E7%A1%AE%E8%AE%A4%E3%80%8B.pdf\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: transparent; color: rgb(234, 66, 55);\">移植中心器官接收确认书</a></p>', '2025-02-17 14:38:39');
INSERT INTO `news` VALUES (3, '行李运输规定-国际/地区行李运输规定', 2, 'upload/news3.jpg', '2025-02-17 14:38:39', '<p><strong>一、手提行李规定：</strong></p><p>1、头等舱、公务舱旅客可携带两件手提行李，经济舱旅客可携带一件手提行李，金鹏金卡、银卡会员、公司VIP、CIP旅客可携带手提行李件数也按照其乘坐舱位等级对应标准执行。</p><p>2、 旅客手提行李单件不得超过7公斤，行李长、宽、高的总和不超过115厘米（45英寸），可放入客舱座位上方的行李舱内或正前方的座椅下。</p><p>&nbsp;</p><p>手提行李额规定</p><p>区域</p><p>舱位等级</p><p>行李数量上限</p><p>每件重量上限</p><p>每件尺寸上限</p><p>国际及地区航线</p><p>公务舱</p><p>2</p><p>单件不得超过7公斤</p><p>三边之和不超过115厘米</p><p>经济舱</p><p>1</p><p>单件不得超过7公斤</p><p>三边之和不超过115厘米</p><p class=\"ql-align-center\">备注</p><p>1.手提行李额政策适用于由首航实际承运的国际及地区航线。</p><p>2.超过上述重量、件数或体积限制的随身携带物品，应作为托运行李托运。</p><p>3.尺寸上限是指三边尺寸之和的上限。</p><p>4.日本始发至中国方向的航线, 登机口处，一个电饭锅另收费2000日元；一个电热水壶另收费2000日元；一个扫地机器人另收费2000日元。</p><p>3、乘坐首航航班的旅客，除了免费手提行李以外，每位旅客不用另付费用，可以携带下列限于自己照管，仅在上机、下机或者在航班上所用的私人物品：</p><p>&nbsp;</p><p><strong>物品项目</strong></p><p><strong>适用范围</strong></p><p>一件大衣、披肩或者毯子；一把雨伞或者手杖；一副双筒望远镜；一架小型照相机；合理数量的在航班上阅读的读物；一个适用作通常旅行化妆而不是装运那些应另作行李交运的手提袋、手袋或者手提包或小背包；一个小型公文包或一个手提电脑公文包。</p><p>除了婴儿以外的所有旅客</p><p>航班上供喂食婴儿的食品，一个婴儿背篮和可折叠的轻便婴儿车或者推车（可托运，如体积、重量不超过手提行李限制，则可带入客舱放在座位上方的行李舱内或正前方的座椅下）。</p><p>婴儿旅客</p><p>一辆可折叠的轮椅和/或一双拐杖和/或一副背带或旅客用的其他肢体修复用具（可托运，如体积、重量不超过手提行李限制，则可带入客舱放在座位上方的行李舱内或正前方的座椅下）,便携式制氧机及其他呼吸辅助设备。</p><p>依靠轮椅、拐杖、背带、肢体修复用具、呼吸辅助设备的障碍旅客</p><p>4、特殊要求</p><p><strong>（1）美国航线</strong></p><p>自 2018 年 6 月 30 日起， 超过 350ml（含）的粉末状物品（例如面粉、糖、咖啡粉、香料等） 不得带入客舱运输。除非：</p><p>A&nbsp;超过 350ml（含）的医疗药品、婴儿奶粉、骨灰等可以带入客 舱进行运输，但需检查其包装是否密封完好，有无破坏痕迹（包括裂 缝等）；如果包装未密封或有破坏痕迹，须确保包装内物品与包装描 述一致；否则不得带入客舱；</p><p>B&nbsp;旅客购买自控制区免税店，且密封在容器或密封袋里的粉末状物品可以带入客舱进行运输；否则不得带入客舱。</p><p><strong>（2）澳洲航线</strong></p><p>A&nbsp;自 2018 年 6 月 30 日起，所有澳洲出港国际航班要求：每位旅客 仅允许携带不超过 350ml 数量的无机粉末（如沙子、盐、爽身粉及化 妆品类）进入客舱；</p><p>B&nbsp;旅客经过安检通道时，除单独拿出液体、气溶胶和凝胶物品外， 还需拿出随身携带粉末状物质接受 X 光机检查；</p><p>C&nbsp;对有机粉末物品无数量限制要求，如食品类物品：婴儿奶粉、咖 啡粉及糖类等；</p><p>D&nbsp;悉尼、墨尔本机场允许旅客最多随身携带一个打火机或安全火柴上机。</p><p><strong>（3）加拿大航线</strong></p><p>自 2017 年 11 月 27 日起，加拿大境内机场将正式以新版违禁物品清单进行安检。</p><p>A&nbsp;仅允许携带 6cm 或以下的小型刀片（约大号回形针/曲别针大 小）。禁止携带美工刀及各式尺寸的剃刀；</p><p>B&nbsp;粉末及颗粒物质如浴盐、海盐、婴儿爽身粉、足浴粉、食用酵母粉及沙子携带数量限制为 350ml 以下（容积约为苏打水罐大小）。而婴儿奶粉、蛋白粉、茶及咖啡仍然不限制携带数量。</p><p><strong>（4）日本航线</strong></p><p>日本大阪关西机场免税店有将某品牌回旋镖作为免税商品出售情况。根据民航局下发《禁止及限制携带和托运物品目录公告》内容要求，作为能够造成人身伤害或对航空安全和运输秩序构成较大危害的物品，回旋镖为禁止随身携带但可作为行李进行托运。</p><p><strong>（5）葡萄牙航线</strong></p><p>里斯本机场允许旅客最多随身携带一个打火机或安全火柴上机。</p><p><strong>（6）西班牙航线</strong></p><p>马德里机场对旅客携带打火机、锂电池均没有明确限制。</p><p><strong>（7）俄罗斯航线</strong></p><p>谢列梅捷沃机场允许每位旅客随身携带 1 个小型打火机（超过 zippo 常规大小则不可携带），禁止携带火柴。</p><p><strong>（8）英国航线</strong></p><p>A 伦敦机场安检要求单独拿出手提电脑、登机牌和护照，脱掉外套、高跟鞋和金属皮带等进行 X 光机和“裸体”安检门检查；</p><p>B&nbsp;手提行李过检之前，行李内的所有液体、胶体、打火机、火柴等危险物品无论体积大小，必须全部放在一个 20*20cm 的塑料袋内单独过检，单个物品液体容积不得超过100ml；</p><p>C&nbsp;对于锂电池的携带没有限制，仅要求不得托运；</p><p>D&nbsp;允许旅客最多随身携带一个打火机或安全火柴上机。</p><p><strong>（9）越南与柬埔寨航线</strong></p><p>芽庄及暹粒机场允许旅客随身携带一只打火机，且未对锂电池做出要求。</p><p><strong>&nbsp;</strong></p><p><strong>二、托运行李规定：</strong></p><p><strong>1、免费行李额规定</strong></p><p class=\"ql-align-center\"><strong>区域</strong></p><p class=\"ql-align-center\"><strong>各航线舱位等级</strong></p><p class=\"ql-align-center\"><strong>免费托运行李额</strong></p><p class=\"ql-align-center\">中国=美洲</p><p class=\"ql-align-center\">公务舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过32公斤/70磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">经济舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过23公斤/50磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">中国=大洋洲</p><p class=\"ql-align-center\">公务舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过32公斤/70磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">经济舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过23公斤/50磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">北京=札幌</p><p class=\"ql-align-center\">公务舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过32公斤/70磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">经济舱</p><p class=\"ql-align-center\">一件（每件行李重量不超过23公斤/50磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">中国=日本（北京=札幌航线除外）</p><p class=\"ql-align-center\">公务舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过32公斤/70磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">经济舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过23公斤/50磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">国际及地区航线（美洲、大洋洲、日本航线除外）</p><p class=\"ql-align-center\">公务舱</p><p class=\"ql-align-center\">两件（每件行李重量不超过32公斤/70磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">经济舱</p><p class=\"ql-align-center\">一件（每件行李重量不超过23公斤/50磅,三边之和不超过158厘米/62英寸）</p><p class=\"ql-align-center\">备注</p><p>1、持儿童客票、占座婴儿的旅客免费托运行李额标准视同成人。</p><p>2、婴儿客票免费托运行李额为一件。每件重量10公斤（22磅），单件托运行李三边之和不得超过115厘米，另可免费托运一辆折叠式婴儿车或摇篮（20*40*55），如客舱空间允许并经乘务长同意后可带入客舱。</p><p>3、单件托运行李重量上限不得超过32公斤（70磅），三边尺寸之和不得超过203厘米（80英寸），重量、尺寸超过以上标准的，建议旅客将行李拆开分装，无法拆分的请登录http://www.hnacargo.com/Portal/Default.aspx，联系货运部门。</p><p>4、当国内、国际航班均为首航（JD）运输时，该行李运输规定适用于全程。</p><p>5、代码共享航线免费托运行李额规定另行通知，如无另外规定，则适用同区域自营航线免费托运行李额标准。</p><p>6、本规定自2024年12月7日起（出票日期）生效。此政策生效同时废止JDIS23085政策免费托运行李规定，特殊渠道免费托运行李额及航线特殊时段特殊行程行李标准按原政策执行。</p><p><strong>计重制航线：金鹏白金卡会员、金卡会员可享受额外30kg（66磅）免费行李，金鹏银卡会员可享受额外20kg（44磅）免费行李。</strong></p><p><strong>计件制航线：金鹏白金卡会员、金卡会员、银卡会员均可享受额外一件免费行李（行李重量及尺寸依照客票舱位对应额度执行）。</strong></p><p><strong>2、超限行李额规定</strong></p><p class=\"ql-align-center\">航线/标准</p><p class=\"ql-align-center\">超重（仅经济，公务不允许）</p><p class=\"ql-align-center\">超件（公务/经济）</p><p class=\"ql-align-center\">超尺寸（公务/经济）</p><p class=\"ql-align-center\">同时包含超件、超重或超大中两项或以上</p><p class=\"ql-align-center\">23KG&lt;W≤28KG</p><p class=\"ql-align-center\">28KG&lt;W≤32KG</p><p class=\"ql-align-center\">超出的第一件</p><p class=\"ql-align-center\">超出的第二件及以上</p><p class=\"ql-align-center\">158CM&lt;S≤203CM</p><p class=\"ql-align-center\">中国=美洲</p><p class=\"ql-align-center\">(不含加拿大)</p><p class=\"ql-align-center\">1000元/150美元</p><p class=\"ql-align-center\">1400元/210美元</p><p class=\"ql-align-center\">1400元/210美元</p><p class=\"ql-align-center\">2000元/300美元</p><p class=\"ql-align-center\">1300元/200美元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">中国=加拿大</p><p class=\"ql-align-center\">1000元/200加元</p><p class=\"ql-align-center\">1300元/260加元</p><p class=\"ql-align-center\">1300元/260加元</p><p class=\"ql-align-center\">2000元/400加元</p><p class=\"ql-align-center\">1300元/260加元</p><p class=\"ql-align-center\">就高原则</p><p class=\"ql-align-center\">中国=欧洲</p><p class=\"ql-align-center\">(不含俄罗斯)</p><p class=\"ql-align-center\">1200元/170欧元/1650挪威克朗</p><p class=\"ql-align-center\">140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-center\">1200元/170欧元/1650挪威克朗</p><p class=\"ql-align-center\">140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-center\">1200元/170欧元/1650挪威克朗</p><p class=\"ql-align-center\">140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-center\">2000元/280欧元/2750挪威克朗</p><p class=\"ql-align-center\">240英镑/290瑞士法郎/7070捷克克朗/113000匈牙利福林</p><p class=\"ql-align-center\">1200元/170欧元/1650挪威克朗</p><p class=\"ql-align-center\">140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">中国=俄罗斯</p><p class=\"ql-align-center\">1400元/180欧元/16000卢布</p><p class=\"ql-align-center\">1400元/180欧元/16000卢布</p><p class=\"ql-align-center\">1400元/180欧元/16000卢布</p><p class=\"ql-align-center\">2000元/280欧元/23000卢布</p><p class=\"ql-align-center\">1400元/180欧元/16000卢布</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">中国=大洋洲</p><p class=\"ql-align-center\">1000元/210澳元/230新西兰元</p><p class=\"ql-align-center\">1000元/210澳元/230新西兰元</p><p class=\"ql-align-center\">1100元/230澳元/250新西兰元</p><p class=\"ql-align-center\">2000元/420澳元/460新西兰元</p><p class=\"ql-align-center\">1000元/210澳元/230新西兰元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">中国=日本</p><p class=\"ql-align-center\">1000元/20000日元</p><p class=\"ql-align-center\">1200元/24000日元</p><p class=\"ql-align-center\">1200元/24000日元</p><p class=\"ql-align-center\">2000元/40000日元</p><p class=\"ql-align-center\">1000元/20000日元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">中国=亚洲(除中国=日本)</p><p class=\"ql-align-center\">杭州=塞班</p><p class=\"ql-align-center\">390元 /1930泰铢/60美元/450澳门元/440港元</p><p class=\"ql-align-center\">1000元/4950泰铢/150美元/1150澳门元</p><p class=\"ql-align-center\">880元/4950泰铢/150美元/1010澳门元</p><p class=\"ql-align-center\">1400元 /6920泰铢/210美元/1610澳门元</p><p class=\"ql-align-center\">1000元 /4950泰铢/150美元/1150澳门元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">特殊行程：中国经欧洲中转至非洲</p><p class=\"ql-align-center\">1200元/170欧元/140英镑</p><p class=\"ql-align-center\">1200元/170欧元/140英镑</p><p class=\"ql-align-center\">1400元/200欧元/160英镑</p><p class=\"ql-align-center\">2000元/280欧元/240英镑</p><p class=\"ql-align-center\">1200元/170欧元/140英镑</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">特殊行程：中国经欧洲中转至美洲</p><p class=\"ql-align-center\">1000元/150美元/200加元</p><p class=\"ql-align-center\">1400元/210美元/280加元</p><p class=\"ql-align-center\">1400元/210美元/280加元</p><p class=\"ql-align-center\">2000元/300美元/400加元</p><p class=\"ql-align-center\">1300元/200美元/260加元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">备注</p><p class=\"ql-align-justify\">1、持儿童婴儿客票的旅客超限行李费收费标准视同成人。</p><p class=\"ql-align-justify\">2、单件托运行李重量上限不得超过32公斤（70磅），三边尺寸之和不得超过203厘米（80英寸），重量、尺寸超过以上标准的，建议旅客将行李拆开分装，无法拆分的请登录http://www.hnacargo.com/Portal/Default.aspx，联系货运部门。</p><p class=\"ql-align-justify\">3、当国内、国际航班均为首航运输且国内转机点转机时间在24小时以内时，该行李运输规定适用于国内航段。</p><p class=\"ql-align-justify\">4、自2023年5月16日起（航班日期），调整首航国际及地区航班逾重行李收费标准，此政策生效同时废止首航国际自营航线免费行李额及超限行李费业务通告中超限行李额内容，国际航线留学生特殊旅客及特殊渠道免费行李额标准按原政策执行</p><p class=\"ql-align-center\">&nbsp;</p><p class=\"ql-align-center\">&nbsp;</p><p class=\"ql-align-center\"><strong>包机航线超限行李额规定</strong></p><p class=\"ql-align-center\">航线</p><p class=\"ql-align-center\">超重（仅经济，公务不允许）</p><p class=\"ql-align-center\">超件（公务/经济）</p><p class=\"ql-align-center\">超尺寸（公务/经济）</p><p class=\"ql-align-center\">同时包含超件、超重或超大中两项或以上</p><p class=\"ql-align-center\">23KG&lt;W≤32KG</p><p class=\"ql-align-center\">超出的第一件</p><p class=\"ql-align-center\">超出的第二件及以上</p><p class=\"ql-align-center\">158CM&lt;S≤203CM</p><p class=\"ql-align-center\">青岛=济州</p><p class=\"ql-align-center\">450元/77800韩元</p><p class=\"ql-align-center\">450元/77800韩元</p><p class=\"ql-align-center\">700元/121000韩元</p><p class=\"ql-align-center\">1000元/172800韩元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">杭州=济州</p><p class=\"ql-align-center\">450元/77800韩元</p><p class=\"ql-align-center\">450元/77800韩元</p><p class=\"ql-align-center\">700元/121000韩元</p><p class=\"ql-align-center\">1000元/172800韩元</p><p class=\"ql-align-center\">叠加收费</p><p class=\"ql-align-center\">备注</p><p>1、持儿童婴儿客票的旅客免费行李额及超限行李费收费标准视同成人。</p><p>2、单件托运行李重量上限不得超过32公斤（70磅），三边尺寸之和不得超过203厘米（80英寸），重量、尺寸超过以上标准的，建议旅客将行李拆开分装。</p><p>3、自2019年8月26日起（出票日期），调整首航国际及地区航班逾重行李收费标准，此政策生效同时废止首航国际包机航线免费行李额及超限行李费业务通告中超限行李额内容。</p><p>&nbsp;</p><p class=\"ql-align-center\"><strong>国际代码共享航线超限行李额规定</strong></p><p class=\"ql-align-center\">航线/标准</p><p class=\"ql-align-center\">超重（仅经济，公务不允许）</p><p class=\"ql-align-center\">超件（公务/经济）</p><p class=\"ql-align-center\">超尺寸（公务/经济）</p><p class=\"ql-align-center\">同时包含超件、超重或超大中两项或以上</p><p class=\"ql-align-center\">23KG&lt;W≤28KG</p><p class=\"ql-align-center\">28KG&lt;W≤32KG</p><p class=\"ql-align-center\">超出的第一件</p><p class=\"ql-align-center\">超出的第二件及以上</p><p class=\"ql-align-center\">158CM&lt;S≤203CM</p><p class=\"ql-align-justify\">中国=美洲(不含加拿大)</p><p class=\"ql-align-center\">1000元/150美元</p><p class=\"ql-align-center\">1400元/210美元</p><p class=\"ql-align-center\">1400元/210美元</p><p class=\"ql-align-center\">2000元/300美元</p><p class=\"ql-align-justify\">1300元/200美元</p><p class=\"ql-align-justify\">叠加收费</p><p class=\"ql-align-justify\">中国=加拿大</p><p class=\"ql-align-center\">1000元/200加元</p><p class=\"ql-align-center\">1300元/260加元</p><p class=\"ql-align-center\">1300元/260加元</p><p class=\"ql-align-center\">2000元/400加元</p><p class=\"ql-align-justify\">1300元/260加元</p><p class=\"ql-align-justify\">就高原则</p><p class=\"ql-align-justify\">中国=欧洲</p><p class=\"ql-align-justify\">(不含俄罗斯)</p><p class=\"ql-align-justify\">1200元/170欧元/1650挪威克朗/140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-justify\">1200元/170欧元/1650挪威克朗/140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-justify\">1200元/170欧元/1650挪威克朗/140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-justify\">2000元/280欧元/2750挪威克朗/240英镑/290瑞士法郎/7070捷克克朗/113000匈牙利福林</p><p class=\"ql-align-justify\">1200元/170欧元/1650挪威克朗/140英镑/180瑞士法郎/4240捷克克朗/68000匈牙利福林</p><p class=\"ql-align-justify\">叠加收费</p><p class=\"ql-align-justify\">中国=俄罗斯</p><p class=\"ql-align-justify\">1000元/140欧元</p><p class=\"ql-align-justify\">1200元/170欧元</p><p class=\"ql-align-justify\">1200元/170欧元</p><p class=\"ql-align-justify\">2000元/280欧元</p><p class=\"ql-align-justify\">1000元/140欧元</p><p class=\"ql-align-justify\">叠加收费</p><p class=\"ql-align-justify\">中国=大洋洲</p><p class=\"ql-align-justify\">480元/100澳元/100新西兰元</p><p class=\"ql-align-justify\">800元/170澳元/170新西兰元</p><p class=\"ql-align-justify\">800元/170澳元/170新西兰元</p><p class=\"ql-align-justify\">1100元/230澳元/230新西兰元</p><p class=\"ql-align-justify\">1000元/220澳元/220新西兰元</p><p class=\"ql-align-justify\">叠加收费</p><p class=\"ql-align-justify\">中国=日本</p><p class=\"ql-align-justify\">1000元/20000日元</p><p class=\"ql-align-center\">1200元/24000日元</p><p class=\"ql-align-justify\">1200元/24000日元</p><p class=\"ql-align-justify\">2000元/40000日元</p><p class=\"ql-align-justify\">1000元/20000日元</p><p class=\"ql-align-justify\">叠加收费</p><p class=\"ql-align-justify\">中国=亚洲(含港澳台地区，除中国=日本)杭州=塞班</p><p class=\"ql-align-justify\">390元/440港元/60美元/450澳门元</p><p class=\"ql-align-justify\">1000元/1120港元/150美元/1150澳门元</p><p class=\"ql-align-justify\">880元/980港元 /130美元/1010澳门元</p><p class=\"ql-align-justify\">1400元/1560港元/210美元/1610澳门元</p><p class=\"ql-align-justify\">1000元/1120港元/150美元/1150澳门元</p><p class=\"ql-align-justify\">叠加收费</p><p class=\"ql-align-justify\">备注</p><p>1、持儿童婴儿客票的旅客超限行李费收费标准视同成人。</p><p>2、单件托运行李重量上限不得超过32公斤（70磅），三边尺寸之和不得超过203厘米（80英寸），重量、尺寸超过以上标准的，建议旅客将行李拆开分装，无法拆分的请登录http://www.hnacargo.com/Portal/Default.aspx，联系货运部门。</p><p>3、自2022年12月24日起（航班日期），调整首航国际及地区航班逾重行李收费标准，此政策生效同时废止首航国际自营航线免费行李额及超限行李费业务通告中超限行李额内容，国际航线留学生，特殊旅客及特殊渠道免费行李额标准按原政策执行。</p><p>&nbsp;</p><p><strong>3、预付费行李</strong></p><p><strong>预付费行李额规定</strong></p><p>航线/标准</p><p>（公务/经济）</p><p>第一件</p><p>第二件及以上</p><p>中国=美洲（不含加拿大）</p><p>1260元/190美元</p><p>1260元/190美元</p><p>中国=加拿大</p><p>1170元/230加元</p><p>1170元/230加元</p><p>中国=欧洲（不含俄罗斯）</p><p>1080元/150欧元/130英镑</p><p>1080元/150欧元/130英镑</p><p>中国=俄罗斯</p><p>1260元/175欧元/13560卢布</p><p>1260元/175欧元/13560卢布</p><p>中国=大洋洲</p><p>880元/190澳元/200新西兰元</p><p>880元/190澳元/200新西兰元</p><p>中国=日本</p><p>1080元/21000日元</p><p>1080元/21000日元</p><p>中国=亚洲(除中国=日本/济州）</p><p>790元/100美元/3900泰铢/2750000越南盾</p><p>1260元/130美元/6220泰铢/4381000越南盾</p><p>中国=济州</p><p>360元/62200韩元</p><p>560元/96800韩元</p><p>备注</p><p>1、马累、塞班、澳门、济州航线，只允许销售境内始发，单程的预付费行李。海参崴航线，暂不销售预付费行李。</p><p>2、单件托运行李重量上限不得超过32公斤（70磅），三边尺寸之和不得超过203厘米（80英寸），重量、尺寸超过以上标准的，建议旅客将行李拆开分装，无法拆分的请登录<a href=\"http://www.hnacargo.com/Portal/Default.aspx\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: transparent; color: rgb(234, 66, 55);\">http://www.hnacargo.com/Portal/Default.aspx</a>，联系货运部门。</p><p>3、自2023年2月14日起（出票日期），调整首航国际及地区航班预付费行李收费标准，此政策生效同时废止首航国际自营航线免费行李额及超限行李费业务通告中预付费行李收费标准。</p><p>&nbsp;<strong>4、留学生行李</strong></p><p>适用航线</p><p>中国=美洲、中国=欧洲（含俄罗斯）、中国=大洋洲</p><p>舱位等级</p><p>免费行李额</p><p>经济舱</p><p>两件（每件行李重量不超过23公斤/50磅,三边之和不超过158厘米/62英寸）</p><p>1.出票时需在“旅客姓名”栏（NAME OF PASSENGER）中的旅客姓名后填写“/SD”（适用于留学生），使用QTE:STU/JD 指令出票。</p><p>2.尺寸上限是指三边尺寸之和的上限。其他未尽事宜以现行首都航空行李相关规定为准。</p><p>3. 享受留学生行李标准，需购买留学生客票特殊产品，如需请致电首都航空客服热线95375（境内），+8689895375（境外）进行购买，网站暂不支持此类客票销售。</p>', '2025-02-17 14:38:39');
INSERT INTO `news` VALUES (4, '行李运输规定-国内行李运输规定', 2, 'upload/news4.jpg', '2025-02-08 14:38:39', '<p><strong>一、手提行李</strong></p><p>&nbsp;&nbsp;&nbsp;手提行李的重量，持公务舱客票（或其他首都航空服务产品有明确规定）的旅客以每件7公斤为限，每人可随身携带两件物品，每件随身携带物品的体积不得超过20cm×40cm×55cm。持经济舱客票的旅客以每件7公斤为限，每人只能随身携带一件物品，每件随身携带物品的体积不得超过20cm×30cm×40cm（经济舱产品客票手提行李标准依照产品规定为准）。且应能置于旅客的前排座位之下或封闭式行李架内。超过上述重量、件数或体积限制的随身携带物品，应作为托运行李托运。</p><p><strong>二、托运行李</strong></p><p>&nbsp;（一）托运行李必须包装完善、锁扣完好、捆扎牢固，能承受一定的压力，能够在正常的操作条件下安全装卸和运输，并应符合下列条件：</p><p>1.旅行箱、旅行袋和手提包等必须加锁。</p><p>2.两件以上的包件，不能捆为一件。</p><p>3.行李上不能附插、栓挂其他物品。</p><p>4.竹篮、网兜、草绳、草袋等不能作为行李的外包装物。</p><p>5.带有危险品标记、标签的包装件一般不能作为行李的外包装物。</p><p>6.行李上应写明旅客的姓名、详细地址、电话号码。</p><p>7.行李包装内不能用锯末、谷壳、草屑等作衬垫物；行李上应写明旅客的姓名、详细地址、电话号码。</p><p>（二）托运行李每件重量不能超过50公斤，体积不能超过40cm×60cm×100cm。超过上述规定的行李，应事先征得首都航空的同意才能托运。</p><p><strong>三、免费行李额</strong></p><p>（一）每位旅客的免费托运行李额</p><p>1.持公务舱客票的成人或儿童旅客为30公斤。</p><p>2.持经济舱普通票价的成人旅客为20公斤。</p><p>3.持经济舱5折以上票价（除普通票价外）的成人旅客为20公斤。</p><p>4.持经济舱5折以下票价的成人旅客，无免费托运行李额。</p><p>5.持经济舱5折以上票价的儿童旅客为20公斤。</p><p>6.持经济舱5折以下票价的儿童旅客，无免费托运行李额。</p><p>7.按适用成人普通票价10%购票的婴儿旅客，无免费托运行李额（但可免费办理一件婴儿推车作为行李托运，无重量限制）。</p><p>8.持免票舱客票的旅客为20公斤。</p><p>9.占座婴儿客票免费行李额按照儿童客票免费行李额标准执行。</p><p>10.首都航空优惠票价或其他产品的免费行李额，有特定文件规定时（可能与上述标准不一致），按照优惠票价或产品的规定执行。</p><p>（二）搭乘同一航班前往同一目的地的两个（含）以上的同行旅客，如在同一时间、同一地点办理行李托运手续，其免费行李额可以按照各自的客票价等级标准合并计算。</p><p>（三）旅客非自愿改变舱位等级，应按原舱位等级享受免费行李额。</p><p>（四）构成国际运输联程客票的国内航段，每位旅客的免费行李额按适用的国际航线免费行李额计算。</p><p>（五）非国际运输联程客票的国内航段：对于国内、国际航班同为首都航空运输，但客票分别填开不属于同一运输合同，且在国内转机点转机时间在24小时以内的，国内航段按照国际航段标准运输规定执行；对于国际航班为非首都航空运输，客票分别填开不属于同一运输合同，则国内航段按照票面行李额度执行。</p><p>（六）限制旅客乘坐民航班机，对其必须携带的辅助器具（折叠轮椅、手杖、假肢等）给予免费携带，担架旅客的免费行李额为所占座位的免费行李额总和。</p><p>（七）额外占座旅客的免费行李额，按其所占座位的票价等级和占用座位数确定。手提行李占座的客票没有免费行李额。</p><p>（八）要客、金鹏贵宾会员旅客在享受客票对应正常免费行李额的同时，额外增加免费行李额如下：白金卡、金卡会员可享受额外30KG免费行李，银卡会员可享受额外20KG免费行李。VVIP旅客免费行李额无限制，VIP旅客可享受额外20KG免费行李，CIP旅客可享受额外10KG免费行李。</p><p><strong>四、逾重行李费</strong></p><p>（一）旅客的托运行李和手提行李中超过该旅客免费行李额的部分及无人陪伴的行李，称为逾重行李。旅客携带逾重行李乘机，应当支付逾重行李费。</p><p>（二）收取逾重行李费，应填开逾重行李票。</p><p>（三）国内逾重行李费以每公斤按航程距离所对应的相应收费标准填开逾重行李票，收费单位以元为单位，舍去个位数取整至十位数</p><p>1.航程距离800（不含）公里以下，12元/公斤。</p><p>2.航程距离800（含）-1600（不含）公里之间，16元/公斤。</p><p>3.航程距离1600（含）公里以上，20元/公斤。</p><p>4.登机口办理行李托运，300元/件（仅限在时间、安全等条件允许的情况下可办理）。</p><p>（四）逾重行李收费标准如有其他规定或产品政策，则按照相应的规定或产品政策执行。</p><p><strong>特别说明：</strong></p><p><strong>如您的出行计划可能涉及相关需求，可拨打首都航空客服热线95375（国内）+8689895375（海外）详细咨询。</strong></p>', '2025-01-23 14:38:39');
INSERT INTO `news` VALUES (5, '公积金政策又上“新”了！灵活就业人员也可享受多重权益', 1, 'upload/news5.jpg', '2025-01-09 14:38:39', '<p>	下调贷款利率，减轻购房成本；优化租房提取流程，助力百姓安居；多地支持异地提取，方便市民买房购房；零材料申请，随时随地办理业务……今年以来，<strong>全国有超过20个城市相继出台了住房公积金优化调整政策，</strong>降低了购房成本和门槛，给老百姓带来了很大的便利。</p><p><strong> 多地住房公积金优化调整有哪些新变化？</strong></p><p>2月以来，各地密集出台住房公积金优化调整政策，长沙、济南、大连等城市，都不同程度提高了住房公积金贷款额度，最高额度都提高了几十万元不等，此外最低首付比例也降到了20%。</p><p>长沙住房公积金管理中心政策业务部部长刘丹对记者表示，比如说一套150万的新房，职工来申请公积金组合贷款，首付款可以从原来的45万降低到目前的30万。</p><p>天津、宜昌、兰州等地明确将个体工商户、自由职业者等灵活就业人员，也纳入住房公积金缴存范围，灵活就业人员原则上也可享受“商转公”“多孩家庭公积金贷款支持政策”等多重权益。</p><p>而在福建多地则明确支持省内购房异地可以提取，厦门、莆田、南平等地还允许父母或子女等家庭成员之间利用住房公积金进行购房贷款。</p><p>根据初步统计，今年以来，全国已经有超过20个城市出台了公积金优化调整相关政策。</p><p class=\"ql-align-center\"><img src=\"https://p3.img.cctvpic.com/photoworkspace/contentimg/2025/02/16/2025021614474929068.jpg\"></p><p><strong> 如何提取住房公积金支付房租？</strong></p><p>实际上住房公积金也可以支付房租。记者了解到，目前各地使用住房公积金支付房租的要求和方式有所差别，现在我们就以北京为例，看看如何提取住房公积金支付房租？</p><p>前不久，北京推出了住房公积金直付房租的试点，让不少租房人提取更加便利。</p><p><strong>“直付房租”</strong>是指公积金中心根据缴存人的授权和申请，按月将缴存人可提取的住房公积金从其公积金账户直接划转至试点住房出租机构账户，用于支付房租的方式。</p><p>北京住房公积金管理中心主任张国伟向记者表示，这次租金直付覆盖的范围比较全，包括商品房、保租房、公租房，今年还将根据试点效果，陆续在全市推广实施。</p><p>与此同时，北京不断细化租房提取事项类型，租住商品房并且在“北京市房屋租赁管理服务平台”备案并提供租房发票的，<strong>按实际月租金全额提取，实际租金超过月缴存额的，按月缴存额全额提取。</strong></p><p>数据显示，近年来，我国住房公积金租房提取金额、人数快速增长，每年支持超过1500万新市民、青年人等缴存群体提取住房公积金支付房租，其中40岁以下青年人占比超过80%。</p><p><strong> 关于住房公积金</strong></p><p><strong> 你了解多少？</strong></p><p><strong>住房公积金，</strong>是指国家机关、国有企业、城镇集体企业、外商投资企业、城镇私营企业及其他城镇企业、事业单位、民办非企业单位、社会团体及其在职职工缴存的长期住房储金。</p><p class=\"ql-align-center\"><img src=\"https://p2.img.cctvpic.com/photoworkspace/contentimg/2025/02/16/2025021614474958656.jpg\"></p><p>住房公积金是带有保障性，所以它比商业银行的贷款率低。以目前100万30年为例，如果是首套房，30年下来公积金贷款比商业贷款要少偿还利息将近6万元。</p><p>从一般用途上来讲，住房公积金主要是用于租房购房这些住房消费项目，可以用于购买、建造、翻建、大修、自住住房，对于一般的装修类提取是不能支持提取的。</p><p>根据住房城乡建设部发布的数据显示，截至目前，我国住房公积金实缴职工人数超过1.7亿 ，缴存额达到34697.69亿元。</p><p>（总台央视记者 崔霞 谭振华）</p>', '2025-02-13 14:38:39');
INSERT INTO `news` VALUES (6, '忠诚履职把反腐败斗争进行到底', 1, 'upload/news6.jpg', '2025-01-16 14:38:39', '<p class=\"ql-align-justify\">	习近平总书记在二十届中央纪委四次全会上发表重要讲话，充分肯定过去一年全面从严治党取得的新进展新成效，深刻分析当前反腐败斗争形势，对坚决打好反腐败斗争攻坚战、持久战、总体战发出动员令。作为中管企业纪检监察机构，必须把思想和行动统一到党中央决策部署上来，以实际行动坚定拥护“两个确立”、坚决做到“两个维护”。</p><p class=\"ql-align-justify\">坚持以伟大自我革命引领伟大社会革命。新时代以来，以习近平同志为核心的党中央以前所未有的力度推进全面从严治党，赢得了确保党不变质、不变色、不变味的历史主动，赢得了党团结带领全体人民为强国建设、民族复兴伟业共同奋斗的历史主动。中国海油纪检监察组深入学习贯彻习近平总书记关于党的自我革命的重要思想，强化政治监督，强力正风肃纪反腐，推动管党治党宽松软状况得到整体性扭转。特别是过去一年来，查办案件持续加压发力，立案数量、留置数量、处理处分数量均同比大幅增长，实现多个领域反腐败斗争的重大突破，采办招投标等领域改革破难而进，为企业高质量发展清障除碍、保驾护航。</p><p class=\"ql-align-justify\">始终保持对反腐败斗争形势的清醒认识。习近平总书记深刻指出，当前反腐败斗争形势仍然严峻复杂，铲除腐败滋生土壤和条件任务仍然艰巨繁重，坚定有力批驳错误认识，为全党正本清源、举旗定向。从中国海油来看，严的氛围尚未真正形成，遏制增量、清除存量的任务十分艰巨。有的领导干部不收敛、不知止，用人腐败和用权腐败相互交织，基层不正之风和腐败问题量多面广，采办招投标、合同管理、船舶租赁、物资管理、境外业务等领域权力监管还不够有力有效。中国海油纪检监察组将坚定对反腐败斗争的信心、恒心、决心，乘势而上、稳中求进，做到一步不停歇、半步不退让，坚决打好反腐败斗争攻坚战、持久战、总体战。</p><p class=\"ql-align-justify\">忠诚履职把反腐败斗争进行到底。当前，正处于中国式现代化建设的关键时期。要把宏伟蓝图变为美好现实，必须用改革精神和严的标准管党治党，不断把全面从严治党推向纵深。中国海油纪检监察组将牢记职责使命，自觉把工作放在进一步全面深化改革、推进中国式现代化的大局中谋划推进。聚焦贯彻落实二十届三中全会精神做深做实政治监督，强化对重大改革研究论证、决策实施、效果评估的全过程监督，确保解决实际问题、取得良好效果。加强党的纪律建设，坚持严肃教育、严格监督、严明执纪相贯通，深入挖掘案例资源开展警示教育，持续深化“一企一策”点题式监督，准确运用“四种形态”，强化制度执行刚性约束。深化风腐同查同治，持续整治违规套取差旅费用、违规报销业务招待费等问题，深挖彻查职务犯罪问题，坚决打掉污染政治生态的团团伙伙，坚决斩断内外勾结的利益链条。贯通落实主体责任、职能监管责任和专责监督责任，一体推进不敢腐不能腐不想腐，坚持“一案一约谈、一案一警示、一案一整改”，推动以改革的办法破除重点领域顽瘴痼疾，着力铲除腐败滋生的土壤和条件。推进纪检监察工作规范化法治化正规化建设，以更高标准、更严要求，推动纪检监察铁军建设再上新台阶。（中国海洋石油集团有限公司纪检监察组组长 钟庆明）</p><p class=\"ql-align-center\"><img src=\"https://p3.img.cctvpic.com/photoAlbum/page/performance/img/2021/3/26/1616750563130_326.png\">扫二维码 访问央视网</p><p><br></p>', '2025-01-29 14:38:39');
INSERT INTO `news` VALUES (7, '厦航与莆田市政府签署战略协议', 3, 'upload/news7.jpg', '2025-01-31 14:38:39', '<p>	5月1日，厦航与莆田市人民政府在莆田市湄洲岛签署战略合作框架协议。莆田市委书记付朝阳，市长林旭阳会见厦航董事长、党委书记赵东，总经理、党委副书记谢兵一行，并共同出席签约仪式。莆田市委常委、秘书长高宇，市人民政府党组成员、副市长朱正扬及厦航党委委员、副总经理陈立等领导参加。</p><p>	农历三月廿三，适逢妈祖诞辰。林旭阳市长在纪念妈祖诞辰1064周年大会暨春祭大典的致辞中表示：期待与厦航携手合作，持续扩大妈祖文化的国际影响力。</p><p>	签约仪式上，湄洲岛国家旅游度假区管委会、湄洲妈祖祖庙董事会分别向厦航授予“‘世界妈祖文化论坛’战略合作伙伴”牌匾和“‘湄洲妈祖巡天下’‘天下妈祖回娘家’航空承运合作单位”牌匾。此次战略合作，厦航将依托通达六大洲的航线网络和广泛覆盖的驻外机构，开展妈祖文化相关主题活动和系列巡安民俗活动，对接保障归国进香团、出国巡安团的承运服务工作；利用厦航涵盖海内外的宣传矩阵助力妈祖文化宣传推广，在国际舞台上结合妈祖文化讲好中国故事；依托自有上下游产业支持莆田优质农特产品对外销售，深化文旅、酒店、餐饮、康养、文创等各领域合作，助力莆田打响城市品牌。</p><p>	一直以来，厦航都是弘扬推广妈祖文化的先行者、实践者。从1997年湄洲妈祖金身赴台巡安，到2001年福建代表团参加澳门首届妈祖文化旅游节，再到之后妈祖金身巡安澳门和东南亚，都是由厦航负责承运保障，每一次都引起了广泛而良好的社会反响。厦航为妈祖金身巡安精心筹划的“打印专属登机牌、设置专属座椅”等特色服务，受到各主流媒体和社会大众的高度关注，加速了妈祖文化“出圈”传播。</p>', '2025-01-30 14:38:39');
INSERT INTO `news` VALUES (8, '传递中国声音！厦航董事长赵东出席联合国全球契约组织理事会', 3, 'upload/news8.jpg', '2025-01-29 14:38:39', '<p>	当地时间9月20日-23日，联合国全球契约组织理事会、秘书长讨论会在美国纽约召开。厦航董事长、党委书记赵东作为唯一中国理事，与联合国秘书长安东尼奥·古特雷斯、联合国助理秘书长、联合国全球契约组织总干事桑达·奥加博等24位理事共同出席会议，围绕“国家网络建设”“中非合作”等议题展示中国战略愿景、中国企业阶段性成果，提出战略和决策建议，向世界传递中国声音。会议期间，赵东向古特雷斯秘书长介绍了厦航的可持续发展工作，并赠送厦航最新的融入支持联合国可持续发展目标元素的运动服。</p><p>	会上，理事成员对契约组织的国家网络发展和治理进行了讨论。赵东从因地制宜、商业运作、协作共赢三方面，提出国家网络发展需充分结合各国的国情特点发挥理事作用，通过激活运作机制不断促进商业向善，同时要构筑合作公共平台，实现互利共赢。此外，赵东还介绍了中国企业在运营中面临的实际情况，并表达了作为理事，将致力于不断提升中国企业与联合国全球契约组织联动的决心。</p><p>	“通过中非企业可持续发展合作加强南南合作”是联合国全球契约组织中国战略的工作重点。赵东围绕中非合作论坛北京峰会成果，以生动的案例对中国企业在非援助模式进行介绍和解读，向理事们展示了过去几十年来，中国企业以援助带动投资，通过技术传授的方式，为非洲日后的发展留下更多的本地人才，实现真正的造血式南南发展合作的成果。</p><p>	9月23日，正值纽约气候周，联合国全球契约组织举办绿色价值CEO圆桌论坛，邀请全球8个国家30余位企业代表参与气候变化议题的对话和探讨，赵东受邀作开场致词。联合国全球契约组织副总干事梅利莎·鲍威尔、第29届联合国气候变化大会阿塞拜疆首席运营官纳尔敏·贾尔恰洛娃等出席会议。</p><p><br></p>', '2025-01-30 14:38:39');
INSERT INTO `news` VALUES (9, '厦航总经理谢兵参加IATA世界安全与运行大会 宣布厦航将承办2025年度大会', 3, 'upload/news9.jpg', '2025-02-15 14:38:39', '<p>	10月1日至3日，厦航总经理、党委副书记谢兵带队赴摩洛哥出席IATA（国际航协）2024年度世界安全与运行大会，全球来自政府部门、航司、行业组织、航空供应商在内的超800名专家与学者代表参会。大会闭幕式上，谢兵作主旨发言，宣布厦航将承办下一年度大会，并热情邀请业界同仁明年共赴厦门。会上，2025年大会官方预热视频正式亮相，推介厦航以及总部所在城市厦门。</p><p>	会议期间，谢兵分别会见了多位航空安全领域相关的负责人，包括国际航协运行、安全与安保高级副总裁Nick Careen，空客航空安全高级副总裁Yannick Malinge，以及飞行数据仿真系统供应商CEFA公司CEO Dominique MINEO等，就下一届会议承办具体事宜、空客机队运行情况、安全管理与飞行训练等方面议题进行深入探讨。</p><p>	IATA世界安全与运行大会是全球航空公司在航空安全、航班运行以及基础设施方面规模最大、层级最高的会议，议题涵盖了包括航班运行、客舱管理、维修以及应急管理在内的多个安全领域，是航司决策者与业内人士讨论当下最为热点和具有全球战略意义的安全与运行问题、建立发展合作伙伴关系的重要平台。</p><p>	作为2025年度大会的承办航司，厦航将以此为契机，用更加开放、包容的姿态，积极融入全球航空业的发展潮流，加强与国际航空业的交流互鉴、共同应对挑战、分享机遇，为推动全球航空安全与运行的进步作出更大贡献。</p><p class=\"ql-align-center\">	</p>', '2025-02-17 14:38:39');
INSERT INTO `news` VALUES (10, '南航成首家运行航空公司 广州白云机场第四跑道启用', 3, 'upload/news10.jpg', '2025-01-31 14:38:39', '<h2 class=\"ql-align-center\"><br></h2><p>	1月23日早上08:10，南航三亚-广州的CZ6731航班平稳降落在广州白云机场第四跑道，标志着该跑道正式启用，意味着广州白云机场成为粤港澳大湾区唯一的四跑道机场，保障服务能力迈出了提质增效的关键一步，同时也预示着南航迎来新的发展机遇，将会在高质量发展道路上阔步向前。</p><p>	广州白云机场第四跑道（西二跑道）位于西一跑道西侧，长3400米、宽45米，满足大型E类飞机起降的要求。为保障第四跑道启用，南航作为白云机场主要基地航空公司，积极配合白云机场完成跑道投用前的校飞、试飞工作，全程参与跑道切换演练，确保启用过渡期间的运行安全。</p><p>	正值春运，为保证第四跑道切换启用期间航班运行安全顺畅，南航运行指挥中心一方面提前梳理航图资料和飞行程序变更细节，做好航行情报数据周期切换，准确校核机载导航数据库中南航定制化数据，聚焦运行核心风险防控，做好第四跑道启用及粤港澳大湾区空域调整宣贯培训工作，全力确保航班运行安全。另一方面制定专项应对方案，提前梳理和固定进出港航班计划，成立专项工作小组与白云机场、中南空管局对接，加强沟通协作，在中长期、短期、当日持续监控航班变化，协同白云机场运管委做好预先计划调整，提升公司航班运行效率，努力服务旅客春运出行需求。</p><p>	南航运行指挥中心总经理熊国斌表示，随着白云机场第四跑道的启用，南航将进一步增加白云机场航班量，把旅客安全舒适送到目的地。这将对南航服务粤港澳大湾区战略，打造具有全球竞争力的国际航空枢纽，为旅客提供优质准点的服务起到非常重要的作用，让更多人乐享美好飞行。</p>', '2025-01-29 14:38:39');
INSERT INTO `news` VALUES (11, '关于南航在成都双流国际机场实际承运航班转场至T1航站楼运行的通知', 2, 'upload/news11.jpg', '2025-02-14 14:38:39', '<h2 class=\"ql-align-center\"><br></h2><p><br></p><p>尊敬的旅客：</p><p>	自2025年2月24日起，由南航实际承运的成都双流国际机场进出港航班，由T2航站楼调整至T1航站楼运营。</p><p>	为确保您的行程顺畅，请前往双流机场T1航站楼办理值机、安全检查等乘机手续。请关注上述调整信息，做好出行安排。感谢您的理解与配合，祝您旅途愉快！</p><p>&nbsp;</p><p class=\"ql-align-right\">中国南方航空股份有限公司</p><p class=\"ql-align-right\">2025年2月10日</p><p><br></p><p>Google</p><p>Bing</p><p>Baidu</p><p>Yandex</p><p>DuckduckGo</p><p>Wikipedia</p>', '2025-02-06 14:38:39');
INSERT INTO `news` VALUES (12, '无人认领行李公告', 2, 'upload/news12.jpg', '2025-01-16 14:38:39', '<h2 class=\"ql-align-center\"><br></h2><p><br></p><p>尊敬的各位旅客：</p><p>	中国南方航空股份有限公司将对承运过程中，自到达次日起保存超过60天仍无人认领的行李进行公示，公示期为公示之日起30天，公示图片附后。</p><p>	如您在90天内乘坐本公司航班，出现托运行李遗失且未获得赔偿的情况下，请查阅公示页面确认是否有您的遗失行李。如在公示页面内发现遗失行李，请在公示期内准备行李报失时航空公司开具的《不正常行李运输记录单》，填写《丢失行李内物调查表》，致电本公司行李查询部门。我们将根据案件情况、行李内物与您核对行李信息，办理行李认领手续。具体联系方式如下：8620-86122921</p><p>	公示期满后，本公司将按照无法交付行李的有关规定，对此批无人认领行李进行处理。</p><p>	如有疑问，请致电以上公布电话咨询。</p><p>	<a href=\"https://www.csair.com/cts-products/group1/M00/0F/C5/rBtJFGesCSqAb4PMAHftKPUBf0E927.pdf\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 160, 233);\">2024年逾期行李（10月31日前）.pdf</a></p><p>	<a href=\"https://www.csair.com/cts-products/group1/M00/0F/C5/rBtJFWesCYWARAapAAnr0zWgHNo282.pdf\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 160, 233);\">过站航班逾期（酒).pdf</a></p><p>&nbsp;</p><p class=\"ql-align-right\">中国南方航空股份有限公司</p><p class=\"ql-align-right\">2025年2月12日</p><p><br></p>', '2025-01-30 14:38:39');
INSERT INTO `news` VALUES (13, '把迎春花市搬到万米高空 南航开展“木棉新禧”迎新春主题航班活动', 3, 'upload/news13.jpg', '2025-01-23 14:38:39', '<p>	1月23日，南方小年当天，南航在哈尔滨至广州的CZ3616航班上开展“木棉新禧”迎新春主题航班活动，把岭南传统的迎春花市搬到万米高空，营造喜庆祥和的节日氛围，为旅客送上新春的温暖祝福。</p><p>	春节期间南航还将在在北京、上海、广州、深圳等18个城市出发的近50个国内航班以及广州出发至法兰克福、巴黎、纽约等国际航班上开展不同形式的迎新春主题航班活动，为旅客打造具有各地文化特色的新年乘机体验。</p><p>	<strong>传统文化融入航班活动</strong></p><p>	1月23日中午，哈尔滨太平国际机场南航CZ3616航班的登机口排起了长队，有返乡过年的广东旅客，也有到花城广州旅游过年的东北旅客。旅客们刚踏上登机梯，就看到乘务员们统一身着喜庆的红色旗袍，手持木棉花枝在机舱门口迎接。客舱壁板也经过精心布置，伴着喜庆的登机音乐，浓浓的年味扑面而来。当飞机飞到万米高空，“空中花市”正式开启，乘务组请出“财神”为旅客送迎春花、派“利是”，介绍迎春花市这一岭南地区传统民俗文化盛会。此次航班上有不少外国旅客，他们也被热闹的氛围感染，主动与“财神”及乘务组合影留念。航班活动还设置了猜灯谜、拜年歌曲联唱等环节，旅客们纷纷举手、踊跃参与。“能坐上这次主题航班，感觉自己很幸运，谢谢你们，真的超暖心。”乘客汤女士在下机时专门向乘务组表达了自己的感谢。</p><p>	“中华优秀传统文化一直是我们设计主题航班活动的灵感来源，活动中融入全国各地的特色民俗、传统非遗等文化符号，通过飞机这一载体，向中外旅客全方位展示中华传统文化的独特魅力。”航班主任乘务长陈雪婧表示。</p><p>	<strong>节日美食传递家乡味道</strong></p><p>	春运期间，南航将在广州、北京、深圳、上海、杭州等地进出港的46条航线上推出具有各地地域特色的丰富菜式。比如，在全国多地飞往贵阳的航班上提供特色辣子鸡，在飞往汕头的航班上提供潮汕红桃粿，在飞往大连的航班上提供海味全家福，让旅客从登上飞机开始就能感受到“家”的味道。另外，南航还推出与季节和餐食相匹配的养生茶饮，结合春节期间特色的客舱装饰、新春广播、主题餐盒等，打造一趟综合了视觉、味觉、听觉等多方位感受的新年乘机之旅。</p><p>	<strong>特别关爱送给重点旅客</strong></p><p>	春运期间，南航为老人、儿童等重点旅客群体开启“暖心模式”。对于单独乘坐飞机出行的小旅客，乘务组将填写“木棉童飞”乘机卡，记录小旅客在机上的饮食等情况，以便家长了解。如遇航班延误、取消等不正常情况，乘务组还将通过“亲情连线”等特色服务，及时与接机人做好沟通。对于老年旅客、残疾旅客以及首次乘机的旅客，乘务组将在航班飞行过程中给予特别关注，详细介绍机上服务设施的使用方法，主动询问倾听旅客需求，及时提供帮助。</p><p>	“南航的无陪儿童服务与推出之初相比，有了很大的优化。除了将小旅客平安送达目的地之外，我们还通过文字记录、电话沟通等多种形式，注重满足家长想要了解孩子乘机状态的需求。”南航客舱工作人员提到。春节期间，南航还通过“木棉童飞”、“木棉暖心”等一系列新服务举措，为节日出行旅客提供更多便利，让更多人乐享美好飞行。</p>', '2025-02-14 14:38:39');
INSERT INTO `news` VALUES (14, '南航集团顺利实现2024航空安全年', 3, 'upload/news14.jpg', '2025-01-24 14:38:39', '<p>	2024年12月31日晚21时32分，由北京大兴飞往广州的中国南方航空CZ3100航班平稳降落在广州白云国际机场，标志着南航集团顺利实现2024航空安全年。南航集团预计全年累计完成运输飞行314.5万小时、通航飞行1.93万小时，安全运输旅客1.65亿人次，货邮运输量达183.4万吨，继续保持国内民航最好的安全纪录，各项服务指标均居国内航空公司前列，连续7年在中央企业党建考核中保持“A”级。</p><p>	<strong>心怀“国之大者” 全力服务国家重大战略</strong></p><p>	南航扎实推动高质量发展，积极落实京津冀协同发展、粤港澳大湾区建设、东北振兴等区域重大战略，圆满完成“两会”、博鳌论坛、进博会等重要保障任务，在建设世界一流新征程上迈出了坚实步伐。</p><p>	南航持续深化枢纽网络战略，构筑大湾区到国内主要城市的4小时航空交通圈，打造北京大兴“四进四出”航班波，新开通广州-布达佩斯、广州-贝尔格莱德、北京大兴-悉尼等国际及地区客运航线47条，成为“一带一路”头号航空承运人。南航全力支持国产飞机事业发展，签订100架C919飞机采购协议并已接收3架C919飞机。目前，南航C919执飞4条商业定期航线，运送旅客超6.1万人次，展现了国产大飞机的卓越性能和南航的高效运营能力。</p><p>	<strong>积极开拓创新 因地制宜培育新质生产力</strong></p><p>	南航深入实施国企改革深化提升行动，加快数字化转型，推进科技创新、产业创新、发展方式创新，积极培育和发展新质生产力，连续3年获评央企改革考核A级。</p><p>	南航自主研发全球首套兼容空客、波音、中国商飞等主流机型的飞机健康诊断“天瞳系统”，填补了中国民航该领域的空白。自主研发“天极”系统，并首家应用于C919飞行计划管理，服务国产大飞机高水平科技自立自强。自主研制首台A320NEO-D级全动飞行模拟机，打破技术壁垒。</p><p>	南航明确了“2+5+X”产业新布局，加快布局战略性新兴产业。南航首创国内跨境电商带电货物包机运输，货运航线网络覆盖全球超170个国家、1000余个城市，南航物流、南航通航获评国资委“双百企业”标杆。南航翔翼公司获评国家专精特新“小巨人”企业称号，主导的“超写实高等级视景系统关键技术及应用”获中国航空学会科技进步奖一等奖。</p><p>	<strong>强化品牌引领 打造“亲和精细”服务</strong></p><p>	南航积极践行“人民航空为人民”，创新推出新时代“阳光南航”企业文化和品牌理念体系，以“让更多人乐享美好飞行”为企业使命，以“安全第一 客户为本”为核心价值观，打造“亲和精细”优质服务，树立“可靠、温暖、活力”品牌形象。2024年，南航品牌在国资委中央企业品牌建设榜单中排第8名，连续14年获得中国品牌力指数航空服务第1名，均居国内行业首位。</p><p>	南航深化大运行建设，打造人性化、数字化、精细化、个性化、便捷化的“五化”服务，推进广州始发“南航快线”国内航班人工柜台缩短至30分钟截载。目前，“南航明珠俱乐部”常旅客奖励计划会员已超1亿人。南航连续7年获评民航旅客服务测评（CAPSE）“最佳航空公司”，“南航e行”获评中央企业品牌引领行动首批优秀成果。</p><p>	<strong>扛起央企担当 积极履行社会责任</strong></p><p>	南航纵深推进绿色低碳发展，探索形成了以飞机节能减排、降低地面能耗、旅客绿色出行为抓手，覆盖航空运输全流程的绿色发展模式。积极参加可持续航空燃料应用试点，牵头起草编制民航业首部限塑类团体标准，发布民航业首部绿色发展白皮书。</p><p>	南航认真学习运用“千万工程”经验，深化“南航消费帮扶”等品牌，全力服务乡村振兴，全年在全国各帮扶点共投入各类帮扶资金近亿元。</p><p>	2025年是“十四五”规划收官之年，南航集团将始终坚持以习近平新时代中国特色社会主义思想为指导，聚精会神抓好高质量发展，努力在建设世界一流的新征程上走在前列。</p>', '2025-02-06 14:38:39');

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(0) NOT NULL COMMENT '采购员id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采购员名',
  `tablename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 1, 'cyan', 'yonghu', '用户', 'lrcph0junfk90hepnmzegopq31ocy7cj', '2025-02-06 14:42:29', '2025-02-16 23:01:27');
INSERT INTO `token` VALUES (2, 1, 'admin', 'users', '管理员', 'fizsxnf3q1hebs0b6lgdlsxlo3zw5610', '2025-02-06 15:12:06', '2025-05-05 10:56:53');
INSERT INTO `token` VALUES (3, 3, 'cyang', 'yonghu', '用户', '7hte98yd9div4hsozaaq5eam5onmwjmg', '2025-02-06 23:26:30', '2025-06-16 23:25:04');
INSERT INTO `token` VALUES (4, 9, '20250303', 'yonghu', '用户', 'quhmzbxmu9k2g6ue5zr7j95ob2ekgzti', '2025-03-20 14:41:27', '2025-03-20 15:41:27');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采购员名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin', '管理员', '2025-01-09 14:38:29');

-- ----------------------------
-- Table structure for yonghu
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `yonghu_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户姓名 Search111 ',
  `yonghu_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `yonghu_phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户手机号',
  `yonghu_id_number` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户身份证号 ',
  `sex_types` int(0) NULL DEFAULT NULL COMMENT '性别 Search111 ',
  `new_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '余额 ',
  `yonghu_delete` int(0) NULL DEFAULT 1 COMMENT '假删',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES (1, 'cindy', '123456', 'cindy', 'upload/1740592774940.png', '15600959523', '410224199010102001', 1, 9649.62, 1, '2025-01-16 14:38:39');
INSERT INTO `yonghu` VALUES (2, '13500505050', '123456', '小黄', 'upload/1740592763987.jpg', '13500505050', '410224199010102002', 1, 962.45, 1, '2025-01-02 14:38:39');
INSERT INTO `yonghu` VALUES (3, 'cyang', '123456', '小杨', 'upload/1742477385307.jpg', '13200202020', '410224199010102003', 2, 90080.00, 1, '2025-01-04 14:38:39');
INSERT INTO `yonghu` VALUES (9, '20250303', '123456', '小花', NULL, '13500525656', '350325200304051265', 1, 90000.00, 1, '2025-03-20 14:41:20');

SET FOREIGN_KEY_CHECKS = 1;
