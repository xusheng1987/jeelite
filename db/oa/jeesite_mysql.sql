SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS oa_notify_record;
DROP TABLE IF EXISTS oa_notify;




CREATE TABLE oa_notify
(
	id varchar(64) NOT NULL COMMENT '编号',
	type char(1) COMMENT '类型',
	title varchar(200) COMMENT '标题',
	content varchar(2000) COMMENT '内容',
	files varchar(2000) COMMENT '附件',
	status char(1) COMMENT '状态',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) COMMENT = '通知通告';


CREATE TABLE oa_notify_record
(
	id varchar(64) NOT NULL COMMENT '编号',
	oa_notify_id varchar(64) COMMENT '通知通告ID',
	user_id varchar(64) COMMENT '接受人',
	read_flag char(1) DEFAULT '0' COMMENT '阅读标记',
	read_date date COMMENT '阅读时间',
	PRIMARY KEY (id)
) COMMENT = '通知通告发送记录';




/* Create Indexes */

CREATE INDEX oa_notify_del_flag ON oa_notify (del_flag ASC);
CREATE INDEX oa_notify_record_notify_id ON oa_notify_record (oa_notify_id ASC);
CREATE INDEX oa_notify_record_user_id ON oa_notify_record (user_id ASC);
CREATE INDEX oa_notify_record_read_flag ON oa_notify_record (read_flag ASC);



