SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS sys_job;
DROP TABLE IF EXISTS sys_job_log;


/* Create Tables */

CREATE TABLE sys_job (
  id varchar(64) NOT NULL COMMENT '任务id',
  bean_name varchar(100) NOT NULL COMMENT 'bean名称',
  method_name varchar(100) NOT NULL COMMENT '方法名',
  params varchar(100) COMMENT '参数',
  cron_expression varchar(100) NOT NULL COMMENT 'cron表达式',
  status char(1) NOT NULL COMMENT '任务状态（0：正常，1：暂停）',
  remark varchar(255) COMMENT '备注',
  create_date datetime NOT NULL COMMENT '创建时间',
  update_date datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) COMMENT='定时任务';

CREATE TABLE sys_job_log (
  id varchar(64) NOT NULL COMMENT '任务日志id',
  job_id varchar(64) NOT NULL COMMENT '任务id',
  bean_name varchar(100) COMMENT 'bean名称',
  method_name varchar(100) COMMENT '方法名',
  params varchar(100) COMMENT '参数',
  status char(1) NOT NULL COMMENT '任务状态（0：成功，1：失败）',
  error_info varchar(2000) COMMENT '失败信息',
  cost_time int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  create_date datetime COMMENT '创建时间',
  PRIMARY KEY (id)
) COMMENT='定时任务日志';

/* Create Indexes */

CREATE INDEX job_bean_name ON sys_job (bean_name ASC);
CREATE INDEX job_method_name ON sys_job (method_name ASC);
CREATE INDEX job_status ON sys_job (status ASC);
CREATE INDEX job_log_bean_name ON sys_job_log (bean_name ASC);
CREATE INDEX job_log_method_name ON sys_job_log (method_name ASC);
CREATE INDEX job_log_status ON sys_job_log (status ASC);