
/* DROP TABLES */

DROP TABLE sys_job;
DROP TABLE sys_job_log;




/* CREATE TABLES */

-- 定时任务表
CREATE TABLE sys_job (
	id VARCHAR2(64) NOT NULL,
	bean_name VARCHAR2(100) NOT NULL,
	method_name VARCHAR2(100) NOT NULL,
	params VARCHAR2(100),
	cron_expression VARCHAR2(100) NOT NULL,
	status CHAR(1) NOT NULL,
	remark NVARCHAR2(255),
	create_date TIMESTAMP NOT NULL,
	update_date TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
);

-- 定时任务日志表
CREATE TABLE sys_job_log (
	id VARCHAR2(64) NOT NULL,
	job_id VARCHAR2(64) NOT NULL,
	bean_name VARCHAR2(100),
	method_name VARCHAR2(100),
	params VARCHAR2(100),
	status CHAR(1) NOT NULL,
	error_info VARCHAR2(2000),
	cost_time NUMBER(10,0) NOT NULL,
	create_date TIMESTAMP,
	PRIMARY KEY (id)
);


/* CREATE INDEXES */

CREATE INDEX job_bean_name ON sys_job (bean_name);
CREATE INDEX job_method_name ON sys_job (method_name);
CREATE INDEX job_status ON sys_job (status);
CREATE INDEX job_log_bean_name ON sys_job_log (bean_name);
CREATE INDEX job_log_method_name ON sys_job_log (method_name);
CREATE INDEX job_log_status ON sys_job_log (status);

/* COMMENTS */

COMMENT ON TABLE sys_job IS '定时任务表';
COMMENT ON COLUMN sys_job.bean_name IS 'bean名称';
COMMENT ON COLUMN sys_job.method_name IS '方法名';
COMMENT ON COLUMN sys_job.params IS '参数';
COMMENT ON COLUMN sys_job.cron_expression IS 'cron表达式';
COMMENT ON COLUMN sys_job.status IS '任务状态（0：正常，1：暂停）';
COMMENT ON COLUMN sys_job.remark IS '备注';
COMMENT ON COLUMN sys_job.create_date IS '创建时间';
COMMENT ON COLUMN sys_job.update_date IS '更新时间';
COMMENT ON TABLE sys_job_log IS '定时任务日志表';
COMMENT ON COLUMN sys_job_log.job_id IS '任务id';
COMMENT ON COLUMN sys_job_log.bean_name IS 'bean名称';
COMMENT ON COLUMN sys_job_log.method_name IS '方法名';
COMMENT ON COLUMN sys_job_log.params IS '参数';
COMMENT ON COLUMN sys_job_log.status IS '任务状态（0：成功，1：失败）';
COMMENT ON COLUMN sys_job_log.error_info IS '失败信息';
COMMENT ON COLUMN sys_job_log.cost_time IS '耗时(单位：毫秒)';
COMMENT ON COLUMN sys_job_log.create_date IS '创建时间';