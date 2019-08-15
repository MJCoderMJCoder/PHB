/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018-09-27 21:08:23                          */
/*==============================================================*/


drop trigger tib_travelroute;

drop trigger tib_vehicle;

drop table if exists administrator;

drop table if exists driverGuide;

drop table if exists travelDestination;

drop table if exists travelDestination_travelRoute;

drop table if exists travelRoute;

drop table if exists traveller;

drop table if exists user;

drop table if exists vehicle;

/*==============================================================*/
/* Table: administrator                                         */
/*==============================================================*/
create table administrator
(
   administratorId      int not null comment '管理员主键',
   name                 varchar(10) not null comment '姓名/景点名称',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(11) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   password             varchar(20) not null comment '密码',
   primary key (administratorId)
);

alter table administrator comment '管理员';

/*==============================================================*/
/* Table: driverGuide                                           */
/*==============================================================*/
create table driverGuide
(
   driverGuideId        int not null comment '司机、导游的主键',
   vehicleId            int comment '交通工具主键',
   name                 varchar(10) not null comment '姓名/景点名称',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(11) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   vehicleForeign       int comment '外键：对应交通工具的主键',
   role                 varchar(10) not null comment '角色：司机、导游',
   primary key (driverGuideId),
   key AK_vehicleForeign (vehicleForeign)
);

alter table driverGuide comment '司机、导游';

/*==============================================================*/
/* Table: travelDestination                                     */
/*==============================================================*/
create table travelDestination
(
   travelDestinationId  int not null comment '旅游目的地（景点）实体的主键',
   name                 varchar(10) not null comment '姓名/景点名称',
   price                float(8) not null comment '价格',
   country              varchar(10) not null comment '国家',
   province             varchar(10) comment '省份、州',
   city                 varchar(10) comment '市、城市',
   districts            varchar(10) comment '县、区',
   address              varchar(10) not null comment '地址详情',
   relationshipForeign  int comment '关系外键',
   primary key (travelDestinationId),
   key AK_relationshipForeign (relationshipForeign)
);

alter table travelDestination comment '旅游目的地、景点';

/*==============================================================*/
/* Table: travelDestination_travelRoute                         */
/*==============================================================*/
create table travelDestination_travelRoute
(
   travelRouteId        int not null comment '旅游线路实体的主键',
   travelDestinationId  int not null comment '旅游目的地（景点）实体的主键',
   relationshipId       int not null comment '关系主键',
   remark               varchar(15) comment '备注',
   primary key (travelRouteId, travelDestinationId)
);

alter table travelDestination_travelRoute comment '旅游目的地、景点和旅游线路的关系';

/*==============================================================*/
/* Table: travelRoute                                           */
/*==============================================================*/
create table travelRoute
(
   travelRouteId        int not null comment '旅游线路实体的主键',
   vehicleId            int not null comment '交通工具主键',
   name                 varchar(10) not null comment '姓名/景点名称',
   price                float(8) not null comment '价格',
   relationshipForeign  int not null comment '关系外键',
   primary key (travelRouteId),
   key AK_relationshipForeign (relationshipForeign)
);

alter table travelRoute comment '旅游线路';

/*==============================================================*/
/* Table: traveller                                             */
/*==============================================================*/
create table traveller
(
   travellerId          int not null comment '旅客实体的主键',
   travelRouteId        int not null comment '旅游线路实体的主键',
   name                 varchar(10) not null comment '姓名/景点名称',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(11) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号',
   travelRouteForeign   int comment '外键：对应旅游线路的主键',
   primary key (travellerId),
   key AK_travelRouteForeign (travelRouteForeign)
);

alter table traveller comment '旅客实体';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   name                 varchar(10) not null comment '姓名/景点名称',
   gender               char(10) not null comment '性别',
   birthday             timestamp not null comment '出生日期',
   email                varchar(15) not null comment '邮箱',
   phone                varchar(11) not null comment '手机号',
   idNumber             varchar(18) not null comment '身份证号'
);

alter table user comment '用户';

/*==============================================================*/
/* Table: vehicle                                               */
/*==============================================================*/
create table vehicle
(
   vehicleId            int not null comment '交通工具主键',
   travelRouteId        int not null comment '旅游线路实体的主键',
   type                 varchar(5) not null comment '交通工具类型：大巴、飞机、游轮',
   number               varchar(10) not null comment '车牌号、航班号...',
   travelRouteForeign   int comment '外键：对应旅游线路的主键',
   primary key (vehicleId),
   key AK_travelRouteForeign (travelRouteForeign)
);

alter table vehicle comment '交通工具';

alter table administrator add constraint FK_AdministratorInheritanceUser foreign key ()
      references user on delete restrict on update restrict;

alter table driverGuide add constraint FK_DriverGuideInheritanceUser foreign key ()
      references user on delete restrict on update restrict;

alter table driverGuide add constraint FK_driverGuide_vehicle foreign key (vehicleId)
      references vehicle (vehicleId) on delete restrict on update restrict;

alter table travelDestination_travelRoute add constraint FK_belong foreign key (travelDestinationId)
      references travelDestination (travelDestinationId) on delete restrict on update restrict;

alter table travelDestination_travelRoute add constraint FK_contain foreign key (travelRouteId)
      references travelRoute (travelRouteId) on delete restrict on update restrict;

alter table travelRoute add constraint FK_give foreign key (vehicleId)
      references vehicle (vehicleId) on delete restrict on update restrict;

alter table traveller add constraint FK_TravellerInheritanceUser foreign key ()
      references user on delete restrict on update restrict;

alter table traveller add constraint FK_traveller_travelRoute foreign key (travelRouteId)
      references travelRoute (travelRouteId) on delete restrict on update restrict;

alter table vehicle add constraint FK_use foreign key (travelRouteId)
      references travelRoute (travelRouteId) on delete restrict on update restrict;


create trigger tib_travelroute before insert
on travelRoute for each row
begin
end;


create trigger tib_vehicle before insert
on vehicle for each row
begin
end;

