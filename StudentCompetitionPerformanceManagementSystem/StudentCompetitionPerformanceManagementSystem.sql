/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018-10-18 10:05:51                          */
/*==============================================================*/


drop table if exists administrator;

drop table if exists competition;

drop table if exists grade;

drop table if exists groupStage;

drop table if exists judgment;

drop table if exists student;

drop table if exists user;

/*==============================================================*/
/* Table: administrator                                         */
/*==============================================================*/
create table administrator
(
   userId               int not null comment '用户的主键ID（用于唯一地标识表中的某一条记录）',
   name                 varchar(20) not null comment '姓名',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(15) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   remark               int comment '详情描述、备注',
   password             varchar(30) not null comment '密码',
   primary key (userId)
);

alter table administrator comment '管理员';

/*==============================================================*/
/* Table: competition                                           */
/*==============================================================*/
create table competition
(
   competitionId        int not null comment '竞赛的主键',
   competition          varchar(30) not null comment '竞赛名称',
   start                timestamp not null comment '开始时间',
   end                  timestamp not null comment '结束时间',
   remark               int not null comment '详情描述、备注',
   primary key (competitionId)
);

alter table competition comment '竞赛';

/*==============================================================*/
/* Table: grade                                                 */
/*==============================================================*/
create table grade
(
   gradeId              int not null comment '成绩表主键ID',
   groupId              int not null comment '小组赛的主键ID',
   userId               int not null comment '用户的主键ID（用于唯一地标识表中的某一条记录）',
   stu_userId           int not null comment '用户的主键ID（用于唯一地标识表中的某一条记录）',
   grade                float(10) not null comment '成绩分数',
   remark               int comment '详情描述、备注',
   primary key (gradeId)
);

alter table grade comment '成绩';

/*==============================================================*/
/* Table: groupStage                                            */
/*==============================================================*/
create table groupStage
(
   groupId              int not null comment '小组赛的主键ID',
   competitionId        int not null comment '竞赛的主键',
   groupStage           varchar(30) not null comment '小组赛名称',
   start                timestamp not null comment '开始时间',
   end                  timestamp not null comment '结束时间',
   remark               int comment '详情描述、备注',
   primary key (groupId)
);

alter table groupStage comment '小组赛：一个竞赛可能分为好几个小组赛';

/*==============================================================*/
/* Table: judgment                                              */
/*==============================================================*/
create table judgment
(
   userId               int not null comment '用户的主键ID（用于唯一地标识表中的某一条记录）',
   name                 varchar(20) not null comment '姓名',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(15) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   remark               int comment '详情描述、备注',
   judgmentNumber       int not null comment '裁判编号',
   primary key (userId)
);

alter table judgment comment '裁判/打分员';

/*==============================================================*/
/* Table: student                                               */
/*==============================================================*/
create table student
(
   userId               int not null comment '用户的主键ID（用于唯一地标识表中的某一条记录）',
   name                 varchar(20) not null comment '姓名',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(15) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   remark               int comment '详情描述、备注',
   studentNumber        int not null comment '学号',
   school               varchar(20) not null comment '学校',
   major                varchar(20) not null comment '专业',
   primary key (userId)
);

alter table student comment '学生';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   userId               int not null comment '用户的主键ID（用于唯一地标识表中的某一条记录）',
   name                 varchar(20) not null comment '姓名',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(15) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   remark               int comment '详情描述、备注',
   primary key (userId)
);

alter table user comment '用户';

alter table administrator add constraint FK_AdministratorInheritanceUser foreign key (userId)
      references user (userId) on delete restrict on update restrict;

alter table grade add constraint FK_GradeRelationshipGroupStage foreign key (groupId)
      references groupStage (groupId) on delete restrict on update restrict;

alter table grade add constraint FK_JudgmentRelationshipGrade foreign key (userId)
      references judgment (userId) on delete restrict on update restrict;

alter table grade add constraint FK_StudentRelationshipGrade foreign key (stu_userId)
      references student (userId) on delete restrict on update restrict;

alter table groupStage add constraint FK_CompetitionRelationshipGroupStage foreign key (competitionId)
      references competition (competitionId) on delete restrict on update restrict;

alter table judgment add constraint FK_JudgmentInheritanceUser foreign key (userId)
      references user (userId) on delete restrict on update restrict;

alter table student add constraint FK_StudentInheritanceUser foreign key (userId)
      references user (userId) on delete restrict on update restrict;

