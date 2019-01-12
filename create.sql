/*
��Ʒ ��Ʒ��ţ���Ʒ���ƣ�Ʒ�ƣ��ͺţ����ۼ�
��� ����ţ���Ӧ�̱�ţ������ۣ����������������
��Ӧ�� ��Ӧ�̱�ţ���Ӧ�����ƣ���ϵ���������绰����ַ��email��΢�ź�
�ɹ����� �ɹ������ţ���Ʒ��ţ�Ա����ţ���Ӧ�̱�ţ�������������������
���۶��� ���۶����ţ���Ʒ��ţ�Ա����ţ��ͻ���ţ�������������������

���� ���ű�ţ��������ƣ��������ܣ���ע
Ա�� Ա����ţ����ű�ţ��������Ա𣬳������£�Ƹ�����ڣ���ְ���ڣ����ʣ�����
�ͻ� �ͻ���ţ���˾���ƣ���ϵ���������绰����ַ��email��΢�źţ����õȼ�
�ͻ���� �����ţ��ͻ���ţ����ڣ�����

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
	filename='F:\Myself\2018-2019-1\dbms\�γ����\DATA\saleData.mdf',
	size=10mb,
	maxsize=unlimited,
	filegrowth=10%
)
log on(
	name=saleLog,
	filename='F:\Myself\2018-2019-1\dbms\�γ����\DATA\saleLog.ldf',
	size=1mb,
	maxsize=10mb,
	filegrowth=1mb
)

use saleData

--�������ݱ�
--��Ʒ��Ϣ��Product
go
create table Product(
	Pnum char(8) primary key,
	Pname varchar(20) not null,
	brand varchar(15) not null,
	model varchar(15),
	salePrice float not null
)
--��Ӧ����Ϣ��Supplier
go
create table Supplier(
	Snum char(8) primary key,
	Sname varchar(20) not null,
	contactName varchar(20) not null,
	tel varchar(16) check(len(tel)>=7 and len(tel)<=16),--��ӵ绰���볤��Լ��
	addr varchar(30),
	email varchar(20) check(email like '%@%'),--�������Լ��
	wechat varchar(20)
)
--�����Ϣ��Inventory
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

--������Ϣ��Department
create table Department(
	Dnum char(8) primary key,
	Dname varchar(20),
	leader char(8),
	remarks char(8)
)

--Ա����Ϣ��Employee
create table Employee(
	Enum char(8) primary key,
	Dnum char(8),
	Ename varchar(20) not null,
	sex char(2) default '��' check(sex='��' or sex='Ů'),
	birth datetime,
	employmentDate datetime default getdate(),
	departureDate datetime,
	salary float,
	resume text,
	foreign key(Dnum) references Department(Dnum)
)

--�ɹ�������Ϣ��PurchaseOrder
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

--�ͻ���Ϣ��Customer
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

--���۶�����Ϣ��Sale
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

--�ͻ������Ϣ��CustomerOpinion
go
create table CustomerOpinion(
	COnum char(8) primary key,
	Cnum char(8),
	COdate datetime default getdate(),
	COresume text,
	foreign key(Cnum) references Customer(Cnum)
)

--��ͬ
go
create table Pact(
	num char(8) primary key,
	pay int,--1��ʾ����
	delivery int,--1��ʾ����
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
values('0000001','�г���','admin','test')

insert
into Employee(Enum,Dnum,Ename,birth)
values('00000001','0000001','���Ϻ�',2000-01-01)
