

/* Drop Tables */

DROP TABLE oa_notify_record;
DROP TABLE oa_notify;




/* Create Tables */

CREATE TABLE oa_notify
(
	id varchar(64) NOT NULL,
	type char(1),
	title varchar(200),
	content varchar(2000),
	files varchar(2000),
	status char(1),
	create_by varchar(64) NOT NULL,
	create_date datetime NOT NULL,
	update_by varchar(64) NOT NULL,
	update_date datetime NOT NULL,
	remarks varchar(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE oa_notify_record
(
	id varchar(64) NOT NULL,
	oa_notify_id varchar(64),
	user_id varchar(64),
	read_flag char(1) DEFAULT '0',
	read_date smalldatetime,
	PRIMARY KEY (id)
);



/* Create Indexes */

CREATE INDEX oa_notify_del_flag ON oa_notify (del_flag ASC);
CREATE INDEX oa_notify_record_notify_id ON oa_notify_record (oa_notify_id ASC);
CREATE INDEX oa_notify_record_user_id ON oa_notify_record (user_id ASC);
CREATE INDEX oa_notify_record_read_flag ON oa_notify_record (read_flag ASC);



