use saleData

insert
into root
values('admin','admin')

select * from root

delete
from root
where pwd='admin'

select * 
from root 
where [user]='admin';

select *
from root
where [user]='admin' and pwd='admin'

select *
from root
where [user] ='lint' and pwd = 'lint'

select * from Customer

insert
into Product
values('AHK23568','���͵��','��','M',1200.00)
insert
into Product
values('AHK23567','���͵��','��','M',1240.00)
insert
into Product
values('AHK23566','���ػ�','��','L',160000.00)
insert
into Product
values('AOK23568','������','��','M',1200.00)
insert
into Product
values('AOK23564','·����','Tink','M',1200.00)
select * from Product

insert
into Supplier
values('SKH00001','�ɴ�','��¬','0734-2356891','���Ϻ���','123@fox.com','123325')

insert
into Supplier
values('SKH00002','����','�ɺ�','0734-2356890','���ϳ�ɳ','127@fox.com','123324')

select * from Supplier

insert
into Inventory
values('AAA00022','SKH00002','AOK23564',120.00,20,0)

insert
into Inventory
values('AAA00021','SKH00002','AOK23568',120.00,20,0)

insert
into Inventory
values('AAA00020','SKH00002','AHK23566',120.00,20,0)

insert
into Inventory
values('AAA00019','SKH00001','AHK23567',120.00,20,0)

insert
into Inventory
values('AAA00018','SKH00001','AHK23566',120.00,20,0)

select * from Inventory

insert
into PurchaseOrder
values('A201812A','AHK23568','00000001','SKH00002',20,2018-12-12)

select * from PurchaseOrder

insert
into Customer
values('AA002342','¬','�Ŷ�','15236982365','���Ϻ���','20@qq.com','15236982365',10)

insert
into Customer
values('AA002340','��','����','15236982323','���Ϻ���','25@qq.com','15236982323',8)

select * from Customer

insert
into Sale
values('S201812A','AHK23568','00000001','AA002342',20,2018-12-12)

insert
into Sale
values('S201812B','AOK23568','00000001','AA002342',60,2018-12-27)

insert
into Sale
values('S201812C','AOK23564','00000001','AA002342',80,2018-12-27)

select * from Sale

insert
into CustomerOpinion
values('CO00A001','AA002342',2018-12-20,'����')

insert
into CustomerOpinion
values('CO00A002','AA002342',2018-12-20,'��������')

insert
into CustomerOpinion
values('CO00A002','AA002342',2018-12-20,'��������')

insert
into CustomerOpinion
values('CO00A003','AA002340',2018-12-20,'����')

select * from CustomerOpinion
select * from Customer

select COnum,company,contactName,tel,COresume
from Customer,CustomerOpinion
where Customer.Cnum=CustomerOpinion.Cnum

select COnum,company,contactName,tel,COresume 
from Customer, CustomerOpinion 
where Customer.Cnum = CustomerOpinion.Cnum and (company like '%d%' or COnum like '%f%' )

insert 
into CustomerOpinion(COnum,Cnum,COresume)  
values('C000B005','AA002341','VERY GOOD')

update CustomerOpinion
set COresume='date up up'
where COnum='C000B003'

update CustomerOpinion 
set COresume = 'date up up up'
 where COnum = 'C000B003'


select * from Sale
select Snum,Pname,Ename,company,quantity,POdate
from Sale,Employee,Product,Customer
where Sale.Pnum=Product.Pnum and Sale.Enum=Employee.Enum and Sale.Cnum=Customer.Cnum

select * from tt

use saleData

 create table dbname
(Snum char(8), 
Pname varchar(20),
 Ename varchar(20), 
 company varchar(16), 
 quantity int, 
 POdate datetime)

 insert into dbname( Snum, Pname, Ename, company, quantity)
values('00', '00', '00', '0', '0')

 drop table tt

 select * from tt

select * from Customer where company='¬'

select * from Product

select * from Sale 

update Product 
set  Pname='QI',brand='E',model='E',salePrice=10.2 
where  Pnum = 'AHK23566'