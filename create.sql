/*
产品 产品编号，产品名称，品牌，型号，销售价
库存 库存编号，供应商编号，进货价，库存量，已销售量
供应商 供应商编号，供应商名称，联系人姓名，电话，地址，email，微信号
采购订单 采购订单号，产品编号，员工编号，供应商编号，订购数量，订购日期
销售订单 销售订单号，产品编号，员工编号，客户编号，订购数量，销售日期

部门 部门编号，部门名称，部门主管，备注
员工 员工编号，部门编号，姓名，性别，出生年月，聘用日期，离职日期，工资，简历
客户 客户编号，公司名称，联系人姓名，电话，地址，email，微信号，信用等级
客户意见 意见编号，客户编号，日期，内容

Product Pnum,Pname,brand,model,salePrice
Inventory Inum,Snum,Pnum,purchasePrice,Iquantity,saledQuantity
Supplier Snum,Sname,contactName,tel,addr,email,wechat
PurchaseOrder POnum,Pnum,Enum,Snum,quantity,date
Sale Snum,Pnum,Enum,Cnum,quantity,date

Department Dnum,Dname,leader,remarks
Employee Enum,Dnum,Ename,sex,birth,employmentDate,departureDate,salary,resume
Customer Cnum,company,contactName,tel,addr,email,wechat,credit
CustomerOpinion COnum,Cnum,date,content
*/
create database saleData
on primary(
	name=saleData,
	filename='F:\Myself\2018-2019-1\dbms\课程设计\DATA\saleData.mdf',
	size=10mb,
	maxsize=unlimited,
	filegrowth=10%
)
log on(
	name=saleLog,
	filename='F:\Myself\2018-2019-1\dbms\课程设计\DATA\saleLog.ldf',
	size=1mb,
	maxsize=10mb,
	filegrowth=1mb
)

use saleData

--构建数据表
--产品信息表Product
go
create table Product(
	Pnum char(8) primary key,
	Pname varchar(20) not null,
	brand varchar(15) not null,
	model varchar(15),
	salePrice float not null
)
--供应商信息表Supplier
go
create table Supplier(
	Snum char(8) primary key,
	Sname varchar(20) not null,
	contactName varchar(20) not null,
	tel varchar(16) check(len(tel)>=7 and len(tel)<=16),--添加电话号码长度约束
	addr varchar(30),
	email varchar(20) check(email like '%@%'),--添加邮箱约束
	wechat varchar(20)
)
--库存信息表Inventory
go
create table Inventory(
	Inum char(8) primary key,
	Snum char(8),
	Pnum char(8),
	puchasePrice float not null,
	Iquantity int,
	saleduantity int,
	foreign key(Snum) references Supplier(Snum),
	foreign key(Pnum) references Product(Pnum)
)

--drop table Inventory

--部门信息表Department
create table Department(
	Dnum char(8) primary key,
	Dname varchar(20),
	leader char(8),
	remarks char(8)
)

--员工信息表Employee
create table Employee(
	Enum char(8) primary key,
	Dnum char(8),
	Ename varchar(20) not null,
	sex char(2) default '男' check(sex='男' or sex='女'),
	birth datetime,
	employmentDate datetime default getdate(),
	departureDate datetime,
	salary float,
	resume text,
	foreign key(Dnum) references Department(Dnum)
)

--采购订单信息表PurchaseOrder
go
create table PurchaseOrder(
	POnum char(8) primary key,
	Pnum char(8),
	Enum char(8),
	Snum char(8),
	quantity int,
	POdate datetime,
	foreign key(Pnum) references Product(Pnum),
	foreign key(Enum) references Employee(Enum),
	foreign key(Snum) references Supplier(Snum)
)

--客户信息表Customer
go
create table Customer(
	Cnum char(8) primary key,
	company varchar(16) not null,
	contactName varchar(20),
	tel varchar(16),
	addr varchar(30),
	email varchar(20),
	wechat varchar(20),
	credit int
)

--销售订单信息表Sale
go
create table Sale(
	Snum char(8) primary key,
	Pnum char(8),
	Enum char(8),
	Cnum char(8),
	quantity int,
	POdate datetime,
	foreign key(Pnum) references Product(Pnum),
	foreign key(Enum) references Employee(Enum),
	foreign key(Cnum) references Customer(Cnum)
)

--客户意见信息表CustomerOpinion
go
create table CustomerOpinion(
	COnum char(8) primary key,
	Cnum char(8),
	COdate datetime default getdate(),
	COresume text,
	foreign key(Cnum) references Customer(Cnum)
)

--合同
go
create table Pact(
	num char(8) primary key,
	pay int,--1表示付款
	delivery int,--1表示交付
	foreign key(num) references Sale(Snum)
)

select * from Sale
select * from Customer
select * from Employee
select * from Department
select * from Pact

select Sale.Snum,pay,delivery,quantity*puchasePrice as 'price',POdate
from Sale,Inventory,Pact
where Sale.Snum=Pact.num and Sale.Pnum=Inventory.Pnum 

insert
into Pact
values('S201812A',1,1)

insert
into Pact
values('S201812B',1,0)

insert
into Pact
values('S201812C',0,0)

insert
into Department
values('0000001','市场部','admin','test')

insert
into Employee(Enum,Dnum,Ename,birth)
values('00000001','0000001','赵老汉',2000-01-01)
