
/* Drop Tables */

DROP TABLE oa_notify_record;
DROP TABLE oa_notify;




/* Create Tables */

CREATE TABLE oa_notify
(
	id varchar2(64) NOT NULL,
	type char(1),
	title nvarchar2(200),
	content nvarchar2(2000),
	files nvarchar2(2000),
	status char(1),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE oa_notify_record
(
	id varchar2(64) NOT NULL,
	oa_notify_id varchar2(64),
	user_id varchar2(64),
	read_flag char(1) DEFAULT '0',
	read_date date,
	PRIMARY KEY (id)
);




/* Create Indexes */

CREATE INDEX oa_notify_del_flag ON oa_notify (del_flag);
CREATE INDEX oa_notify_record_notify_id ON oa_notify_record (oa_notify_id);
CREATE INDEX oa_notify_record_user_id ON oa_notify_record (user_id);
CREATE INDEX oa_notify_record_read_flag ON oa_notify_record (read_flag);



/* Comments */

COMMENT ON TABLE oa_notify IS '通知通告';
COMMENT ON COLUMN oa_notify.id IS '编号';
COMMENT ON COLUMN oa_notify.type IS '类型';
COMMENT ON COLUMN oa_notify.title IS '标题';
COMMENT ON COLUMN oa_notify.content IS '内容';
COMMENT ON COLUMN oa_notify.files IS '附件';
COMMENT ON COLUMN oa_notify.status IS '状态';
COMMENT ON COLUMN oa_notify.create_by IS '创建者';
COMMENT ON COLUMN oa_notify.create_date IS '创建时间';
COMMENT ON COLUMN oa_notify.update_by IS '更新者';
COMMENT ON COLUMN oa_notify.update_date IS '更新时间';
COMMENT ON COLUMN oa_notify.remarks IS '备注信息';
COMMENT ON COLUMN oa_notify.del_flag IS '删除标记';
COMMENT ON TABLE oa_notify_record IS '通知通告发送记录';
COMMENT ON COLUMN oa_notify_record.id IS '编号';
COMMENT ON COLUMN oa_notify_record.oa_notify_id IS '通知通告ID';
COMMENT ON COLUMN oa_notify_record.user_id IS '接受人';
COMMENT ON COLUMN oa_notify_record.read_flag IS '阅读标记';
COMMENT ON COLUMN oa_notify_record.read_date IS '阅读时间';




