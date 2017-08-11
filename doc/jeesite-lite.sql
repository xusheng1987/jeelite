/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50635
Source Host           : localhost:3306
Source Database       : jeesite-lite

Target Server Type    : MYSQL
Target Server Version : 50635
File Encoding         : 65001

Date: 2017-08-11 11:18:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `package_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成表编号',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_scheme_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='生成方案';

-- ----------------------------
-- Records of gen_scheme
-- ----------------------------
INSERT INTO `gen_scheme` VALUES ('35a13dc260284a728a270db3f382664b', '树结构', 'treeTable', 'com.thinkgem.jeesite.modules', 'test3', null, '树结构生成', '树结构', 'ThinkGem', 'f6e4dafaa72f4c509636484715f33a96', '1', '2013-08-12 13:10:05', '1', '2017-08-11 09:19:29', '', '0');
INSERT INTO `gen_scheme` VALUES ('9c9de9db6da743bb899036c6546061ac', '单表', 'curd', 'com.thinkgem.jeesite.modules', 'test1', null, '单表生成', '单表', 'ThinkGem', 'aef6f1fc948f4c9ab1c1b780bc471cc2', '1', '2013-08-12 13:10:05', '1', '2017-08-11 09:15:11', '', '0');
INSERT INTO `gen_scheme` VALUES ('e6d905fd236b46d1af581dd32bdfb3b0', '主子表', 'curd_many', 'com.thinkgem.jeesite.modules', 'test2', null, '主子表生成', '主子表', 'ThinkGem', '43d6d5acffa14c258340ce6765e46c6f', '1', '2013-08-12 13:10:05', '1', '2017-08-11 09:17:00', '', '0');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) DEFAULT NULL COMMENT '关联父表外键',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_name` (`name`),
  KEY `gen_table_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('43d6d5acffa14c258340ce6765e46c6f', 'test_data_main', '业务数据表', 'TestDataMain', null, null, '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table` VALUES ('6e05c389f3c6415ea34e55e9dfb28934', 'test_data_child', '业务数据子表', 'TestDataChild', 'test_data_main', 'test_data_main_id', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table` VALUES ('aef6f1fc948f4c9ab1c1b780bc471cc2', 'test_data', '业务数据表', 'TestData', null, null, '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table` VALUES ('f6e4dafaa72f4c509636484715f33a96', 'test_tree', '树结构表', 'TestTree', null, null, '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_name` (`name`),
  KEY `gen_table_column_sort` (`sort`),
  KEY `gen_table_column_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('0902a0cb3e8f434280c20e9d771d0658', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '1', '1', '=', 'radiobox', 'sex', null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('103fc05c88ff40639875c2111881996a', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('12fa38dd986e41908f7fefa5839d1220', '6e05c389f3c6415ea34e55e9dfb28934', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('195ee9241f954d008fe01625f4adbfef', 'f6e4dafaa72f4c509636484715f33a96', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('19c6478b8ff54c60910c2e4fc3d27503', '43d6d5acffa14c258340ce6765e46c6f', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('1ac6562f753d4e599693840651ab2bf7', '43d6d5acffa14c258340ce6765e46c6f', 'in_date', '加入日期', 'timestamp(6)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '0', '=', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('1b8eb55f65284fa6b0a5879b6d8ad3ec', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'in_date', '加入日期', 'timestamp(6)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '1', 'between', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('1d5ca4d114be41e99f8dc42a682ba609', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'user_id', '归属用户', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('21756504ffdc487eb167a823f89c0c06', '43d6d5acffa14c258340ce6765e46c6f', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '10', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('24bbdc0a555e4412a106ab1c5f03008e', 'f6e4dafaa72f4c509636484715f33a96', 'parent_ids', '所有父级编号', 'varchar2(2000)', 'String', 'parentIds', '0', '0', '1', '1', '0', '0', 'like', 'input', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('33152ce420904594b3eac796a27f0560', '6e05c389f3c6415ea34e55e9dfb28934', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('35af241859624a01917ab64c3f4f0813', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '13', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('398b4a03f06940bfb979ca574e1911e3', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('3a7cf23ae48a4c849ceb03feffc7a524', '43d6d5acffa14c258340ce6765e46c6f', 'area_id', '归属区域', 'nvarchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '0', '0', '=', 'areaselect', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('3d9c32865bb44e85af73381df0ffbf3d', '43d6d5acffa14c258340ce6765e46c6f', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '11', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('416c76d2019b4f76a96d8dc3a8faf84c', 'f6e4dafaa72f4c509636484715f33a96', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('46e6d8283270493687085d29efdecb05', 'f6e4dafaa72f4c509636484715f33a96', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '11', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('4a0a1fff86ca46519477d66b82e01991', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('4c8ef12cb6924b9ba44048ba9913150b', '43d6d5acffa14c258340ce6765e46c6f', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('53d65a3d306d4fac9e561db9d3c66912', '6e05c389f3c6415ea34e55e9dfb28934', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('56fa71c0bd7e4132931874e548dc9ba5', '6e05c389f3c6415ea34e55e9dfb28934', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('5a4a1933c9c844fdba99de043dc8205e', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '10', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('5e5c69bd3eaa4dcc9743f361f3771c08', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('633f5a49ec974c099158e7b3e6bfa930', 'f6e4dafaa72f4c509636484715f33a96', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '0', '1', '1', '1', '1', 'like', 'input', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('652491500f2641ffa7caf95a93e64d34', '6e05c389f3c6415ea34e55e9dfb28934', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('6763ff6dc7cd4c668e76cf9b697d3ff6', 'f6e4dafaa72f4c509636484715f33a96', 'sort', '排序', 'number(10)', 'Integer', 'sort', '0', '0', '1', '1', '1', '0', '=', 'input', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('67d0331f809a48ee825602659f0778e8', '43d6d5acffa14c258340ce6765e46c6f', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('68345713bef3445c906f70e68f55de38', '6e05c389f3c6415ea34e55e9dfb28934', 'test_data_main_id', '业务主表', 'varchar2(64)', 'String', 'testDataMain.id', '0', '1', '1', '1', '0', '0', '=', 'input', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('71ea4bc10d274911b405f3165fc1bb1a', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'area_id', '归属区域', 'nvarchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '1', '1', '=', 'areaselect', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('7f871058d94c4d9a89084be7c9ce806d', '6e05c389f3c6415ea34e55e9dfb28934', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('8b48774cfe184913b8b5eb17639cf12d', '43d6d5acffa14c258340ce6765e46c6f', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('8b7cf0525519474ebe1de9e587eb7067', '6e05c389f3c6415ea34e55e9dfb28934', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('8b9de88df53e485d8ef461c4b1824bc1', '43d6d5acffa14c258340ce6765e46c6f', 'user_id', '归属用户', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('8da38dbe5fe54e9bb1f9682c27fbf403', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '12', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('92481c16a0b94b0e8bba16c3c54eb1e4', 'f6e4dafaa72f4c509636484715f33a96', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('9a012c1d2f934dbf996679adb7cc827a', 'f6e4dafaa72f4c509636484715f33a96', 'parent_id', '父级编号', 'varchar2(64)', 'This', 'parent.id|name', '0', '0', '1', '1', '0', '0', '=', 'treeselect', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('ad3bf0d4b44b4528a5211a66af88f322', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'office_id', '归属部门', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '1', '1', '=', 'officeselect', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('bb1256a8d1b741f6936d8fed06f45eed', 'f6e4dafaa72f4c509636484715f33a96', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('ca68a2d403f0449cbaa1d54198c6f350', '43d6d5acffa14c258340ce6765e46c6f', 'office_id', '归属部门', 'varchar2(64)', 'com.thinkgem.jeesite.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '0', '0', '=', 'officeselect', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('cb9c0ec3da26432d9cbac05ede0fd1d0', '43d6d5acffa14c258340ce6765e46c6f', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '12', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('cfcfa06ea61749c9b4c4dbc507e0e580', 'f6e4dafaa72f4c509636484715f33a96', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('d5c2d932ae904aa8a9f9ef34cd36fb0b', '43d6d5acffa14c258340ce6765e46c6f', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '0', '1', '=', 'select', 'sex', null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('e64050a2ebf041faa16f12dda5dcf784', '6e05c389f3c6415ea34e55e9dfb28934', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('e8d11127952d4aa288bb3901fc83127f', '43d6d5acffa14c258340ce6765e46c6f', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '13', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('eb2e5afd13f147a990d30e68e7f64e12', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '11', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
INSERT INTO `gen_table_column` VALUES ('f5ed8c82bad0413fbfcccefa95931358', 'f6e4dafaa72f4c509636484715f33a96', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '10', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');

-- ----------------------------
-- Table structure for oa_notify
-- ----------------------------
DROP TABLE IF EXISTS `oa_notify`;
CREATE TABLE `oa_notify` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT NULL COMMENT '类型',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) DEFAULT NULL COMMENT '附件',
  `status` char(1) DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知通告';

-- ----------------------------
-- Records of oa_notify
-- ----------------------------
INSERT INTO `oa_notify` VALUES ('54f50aeb930147828fee4195d5f9935b', '3', '2222222', '22333333333333', '', '0', '1', '2017-08-09 11:14:56', '1', '2017-08-09 11:14:56', null, '1');
INSERT INTO `oa_notify` VALUES ('fc40130b11b143c6b58c33b30fc85db2', '1', '项目组总结大会', '晚上8点', '', '1', '1', '2017-08-08 17:01:23', '1', '2017-08-09 10:05:19', null, '0');

-- ----------------------------
-- Table structure for oa_notify_record
-- ----------------------------
DROP TABLE IF EXISTS `oa_notify_record`;
CREATE TABLE `oa_notify_record` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `oa_notify_id` varchar(64) DEFAULT NULL COMMENT '通知通告ID',
  `user_id` varchar(64) DEFAULT NULL COMMENT '接受人',
  `read_flag` char(1) DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`oa_notify_id`),
  KEY `oa_notify_record_user_id` (`user_id`),
  KEY `oa_notify_record_read_flag` (`read_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知通告发送记录';

-- ----------------------------
-- Records of oa_notify_record
-- ----------------------------
INSERT INTO `oa_notify_record` VALUES ('01179c5c9c904f299e23bc25ba55c592', '54f50aeb930147828fee4195d5f9935b', '9', '0', null);
INSERT INTO `oa_notify_record` VALUES ('05443fa57ae841f897537a4ee4004d56', 'fc40130b11b143c6b58c33b30fc85db2', '12', '0', null);
INSERT INTO `oa_notify_record` VALUES ('185f2f79d862464a99f48d67ed3f4d68', 'fc40130b11b143c6b58c33b30fc85db2', '3', '0', null);
INSERT INTO `oa_notify_record` VALUES ('1acf278b05714cd4ba0ef6286ddefe86', 'fc40130b11b143c6b58c33b30fc85db2', '10', '0', null);
INSERT INTO `oa_notify_record` VALUES ('31238d49f39e4cd7a4d449c0e3fd75bb', 'fc40130b11b143c6b58c33b30fc85db2', '9', '0', null);
INSERT INTO `oa_notify_record` VALUES ('3aa688d656d341918704edd263fbe9c0', 'fc40130b11b143c6b58c33b30fc85db2', '13', '0', null);
INSERT INTO `oa_notify_record` VALUES ('4794d56679d642a1a01448f3ef19f109', 'fc40130b11b143c6b58c33b30fc85db2', '6', '0', null);
INSERT INTO `oa_notify_record` VALUES ('590787de7e5748e29f32ba1a77318c62', '54f50aeb930147828fee4195d5f9935b', '8', '0', null);
INSERT INTO `oa_notify_record` VALUES ('5f9aff764ba54cc7871d1e6aaa9bfbde', '54f50aeb930147828fee4195d5f9935b', '13', '0', null);
INSERT INTO `oa_notify_record` VALUES ('6101ec0af9274621a1b69c933d6286c3', '54f50aeb930147828fee4195d5f9935b', '7', '0', null);
INSERT INTO `oa_notify_record` VALUES ('63593e96879443d897d34d630313a77f', 'fc40130b11b143c6b58c33b30fc85db2', '5', '0', null);
INSERT INTO `oa_notify_record` VALUES ('6393776c19d5436ba992cdc98c1807e0', '54f50aeb930147828fee4195d5f9935b', '2', '0', null);
INSERT INTO `oa_notify_record` VALUES ('64983d04895f4124937d8412a57d384a', 'fc40130b11b143c6b58c33b30fc85db2', '8', '0', null);
INSERT INTO `oa_notify_record` VALUES ('69248153d6e448b69ba55a749338eff4', '54f50aeb930147828fee4195d5f9935b', '12', '0', null);
INSERT INTO `oa_notify_record` VALUES ('6944db5beb4b468c8509eaa6a1297313', 'fc40130b11b143c6b58c33b30fc85db2', '2', '0', null);
INSERT INTO `oa_notify_record` VALUES ('6e6674df6a4843b2812a77a01b5958df', 'fc40130b11b143c6b58c33b30fc85db2', '4', '0', null);
INSERT INTO `oa_notify_record` VALUES ('76d06dac004a4528aadfc1386131eeaf', '54f50aeb930147828fee4195d5f9935b', '1', '0', null);
INSERT INTO `oa_notify_record` VALUES ('88927c5de91445c1b18a29f7505fd811', '54f50aeb930147828fee4195d5f9935b', '6', '0', null);
INSERT INTO `oa_notify_record` VALUES ('a9a3fea755d44a6c98a3a250b8eb7abb', '54f50aeb930147828fee4195d5f9935b', '4', '0', null);
INSERT INTO `oa_notify_record` VALUES ('b67ddf69f85540fdbaa090a4ea176ca4', '54f50aeb930147828fee4195d5f9935b', '11', '0', null);
INSERT INTO `oa_notify_record` VALUES ('c3862beeab514fe1886354a8805c4b8c', '54f50aeb930147828fee4195d5f9935b', '10', '0', null);
INSERT INTO `oa_notify_record` VALUES ('cd1274eb8525411089266d625f365b4f', 'fc40130b11b143c6b58c33b30fc85db2', '1', '0', null);
INSERT INTO `oa_notify_record` VALUES ('cfd1c28dbdbb46d0872e4caaba2590f7', 'fc40130b11b143c6b58c33b30fc85db2', '7', '0', null);
INSERT INTO `oa_notify_record` VALUES ('dd7ee83cf75e4214ab3561f40d252b13', 'fc40130b11b143c6b58c33b30fc85db2', '11', '0', null);
INSERT INTO `oa_notify_record` VALUES ('e6ade87bc7c743a4bc39a161e79107b7', '54f50aeb930147828fee4195d5f9935b', '5', '0', null);
INSERT INTO `oa_notify_record` VALUES ('f8350b6c70d94121aac9d4d606a09731', '54f50aeb930147828fee4195d5f9935b', '3', '0', null);

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `type` char(1) DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES ('1', '0', '0,', '中国', '10', '100000', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('2', '1', '0,1,', '山东省', '20', '110000', '2', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('3', '2', '0,1,2,', '济南市', '30', '110101', '3', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('4', '3', '0,1,2,3,', '历城区', '40', '110102', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('5', '3', '0,1,2,3,', '历下区', '50', '110104', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('6', '3', '0,1,2,3,', '高新区', '60', '110105', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '0', '正常', 'del_flag', '删除标记', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('10', 'yellow', '黄色', 'color', '颜色值', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('105', '1', '会议通告\0\0\0\0', 'oa_notify_type', '通知通告类型', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('106', '2', '奖惩通告\0\0\0\0', 'oa_notify_type', '通知通告类型', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('107', '3', '活动通告\0\0\0\0', 'oa_notify_type', '通知通告类型', '30', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('108', '0', '草稿', 'oa_notify_status', '通知通告状态', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('109', '1', '发布', 'oa_notify_status', '通知通告状态', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('11', 'orange', '橙色', 'color', '颜色值', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('110', '0', '未读', 'oa_notify_read', '通知通告状态', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('111', '1', '已读', 'oa_notify_read', '通知通告状态', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('12', 'default', '默认主题', 'theme', '主题方案', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('13', 'cerulean', '天蓝主题', 'theme', '主题方案', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('14', 'readable', '橙色主题', 'theme', '主题方案', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('15', 'united', '红色主题', 'theme', '主题方案', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('16', 'flat', 'Flat主题', 'theme', '主题方案', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('17', '1', '国家', 'sys_area_type', '区域类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('18', '2', '省份、直辖市', 'sys_area_type', '区域类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('19', '3', '地市', 'sys_area_type', '区域类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('2', '1', '删除', 'del_flag', '删除标记', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('20', '4', '区县', 'sys_area_type', '区域类型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('21', '1', '公司', 'sys_office_type', '机构类型', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('22', '2', '部门', 'sys_office_type', '机构类型', '70', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('23', '3', '小组', 'sys_office_type', '机构类型', '80', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('24', '4', '其它', 'sys_office_type', '机构类型', '90', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('25', '1', '综合部', 'sys_office_common', '快捷通用部门', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('26', '2', '开发部', 'sys_office_common', '快捷通用部门', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('27', '3', '人力部', 'sys_office_common', '快捷通用部门', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('28', '1', '一级', 'sys_office_grade', '机构等级', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('29', '2', '二级', 'sys_office_grade', '机构等级', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('3', '1', '显示', 'show_hide', '显示/隐藏', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('30', '3', '三级', 'sys_office_grade', '机构等级', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('31', '4', '四级', 'sys_office_grade', '机构等级', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('32', '1', '所有数据', 'sys_data_scope', '数据范围', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('33', '2', '所在公司及以下数据', 'sys_data_scope', '数据范围', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('34', '3', '所在公司数据', 'sys_data_scope', '数据范围', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('35', '4', '所在部门及以下数据', 'sys_data_scope', '数据范围', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('36', '5', '所在部门数据', 'sys_data_scope', '数据范围', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('37', '8', '仅本人数据', 'sys_data_scope', '数据范围', '90', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('38', '9', '按明细设置', 'sys_data_scope', '数据范围', '100', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('39', '1', '系统管理', 'sys_user_type', '用户类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('4', '0', '隐藏', 'show_hide', '显示/隐藏', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('40', '2', '部门经理', 'sys_user_type', '用户类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('41', '3', '普通用户', 'sys_user_type', '用户类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('5', '1', '是', 'yes_no', '是/否', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('6', '0', '否', 'yes_no', '是/否', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('67', '1', '接入日志', 'sys_log_type', '日志类型', '30', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('68', '2', '异常日志', 'sys_log_type', '日志类型', '40', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('7', 'red', '红色', 'color', '颜色值', '10', '0', '1', '2013-05-27 08:00:00', '1', '2017-07-20 14:41:12', '备注', '0');
INSERT INTO `sys_dict` VALUES ('8', 'green', '绿色', 'color', '颜色值', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('9', 'blue', '蓝色', 'color', '颜色值', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('96', '1', '男', 'sex', '性别', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('97', '2', '女', 'sex', '性别', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('0013b230e4f34181a5f4773ceae18473', '1', '系统登录', '1', '2017-07-20 17:36:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('0015aaf3b70b4cfdb7016dc5fc30bdb3', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:03:36', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('00271bf8d9aa4b38b7f135078dd3354c', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:33:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('025719a0474446d1a4d1996da3858607', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:51:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('035ecafabe5a4617a3f13519d81e9735', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-14 08:57:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/save', 'POST', 'id=&menuIds=&dataScope=8&useable=1&office.name=公司领导&name=111111&officeIds=&remarks=&office.id=2&oldName=&sysData=1', '');
INSERT INTO `sys_log` VALUES ('039134edda8f4db9b829976534b4bc5a', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 11:30:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/form', 'GET', 'id=1', '');
INSERT INTO `sys_log` VALUES ('04134def1d2b45b5bd3a72c87777b98a', '1', '系统设置-机构用户-区域管理', '1', '2017-06-13 11:41:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/area/', 'GET', 'tabPageId=jerichotabiframe_6', '');
INSERT INTO `sys_log` VALUES ('04e6cef5aa744767a056957b251628a2', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:48:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('05948c31811c4bf2ab0cc7e4dcd1bc52', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 10:08:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('064b61e8ea914cd2ba5e82ec930cc0c8', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:48:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0729d32f9f43410dbec96c433add5e01', '1', '系统登录', '1', '2017-07-24 17:31:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('074e31b9947c424897a9b00b5049c518', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 16:51:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('075457dab5624c8890bd569d83f2f9d8', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 14:41:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/save', 'POST', 'id=7&sort=10&description=颜色值&value=red&label=红色&remarks=备注&type=color', '');
INSERT INTO `sys_log` VALUES ('076ab4de42df49f5a443be97f2cb974b', '1', '系统登录', '1', '2017-07-24 11:00:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('0812ef7a0bf64c968b765af1867edf04', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 09:34:09', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('088404ad00874a56bddc181f42fb24c6', '1', '系统登录', '1', '2017-05-03 09:24:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('08f2c80aee05400dba306b1b10528294', '1', '系统登录', '1', '2017-06-14 08:44:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('09be892c228b415896845d3c4a2145dd', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-05-03 09:25:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0a8b7f2c282641cf8623db8543f222ad', '1', '系统登录', '1', '2017-07-24 17:27:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('0a9d62b2af744ddaaacaaa5a942ff932', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:08:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0abf661839fa497fbe5214b491dbbc59', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 15:29:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('0b27c6b6bc3348fca4752159ae9162f8', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:46:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('0b3fa9c280a640c485e0b3623051a595', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 13:58:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0b6f16705fb747edaf70fd9d888376e6', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 09:27:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0ccc082f2f444b5ea29e6fda54fc9bab', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 15:09:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('0d224839dd514d70b376ebc7c3bfb83b', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:06:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/export', 'POST', 'orderBy=&pageNo=1&office.name=&company.id=&name=&pageSize=30&office.id=&company.name=&loginName=', '');
INSERT INTO `sys_log` VALUES ('0e16c3b6e9e04de89b294475810612a6', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:06:53', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0e4d3f2d94f54d3c99a6117ae6f4d31e', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 11:15:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('0e63bd85bc094b71b10b1e3d20ebba91', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 17:01:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0e7feb081fd94c75b5c88718880155c9', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-05-03 09:25:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('0ecbe6ec31ed4cc99e16a0771adf9e29', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:59:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('0f0b6e6f806146eba45e00f8072a56ec', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:45:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'type=color&description=颜色值&sort=20', '');
INSERT INTO `sys_log` VALUES ('0fa69e8032c1406eaeccc91950bc637a', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 09:56:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('1064984e10404aed988dbed0e02cd53a', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:37:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=30&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('112fdf2221c1483292ec5c82ea13fa9b', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 09:06:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('1188e4a29c3048c59f7f7b111b5654c9', '1', '系统设置-机构用户-用户管理', '1', '2017-05-03 09:25:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('12eee16cc1554bcf9fcfb9c6f1e0c04e', '1', '系统设置-系统设置-菜单管理-查看', '1', '2017-06-14 09:03:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/menu/form', 'GET', 'id=27', '');
INSERT INTO `sys_log` VALUES ('134cca40dabc4ceaa3c25e73fbbf9bf3', '1', '系统登录', '1', '2017-07-24 17:03:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('14d2aab1f99d425687b13f256133e185', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:59:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('152cb5ef3cfa486e924f3d5cd9d329f7', '2', '系统设置-机构用户-用户管理-查看', '1', '2017-07-13 16:51:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', 'org.springframework.web.util.NestedServletException: Handler processing failed; nested exception is java.lang.Error: Unresolved compilation problems: \n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n\r\n	at org.springframework.web.servlet.DispatcherServlet.triggerAfterCompletionWithError(DispatcherServlet.java:1302)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:977)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:965)\r\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:856)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:707)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:841)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:820)\r\n	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:652)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1317)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.obtainContent(SiteMeshFilter.java:129)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.doFilter(SiteMeshFilter.java:77)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1288)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter$1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:383)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:344)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:261)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1288)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1288)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:443)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:137)\r\n	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:556)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:227)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1044)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:372)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:189)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:978)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:135)\r\n	at org.eclipse.jetty.server.handler.ContextHandlerCollection.handle(ContextHandlerCollection.java:255)\r\n	at org.eclipse.jetty.server.handler.HandlerCollection.handle(HandlerCollection.java:154)\r\n	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:116)\r\n	at org.eclipse.jetty.server.Server.handle(Server.java:369)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.handleRequest(AbstractHttpConnection.java:486)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.headerComplete(AbstractHttpConnection.java:933)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection$RequestHandler.headerComplete(AbstractHttpConnection.java:995)\r\n	at org.eclipse.jetty.http.HttpParser.parseNext(HttpParser.java:644)\r\n	at org.eclipse.jetty.http.HttpParser.parseAvailable(HttpParser.java:235)\r\n	at org.eclipse.jetty.server.AsyncHttpConnection.handle(AsyncHttpConnection.java:82)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint.handle(SelectChannelEndPoint.java:667)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint$1.run(SelectChannelEndPoint.java:52)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:608)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool$3.run(QueuedThreadPool.java:543)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: java.lang.Error: Unresolved compilation problems: \n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n\r\n	at com.thinkgem.jeesite.common.service.BaseService.dataScopeFilter(BaseService.java:55)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService.findUser(SystemService.java:87)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$FastClassBySpringCGLIB$$4ff9ba04.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:718)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$EnhancerBySpringCGLIB$$f23f20ec.findUser(<generated>)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$FastClassBySpringCGLIB$$4ff9ba04.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:718)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$EnhancerBySpringCGLIB$$c15955e2.findUser(<generated>)\r\n	at com.thinkgem.jeesite.modules.sys.web.UserController.list(UserController.java:71)\r\n	at com.thinkgem.jeesite.modules.sys.web.UserController$$FastClassBySpringCGLIB$$25977f0a.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:718)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.apache.shiro.spring.security.interceptor.AopAllianceAnnotationsAuthorizingMethodInterceptor$1.proceed(AopAllianceAnnotationsAuthorizingMethodInterceptor.java:82)\r\n	at org.apache.shiro.authz.aop.AuthorizingMethodInterceptor.invoke(AuthorizingMethodInterceptor.java:39)\r\n	at org.apache.shiro.spring.security.interceptor.AopAllianceAnnotationsAuthorizingMethodInterceptor.invoke(AopAllianceAnnotationsAuthorizingMethodInterceptor.java:115)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\r\n	at com.thinkgem.jeesite.modules.sys.web.UserController$$EnhancerBySpringCGLIB$$4ac4748c.list(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:606)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:222)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:137)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:110)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:775)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:705)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:959)\r\n	... 53 more\r\n');
INSERT INTO `sys_log` VALUES ('16138d898373487fac610fdd1443b8f1', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:55:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('166ef6d0c0cc4ed1ba67e551312d898b', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 17:56:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('16d6bda1e3034f159d54290c3e20ceb8', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 11:32:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('16ddee49cbea4fd4bf26e7067ae5836b', '1', '系统设置-机构用户-用户管理', '1', '2017-06-14 11:15:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('17a95828713449818bf658faa1dcc04b', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:41:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('18112657681c49b6b685db7ac63fb967', '1', '系统登录', '1', '2017-08-08 09:13:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('18aeaacd82df44d5853dbcc8a3ab87d9', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 16:53:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('19033bb0ca1e4b8c9f3a581260733ca0', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 14:47:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('1af6437548ba4113a37f8d7e4f5ffdfe', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 15:10:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/save', 'POST', 'id=6&menuIds=1,27,28,29,30,71,56,57,58,59,62,88,89,90,2,13,20,21,22,17,18,19,14,15,16,3,4,5,6,7,8,9,10,11,12,6...&dataScope=8&useable=1&office.name=公司领导&name=普通用户&officeIds=&remarks=&office.id=2&oldName=普通用户&sysData=1', '');
INSERT INTO `sys_log` VALUES ('1b38f7cd81bc4d76a7cacddc571bea3a', '1', '我的面板-个人信息-个人信息', '1', '2017-06-14 09:19:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('1c880e8fbff647ba907569db32d1a223', '1', '系统登录', '1', '2017-07-25 20:14:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('1cdc3dbf1b2b4fb5bc215ed54891c415', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:47:43', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('1f06d32c786c45adae4c12c915cb37ec', '1', '系统登录', '1', '2017-08-08 11:00:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('1f198636966a42598cf913577050beab', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:37:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('1fa1558fa156478a991458500f563416', '1', '我的面板-个人信息-个人信息', '7', '2017-06-13 16:53:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2083c57c9fa943d1830420a856a4b855', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=17&parentIds=0,1,7,17,', '');
INSERT INTO `sys_log` VALUES ('21293088a32846d89e0139c404c90b68', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:36:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('22549c31da724732aae16a7c9ffb218a', '1', '系统设置-系统设置-菜单管理', '1', '2017-06-14 09:03:03', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/menu/', 'GET', 'tabPageId=jerichotabiframe_3', '');
INSERT INTO `sys_log` VALUES ('22691a268ac6413b82dee2dd915eac3a', '1', '我的面板-个人信息-个人信息', '7', '2017-06-13 17:13:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('22f230de885643b993818b256c992acd', '1', '系统登录', '1', '2017-07-24 16:18:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('232421adfe964e9a9b2b1dec7c2b3026', '1', '系统登录', '1', '2017-07-20 14:40:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('23a9dde36fa44b8686ab4bc181273e81', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 15:11:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/save', 'POST', 'id=6&menuIds=1,27,28,29,30,71,56,57,58,59,62,88,89,90,2,13,20,21,22,17,18,19,14,15,16,3,4,5,6,7,8,9,10,11,12,6...&dataScope=8&useable=1&office.name=公司领导&name=普通用户&officeIds=&remarks=&office.id=2&oldName=普通用户&sysData=1', '');
INSERT INTO `sys_log` VALUES ('24b75a8ded714901bb40eab2833aa739', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 15:09:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assignrole', 'POST', 'id=6&idsArr=13', '');
INSERT INTO `sys_log` VALUES ('24bfb411bc8a4f88a5003204b7b7f56b', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:54:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('24cff2cbc4004aa89321a00e909a1afd', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 13:48:20', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2582ef86cd43463db5adae55d3870567', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:12:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'POST', 'orderBy=&pageNo=1&office.name=&company.id=&name=&pageSize=30&office.id=&company.name=&loginName=', '');
INSERT INTO `sys_log` VALUES ('2592d997d46b4cb7b02ca4a8c22c2f61', '1', '我的面板-个人信息-个人信息', '1', '2017-05-03 09:24:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('260bb6b9f5de4872a8cb74eeac4f1413', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 10:02:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('26d780184e3845299b47ce0b33060945', '1', '系统设置-机构用户-用户管理', '7', '2017-06-13 18:09:00', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('26f16f0793b44153a01013c8511ebf36', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 16:50:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('26fdbaf566154b20b0fa3b0aae4f4476', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 11:15:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('27278c57db4f4f0aa4b091c1e4786c2a', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:40:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('27fa631c638a4ab88de30ad9b4476fb3', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 14:10:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('294b01a39aa746c4a6e062ad736e56db', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 11:31:09', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_4', '');
INSERT INTO `sys_log` VALUES ('29a0494e6ccf42339aae4a4f7c05ab57', '1', '系统登录', '1', '2017-08-08 14:34:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('29d2d89aec6f44a998fcd3518d0d7551', '1', '系统登录', '1', '2017-07-24 16:07:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('29ef26b9bfc34a99999d18035c0ec350', '1', '系统登录', '1', '2017-08-08 15:02:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('2a0ff99782664722965b9498b3f7c223', '1', '系统登录', '1', '2017-07-25 14:03:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('2a399e19d821404089c72cf0f57373e8', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 13:58:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2b1506d2c7e54d1a9dc0d909d4df4b69', '1', '系统设置-机构用户-机构管理', '1', '2017-06-13 15:12:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('2b3259a164de437b936d1797f7bed4bb', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 16:54:55', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2b52d8c2e08043d2bc3fefec0c09c189', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('2ba95ff3f14440a09f78f7b7a5cfc463', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:08:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('2c1644a6b8e2430e9111385a9a1757e8', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:59:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('2c39f3eba6dc421c8122df08771051fe', '1', '我的面板-个人信息-个人信息', '1', '2017-05-03 09:41:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2cf1752316b943bf827c978be7a330dc', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 11:15:34', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('2d24108e25d24a658ae548afb7af6e95', '1', '代码生成-生成示例-单表', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testData', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2dce03230cd74c8cb096f326b3759537', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:54:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('2e40183a9a2a446c9b1abad7a7bfb7ff', '1', '系统登录', '1', '2017-07-24 17:49:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('314b197eda6e4601ae2f7ec2745288eb', '1', '系统登录', '2', '2017-08-09 09:42:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge/15.15063', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('316154bf9aa14f64b684a068f640747b', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:59:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('3193f6f2658346a8a365575751432faf', '1', '代码生成-代码生成-业务表配置', '1', '2017-05-03 09:27:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/gen/genTable', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('328ec1c4abff4c0383a58d0d369dae39', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:55:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('32bb680ec02e4d369dd6c15396cc60a7', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 15:29:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('32deaa1820004b3885a678b9da3faa24', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 10:02:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('32eeaa9998da4f949b1cf975811da077', '1', '系统设置-系统设置-角色管理', '1', '2017-06-14 08:44:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('332627b6d89247b1875b260138f19c41', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 13:58:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('332bc26d6b014ef8b44aa181b8ad70c9', '1', '系统登录', '7', '2017-06-13 15:14:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('33bc8ffaa84941a0a19173b067fafd46', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 11:30:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('33e11ab2897b46a4bb4a31558c63b638', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 15:28:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('343fadadbab44ce89d99c3d25a46ec8b', '1', '系统登录', '1', '2017-08-09 09:32:51', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('34bc5a1f5c0446c884b918bb0c6b927c', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:44:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('353b41619e3c4ae89a85f4badded393a', '1', '系统设置-日志查询-日志查询', '1', '2017-05-03 09:26:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('363fc5c523ca4d8aa0bd241b05059256', '1', '系统登录', '7', '2017-06-13 16:54:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('37b6fab02f8e4b9d8e8768f97a9eac7c', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 15:09:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=6', '');
INSERT INTO `sys_log` VALUES ('37c58a13aa61457ea617a8f259f94ab2', '1', '系统登录', '7', '2017-06-13 17:13:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('3827f6615e664cb9bb12c60b6dc2d6bc', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 15:28:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('38a47c3d40864ec3a53146636e4dacfb', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:12:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=17&parentIds=0,1,7,17,', '');
INSERT INTO `sys_log` VALUES ('393c3ccfeb9d4a9f844c1675f91824df', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:58:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('395525831ab04f76b9e18122dffcd09d', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 16:12:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('3986d054f6474a9e90303d862427ab3b', '1', '系统设置-日志查询-日志查询', '1', '2017-05-03 09:26:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('39b96309e465419f9e853e4ee1d4d9ed', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 14:10:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('39d2c6773a33462596a3fbee546b187c', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 09:15:20', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '22222222222222222222');
INSERT INTO `sys_log` VALUES ('3a3fb6d9b98b436dbb173182aa6f9c70', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 14:48:20', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/delete', 'POST', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d', '');
INSERT INTO `sys_log` VALUES ('3ab05fcd0a3842d08cbb14291d646cb0', '1', '代码生成-生成示例-单表', '1', '2017-05-03 09:27:03', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/test/testData', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('3bbb44e039ee499b8a1a8c442978f0a5', '1', '系统登录', '1', '2017-08-08 10:08:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('3d346201036547f0ad3c8a553f1b8101', '1', '系统设置-系统设置-角色管理', '1', '2017-06-14 08:57:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('3d34d2a74a4640648880d20c71518a18', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 10:54:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('3e1719489d0b44bf9dc2c3209f158754', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:02:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('3e1ab8721b9d42a4b2fe37d03800cc8f', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:34:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('3e811b75a70940ada9b28af93f075fb0', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:54:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('3efafe1f633e415d85ba1e6d9b6ff442', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:55:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('3f053dbd003444e9beb65edd5e347f45', '1', '系统登录', '1', '2017-06-28 10:31:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('3fc28545327040f7bc99dee1ca5273cb', '1', '系统登录', '1', '2017-08-09 08:44:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('3fc3a538219049d9a54e57d119f41351', '1', '系统设置-机构用户-用户管理', '7', '2017-06-13 17:13:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('40f48c5a363b43378f0672e44eb99fc2', '1', '系统登录', '1', '2017-07-20 10:34:00', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('411cfc022f7d4c67b95575d45fbf8dec', '1', '系统登录', '1', '2017-07-18 10:53:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('41977e1c69bc42a59abc16dfcc741101', '1', '系统登录', '1', '2017-06-13 16:12:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4233664e2edd4b228a8f057a13f9eedd', '1', '系统登录', '1', '2017-08-08 16:24:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('426a94fa04b442f99dad8cbe899f87ef', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:38:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('43c2d5c0531b4c538464143e318d3cb0', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 09:15:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('440773b8b9b44c3db256c730ba2d65f4', '1', '代码生成-生成示例-树结构', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testTree', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4445f53b8fe444488db1d0405ea74005', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:45:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'type=color&description=颜色值&sort=20', '');
INSERT INTO `sys_log` VALUES ('449de4d3b57a49b780aeb24b70a5edab', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 16:23:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('456de7d75bf34129851326328dd7fb7f', '1', '系统登录', '1', '2017-06-13 15:12:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('45c81f85cb0d4b0088c4340bbb17d2ad', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4683c887cece4eadbbfb379581c6432b', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 15:30:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/delete', 'POST', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d', '');
INSERT INTO `sys_log` VALUES ('47364066209a42ec9a79afbb4770cf0b', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 10:34:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4788c3eda63949b183bc7502ad7dd319', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 16:13:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('47916d2c27bc4fdab027221e119d9054', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 14:59:23', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/save', 'POST', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d&sort=20&description=颜色值&value=white&label=白色&remarks=白色&type=color', '');
INSERT INTO `sys_log` VALUES ('47bacd7488414d44851e4ba4ab4ca71b', '1', '系统登录', '1', '2017-07-26 16:20:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('47c62bff522d46acafdbe3faeeeb6764', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:59:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('47d1c75419414d32bcc8d355cc24d7eb', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 15:15:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('48a631954d074cac886e62c6ca3711c8', '1', '代码生成-生成示例-单表-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testData/data', 'GET', 'limit=10&area.id=&office.id=&beginInDate=&area.name=&endInDate=&order=asc&user.name=&office.name=&user.id=&name=&offset=0', '');
INSERT INTO `sys_log` VALUES ('48e8134233f84377984edfc41dd698d9', '1', '我的面板-个人信息-个人信息', '7', '2017-06-13 15:14:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('48fa70b509bf488bac1a019821863c11', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:59:23', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('4a5a71c1585b4b28a0532b9227b282df', '1', '系统登录', '1', '2017-07-24 15:37:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4abf0fd169c8440386cac0f2f1bc5d71', '1', '系统设置-机构用户-用户管理', '7', '2017-06-13 16:53:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4af5f1de0ffd423c8342a2b7a70daaeb', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:12:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4b5561b1cde241feaa3c8c233754335d', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:12:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'office.id=23&office.name=公司领导', '');
INSERT INTO `sys_log` VALUES ('4bbab85e1ee248eea62f7ee054bf9f3a', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 11:31:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4bf59febac724ea5bd22bd43ab507635', '1', '系统设置-机构用户-用户管理', '1', '2017-07-18 10:54:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4c55404ebc224292a01ac85b94493c71', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 09:59:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4ccc38d67e924ea69de95d9fda2e60f1', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=17&parentIds=0,1,7,17,', '');
INSERT INTO `sys_log` VALUES ('4cfa658e177e49818c8c7f5fcb0960e1', '1', '系统登录', '1', '2017-07-25 13:45:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4db26af2ab874a4ea8bbed96b35847ec', '1', '代码生成-生成示例-单表', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testData', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4debb183978b4861b9055deea257f0e4', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 11:30:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('4e1b74a0bdef4625943b665d762d6eaa', '1', '系统登录', '1', '2017-07-24 17:25:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4e2c4ba87aa5478c9c128739e25cb740', '1', '系统登录', '1', '2017-06-13 15:10:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4e86a98397cf4e99bb69a8f7cf1aa8d8', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:02:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4ee1cce3d6c84b26b168b9781864d5a9', '1', '系统登录', '1', '2017-07-20 09:27:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('4f3ff3d9ed86446dbe9fa30acd13049b', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 14:40:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('4f5f87ca1b264dc3b7e86df827b42f37', '2', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 11:20:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '111111111111111');
INSERT INTO `sys_log` VALUES ('4f63e86b33e443078b55e0bbb5d57fda', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:04:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('53374ab1b17d4c129fab0b5f9792391a', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:11:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('533ad09444ed47d1acd98ec8ed02c297', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:41:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('544215b5e872481cbce78b8d56ec38f7', '1', '我的面板-个人信息-个人信息', '1', '2017-06-14 08:44:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('54767ca6197446d08f9bcf924d33d391', '1', '系统登录', '1', '2017-07-25 20:12:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('549c4e83f79f4253aeebe7ab45c9c9a7', '1', '系统设置-机构用户-机构管理-查看', '7', '2017-06-13 18:02:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('54ccd1aae9b94b8ba61765f23c1e194b', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:51:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('54ec4b1e187440c6b2b20186e1278607', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:10:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('54f2d976288644c48df6e1d3938a4691', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:25:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('551c94c938fc491f9cdb3717c563f542', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:40:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('55221509a0204141a905d4d9f78b42f4', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:59:23', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('552e5d10c94541cba768412bdae40d27', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 17:14:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('55509b2070b84643a5c0a6dfc4e9f10a', '1', '系统登录', '1', '2017-07-20 17:08:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('5634b2c1907b47e9acf958ef4e3698a8', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:46:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'type=color&description=颜色值&sort=20', '');
INSERT INTO `sys_log` VALUES ('56d1ba3bb47946c8b604c8401498d506', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 17:01:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('57292b5d231f46b3a492e54cb23c842a', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:01:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('58737523bc3c41218abe022dcb49a006', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 16:59:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('58aa32eb44844f39a4026938db276ef9', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:58:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('598697d9799648859de6549b83e6679b', '1', '系统设置-机构用户-用户管理', '1', '2017-05-03 09:39:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('59c7487aad5546d2a4379e344fe45463', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=7&parentIds=0,1,7,', '');
INSERT INTO `sys_log` VALUES ('5ac09f8e71094518b84a5b2934fe128e', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:56:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('5ace241e077044c99b8e61499751a8bf', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 13:58:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('5b3afd5d24694830830f65c6209f7dc7', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 13:58:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('5b4927797dd249bdaad44ee8bec3aa65', '1', '系统设置-机构用户-区域管理', '1', '2017-05-03 09:25:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/area/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('5b6c4208f00d4e7695ffa4d1a8ef5b03', '1', '系统设置-机构用户-用户管理', '1', '2017-06-14 08:44:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('5cbb657341c347c18e1a615a1580e4c3', '1', '我的面板-个人信息-个人信息', '7', '2017-06-13 16:54:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('5e7f812b59c0456c8af2b4e3fa59759b', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('5f8c35452b1643cbadc174b72663068e', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 13:44:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('602b4310d25347d18bd13728045f979d', '1', '代码生成-生成示例-树结构', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testTree', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('60f066eb2f4444c7a1e583ec37ae92eb', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:09:03', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('6184e09a70db4d80b76464338a8e9866', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:54:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('61a8a539053349d198506915144cc364', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 10:34:09', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('625b8d5d108d4721b00b0c265a7ae4ae', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('6272d458c5d34f87956abe9c937155c4', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 14:10:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'tabPageId=jerichotabiframe_10', '');
INSERT INTO `sys_log` VALUES ('6276c75da7c740e0b4b385e7b4a17429', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 16:34:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('63cf3035be33439b902b9e430e3e31d2', '1', '系统设置-机构用户-用户管理', '7', '2017-06-13 17:23:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('64582b26e4c2492abd1dda55b9dd871c', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 16:53:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('645a29dd21204124b61351c5176c6c1b', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:54:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('648f9683a307476c90ca26c045ba7afe', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 10:08:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('64a9ed5be75e42c29d65c65199dcc24a', '1', '我的面板-个人信息-个人信息', '1', '2017-05-03 09:41:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('64e91875c62f417ab3c09ef8249e41dd', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 16:50:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('661c3c8468884fa69495bac20729393d', '1', '我的面板-个人信息-修改密码', '1', '2017-06-14 11:11:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/modifyPwd', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('665b860e683642feaa077644a5131c4b', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:51:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('66710d8f6048423087f5d3c78877c674', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 15:15:34', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('66db595b61a5478e8312e230b99047f9', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 13:53:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/form', 'GET', 'id=1', '');
INSERT INTO `sys_log` VALUES ('677c05dfe69f4ca38889ad43c21e342c', '1', '系统设置-机构用户-机构管理', '1', '2017-06-13 16:19:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('677f3c102829400686a4271b061d1a34', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:09:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/usertorole', 'POST', 'id=6&___t0.9119391939483792=', '');
INSERT INTO `sys_log` VALUES ('6782c1de384348d7860364efec2deeb2', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:09:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/users', 'GET', 'officeId=26', '');
INSERT INTO `sys_log` VALUES ('6885c64865da4f658e92c181a2ca875b', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 18:21:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('69095ab4686740c987dbcabc52b69e85', '1', '代码生成-生成示例-主子表', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testDataMain', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('69c0912b0fdf458d8efea3975c160de8', '1', '系统设置-系统设置-字典管理', '1', '2017-05-03 09:26:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'POST', 'pageSize=30&type=&pageNo=2&description=', '');
INSERT INTO `sys_log` VALUES ('6a109bc6934e499994e812391884bf26', '1', '系统登录', '1', '2017-07-24 15:26:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a;JSESSIONID=15dabc3d14324a469627744539c656d0', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('6a24ee9c57424dc4bf1358ae7298ad1a', '1', '我的面板-个人信息-个人信息', '1', '2017-07-18 11:06:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('6a4414b60fcc417db62e66c5032dd05d', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 17:54:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/usertorole', 'POST', 'id=7&___t0.514992259728617=', '');
INSERT INTO `sys_log` VALUES ('6b05df6efec244a5bda6f7b0ff94e275', '1', '我的面板-个人信息-个人信息', '1', '2017-05-03 09:27:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('6bc7b650fa6b444ea843186f77600551', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:27:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('6c0d5b689ba44971949c7aea5de6ae98', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:49:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('6cb124a168b944f2bbaba97939137293', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:55:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('6d8cbebeaf2a42b3b6ce771c48735b3c', '1', '系统登录', '13', '2017-06-13 15:11:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('6fbef46857c14e10b3b498ce3e37c515', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('6fe8490e94684b5bad971934aaa8b3bb', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:46:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('700ea2067fb64296844f79776faf14e4', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 09:56:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('706179b23f7d4e1fb7ead95e87ea55d7', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 09:27:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('7107ddf2d4664a2d9f6d547f95d011da', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=17&parentIds=0,1,7,17,', '');
INSERT INTO `sys_log` VALUES ('710f39c7128142ac8fead6979b642c8b', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 16:12:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('730e8afe0ced4c54b7e00d35c386274c', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 11:20:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('731f8103a3044e07853df9aa2c309b1a', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 14:47:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('735f25fa06314735a1bfe834983da1a3', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 15:09:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('73ee515b1c784a99bb114776eb8346d3', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 11:49:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('746a8fc58d8a4eaa9eaaa311c4adab61', '1', '代码生成-生成示例-单表', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testData', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('7493557eedcd48e7a32d1fc6449fbfd3', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=7&parentIds=0,1,7,', '');
INSERT INTO `sys_log` VALUES ('75346022330547e4bccc9fb9858aeb22', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 15:30:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('761e3d9ed2874ef8b56f8afad4804310', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:55:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('768c979ee9ab48cc93d05244f090d76f', '1', '系统登录', '1', '2017-07-20 09:34:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('77a1c602142c4ee8aef54632437ba254', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 15:28:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('77b637edec5b4bec99c1f140c7ca3833', '1', '代码生成-生成示例-主子表-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testDataMain/data', 'GET', 'limit=10&sex=&order=asc&user.name=&user.id=&name=&offset=0', '');
INSERT INTO `sys_log` VALUES ('77b9289486e945a6af609f4ca821a569', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:39:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('77f61e0ec31745e38fc89ba1295af9d6', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:40:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('78065fb038bd4ff2bfc26268be850f94', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 15:11:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=6', '');
INSERT INTO `sys_log` VALUES ('782c4f0a2139469a838a224ce7e61f34', '1', '系统登录', '1', '2017-08-08 14:45:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('78b7a00dc6034890b3299d8a7a5272f0', '1', '系统登录', '1', '2017-08-08 16:19:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('7a47ed7cefa2441c891249489e0d01ab', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:40:03', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('7a833b60804f498aa3e2300f77dd7ece', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 13:59:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('7a897a0d4ae240a49dfbfa493e27f2fc', '1', '系统登录', '1', '2017-07-24 17:34:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('7ac761de481b49dca507c3cf5311cc98', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:13:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('7dce2972f7774070830a3a7deeeac983', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:41:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('7e3c917a8c7b4fe787b0dee797a8bbcf', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 17:55:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('7ef4f9b0129148a3b412c4867bec1c42', '1', '系统登录', '1', '2017-08-08 14:33:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('7ff552ebb6974570a5b137b159689783', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-14 08:44:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('80e0c3e9d41041f3b5cd5022af1f161a', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:34:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('815b131cfafe4b0d9b50f0ee5ea0f548', '1', '系统登录', '1', '2017-07-20 17:46:34', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('824eee5c00d84e418a0889ea32c32f8a', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:13:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('82d6d5b511f24a2e9a6050e9c00142a5', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('843c07dbcd974fe39d53184baf0b73ec', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-14 08:57:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=d5d1f0092ddd469ab0ff1a9c622671d3', '');
INSERT INTO `sys_log` VALUES ('84831c84e9524996a630b52e7bf007c4', '1', '系统登录', '2', '2017-08-09 11:21:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge/15.15063', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('84861640f50447f5b89cf8db7516ddc5', '1', '系统设置-机构用户-机构管理', '1', '2017-06-13 11:41:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', 'tabPageId=jerichotabiframe_5', '');
INSERT INTO `sys_log` VALUES ('85105eacb4ad4299854fe4a75e1c06d8', '1', '系统登录', '1', '2017-07-18 11:08:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('857d1839387f419487165399144694ce', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:51:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('865a69577c464fed988f1de9613e16a5', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 10:34:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('866733e8b9ef4bb5bf8d8fa6f4b2547f', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 15:12:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('8694f22583354d8cbdb1a665baa5c621', '1', '系统登录', '1', '2017-08-08 14:53:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('87edb953e024470f88859db09afa44b7', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:03:53', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('8830bb002636456aa46072d83ca16008', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 13:44:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('897ba2bbad3a412ba15263e8b8dac5b9', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 10:08:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('89afbdfa40334200b5b2943d8529304d', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:41:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('89ebc96d91b34b38b67c5fa6509b94f3', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:58:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('8a91691b35d44ed483e9c1fd983e30cb', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:55:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('8ab45181f52e4b0c9addb06a54734c67', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 15:10:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('8ae520d1dda74c8c8570d0b059ae927a', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 09:27:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('8b227b041fc24978a9b392d82b574e6a', '1', '我的面板-个人信息-个人信息', '1', '2017-06-28 10:31:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('8b3f245be7814703af373b06e96080c0', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:41:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('8c23ad6cd2a14f008dd5d0d3376d9c7e', '1', '系统设置-系统设置-字典管理-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/sys/dict/query', 'GET', 'type=sex', '');
INSERT INTO `sys_log` VALUES ('8c6aba08e2b144b28d8e173c382a6603', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:48:21', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('8c9bfbd13b8740bfb2f7fc6b2263c47e', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:36:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('8d1e2d806bbe434c82870278daf1545f', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 15:11:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('8d9198b87bce47b4b19c5ce1a2971611', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 14:51:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/delete', 'POST', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d', '');
INSERT INTO `sys_log` VALUES ('8dce609839b244d6bbbbea1d83fa8906', '1', '系统设置-机构用户-用户管理', '7', '2017-06-13 15:14:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('8dd36ba38eea4367bd123464414cf016', '1', '系统登录', '1', '2017-08-08 09:55:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('8ec62a6a97f74428867dde59211f6451', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:10:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=6', '');
INSERT INTO `sys_log` VALUES ('8f04fa0d46d14c0dab5d26259b8653e7', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 15:28:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('8f890a38b7844b8ca7bef2109d8da050', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 17:54:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/usertorole', 'POST', '___t0.4651344445822141=&id=7', '');
INSERT INTO `sys_log` VALUES ('8ff5d0a6a3544eee8ee2eb85afac207c', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:59:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('91e91057e35746988000c9bc2ea22188', '1', '系统登录', '1', '2017-08-08 17:34:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('920324adad4743339d306f54d3a1e1ab', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-05-03 09:25:43', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('922901171a794e409854a2fdd5eec70c', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 10:02:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('9237dcec26f541d283244885c25d0fbc', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 09:34:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('936d76f25d7c47d9884f6fa2e658d213', '1', '在线办公-通知通告-通告管理', '1', '2017-05-03 09:25:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('93cb1a788339404c8e2762a601ccc142', '1', '系统登录', '1', '2017-07-18 11:06:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('93e7dd3fa3514a99bd3bc21e4670bc37', '1', '系统登录', '1', '2017-07-24 14:27:51', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('943fdd6fe871440c968ff61297d27f8b', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:41:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('94f18097f6ee40b3927c0e28c72882ef', '1', '我的面板-个人信息-个人信息', '1', '2017-07-18 10:53:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('94f8cb973ab043cdaf4e0f1a71242475', '2', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:34:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', 'java.lang.IllegalStateException: Neither BindingResult nor plain target object for bean name \'type\' available as request attribute\r\n	at org.springframework.web.servlet.support.BindStatus.<init>(BindStatus.java:144)\r\n	at org.springframework.web.servlet.tags.form.AbstractDataBoundFormElementTag.getBindStatus(AbstractDataBoundFormElementTag.java:168)\r\n	at org.springframework.web.servlet.tags.form.AbstractDataBoundFormElementTag.getPropertyPath(AbstractDataBoundFormElementTag.java:188)\r\n	at org.springframework.web.servlet.tags.form.AbstractDataBoundFormElementTag.getName(AbstractDataBoundFormElementTag.java:154)\r\n	at org.springframework.web.servlet.tags.form.AbstractDataBoundFormElementTag.writeDefaultAttributes(AbstractDataBoundFormElementTag.java:117)\r\n	at org.springframework.web.servlet.tags.form.AbstractHtmlElementTag.writeDefaultAttributes(AbstractHtmlElementTag.java:422)\r\n	at org.springframework.web.servlet.tags.form.SelectTag.writeTagContent(SelectTag.java:194)\r\n	at org.springframework.web.servlet.tags.form.AbstractFormTag.doStartTagInternal(AbstractFormTag.java:84)\r\n	at org.springframework.web.servlet.tags.RequestContextAwareTag.doStartTag(RequestContextAwareTag.java:80)\r\n	at org.apache.jsp.WEB_002dINF.views.modules.sys.dictList_jsp._jspService(dictList_jsp.java:133)\r\n	at org.apache.jasper.runtime.HttpJspBase.service(HttpJspBase.java:111)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:848)\r\n	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:403)\r\n	at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:492)\r\n	at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:378)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:848)\r\n	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:684)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:503)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:137)\r\n	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:575)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:231)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1086)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:429)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:193)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1020)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:135)\r\n	at org.eclipse.jetty.server.Dispatcher.forward(Dispatcher.java:276)\r\n	at org.eclipse.jetty.server.Dispatcher.forward(Dispatcher.java:103)\r\n	at org.springframework.web.servlet.view.InternalResourceView.renderMergedOutputModel(InternalResourceView.java:168)\r\n	at org.springframework.web.servlet.view.AbstractView.render(AbstractView.java:303)\r\n	at org.springframework.web.servlet.DispatcherServlet.render(DispatcherServlet.java:1243)\r\n	at org.springframework.web.servlet.DispatcherServlet.processDispatchResult(DispatcherServlet.java:1027)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:971)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:965)\r\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:856)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:735)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:841)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:848)\r\n	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:684)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1496)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.obtainContent(SiteMeshFilter.java:129)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.doFilter(SiteMeshFilter.java:77)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1484)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter$1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:383)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:344)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:261)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1484)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1476)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:501)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:137)\r\n	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:557)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:231)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1086)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:429)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:193)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1020)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:135)\r\n	at org.eclipse.jetty.server.handler.ContextHandlerCollection.handle(ContextHandlerCollection.java:255)\r\n	at org.eclipse.jetty.server.handler.HandlerCollection.handle(HandlerCollection.java:154)\r\n	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:116)\r\n	at org.eclipse.jetty.server.Server.handle(Server.java:370)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.handleRequest(AbstractHttpConnection.java:494)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.headerComplete(AbstractHttpConnection.java:971)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection$RequestHandler.headerComplete(AbstractHttpConnection.java:1033)\r\n	at org.eclipse.jetty.http.HttpParser.parseNext(HttpParser.java:644)\r\n	at org.eclipse.jetty.http.HttpParser.parseAvailable(HttpParser.java:235)\r\n	at org.eclipse.jetty.server.AsyncHttpConnection.handle(AsyncHttpConnection.java:82)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint.handle(SelectChannelEndPoint.java:696)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint$1.run(SelectChannelEndPoint.java:53)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:608)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool$3.run(QueuedThreadPool.java:543)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n');
INSERT INTO `sys_log` VALUES ('956efdd5b4be47479b23c7f389051dbb', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 09:15:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '111111111111111111');
INSERT INTO `sys_log` VALUES ('9623ccccb3d74823bdc90a4351b9da2f', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 13:44:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('96d78274a4c14de0b48a4112f5ad962f', '1', '系统登录', '1', '2017-07-20 15:32:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('96e2c6988d5c4623b9937630c8335ec1', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:58:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('97f24ca184574b20b20d7bdf2f1c9855', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:08:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('99bf0dac5411440fb80a076e7b8c1867', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:58:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('99d0565312a74aa2afdfa34f3db78eed', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:56:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('99f774e23b4d4799b9037cee0aef8e2b', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:01:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/export', 'POST', 'orderBy=&pageNo=1&office.name=&company.id=&name=&pageSize=30&office.id=&company.name=&loginName=', '');
INSERT INTO `sys_log` VALUES ('99fabc3e1fc5496681ff13993240334d', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 11:49:55', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('9a5473957e0d4d4fae29f28bc7b1b92f', '1', '系统设置-机构用户-用户管理', '1', '2017-07-18 11:08:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('9b0507c467824e8b864422364bd33651', '1', '系统设置-机构用户-机构管理', '7', '2017-06-13 15:20:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', 'tabPageId=jerichotabiframe_3', '');
INSERT INTO `sys_log` VALUES ('9b703a6528c04f3f8d82e3f361db9562', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:11:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=13', '');
INSERT INTO `sys_log` VALUES ('9c85901a34004f9bbb589d9b8f632a5b', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 11:20:51', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('9d3355c2703647f4b28c7a655a0ad5f5', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('9d43f6ef875c4965801fe251cffa01a9', '1', '系统登录', '1', '2017-06-13 17:01:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('9d9d4a52e3334dc6bab17c90592c47d3', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 16:53:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('9e8733d333e845eab83d17dcbe842015', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:25:20', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('9e924ef98b52412a90fe8fadb42d5965', '1', '系统设置-系统设置-菜单管理', '1', '2017-05-03 09:25:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/menu/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('9eadd6c81c3c4be38109eb6fb5676c15', '1', '代码生成-生成示例-单表-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testData/data', 'GET', 'limit=10&area.id=&office.id=&beginInDate=&area.name=&endInDate=&order=asc&user.name=&office.name=&user.id=&name=&offset=0', '');
INSERT INTO `sys_log` VALUES ('9ecb3caab6b44c159f523d72e04f3b61', '1', '系统登录', '1', '2017-06-13 15:09:00', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('9f607b3c369143c4b37a6eca86813c46', '1', '我的面板-个人信息-个人信息', '1', '2017-07-18 11:01:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('9f96786c50074c5c92b24f1087efa15f', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 16:19:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'tabPageId=jerichotabiframe_4', '');
INSERT INTO `sys_log` VALUES ('a0839ea514d34e4295679ffed1d137ca', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 11:30:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('a1cff06d24fa4bc19e8f459ed0920900', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:55:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('a2bf1b7e716d460bbc3c0ddc9c8b7d53', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 10:34:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('a34449fe07124e39a6e0028a57d43b28', '1', '我的面板-个人信息-个人信息', '1', '2017-06-14 09:19:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'POST', 'phone=86750&email=thinkgem@163.com&name=系统管理员&remarks=最高管理员&photo=&mobile=86750', '');
INSERT INTO `sys_log` VALUES ('a35985191a4b4c74a7dcbf2cde37d7ff', '1', '系统登录', '7', '2017-06-13 16:53:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('a364e633662649128c66a3e292d5d52c', '1', '系统设置-系统设置-字典管理-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/sys/dict/query', 'GET', 'type=sex', '');
INSERT INTO `sys_log` VALUES ('a42d4573d661439195acc0f63cd797be', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:50:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('a4464358ec4f471f88670950698bab82', '1', '系统登录', '1', '2017-08-08 16:56:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('a4d8fbdb13314ba3aa27438d97ef8999', '1', '系统设置-机构用户-机构管理-查看', '7', '2017-06-13 15:20:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('a533d70ffe4f47b5bfb358bac14f260b', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:37:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=10&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('a6389e9856e849fc90582934e9f9358c', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('a66b58194f41457c9992e9c0f81ed399', '1', '系统登录', '1', '2017-08-08 15:39:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('a7a939b60adc41e59346d8225f091d2c', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:46:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('a7e878b1e9dd4de9a748e873190cc9d8', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 17:23:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('aa366634ba444164b8c0c3067ea6f03b', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:37:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=20&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('aa38a792f79545a8a144cd14e01e7e6f', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 11:30:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('aa97644f6b6d43989082be6827796ec4', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-05-03 09:42:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ab6d975ceb0b4ae6a3abe34565234d57', '1', '代码生成-代码生成-业务表配置', '1', '2017-05-03 09:42:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/gen/genTable', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ac30ab9edf3347cda29d495ab12c7d4d', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 09:08:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('ac8424dc34334e8689783906292c8e8c', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:49:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('acf36a5874f249cdbe0853c5bc3349d8', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:37:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=50&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('ad439b0cdfef403c9e921edb5a8e6c97', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:56:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('adc3a5704679403a9d4b908b79b4b061', '1', '我的面板-个人信息-个人信息', '13', '2017-06-13 15:11:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('ae642437225b4f1aacbe085a100ed117', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:59:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d', '');
INSERT INTO `sys_log` VALUES ('ae99efd29d284afc88e22f76ab9e6e4d', '1', '系统登录', '1', '2017-06-13 16:50:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('aecc460d2101441bb8dd8e86664e0411', '1', '系统登录', '1', '2017-07-20 09:06:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('af1e8f9dc93d42038863523c2c4db9de', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:12:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'office.id=23&office.name=公司领导', '');
INSERT INTO `sys_log` VALUES ('afc02e3dfa6e495b89278c64d4d40b0b', '1', '系统登录', '1', '2017-06-14 09:19:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('afc11fecfe5b4e5c93928a3cdbe0c39a', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:51:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('b00f9c5a410a4d59b16ec75e4e3513ff', '1', '系统登录', '1', '2017-08-08 15:10:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b0c3a7bd5f3c4f05883dd26dad8dd86e', '2', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:39:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', 'org.apache.jasper.JasperException: /WEB-INF/views/modules/sys/logList.jsp(43,37) PWC6038: \"${fn:replace(fn:replace(fns:escapeHtml(\"+row.exception+\"), \'\\n\', \'<br/>\'), \'\\t\', \'&nbsp; &nbsp; \')}\" contains invalid expression(s): javax.el.ELException: Error Parsing: ${fn:replace(fn:replace(fns:escapeHtml(\"+row.exception+\"), \'\\n\', \'<br/>\'), \'\\t\', \'&nbsp; &nbsp; \')}\r\n	at org.apache.jasper.compiler.DefaultErrorHandler.jspError(DefaultErrorHandler.java:81)\r\n	at org.apache.jasper.compiler.ErrorDispatcher.dispatch(ErrorDispatcher.java:376)\r\n	at org.apache.jasper.compiler.ErrorDispatcher.jspError(ErrorDispatcher.java:188)\r\n	at org.apache.jasper.compiler.JspUtil.validateExpressions(JspUtil.java:656)\r\n	at org.apache.jasper.compiler.Validator$ValidateVisitor.visit(Validator.java:760)\r\n	at org.apache.jasper.compiler.Node$ELExpression.accept(Node.java:947)\r\n	at org.apache.jasper.compiler.Node$Nodes.visit(Node.java:2297)\r\n	at org.apache.jasper.compiler.Node$Visitor.visitBody(Node.java:2347)\r\n	at org.apache.jasper.compiler.Node$Visitor.visit(Node.java:2353)\r\n	at org.apache.jasper.compiler.Node$Root.accept(Node.java:499)\r\n	at org.apache.jasper.compiler.Node$Nodes.visit(Node.java:2297)\r\n	at org.apache.jasper.compiler.Validator.validate(Validator.java:1882)\r\n	at org.apache.jasper.compiler.Compiler.generateJava(Compiler.java:223)\r\n	at org.apache.jasper.compiler.Compiler.compile(Compiler.java:451)\r\n	at org.apache.jasper.JspCompilationContext.compile(JspCompilationContext.java:625)\r\n	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:374)\r\n	at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:492)\r\n	at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:378)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:848)\r\n	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:684)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:503)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:137)\r\n	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:575)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:231)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1086)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:429)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:193)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1020)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:135)\r\n	at org.eclipse.jetty.server.Dispatcher.forward(Dispatcher.java:276)\r\n	at org.eclipse.jetty.server.Dispatcher.forward(Dispatcher.java:103)\r\n	at org.springframework.web.servlet.view.InternalResourceView.renderMergedOutputModel(InternalResourceView.java:168)\r\n	at org.springframework.web.servlet.view.AbstractView.render(AbstractView.java:303)\r\n	at org.springframework.web.servlet.DispatcherServlet.render(DispatcherServlet.java:1243)\r\n	at org.springframework.web.servlet.DispatcherServlet.processDispatchResult(DispatcherServlet.java:1027)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:971)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:965)\r\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:856)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:735)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:841)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:848)\r\n	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:684)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1496)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.obtainContent(SiteMeshFilter.java:129)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.doFilter(SiteMeshFilter.java:77)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1484)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter$1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:383)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:344)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:261)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1484)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1476)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:501)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:137)\r\n	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:557)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:231)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1086)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:429)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:193)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1020)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:135)\r\n	at org.eclipse.jetty.server.handler.ContextHandlerCollection.handle(ContextHandlerCollection.java:255)\r\n	at org.eclipse.jetty.server.handler.HandlerCollection.handle(HandlerCollection.java:154)\r\n	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:116)\r\n	at org.eclipse.jetty.server.Server.handle(Server.java:370)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.handleRequest(AbstractHttpConnection.java:494)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.headerComplete(AbstractHttpConnection.java:971)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection$RequestHandler.headerComplete(AbstractHttpConnection.java:1033)\r\n	at org.eclipse.jetty.http.HttpParser.parseNext(HttpParser.java:644)\r\n	at org.eclipse.jetty.http.HttpParser.parseAvailable(HttpParser.java:235)\r\n	at org.eclipse.jetty.server.AsyncHttpConnection.handle(AsyncHttpConnection.java:82)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint.handle(SelectChannelEndPoint.java:696)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint$1.run(SelectChannelEndPoint.java:53)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:608)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool$3.run(QueuedThreadPool.java:543)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n');
INSERT INTO `sys_log` VALUES ('b0ef07b7051b471585668194dab4e041', '1', '系统设置-机构用户-机构管理', '7', '2017-06-13 18:02:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('b117437bedcb4e32ba9e0081391b1b04', '1', '系统登录', '1', '2017-07-20 17:41:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b15b3328c13a4234a1c3c20547130371', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 11:29:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('b2c475d82378486d8a99afbd7b553499', '1', '代码生成-生成示例-主子表', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testDataMain', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('b2ede2717b344bb5b4efec4113dccad7', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:45:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'type=color&description=颜色值&sort=20', '');
INSERT INTO `sys_log` VALUES ('b343cb8d42554d2b965b9b5c082d7061', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b345427f564d4a38a5083ade9ee50034', '1', '系统登录', '1', '2017-07-24 15:43:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b3a5499c77564e41bb9b3b144c8e7e02', '1', '系统登录', '1', '2017-07-24 17:43:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b464b059fc4f46fb8f95a72b46050b99', '1', '系统登录', '1', '2017-08-08 15:34:09', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b5763ead32764b249a7098e7fa5e9616', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 11:30:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('b57a5e677bb148a2a9314df58d8b0ac2', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 13:58:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('b5c2a1579da14aa8aba49dfcbfbbca76', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 14:59:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/delete', 'POST', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d', '');
INSERT INTO `sys_log` VALUES ('b70b8273b606456f8349ec07b33631e9', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 09:27:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('b84af32be5a64a55a9b72981dccd1203', '1', '系统设置-机构用户-用户管理', '7', '2017-06-13 16:54:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('b89225b6c5514117884790cc4c55600c', '1', '系统设置-系统设置-字典管理-修改', '1', '2017-07-20 14:46:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/save', 'POST', 'id=&sort=20&description=颜色值&value=white&label=白色&remarks=白色&type=color', '');
INSERT INTO `sys_log` VALUES ('b894300d0c914216a5bf5020c05f49e7', '1', '系统设置-机构用户-用户管理-修改', '1', '2017-07-18 11:08:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/import', 'POST', '', '');
INSERT INTO `sys_log` VALUES ('b90961220f7749ce96ed6a91d7e069d2', '1', '系统登录', '1', '2017-07-24 19:05:43', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('b91c950d43b2486799ea82c4f9bbbae1', '1', '系统登录', '1', '2017-08-08 15:30:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('baadb9c783614547ad312964f45d5bc5', '1', '系统登录', '1', '2017-07-20 11:20:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('baeaed8163944f96bfdaf42ca7456806', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:39:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('bc481b97c774484db085b6cde8ce8eee', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-28 10:52:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('bccd8af763e74249912e9edf0ff76785', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 17:54:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('bd9e26c41c5840f8a51caf764a0321b0', '1', '系统登录', '1', '2017-07-18 10:53:21', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('be3ff35d1e694f1e8fb40180e7175ad7', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 09:59:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('be617af7bf3f49d4ae1ab1cc3e104a0c', '1', '系统登录', '1', '2017-07-24 15:40:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('be82a48ea388486796a827b5db6245ec', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 13:59:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('befe2ecd430e4c8f963ca74f149c8ad6', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:13:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('bf794b531af74e04a1e253b9bac59303', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 14:40:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('bf9dbc3af52c4c618507e6318eb7505d', '1', '系统设置-系统设置-角色管理-修改', '7', '2017-06-13 17:54:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=7', '');
INSERT INTO `sys_log` VALUES ('bfaaa858711f4de98bc81f310886aa59', '1', '我的面板-个人信息-个人信息', '1', '2017-07-18 11:08:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('bfea886551f14f0f9a62a78276643385', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:01:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c0071e509ee443bcb3f36bfbba255264', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:09:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/users', 'GET', 'officeId=25', '');
INSERT INTO `sys_log` VALUES ('c069eb6b5a3e4d9c9abbcd7b59536cd7', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 17:50:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c08d8535e5684fd6bdd6b55f528c8af1', '1', '系统设置-系统设置-角色管理', '1', '2017-05-03 09:26:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c0ec3fbcc7f44909aa7918900b727b5e', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:38:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c131212096894112975e2f3aaddb1aac', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 10:27:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c1d305f5e16b4448825a1e8936f35b50', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 11:49:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c1db7ae3f4454d7698c1bc42491453d9', '1', '系统登录', '1', '2017-07-24 16:38:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('c50b4839346e43b5b83a9b64595fb672', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 15:14:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c53832dc31434aa4ae5c5f774b727d98', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 15:30:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('c59fc5a3d7c84730bb83dd10248eba20', '1', '系统登录', '1', '2017-08-02 11:58:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('c6171528a997414695f098edefd137ca', '1', '代码生成-生成示例-主子表-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testDataMain/data', 'GET', 'limit=10&sex=&order=asc&user.name=&user.id=&name=&offset=0', '');
INSERT INTO `sys_log` VALUES ('c6a57e0c75dc4626ada7a94dc2e87ad4', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 09:59:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c6f6585ca3d04b18b52a56ff1caa90ca', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:46:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/form', 'GET', 'id=1f93aa91ed6345d5a0f7cd902c42ff2d', '');
INSERT INTO `sys_log` VALUES ('c7082f8b3a324005a4aa1b0a8b7cb8a1', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:38:13', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c7a0757c2c674a6c85c59506cc6f0be3', '1', '系统设置-机构用户-机构管理', '1', '2017-06-13 11:30:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('c8060c14dc8d47ad9dcd780ee0b4fcf7', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 09:12:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('c8143d8b4d4547969e9f76f6730e6edb', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=17&parentIds=0,1,7,17,', '');
INSERT INTO `sys_log` VALUES ('c9900d6270ff4fb7b810732b395572b5', '1', '系统设置-机构用户-用户管理', '1', '2017-07-18 11:01:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('ca0b97636e474934a51c1e4715ddcf44', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 15:09:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=6', '');
INSERT INTO `sys_log` VALUES ('ca588ddabfa743c4b23d97a3935e7b1e', '2', '系统设置-机构用户-用户管理-查看', '1', '2017-07-13 16:50:35', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', 'org.springframework.web.util.NestedServletException: Handler processing failed; nested exception is java.lang.Error: Unresolved compilation problems: \n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n\r\n	at org.springframework.web.servlet.DispatcherServlet.triggerAfterCompletionWithError(DispatcherServlet.java:1302)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:977)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:893)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:965)\r\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:856)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:707)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:841)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:820)\r\n	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:652)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1317)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.obtainContent(SiteMeshFilter.java:129)\r\n	at com.opensymphony.sitemesh.webapp.SiteMeshFilter.doFilter(SiteMeshFilter.java:77)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1288)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter$1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:383)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:344)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:261)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1288)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:85)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1288)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:443)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:137)\r\n	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:556)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:227)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1044)\r\n	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:372)\r\n	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:189)\r\n	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:978)\r\n	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:135)\r\n	at org.eclipse.jetty.server.handler.ContextHandlerCollection.handle(ContextHandlerCollection.java:255)\r\n	at org.eclipse.jetty.server.handler.HandlerCollection.handle(HandlerCollection.java:154)\r\n	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:116)\r\n	at org.eclipse.jetty.server.Server.handle(Server.java:369)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.handleRequest(AbstractHttpConnection.java:486)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection.headerComplete(AbstractHttpConnection.java:933)\r\n	at org.eclipse.jetty.server.AbstractHttpConnection$RequestHandler.headerComplete(AbstractHttpConnection.java:995)\r\n	at org.eclipse.jetty.http.HttpParser.parseNext(HttpParser.java:644)\r\n	at org.eclipse.jetty.http.HttpParser.parseAvailable(HttpParser.java:235)\r\n	at org.eclipse.jetty.server.AsyncHttpConnection.handle(AsyncHttpConnection.java:82)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint.handle(SelectChannelEndPoint.java:667)\r\n	at org.eclipse.jetty.io.nio.SelectChannelEndPoint$1.run(SelectChannelEndPoint.java:52)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:608)\r\n	at org.eclipse.jetty.util.thread.QueuedThreadPool$3.run(QueuedThreadPool.java:543)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: java.lang.Error: Unresolved compilation problems: \n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n	The method getOffice() is undefined for the type User\n\r\n	at com.thinkgem.jeesite.common.service.BaseService.dataScopeFilter(BaseService.java:55)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService.findUser(SystemService.java:87)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$FastClassBySpringCGLIB$$4ff9ba04.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:718)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$EnhancerBySpringCGLIB$$f23f20ec.findUser(<generated>)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$FastClassBySpringCGLIB$$4ff9ba04.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:718)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\r\n	at com.thinkgem.jeesite.modules.sys.service.SystemService$$EnhancerBySpringCGLIB$$c15955e2.findUser(<generated>)\r\n	at com.thinkgem.jeesite.modules.sys.web.UserController.list(UserController.java:71)\r\n	at com.thinkgem.jeesite.modules.sys.web.UserController$$FastClassBySpringCGLIB$$25977f0a.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:718)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.apache.shiro.spring.security.interceptor.AopAllianceAnnotationsAuthorizingMethodInterceptor$1.proceed(AopAllianceAnnotationsAuthorizingMethodInterceptor.java:82)\r\n	at org.apache.shiro.authz.aop.AuthorizingMethodInterceptor.invoke(AuthorizingMethodInterceptor.java:39)\r\n	at org.apache.shiro.spring.security.interceptor.AopAllianceAnnotationsAuthorizingMethodInterceptor.invoke(AopAllianceAnnotationsAuthorizingMethodInterceptor.java:115)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\r\n	at com.thinkgem.jeesite.modules.sys.web.UserController$$EnhancerBySpringCGLIB$$4ac4748c.list(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:606)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:222)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:137)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:110)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:775)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:705)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:959)\r\n	... 53 more\r\n');
INSERT INTO `sys_log` VALUES ('ca9e44e79df0436097865d9aec9df483', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('cb1078e6ff0a4903ad72bcfd3672d450', '1', '系统登录', '1', '2017-08-09 10:01:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('cb1ac61467cb42dabea7298f0b3f0081', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:51:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('cbab149730ba4fcd8c71a89996c6a9dd', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:08:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/import/template', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cbc8257a882b49eb902e918891cd38f8', '1', '系统设置-机构用户-用户管理', '1', '2017-05-03 09:25:21', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cbff5d6338584c039d92a87ef48773b4', '1', '系统设置-系统设置-角色管理-查看', '7', '2017-06-13 17:55:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/usertorole', 'POST', 'id=7&___t0.15933491119654963=', '');
INSERT INTO `sys_log` VALUES ('cc6b3f62e0dd447e8cda4fe07eb098fd', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:48:20', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', 'type=color&repage=', '');
INSERT INTO `sys_log` VALUES ('cc86cb719e38444288dac6f0183c9ed9', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:37:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('cc8880ad881a4359b2ede96bb63d6af0', '1', '代码生成-生成示例-主子表-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testDataMain/data', 'GET', 'limit=10&sex=&order=asc&user.name=&user.id=&name=&offset=0', '');
INSERT INTO `sys_log` VALUES ('cca364cee285492195967d75cec20bf4', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 11:15:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cce0808515ed43deb2824b8f3fd3c7f3', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 15:28:53', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ccf2c87a49334eff9488a3fdddcb00f9', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 13:48:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ccfda8b611a1438ca41c6f496c0306e7', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 09:59:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cd1a3c10f9a04ab992b72e635c4e8b64', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 11:41:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('cd3f5258af5d445fbea154f0f61e4615', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:40:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cdc22bd7c0484c5f8c7b05b8f5eb3464', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:12:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('cde620a86f554d989e9f611ace2fa719', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 13:59:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ce9e05319d754d6c9428a8a9ce534278', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 09:56:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cec30c7a94224c95b97091cbd5bd821d', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 15:30:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('cf2af854c7bb4c278c4e474686e57460', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 16:12:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('cf3d87dfde244a36a94f10e44cdb1b38', '1', '系统登录', '1', '2017-07-20 13:44:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('cf6e066d25dc4f8982ac1a7eb18c27de', '1', '我的面板-个人信息-个人信息', '1', '2017-07-18 11:06:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('cfcb8c3ffdfb45678cf55940ebdbb3e0', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 10:54:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('d0b58586ee7e48c49f7db10ffd7d779d', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:06:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('d15f9309d7d646149b78ee1b3d46121f', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 11:15:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d200cba4d3c942ecb078e510f0a85f31', '1', '系统登录', '1', '2017-07-20 15:28:51', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('d26f6f792b9e40d98c5079c41ef1ea24', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:49:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d361894c4816484eafd3252906e244e0', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 16:19:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=&parentIds=', '');
INSERT INTO `sys_log` VALUES ('d3ab8ed58fc448bf97ecb61439abc5ec', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:36:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d3b60ad4e5e440a8999eb5ba64d9da7e', '1', '系统登录', '13', '2017-06-13 15:10:03', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('d4084693801047e2a96f04b5db4018e9', '1', '系统设置-系统设置-角色管理', '1', '2017-06-13 15:10:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', 'tabPageId=jerichotabiframe_2', '');
INSERT INTO `sys_log` VALUES ('d425204ca2cf44a2ac57beb75cd0afa7', '1', '系统登录', '1', '2017-07-24 16:35:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('d4bde2efc74f4bf29df61e9df7630a2a', '1', '系统登录', '1', '2017-08-08 14:03:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('d4e7a1576b594dc1be56ae045d0b119b', '2', '系统设置-日志查询-日志查询', '1', '2017-07-20 11:20:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '222222222222222222');
INSERT INTO `sys_log` VALUES ('d6596feb93d04c5d96f64c065f30f2d0', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 09:12:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d6c5414afbdc4ccaa2adaf2660851393', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 13:48:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d724ac369e5b430fa417e1b5de838efc', '1', '我的面板-个人信息-修改密码', '1', '2017-06-14 10:42:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/modifyPwd', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d73c70a09c474d568a776565fe17d3d2', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 14:47:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d7ba09bc56734c2e9d53fa8d1b4946cd', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 09:27:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d7d81a4519684c5aabe60d88220c82fa', '1', '代码生成-生成示例-单表-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testData/data', 'GET', 'limit=10&area.id=&office.id=&beginInDate=&area.name=&endInDate=&order=asc&user.name=&office.name=&user.id=&name=&offset=0', '');
INSERT INTO `sys_log` VALUES ('d88ba36b5e94416cb6ed53d5ec9fc071', '1', '我的面板-个人信息-修改密码', '1', '2017-05-03 09:24:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/modifyPwd', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('d92d6f5eb8c442c4b6ed9a9627cbb8fb', '1', '系统登录', '1', '2017-07-24 18:25:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('da1c07d32a87446487e43bd2ba8a9a96', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:01:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'repage=', '');
INSERT INTO `sys_log` VALUES ('da64607fc75343d5b9509e848e066aa6', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 09:56:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('dc1352de3cdb4cc9ae8b715ba1443f2a', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:12:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'office.id=23&office.name=公司领导', '');
INSERT INTO `sys_log` VALUES ('dc15f837c2374d60b801f167589d25fe', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:12:23', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', 'office.id=23&office.name=公司领导', '');
INSERT INTO `sys_log` VALUES ('dcf5a7e7ea024cfdae1e0fb1cf76059b', '1', '系统设置-机构用户-区域管理', '1', '2017-06-13 16:19:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/area/', 'GET', 'tabPageId=jerichotabiframe_3', '');
INSERT INTO `sys_log` VALUES ('dd2ed60337484ec9ab8fd53189b126f2', '1', '系统设置-机构用户-用户管理-修改', '1', '2017-07-18 11:08:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/import', 'POST', '', '');
INSERT INTO `sys_log` VALUES ('ddce66e0f812413d886dcaa41b09af5f', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 15:15:09', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ddfa948f147544f48e9f58ce2af221d9', '1', '系统设置-系统设置-字典管理', '1', '2017-05-03 09:26:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('df8138d9156e4447b2f1eb02c49e41b4', '1', '系统登录', '1', '2017-07-24 19:29:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('dfc6cb3b4caa412fb2d339ba9101bd5e', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 13:52:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('dfe638f589c84af98d627163805decbd', '1', '系统设置-机构用户-用户管理', '1', '2017-06-28 10:31:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('e07a1ddce6f24dd6813645653de2134a', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 15:12:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('e0c0380696664ce7910a5986bf26b36d', '1', '系统设置-系统设置-角色管理', '7', '2017-06-13 18:21:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e0d9144d02af4f8391a8ebf7ab2ca5ff', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 15:30:19', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('e13031b500284659bee28f7be2af3799', '1', '系统设置-机构用户-机构管理', '1', '2017-05-03 09:25:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e17bcddd87f642ceaa9d04c1fd7bd4b4', '1', '我的面板-个人信息-个人信息', '1', '2017-05-03 09:41:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e258f23a0e4c4030b4ace518fed6f660', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 15:09:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', 'tabPageId=jerichotabiframe_0', '');
INSERT INTO `sys_log` VALUES ('e30c15df0d904fa596d04d91fee88b6e', '1', '系统登录', '1', '2017-06-13 16:53:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('e3a797b48d57447a8709a7a53a8dbadc', '1', '我的面板-个人信息-个人信息', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e425205d3ba447c7b5c160f40bbdc6eb', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-14 08:44:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e51806202d46484c9794e79f348dc0a5', '1', '系统设置-机构用户-用户管理', '1', '2017-07-18 11:06:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('e591938d54364c229a81bedb8c0c9c61', '1', '系统设置-系统设置-角色管理-修改', '1', '2017-06-13 14:10:29', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/assign', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('e5cc5638077246378fb16e762aa5bcbc', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 16:53:34', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e67b9730d54042839b909054b4862c68', '1', '系统设置-机构用户-用户管理-查看', '13', '2017-06-13 15:12:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=13', '');
INSERT INTO `sys_log` VALUES ('e799b69e9a70402eb619474ac6309c60', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 10:54:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/export', 'POST', 'orderBy=&pageNo=1&office.name=&company.id=&name=&pageSize=30&office.id=&company.name=&loginName=', '');
INSERT INTO `sys_log` VALUES ('e7a5e174fead4edb9c1792dff811be4e', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 13:59:15', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e87bfcdc770d449cab4e652f85ebc5e4', '1', '系统登录', '1', '2017-07-24 16:43:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('e8ad328d3a114cffa781bb24f5da7984', '1', '系统设置-机构用户-区域管理', '1', '2017-05-03 09:25:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/area/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e8d353dbaedf4b809da8c1ec61c4eabb', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 10:08:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e97276f321734aa9b34359f3fb480876', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 15:14:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('e99cea39a0ff4508a1e252954beaab0f', '1', '代码生成-生成示例-主子表', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/test/testDataMain', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('eb981764e72c45a19c9b5c802ed19242', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 09:34:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ebc58bf115b04f769899aacd65156b5e', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-05-03 09:25:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ec971eb4cdbb43028c3ec8ee60f82313', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:47:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ecb8e6a3cc0449c8b8829d5c2b7717aa', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 13:59:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('edb0f0c159ff4353a1f101681ffbaab6', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('edf8d8fabed94415979aa4c54f57f25a', '1', '我的面板-个人信息-个人信息', '1', '2017-07-18 10:53:23', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ee2fc56aa5e84bcea8e7d7ba8de43138', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-05-03 09:39:59', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('eebde38ff6474b1d8a46b9b041793544', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:39:49', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('eecd71944a9e4d59a207b290676fd1af', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:09:41', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/users', 'GET', 'officeId=23', '');
INSERT INTO `sys_log` VALUES ('ef4a2d1ae98f4ab095e4a34eaadfbaae', '1', '系统登录', '1', '2017-07-21 16:48:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('efc042fe8f704b678de0efbfc9eacf51', '1', '系统登录', '1', '2017-07-24 10:50:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('f11aa3555f6a42dd8184c39393a9ac86', '1', '系统设置-机构用户-机构管理', '1', '2017-05-03 09:25:43', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/office/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f264550c9a8b42dea800230504c5e810', '1', '系统设置-机构用户-机构管理-查看', '1', '2017-06-13 15:13:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/office/list', 'GET', 'id=17&parentIds=0,1,7,17,', '');
INSERT INTO `sys_log` VALUES ('f320b1b3184649f88854027e06b5028e', '1', '我的面板-个人信息-个人信息', '1', '2017-05-03 09:38:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f3386a4c48414709bceac711c34544e2', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-06-13 11:30:46', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/form', 'GET', 'id=2', '');
INSERT INTO `sys_log` VALUES ('f34e9d04571648f6a431aa692f47f4d3', '1', '系统登录', '1', '2017-06-13 11:29:53', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('f39c460ca2f64fdd8bb9305174c4e206', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-18 11:08:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/export', 'POST', 'orderBy=&pageNo=1&office.name=&company.id=&name=&pageSize=30&office.id=&company.name=&loginName=', '');
INSERT INTO `sys_log` VALUES ('f3a716b2a881402e870048f20f5f861c', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:41:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f556dccbb2b947278a41b4798ba50779', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 14:40:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f57a20127f8e411c9c28889754268cde', '1', '系统设置-系统设置-字典管理-查看', '1', '2017-07-20 14:48:20', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/data', 'GET', 'limit=10&offset=0&order=asc&description=', '');
INSERT INTO `sys_log` VALUES ('f5ade208a9a84eabb8189cd2b15308c9', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:36:39', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f64c75b9fc5244c1878dff169b522702', '1', '系统设置-机构用户-用户管理', '1', '2017-07-20 09:34:07', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f69e99258d1b40169ff09ef2d8c73374', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:09:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/users', 'GET', 'officeId=26', '');
INSERT INTO `sys_log` VALUES ('f73ac79a87834572821e23606495d6f0', '1', '系统设置-机构用户-用户管理', '13', '2017-06-13 15:11:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('f78cc0a4766949be927b30d172c2cb39', '1', '系统设置-系统设置-字典管理', '1', '2017-07-20 14:00:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/dict/', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('f8ee9e3d0db94908a4c5ba8e11212003', '1', '系统设置-系统设置-字典管理-查看', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/sys/dict/query', 'GET', 'type=sex', '');
INSERT INTO `sys_log` VALUES ('f9344f5f30f14d699a211a58baa7b2a3', '1', '系统登录', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('fa4e872a76a44984b56affdcb13aa252', '1', '系统设置-机构用户-用户管理-查看', '7', '2017-06-13 18:09:01', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fa81800606674d42b02a1f6f40bdb3dc', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:27:16', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fb9a10324e6440cbad73aeac280cb02a', '1', '系统登录', '1', '2017-07-24 16:36:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('fc207512e0d04ad98d9f5d829353ff0a', '1', '我的面板-个人信息-个人信息', '1', '2017-07-20 10:02:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fc3c61865e794d099124a85671768def', '1', '在线办公-通知通告-我的通告', '1', '2017-05-03 09:27:08', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/oa/oaNotify/self', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fc4ed963412743379448eb409dce39c3', '1', '系统设置-机构用户-用户管理', '1', '2017-06-13 15:10:23', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', 'tabPageId=jerichotabiframe_1', '');
INSERT INTO `sys_log` VALUES ('fc6c11173e234ee39ab4630f65a4e6d5', '1', '系统设置-机构用户-用户管理-查看', '1', '2017-07-20 13:59:05', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/list', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fc7e8df00eab4119908faabc1bfa0995', '1', '代码生成-代码生成-业务表配置', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/gen/genTable', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fd4a869730794b7198f3d4593b54a9a4', '1', '系统设置-日志查询-日志查询', '1', '2017-07-20 12:40:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/log', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fd9ec2e05e494263bfef1c84ec45afc6', '1', '系统设置-机构用户-用户管理', '1', '2017-05-03 09:42:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a/sys/user/index', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fe1b300d4a88469e8fd7df3f019854e4', '1', '系统登录', '1', '2017-05-03 09:38:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('fe6b0911b2b94e06b0daeb2e6dca1558', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 16:19:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/form', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('fe85d3f847c14bcf89edc2978c20ca2b', '1', '系统登录', '1', '2017-07-20 13:48:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a', 'GET', 'login=', '');
INSERT INTO `sys_log` VALUES ('fedae6eb8ceb48ecaef60e706589c511', '1', '系统设置-系统设置-角色管理-查看', '1', '2017-06-13 15:09:40', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/role/users', 'GET', 'officeId=24', '');
INSERT INTO `sys_log` VALUES ('ff74b3e372aa4c25b45a93c33c2c1b76', '1', '代码生成-代码生成-生成方案配置', null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '/jeesite-lite/a/gen/genScheme', 'GET', '', '');
INSERT INTO `sys_log` VALUES ('ffe85488778c48f7929ba21168fd8e92', '1', '我的面板-个人信息-个人信息', '1', '2017-06-13 17:01:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '/jeesite-lite/a/sys/user/info', 'GET', '', '');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `is_show` char(1) NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('0b2ebd4d639e4c2b83c2dd0764522f24', 'ba8092291b40482db8fe7fc006ea3d76', '0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,', '编辑', '60', '', '', '', '0', 'test:testData:edit', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('0ca004d6b1bf4bcab9670a5060d82a55', '3c92c17886944d0687e73e286cada573', '0,1,79,3c92c17886944d0687e73e286cada573,', '树结构', '90', '/test/testTree', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('1', '0', '0,', '功能菜单', '0', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('10', '3', '0,1,2,3,', '字典管理', '60', '/sys/dict/', null, 'th-list', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '10', '0,1,2,3,10,', '查看', '30', null, null, null, '0', 'sys:dict:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '10', '0,1,2,3,10,', '修改', '40', null, null, null, '0', 'sys:dict:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '2', '0,1,2,', '机构用户', '970', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '13', '0,1,2,13,', '区域管理', '50', '/sys/area/', null, 'th', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('15', '14', '0,1,2,13,14,', '查看', '30', null, null, null, '0', 'sys:area:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('16', '14', '0,1,2,13,14,', '修改', '40', null, null, null, '0', 'sys:area:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('17', '13', '0,1,2,13,', '机构管理', '40', '/sys/office/list', null, 'th-large', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('18', '17', '0,1,2,13,17,', '查看', '30', null, null, null, '0', 'sys:office:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('19', '17', '0,1,2,13,17,', '修改', '40', null, null, null, '0', 'sys:office:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('2', '1', '0,1,', '系统设置', '900', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '13', '0,1,2,13,', '用户管理', '30', '/sys/user/index', null, 'user', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '20', '0,1,2,13,20,', '查看', '30', null, null, null, '0', 'sys:user:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '20', '0,1,2,13,20,', '修改', '40', null, null, null, '0', 'sys:user:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '0,1,', '我的面板', '100', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('28', '27', '0,1,27,', '个人信息', '30', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('29', '28', '0,1,27,28,', '个人信息', '30', '/sys/user/info', null, 'user', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('3', '2', '0,1,2,', '系统设置', '980', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('30', '28', '0,1,27,28,', '修改密码', '40', '/sys/user/modifyPwd', null, 'lock', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('3c92c17886944d0687e73e286cada573', '79', '0,1,79,', '生成示例', '120', '', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('4', '3', '0,1,2,3,', '菜单管理', '30', '/sys/menu/', null, 'list-alt', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('4855cf3b25c244fb8500a380db189d97', 'b1f6d1b86ba24365bae7fd86c5082317', '0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,', '查看', '30', '', '', '', '0', 'test:testDataMain:view', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('5', '4', '0,1,2,3,4,', '查看', '30', null, null, null, '0', 'sys:menu:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('56', '71', '0,1,27,71,', '文件管理', '90', '/../static/ckfinder/ckfinder.html', null, 'folder-open', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('57', '56', '0,1,27,40,56,', '查看', '30', null, null, null, '0', 'cms:ckfinder:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('58', '56', '0,1,27,40,56,', '上传', '40', null, null, null, '0', 'cms:ckfinder:upload', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('59', '56', '0,1,27,40,56,', '修改', '50', null, null, null, '0', 'cms:ckfinder:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('6', '4', '0,1,2,3,4,', '修改', '40', null, null, null, '0', 'sys:menu:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('62', '1', '0,1,', '在线办公', '200', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('67', '2', '0,1,2,', '日志查询', '985', null, null, null, '1', null, '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('68', '67', '0,1,2,67,', '日志查询', '30', '/sys/log', null, 'pencil', '1', 'sys:log:view', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('7', '3', '0,1,2,3,', '角色管理', '50', '/sys/role/', null, 'lock', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('71', '27', '0,1,27,', '文件管理', '90', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('79', '1', '0,1,', '代码生成', '5000', null, null, null, '1', null, '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '7', '0,1,2,3,7,', '查看', '30', null, null, null, '0', 'sys:role:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('80', '79', '0,1,79,', '代码生成', '50', null, null, null, '1', null, '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('81', '80', '0,1,79,80,', '生成方案配置', '30', '/gen/genScheme', null, null, '1', 'gen:genScheme:view,gen:genScheme:edit', '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('82', '80', '0,1,79,80,', '业务表配置', '20', '/gen/genTable', null, null, '1', 'gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit', '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('84', '67', '0,1,2,67,', '连接池监视', '40', '/../druid', null, null, '1', null, '1', '2013-10-18 08:00:00', '1', '2013-10-18 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('88', '62', '0,1,62,', '通知通告', '20', '', '', '', '1', '', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('89', '88', '0,1,62,88,', '我的通告', '30', '/oa/oaNotify/self', '', '', '1', '', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '7', '0,1,2,3,7,', '修改', '40', null, null, null, '0', 'sys:role:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('90', '88', '0,1,62,88,', '通告管理', '50', '/oa/oaNotify', '', '', '1', 'oa:oaNotify:view,oa:oaNotify:edit', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('afab2db430e2457f9cf3a11feaa8b869', '0ca004d6b1bf4bcab9670a5060d82a55', '0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,', '编辑', '60', '', '', '', '0', 'test:testTree:edit', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('b1f6d1b86ba24365bae7fd86c5082317', '3c92c17886944d0687e73e286cada573', '0,1,79,3c92c17886944d0687e73e286cada573,', '主子表', '60', '/test/testDataMain', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('ba8092291b40482db8fe7fc006ea3d76', '3c92c17886944d0687e73e286cada573', '0,1,79,3c92c17886944d0687e73e286cada573,', '单表', '30', '/test/testData', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('c2e4d9082a0b4386884a0b203afe2c5c', '0ca004d6b1bf4bcab9670a5060d82a55', '0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,', '查看', '30', '', '', '', '0', 'test:testTree:view', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('d15ec45a4c5449c3bbd7a61d5f9dd1d2', 'b1f6d1b86ba24365bae7fd86c5082317', '0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,', '编辑', '60', '', '', '', '0', 'test:testDataMain:edit', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
INSERT INTO `sys_menu` VALUES ('df7ce823c5b24ff9bada43d992f373e2', 'ba8092291b40482db8fe7fc006ea3d76', '0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,', '查看', '30', '', '', '', '0', 'test:testData:view', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) NOT NULL COMMENT '归属区域',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `type` char(1) NOT NULL COMMENT '机构类型',
  `grade` char(1) NOT NULL COMMENT '机构等级',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) DEFAULT NULL COMMENT '传真',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `useable` varchar(64) DEFAULT NULL COMMENT '是否启用',
  `primary_person` varchar(64) DEFAULT NULL COMMENT '主负责人',
  `deputy_person` varchar(64) DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
-- Records of sys_office
-- ----------------------------
INSERT INTO `sys_office` VALUES ('1', '0', '0,', '山东省总公司', '10', '2', '100000', '1', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('10', '7', '0,1,7,', '市场部', '30', '3', '200003', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('11', '7', '0,1,7,', '技术部', '40', '3', '200004', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('12', '7', '0,1,7,', '历城区分公司', '0', '4', '201000', '1', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('13', '12', '0,1,7,12,', '公司领导', '10', '4', '201001', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('14', '12', '0,1,7,12,', '综合部', '20', '4', '201002', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('15', '12', '0,1,7,12,', '市场部', '30', '4', '201003', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('16', '12', '0,1,7,12,', '技术部', '40', '4', '201004', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('17', '7', '0,1,7,', '历下区分公司', '40', '5', '201010', '1', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('18', '17', '0,1,7,17,', '公司领导', '10', '5', '201011', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('19', '17', '0,1,7,17,', '综合部', '20', '5', '201012', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('2', '1', '0,1,', '公司领导', '10', '2', '100001', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('20', '17', '0,1,7,17,', '市场部', '30', '5', '201013', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('21', '17', '0,1,7,17,', '技术部', '40', '5', '201014', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('22', '7', '0,1,7,', '高新区分公司', '50', '6', '201010', '1', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('23', '22', '0,1,7,22,', '公司领导', '10', '6', '201011', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('24', '22', '0,1,7,22,', '综合部', '20', '6', '201012', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('25', '22', '0,1,7,22,', '市场部', '30', '6', '201013', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('26', '22', '0,1,7,22,', '技术部', '40', '6', '201014', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('3', '1', '0,1,', '综合部', '20', '2', '100002', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('4', '1', '0,1,', '市场部', '30', '2', '100003', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('5', '1', '0,1,', '技术部', '40', '2', '100004', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('6', '1', '0,1,', '研发部', '50', '2', '100005', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('7', '1', '0,1,', '济南市分公司', '20', '3', '200000', '1', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('8', '7', '0,1,7,', '公司领导', '10', '3', '200001', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('9', '7', '0,1,7,', '综合部', '20', '3', '200002', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `enname` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) DEFAULT NULL COMMENT '数据范围',
  `sys_data` varchar(64) DEFAULT NULL COMMENT '是否系统数据',
  `useable` varchar(64) DEFAULT NULL COMMENT '是否可用',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`),
  KEY `sys_role_enname` (`enname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '1', '系统管理员', 'dept', 'assignment', '1', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_role` VALUES ('2', '1', '公司管理员', 'hr', 'assignment', '2', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_role` VALUES ('3', '1', '本公司管理员', 'a', 'assignment', '3', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_role` VALUES ('4', '1', '部门管理员', 'b', 'assignment', '4', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_role` VALUES ('5', '1', '本部门管理员', 'c', 'assignment', '5', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_role` VALUES ('6', '2', '普通用户', 'd', 'assignment', '8', '1', '1', '1', '2013-05-27 08:00:00', '1', '2017-06-13 15:11:24', '', '0');
INSERT INTO `sys_role` VALUES ('7', '2', '济南市管理员', 'e', 'assignment', '9', '1', '1', '1', '2013-05-27 08:00:00', '1', '2017-07-26 17:17:58', '', '0');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1');
INSERT INTO `sys_role_menu` VALUES ('1', '10');
INSERT INTO `sys_role_menu` VALUES ('1', '11');
INSERT INTO `sys_role_menu` VALUES ('1', '12');
INSERT INTO `sys_role_menu` VALUES ('1', '13');
INSERT INTO `sys_role_menu` VALUES ('1', '14');
INSERT INTO `sys_role_menu` VALUES ('1', '15');
INSERT INTO `sys_role_menu` VALUES ('1', '16');
INSERT INTO `sys_role_menu` VALUES ('1', '17');
INSERT INTO `sys_role_menu` VALUES ('1', '18');
INSERT INTO `sys_role_menu` VALUES ('1', '19');
INSERT INTO `sys_role_menu` VALUES ('1', '2');
INSERT INTO `sys_role_menu` VALUES ('1', '20');
INSERT INTO `sys_role_menu` VALUES ('1', '21');
INSERT INTO `sys_role_menu` VALUES ('1', '22');
INSERT INTO `sys_role_menu` VALUES ('1', '27');
INSERT INTO `sys_role_menu` VALUES ('1', '28');
INSERT INTO `sys_role_menu` VALUES ('1', '29');
INSERT INTO `sys_role_menu` VALUES ('1', '3');
INSERT INTO `sys_role_menu` VALUES ('1', '30');
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('1', '5');
INSERT INTO `sys_role_menu` VALUES ('1', '56');
INSERT INTO `sys_role_menu` VALUES ('1', '57');
INSERT INTO `sys_role_menu` VALUES ('1', '58');
INSERT INTO `sys_role_menu` VALUES ('1', '59');
INSERT INTO `sys_role_menu` VALUES ('1', '6');
INSERT INTO `sys_role_menu` VALUES ('1', '62');
INSERT INTO `sys_role_menu` VALUES ('1', '67');
INSERT INTO `sys_role_menu` VALUES ('1', '68');
INSERT INTO `sys_role_menu` VALUES ('1', '7');
INSERT INTO `sys_role_menu` VALUES ('1', '71');
INSERT INTO `sys_role_menu` VALUES ('1', '79');
INSERT INTO `sys_role_menu` VALUES ('1', '8');
INSERT INTO `sys_role_menu` VALUES ('1', '80');
INSERT INTO `sys_role_menu` VALUES ('1', '81');
INSERT INTO `sys_role_menu` VALUES ('1', '82');
INSERT INTO `sys_role_menu` VALUES ('1', '83');
INSERT INTO `sys_role_menu` VALUES ('1', '84');
INSERT INTO `sys_role_menu` VALUES ('1', '88');
INSERT INTO `sys_role_menu` VALUES ('1', '89');
INSERT INTO `sys_role_menu` VALUES ('1', '9');
INSERT INTO `sys_role_menu` VALUES ('1', '90');
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '10');
INSERT INTO `sys_role_menu` VALUES ('2', '11');
INSERT INTO `sys_role_menu` VALUES ('2', '12');
INSERT INTO `sys_role_menu` VALUES ('2', '13');
INSERT INTO `sys_role_menu` VALUES ('2', '14');
INSERT INTO `sys_role_menu` VALUES ('2', '15');
INSERT INTO `sys_role_menu` VALUES ('2', '16');
INSERT INTO `sys_role_menu` VALUES ('2', '17');
INSERT INTO `sys_role_menu` VALUES ('2', '18');
INSERT INTO `sys_role_menu` VALUES ('2', '19');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '20');
INSERT INTO `sys_role_menu` VALUES ('2', '21');
INSERT INTO `sys_role_menu` VALUES ('2', '22');
INSERT INTO `sys_role_menu` VALUES ('2', '27');
INSERT INTO `sys_role_menu` VALUES ('2', '28');
INSERT INTO `sys_role_menu` VALUES ('2', '29');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '30');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '5');
INSERT INTO `sys_role_menu` VALUES ('2', '56');
INSERT INTO `sys_role_menu` VALUES ('2', '57');
INSERT INTO `sys_role_menu` VALUES ('2', '58');
INSERT INTO `sys_role_menu` VALUES ('2', '59');
INSERT INTO `sys_role_menu` VALUES ('2', '6');
INSERT INTO `sys_role_menu` VALUES ('2', '62');
INSERT INTO `sys_role_menu` VALUES ('2', '67');
INSERT INTO `sys_role_menu` VALUES ('2', '68');
INSERT INTO `sys_role_menu` VALUES ('2', '7');
INSERT INTO `sys_role_menu` VALUES ('2', '71');
INSERT INTO `sys_role_menu` VALUES ('2', '79');
INSERT INTO `sys_role_menu` VALUES ('2', '8');
INSERT INTO `sys_role_menu` VALUES ('2', '80');
INSERT INTO `sys_role_menu` VALUES ('2', '81');
INSERT INTO `sys_role_menu` VALUES ('2', '82');
INSERT INTO `sys_role_menu` VALUES ('2', '83');
INSERT INTO `sys_role_menu` VALUES ('2', '84');
INSERT INTO `sys_role_menu` VALUES ('2', '88');
INSERT INTO `sys_role_menu` VALUES ('2', '89');
INSERT INTO `sys_role_menu` VALUES ('2', '9');
INSERT INTO `sys_role_menu` VALUES ('2', '90');
INSERT INTO `sys_role_menu` VALUES ('3', '1');
INSERT INTO `sys_role_menu` VALUES ('3', '10');
INSERT INTO `sys_role_menu` VALUES ('3', '11');
INSERT INTO `sys_role_menu` VALUES ('3', '12');
INSERT INTO `sys_role_menu` VALUES ('3', '13');
INSERT INTO `sys_role_menu` VALUES ('3', '14');
INSERT INTO `sys_role_menu` VALUES ('3', '15');
INSERT INTO `sys_role_menu` VALUES ('3', '16');
INSERT INTO `sys_role_menu` VALUES ('3', '17');
INSERT INTO `sys_role_menu` VALUES ('3', '18');
INSERT INTO `sys_role_menu` VALUES ('3', '19');
INSERT INTO `sys_role_menu` VALUES ('3', '2');
INSERT INTO `sys_role_menu` VALUES ('3', '20');
INSERT INTO `sys_role_menu` VALUES ('3', '21');
INSERT INTO `sys_role_menu` VALUES ('3', '22');
INSERT INTO `sys_role_menu` VALUES ('3', '27');
INSERT INTO `sys_role_menu` VALUES ('3', '28');
INSERT INTO `sys_role_menu` VALUES ('3', '29');
INSERT INTO `sys_role_menu` VALUES ('3', '3');
INSERT INTO `sys_role_menu` VALUES ('3', '30');
INSERT INTO `sys_role_menu` VALUES ('3', '4');
INSERT INTO `sys_role_menu` VALUES ('3', '5');
INSERT INTO `sys_role_menu` VALUES ('3', '56');
INSERT INTO `sys_role_menu` VALUES ('3', '57');
INSERT INTO `sys_role_menu` VALUES ('3', '58');
INSERT INTO `sys_role_menu` VALUES ('3', '59');
INSERT INTO `sys_role_menu` VALUES ('3', '6');
INSERT INTO `sys_role_menu` VALUES ('3', '62');
INSERT INTO `sys_role_menu` VALUES ('3', '67');
INSERT INTO `sys_role_menu` VALUES ('3', '68');
INSERT INTO `sys_role_menu` VALUES ('3', '7');
INSERT INTO `sys_role_menu` VALUES ('3', '71');
INSERT INTO `sys_role_menu` VALUES ('3', '79');
INSERT INTO `sys_role_menu` VALUES ('3', '8');
INSERT INTO `sys_role_menu` VALUES ('3', '80');
INSERT INTO `sys_role_menu` VALUES ('3', '81');
INSERT INTO `sys_role_menu` VALUES ('3', '82');
INSERT INTO `sys_role_menu` VALUES ('3', '83');
INSERT INTO `sys_role_menu` VALUES ('3', '84');
INSERT INTO `sys_role_menu` VALUES ('3', '88');
INSERT INTO `sys_role_menu` VALUES ('3', '89');
INSERT INTO `sys_role_menu` VALUES ('3', '9');
INSERT INTO `sys_role_menu` VALUES ('3', '90');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '0b2ebd4d639e4c2b83c2dd0764522f24');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '0ca004d6b1bf4bcab9670a5060d82a55');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '1');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '10');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '11');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '12');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '13');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '14');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '15');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '16');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '17');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '18');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '19');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '2');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '20');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '21');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '22');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '27');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '28');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '29');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '3');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '30');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '3c92c17886944d0687e73e286cada573');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '4');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '4855cf3b25c244fb8500a380db189d97');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '5');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '56');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '57');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '58');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '59');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '6');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '62');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '67');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '68');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '7');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '71');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '79');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '8');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '80');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '81');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '82');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '84');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '88');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '89');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '9');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', '90');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'afab2db430e2457f9cf3a11feaa8b869');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'b1f6d1b86ba24365bae7fd86c5082317');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'ba8092291b40482db8fe7fc006ea3d76');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'c2e4d9082a0b4386884a0b203afe2c5c');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'd15ec45a4c5449c3bbd7a61d5f9dd1d2');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'df7ce823c5b24ff9bada43d992f373e2');
INSERT INTO `sys_role_menu` VALUES ('5f55fd93be3f4981a4f96bf781228ccb', 'f7039bd02cdc4c24865b766b2af13776');
INSERT INTO `sys_role_menu` VALUES ('6', '0b2ebd4d639e4c2b83c2dd0764522f24');
INSERT INTO `sys_role_menu` VALUES ('6', '0ca004d6b1bf4bcab9670a5060d82a55');
INSERT INTO `sys_role_menu` VALUES ('6', '1');
INSERT INTO `sys_role_menu` VALUES ('6', '10');
INSERT INTO `sys_role_menu` VALUES ('6', '11');
INSERT INTO `sys_role_menu` VALUES ('6', '12');
INSERT INTO `sys_role_menu` VALUES ('6', '13');
INSERT INTO `sys_role_menu` VALUES ('6', '14');
INSERT INTO `sys_role_menu` VALUES ('6', '15');
INSERT INTO `sys_role_menu` VALUES ('6', '16');
INSERT INTO `sys_role_menu` VALUES ('6', '17');
INSERT INTO `sys_role_menu` VALUES ('6', '18');
INSERT INTO `sys_role_menu` VALUES ('6', '19');
INSERT INTO `sys_role_menu` VALUES ('6', '2');
INSERT INTO `sys_role_menu` VALUES ('6', '20');
INSERT INTO `sys_role_menu` VALUES ('6', '21');
INSERT INTO `sys_role_menu` VALUES ('6', '22');
INSERT INTO `sys_role_menu` VALUES ('6', '27');
INSERT INTO `sys_role_menu` VALUES ('6', '28');
INSERT INTO `sys_role_menu` VALUES ('6', '29');
INSERT INTO `sys_role_menu` VALUES ('6', '3');
INSERT INTO `sys_role_menu` VALUES ('6', '30');
INSERT INTO `sys_role_menu` VALUES ('6', '3c92c17886944d0687e73e286cada573');
INSERT INTO `sys_role_menu` VALUES ('6', '4');
INSERT INTO `sys_role_menu` VALUES ('6', '4855cf3b25c244fb8500a380db189d97');
INSERT INTO `sys_role_menu` VALUES ('6', '5');
INSERT INTO `sys_role_menu` VALUES ('6', '56');
INSERT INTO `sys_role_menu` VALUES ('6', '57');
INSERT INTO `sys_role_menu` VALUES ('6', '58');
INSERT INTO `sys_role_menu` VALUES ('6', '59');
INSERT INTO `sys_role_menu` VALUES ('6', '6');
INSERT INTO `sys_role_menu` VALUES ('6', '62');
INSERT INTO `sys_role_menu` VALUES ('6', '67');
INSERT INTO `sys_role_menu` VALUES ('6', '68');
INSERT INTO `sys_role_menu` VALUES ('6', '7');
INSERT INTO `sys_role_menu` VALUES ('6', '71');
INSERT INTO `sys_role_menu` VALUES ('6', '79');
INSERT INTO `sys_role_menu` VALUES ('6', '8');
INSERT INTO `sys_role_menu` VALUES ('6', '80');
INSERT INTO `sys_role_menu` VALUES ('6', '81');
INSERT INTO `sys_role_menu` VALUES ('6', '82');
INSERT INTO `sys_role_menu` VALUES ('6', '84');
INSERT INTO `sys_role_menu` VALUES ('6', '88');
INSERT INTO `sys_role_menu` VALUES ('6', '89');
INSERT INTO `sys_role_menu` VALUES ('6', '9');
INSERT INTO `sys_role_menu` VALUES ('6', '90');
INSERT INTO `sys_role_menu` VALUES ('6', 'afab2db430e2457f9cf3a11feaa8b869');
INSERT INTO `sys_role_menu` VALUES ('6', 'b1f6d1b86ba24365bae7fd86c5082317');
INSERT INTO `sys_role_menu` VALUES ('6', 'ba8092291b40482db8fe7fc006ea3d76');
INSERT INTO `sys_role_menu` VALUES ('6', 'c2e4d9082a0b4386884a0b203afe2c5c');
INSERT INTO `sys_role_menu` VALUES ('6', 'd15ec45a4c5449c3bbd7a61d5f9dd1d2');
INSERT INTO `sys_role_menu` VALUES ('6', 'df7ce823c5b24ff9bada43d992f373e2');
INSERT INTO `sys_role_menu` VALUES ('7', '1');
INSERT INTO `sys_role_menu` VALUES ('7', '27');
INSERT INTO `sys_role_menu` VALUES ('7', '28');
INSERT INTO `sys_role_menu` VALUES ('7', '29');
INSERT INTO `sys_role_menu` VALUES ('7', '30');
INSERT INTO `sys_role_menu` VALUES ('7', '56');
INSERT INTO `sys_role_menu` VALUES ('7', '57');
INSERT INTO `sys_role_menu` VALUES ('7', '58');
INSERT INTO `sys_role_menu` VALUES ('7', '59');
INSERT INTO `sys_role_menu` VALUES ('7', '62');
INSERT INTO `sys_role_menu` VALUES ('7', '71');
INSERT INTO `sys_role_menu` VALUES ('7', '88');
INSERT INTO `sys_role_menu` VALUES ('7', '89');
INSERT INTO `sys_role_menu` VALUES ('7', '90');
INSERT INTO `sys_role_menu` VALUES ('7', 'f7039bd02cdc4c24865b766b2af13776');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '1');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '27');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '28');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '29');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '30');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '56');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '57');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '58');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '59');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '62');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '71');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '88');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '89');
INSERT INTO `sys_role_menu` VALUES ('d5d1f0092ddd469ab0ff1a9c622671d3', '90');

-- ----------------------------
-- Table structure for sys_role_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_office`;
CREATE TABLE `sys_role_office` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-机构';

-- ----------------------------
-- Records of sys_role_office
-- ----------------------------
INSERT INTO `sys_role_office` VALUES ('7', '10');
INSERT INTO `sys_role_office` VALUES ('7', '11');
INSERT INTO `sys_role_office` VALUES ('7', '12');
INSERT INTO `sys_role_office` VALUES ('7', '13');
INSERT INTO `sys_role_office` VALUES ('7', '14');
INSERT INTO `sys_role_office` VALUES ('7', '15');
INSERT INTO `sys_role_office` VALUES ('7', '16');
INSERT INTO `sys_role_office` VALUES ('7', '17');
INSERT INTO `sys_role_office` VALUES ('7', '18');
INSERT INTO `sys_role_office` VALUES ('7', '19');
INSERT INTO `sys_role_office` VALUES ('7', '20');
INSERT INTO `sys_role_office` VALUES ('7', '21');
INSERT INTO `sys_role_office` VALUES ('7', '22');
INSERT INTO `sys_role_office` VALUES ('7', '23');
INSERT INTO `sys_role_office` VALUES ('7', '24');
INSERT INTO `sys_role_office` VALUES ('7', '25');
INSERT INTO `sys_role_office` VALUES ('7', '26');
INSERT INTO `sys_role_office` VALUES ('7', '7');
INSERT INTO `sys_role_office` VALUES ('7', '8');
INSERT INTO `sys_role_office` VALUES ('7', '9');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `company_id` varchar(64) NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `no` varchar(100) DEFAULT NULL COMMENT '工号',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `user_type` char(1) DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', '2', 'thinkgem', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0001', '系统管理员', 'thinkgem@163.com', '8675', '8675', null, '', '0:0:0:0:0:0:0:1', '2017-08-11 10:23:31', '1', '1', '2013-05-27 08:00:00', '1', '2017-08-08 17:00:07', '最高管理员', '0');
INSERT INTO `sys_user` VALUES ('10', '7', '11', 'jn_jsb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0010', '济南技术部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('11', '12', '13', 'lc_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0011', '济南历城领导', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('12', '12', '18', 'lx_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0012', '济南历下领导', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('13', '22', '23', 'gx_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0013', '济南高新领导', null, null, null, null, null, '0:0:0:0:0:0:0:1', '2017-06-13 15:11:49', '1', '1', '2013-05-27 08:00:00', '1', '2017-06-13 15:09:49', null, '0');
INSERT INTO `sys_user` VALUES ('2', '1', '2', 'sd_admin', '5d32d990527a134cd55e1293ae8210cc628e42836859e4e368fe1934', '0002', '管理员', null, null, null, null, null, '0:0:0:0:0:0:0:1', '2017-08-09 11:21:16', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('3', '1', '3', 'sd_zhb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0003', '综合部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('4', '1', '4', 'sd_scb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0004', '市场部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('5', '1', '5', 'sd_jsb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0005', '技术部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('6', '1', '6', 'sd_yfb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0006', '研发部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('7', '7', '6', 'jn_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0007', '济南领导', '', '', '15998521443', null, '', '0:0:0:0:0:0:0:1', '2017-06-13 17:13:56', '1', '1', '2013-05-27 08:00:00', '1', '2017-08-09 11:20:36', '', '0');
INSERT INTO `sys_user` VALUES ('8', '7', '9', 'jn_zhb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0008', '济南综合部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_user` VALUES ('9', '7', '10', 'jn_scb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0009', '济南市场部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('1', '2');
INSERT INTO `sys_user_role` VALUES ('10', '2');
INSERT INTO `sys_user_role` VALUES ('11', '3');
INSERT INTO `sys_user_role` VALUES ('12', '4');
INSERT INTO `sys_user_role` VALUES ('13', '5');
INSERT INTO `sys_user_role` VALUES ('13', '6');
INSERT INTO `sys_user_role` VALUES ('14', '6');
INSERT INTO `sys_user_role` VALUES ('2', '1');
INSERT INTO `sys_user_role` VALUES ('3', '2');
INSERT INTO `sys_user_role` VALUES ('4', '3');
INSERT INTO `sys_user_role` VALUES ('5', '4');
INSERT INTO `sys_user_role` VALUES ('6', '5');
INSERT INTO `sys_user_role` VALUES ('7', '2');
INSERT INTO `sys_user_role` VALUES ('7', '7');
INSERT INTO `sys_user_role` VALUES ('8', '2');
INSERT INTO `sys_user_role` VALUES ('9', '1');

-- ----------------------------
-- Table structure for test_data
-- ----------------------------
DROP TABLE IF EXISTS `test_data`;
CREATE TABLE `test_data` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `user_id` varchar(64) DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `in_date` datetime DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务数据表';

-- ----------------------------
-- Records of test_data
-- ----------------------------
INSERT INTO `test_data` VALUES ('0a766e8e9d6b488c8af8741c0d1764a1', '6', '6', '5', '测试2', '2', '2017-08-08 23:59:30', '1', '2017-08-09 15:13:28', '1', '2017-08-09 15:25:41', '测试2', '1');
INSERT INTO `test_data` VALUES ('ada6ffa7420a48449003bb4e60a4b36f', '2', '2', '6', '测试表', '1', '2017-08-11 00:01:00', '1', '2017-08-09 15:12:45', '1', '2017-08-09 15:25:50', '测试表', '0');

-- ----------------------------
-- Table structure for test_data_child
-- ----------------------------
DROP TABLE IF EXISTS `test_data_child`;
CREATE TABLE `test_data_child` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `test_data_main_id` varchar(64) DEFAULT NULL COMMENT '业务主表ID',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_child_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务数据子表';

-- ----------------------------
-- Records of test_data_child
-- ----------------------------
INSERT INTO `test_data_child` VALUES ('1cd92cfd61094c59835e7b293954c752', '5c5440cb1ad841e6a2c86195fc4cc952', '11', '1', '2017-08-09 16:22:42', '1', '2017-08-09 16:22:42', '11', '1');
INSERT INTO `test_data_child` VALUES ('6d130807610f4032b987bc4a754e0ee9', '5c5440cb1ad841e6a2c86195fc4cc952', '22', '1', '2017-08-09 16:23:12', '1', '2017-08-09 16:23:12', '22', '1');
INSERT INTO `test_data_child` VALUES ('904f07f6885f4d36a38ebf20fa97da98', '5c5440cb1ad841e6a2c86195fc4cc952', '33', '1', '2017-08-09 16:23:32', '1', '2017-08-09 16:23:32', '33', '1');
INSERT INTO `test_data_child` VALUES ('dd5656cdfbf3460abf4d57bee02b0197', '5c5440cb1ad841e6a2c86195fc4cc952', '44', '1', '2017-08-09 16:23:32', '1', '2017-08-09 16:23:32', '44', '1');

-- ----------------------------
-- Table structure for test_data_main
-- ----------------------------
DROP TABLE IF EXISTS `test_data_main`;
CREATE TABLE `test_data_main` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `user_id` varchar(64) DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `in_date` datetime DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_main_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务数据表';

-- ----------------------------
-- Records of test_data_main
-- ----------------------------
INSERT INTO `test_data_main` VALUES ('5c5440cb1ad841e6a2c86195fc4cc952', '2', '2', '6', '测试1', '1', '2017-08-09 15:31:44', '1', '2017-08-09 15:33:01', '1', '2017-08-09 16:23:32', '测试1', '1');

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS `test_tree`;
CREATE TABLE `test_tree` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_tree_del_flag` (`del_flag`),
  KEY `test_data_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='树结构表';

-- ----------------------------
-- Records of test_tree
-- ----------------------------
INSERT INTO `test_tree` VALUES ('04f641cc353247809cfaa4d8e7039a30', '3421b62d6dd54708a636085f58155dde', '0,3421b62d6dd54708a636085f58155dde,', '55', '30', '1', '2017-08-09 17:30:30', '1', '2017-08-09 17:30:30', '', '0');
INSERT INTO `test_tree` VALUES ('3421b62d6dd54708a636085f58155dde', '0', '0,', '11', '30', '1', '2017-08-09 17:30:18', '1', '2017-08-09 17:30:25', '22', '0');
