create database RMS
use RMS
go

create table RESTAURANT(
	Name varchar(100) primary key NOT NULL default 'The Taste Hub', --It will set default value if we don't enter restaurant name 
	Location varchar(100) NOT NULL,
	Contact varchar(100) NOT NULL,
	[Opening & Closing Time] varchar(100) NOT NULL,
)

create table MENU(
	[Dish ID] int identity(1,1),
	[Dish Name] varchar(100) primary key,
	Price float Not Null,
	Category varchar(100) default 'Other',
	[Menu of] varchar(100) foreign key references RESTAURANT(Name) ON DELETE set default, --Foreign key from Restuarant table
	CONSTRAINT check_price
    CHECK (Price >= 0)  --It will check price and accepts only if price is 0 or positive.
)

create table CUSTOMER(
	[Customer ID] int identity(0,1) primary key,
	[Customer Name] varchar(100) Not Null,
	Contact varchar(100),
	[Arrived at] varchar(100) foreign key references RESTAURANT(Name) --Foreign key from RESTAURANT table
)

create table EMPLOYEE(
	[Employee ID] varchar(100) primary key Not Null,		
	[Employee Name] varchar(100) Not Null,		
	Gender varchar(100) Not null,				
	Contact varchar(100) Not Null,				
	Salary float default 0.00,					
	Addrress varchar(100),
	Designation varchar(100) Not Null,
	[Employee Of] varchar(100) foreign key references RESTAURANT(Name) ON DELETE set default, --Foreign key from RESTAURANT table
	Constraint check_designation  --It will check designation and accpets only if following values
	CHECK (Designation in ('Manager', 'Cook', 'Waiter', 'Cashier'))
)

create table SUPPLIER(
	[Supplier ID] int identity(1,1) primary key,
	[Supplier Name] varchar(100) Not Null,
	Contact varchar(100) Not Null,
	Payment float default 0.00,
	Addrress varchar(100),
	Constraint check_payment
	CHECK (Payment >= 0)  --It will check payment and will not accept negative value
)

create table INVENTORY(
	[Ingredient Id] int identity(1,1) primary key,
	Name varchar(30) NOT NULL,
	Quantity varchar(100),
	[Supplier ID] int foreign key references SUPPLIER([Supplier ID]),
	[Cook ID Tracking Ing.] varchar(100) foreign key references EMPLOYEE([Employee ID]),
)

create table RTABLES(
	[Table No] int primary key,
	[Table Status] varchar(100) Not Null default 'Not Updated',
	[Customer ID] int foreign key references CUSTOMER([Customer ID]),
	[Restaurant Table] varchar(100) foreign key references RESTAURANT(Name) ON Delete Cascade	
)

create table BOOKING(
	[Booking ID] int identity(1,1) primary key,
	[Date and Time] date Not Null,
	[Customer ID] int foreign key references CUSTOMER([Customer ID]) On delete cascade,
	[Table No] int foreign key references RTABLES([Table No]) On delete Cascade,
	[Booking by] varchar(100) foreign key references EMPLOYEE([Employee ID])
)

create table ORDERS(
	[Order No] int primary key,
	[Dish Ordered] varchar(100) foreign key references MENU([Dish Name]) on delete cascade,
	[Customer ID] int foreign key references CUSTOMER([Customer ID]) on delete cascade,
	[Order Status] varchar(100) default 'Pending',
	[Order Taken By] varchar(100) foreign key references EMPLOYEE([Employee ID]),
	Constraint check_order
	CHECK ([Order No] > 0)  -- It will accept order if order number is positive
)

create table BILL(
	[Receipt No] varchar(100) primary key,
	[Order No] int foreign key references ORDERS([Order No]) on delete cascade,
	[Customer ID] int foreign key references CUSTOMER([Customer ID]),
	Quantity int default 0,
	[Dish Ordered] varchar(100) foreign key references MENU([Dish Name]),
	[Bill/Quantity] float Not Null,
	[Taken by] Varchar(100) foreign key references EMPLOYEE([Employee ID]),
	Constraint check_bill  -- It will check receipt number and quantity and accepts if positive
	CHECK (Quantity > 0 and [Bill/Quantity] > 0)
)

create table Verification(
	Info nvarchar(300)
)


--Inserting values in RESTAURANT Table
insert into RESTAURANT values('The Taste Hub','Faqeerabad','057-2641051','9:00 AM to 12:00 AM')

--Inserting values in MENU Table
insert into MENU values('Chicken Karahi',800.00,'Karahi Section','The Taste Hub')
insert into MENU values('Beef Karahi',1100.00,'Karahi Section','The Taste Hub')
insert into MENU values('Mutton Karahi',1200.00,'Karahi Section','The Taste Hub')
insert into MENU values('Tikka Karahi',900.00,'Karahi Section','The Taste Hub')
insert into MENU values('Chicken Burger',200.00,'Fast Food','The Taste Hub')
insert into MENU values('Zinger Burger',400.00,'Fast Food','The Taste Hub')
insert into MENU values('Beef Burger',350.00,'Fast Food','The Taste Hub')
insert into MENU values('Fish Burger',370.00,'Fast Food','The Taste Hub')
insert into MENU values('Taste Hub Special Burger',500.00,'Karahi Section','The Taste Hub')
insert into MENU values('Taka Tak',100.00,NULL,default)

delete from MENU where [Dish ID]=12
 select * from SUPPLIER
 select * from ORDERS
--Inserting values in CUSTOMER Table
insert into CUSTOMER values('Nil','Nil','The Taste Hub','Nil')
insert into CUSTOMER values('Ali Saleem','03445678985','The Taste Hub','Male')
insert into CUSTOMER values('Muhammad Bilal','03219506151','The Taste Hub','Male')
insert into CUSTOMER values('Aneeka Ajmal','03145635980','The Taste Hub','Female')
insert into CUSTOMER values('Iqbal Ali','03225507656','The Taste Hub','Male')
insert into CUSTOMER values('Hania Amir','03445678985','The Taste Hub','Female')

--Inserting values in EMPLOYEE Table
insert into EMPLOYEE values('MNG-1','Akbar Javed','Male','03030883937',75000.00,'Steet No.5, Block H, Mehria Town','Manager','The Taste Hub')
insert into EMPLOYEE values('CK-1','Asmara Anwar','Female','03106578993',30000.00,'Hosue No.12, Street-6, New Faqeerabad','Cook','The Taste Hub')
insert into EMPLOYEE values('CK-2','Hassan Ali','Male','03338645490',30000.00,'Fazaia Colony, Kamra','Cook','The Taste Hub')
insert into EMPLOYEE values('CK-3','Sadia Khan','Female','03365763632',30000.00,'Karabal Colony, Railway Road, Faqeerabad','Cook','The Taste Hub')
insert into EMPLOYEE values('WT-1','Razzaq Saif','Male','03455766546',20000.00,'Lawrencepur Mills Colony','Waiter','The Taste Hub')
insert into EMPLOYEE values('WT-2','Raima Khan','Female','03105554605',20000.00,'Hattian Road Hazro','Waiter','The Taste Hub')
insert into EMPLOYEE values('WT-3','Sidra Asghar','Female','03091113344',20000.00,'Sohrab Colony, Lawrencepur','Waiter','The Taste Hub')
insert into EMPLOYEE values('WT-4','Alia Khan','Female','03491005584',20000.00,'Peoples Colony, Attock','Waiter','The Taste Hub')
insert into EMPLOYEE values('WT-5','Daud Sheikh','Male','03004501121',20000.00,'New Model Town, Sanjwal','Waiter','The Taste Hub')
insert into EMPLOYEE values('CR-1','Abdur Rehman','Male','03330499891',35000.00,'Near Police Station, Faqeerabad','Cashier','The Taste Hub')
insert into EMPLOYEE values('CR-2','Hafsa Ishfaq','Female','03325606545',35000.00,'House No.47, Bank Road, Lawrencepur','Cashier','The Taste Hub')

--Inserting values in SUPPLIER Table
insert into SUPPLIER values('Shadab Ali','03028814555',15000.00,'Lahore, Pakistan')
insert into SUPPLIER values('Akmal Rizwan','03210943120',18000.00,'Islamabad, Pakistan')
insert into SUPPLIER values('Rashid Khan','03448778779',NULL,NULL)

--Inserting values in INVENTORY Table
insert into INVENTORY values('Tomatoes','10 Kg',1,'CK-1')
insert into INVENTORY values('Onions','15 Kg',1,'CK-1')
insert into INVENTORY values('Bun','100',2,'CK-2')
insert into INVENTORY values('Bread Crumbs','50 Packets',2,'CK-2')
insert into INVENTORY values('Green Chilli','10 Kg',1,'CK-1')
insert into INVENTORY values('Eggs','10 Dozen',2,'CK-3')
insert into INVENTORY values('Meat','10 Kg',2,'CK-3')
insert into INVENTORY values('Chillis',NULL,NULL,NULL)

--Inserting values in RTABLES Table
insert into RTABLES([Table No],[Table Status],[Restaurant Table]) values(1,'Free','The Taste Hub')
insert into RTABLES values(2,'Occupied',1, 'The Taste Hub')
insert into RTABLES values(3,'Occupied',2, 'The Taste Hub')
insert into RTABLES values(7,'Occupied',3, 'The Taste Hub')
insert into RTABLES values(4,'Occupied',4, 'The Taste Hub')
insert into RTABLES([Table No],[Table Status],[Restaurant Table]) values(6,'Free', 'The Taste Hub')
insert into RTABLES values(5,'Occupied',5, 'The Taste Hub')

--Inserting values in BOOKING Table
insert into BOOKING values('2020-12-25',3,7,'MNG-1')
insert into BOOKING values('2020-12-28',1,2,'MNG-1')

--Inserting values in ORDERS Table
insert into ORDERS values(1,'Beef Karahi',1,'Served','WT-1')
insert into ORDERS values(2,'Chicken Karahi',2,'Served','WT-3')
insert into ORDERS values(3,'Chicken Burger',3,'In Process','WT-2')
insert into ORDERS values(4,'Fish Burger',4,default,'WT-4')
insert into ORDERS values(5,'Chicken Karahi',5,'Served','WT-5')

--Inserting values in BILL Table
insert into BILL values('RCP-08',1,1,1,'Beef Karahi',1400.00,'CR-1')
insert into BILL values('RCP-06',2,2,1,'Chicken Karahi',1100.00,'CR-1')
insert into BILL values('RCP-02',3,3,3,'Chicken Burger',200.00,'CR-2')
insert into BILL values('RCP-01',4,4,5,'Fish Burger',400.00,'CR-2')
insert into BILL values('RCP-09',5,5,1,'Chicken Karahi',1100.00,'CR-2')


create proc Show_All
as begin 
select * from RESTAURANT
select * from MENU
select * from CUSTOMER
select * from EMPLOYEE
select * from SUPPLIER
select * from INVENTORY
select * from RTABLES
select * from BOOKING
select * from ORDERS
select * from BILL
end

exec Show_All



--Alter Queries
alter table CUSTOMER  --Adding new Column in CuUSTOMER Table
add Gender varchar(100) Not Null
insert into CUSTOMER values ('ali','86386483863','The Taste Hub','female')

--Default Constraint
alter table RTABLES   --Added Default constraint in RTBALES Table
add constraint df_customer
default 0 for [Customer ID]

--Check Constraint
alter table MENU	  --Dropped Check Constrainst
drop constraint check_price

alter table MENU	  --Added Check Constraint
add constraint check_price
CHECK (Price >= 0)

alter table CUSTOMER     --Dropped Foreign Key 
drop constraint fk_customer_restaurant

alter table CUSTOMER	 --Added foreign key
add constraint fk_customer_restaurant
Foreign Key([Arrived at]) references RESTAURANT(Name) 

alter table MENU
add constraint df_res_name
default 'The Taste Hub' for [Menu of]



--Update Query
--(It will update Manager name, Address, Contact)
update EMPLOYEE set [Employee Name]='Muhammad Bilal', [Contact]='03219506151',
[Addrress]='Railway Road, Near Police Chowki, Faqeerabad'
where [Employee ID]='MNG-1'

update RTABLES set [Table Status]='Reserved'
where [Table No]=7 or [Table No]=2

--Group by, Order by and Aggregate Functions
select sum([Bill/Quantity] * Quantity) [Total Sales] from BILL  --Total sales of all total bills


select [Receipt No],sum([Bill/Quantity] * Quantity) [Total Sales] from BILL 
Group by [Receipt No]
Order by [Receipt No]  --Total Bills w.r.t Receipt No in Ascending Order


select count([Table Status]) [Total Tables],[Table Status] from RTABLES 
Group by [Table Status]   --Total Tables Count with status




--Total Salaries of total employees with designation and total count
select Designation, sum(Salary) as [Total Salary], 
count([Employee ID]) as [Total Employees]
from EMPLOYEE 
group by Designation
Order by [Total Employees] Asc



--Inner Join 
--(It will show complete Bill and Order Details for a customer)
select ORDERS.[Order No],BILL.[Receipt No],CUSTOMER.[Customer Name],
ORDERS.[Dish Ordered],BILL.Quantity,[Order Status],
CUSTOMER.Contact,[Order Taken By],
EMPLOYEE.[Employee Name] as [Waiter Name],
(BILL.[Bill/Quantity] * BILL.Quantity) as [Total Bill],
BILL.[Taken by] as [Bill Taken by]
from ORDERS 
inner join CUSTOMER
on CUSTOMER.[Customer ID] = ORDERS.[Customer ID]
inner join EMPLOYEE
on ORDERS.[Order Taken By] = EMPLOYEE.[Employee ID]
inner join BILL
on ORDERS.[Customer ID] = BILL.[Customer ID]
Order by [Order No]

--(Booking details with Tables for Customer)
select BOOKING.[Date and Time],RTABLES.[Table No],RTABLES.[Table Status],
CUSTOMER.[Customer Name],
CUSTOMER.Contact,CUSTOMER.Gender,EMPLOYEE.[Employee Name] as [Booking by]
from BOOKING
inner join CUSTOMER
on BOOKING.[Customer ID] = CUSTOMER.[Customer ID]
inner join EMPLOYEE
on BOOKING.[Booking by] = EMPLOYEE.[Employee ID]
inner join RTABLES
on BOOKING.[Table No] = RTABLES.[Table No]

--Left Outer Join
select MENU.[Dish Name],MENU.Price,MENU.Category,
RESTAURANT.Name as [Restaurant Name],
RESTAURANT.Contact as [Restaurant Contact]
from MENU
left Outer Join RESTAURANT
on MENU.[Menu of] = RESTAURANT.Name


select INVENTORY.Name,INVENTORY.Quantity,INVENTORY.[Supplier ID],
SUPPLIER.[Supplier Name],SUPPLIER.Contact,SUPPLIER.Payment
from INVENTORY
left outer join SUPPLIER
on INVENTORY.[Supplier ID] = SUPPLIER.[Supplier ID]


--Right Outer Join
select INVENTORY.Name,INVENTORY.Quantity,INVENTORY.[Supplier ID],
SUPPLIER.[Supplier Name],SUPPLIER.Contact,SUPPLIER.Payment
from INVENTORY
right outer join SUPPLIER
on INVENTORY.[Supplier ID] = SUPPLIER.[Supplier ID]


--Full Outer Join
select INVENTORY.Name,INVENTORY.Quantity,INVENTORY.[Supplier ID],
SUPPLIER.[Supplier Name],SUPPLIER.Contact,SUPPLIER.Payment
from INVENTORY
full outer join SUPPLIER
on INVENTORY.[Supplier ID] = SUPPLIER.[Supplier ID]

--Inner join
select BILL.[Order No],BILL.[Receipt No],BILL.[Dish Ordered],
BILL.Quantity,(BILL.[Bill/Quantity] * BILL.Quantity) as [Total Bill]
from BILL
join ORDERS
on BILL.[Order No] = ORDERS.[Order No]
Order by ORDERS.[Order No]


 
 --Creating Procedure
Create procedure spBILL
as begin
select BILL.[Order No],BILL.[Receipt No],BILL.[Dish Ordered],
BILL.Quantity, ORDERS.[Order Taken By], EMPLOYEE.[Employee Name],
(BILL.[Bill/Quantity] * BILL.Quantity) as [Total Bill]
from BILL
inner join ORDERS
on BILL.[Order No] = ORDERS.[Order No]
inner join EMPLOYEE
on ORDERS.[Order Taken By] = EMPLOYEE.[Employee ID]
Order by ORDERS.[Order No]
end

-- showing Bill Procedure
exec spBILL

-- Showing Bill Code for Procedure
sp_helptext spBILL

--Trigger for inserting Customer ID in Customer Table
create trigger Cust_Trig
on CUSTOMER
for insert
as begin
declare @id int
select @id=[Customer ID] from inserted
insert into Verification values ('New Customer is added [' + cast(@id as nvarchar(10))+
'] is added at '+ cast(getdate() as nvarchar(100)))
end

select * from Verification

--Trigger for Delete Customer ID in Customer Table
create trigger Cust_Trig_del
on CUSTOMER
for delete
as begin
declare @id int
select @id=[Customer ID] from deleted
insert into Verification values ('New Customer is removed [' + cast(@id as nvarchar(10))+
'] is removed at '+ cast(getdate() as nvarchar(100)))
end

-- Inserting or Deleting Data Through Trigger
insert into CUSTOMER values('Daud Isakhel','03224332245','The Taste Hub','Male')
delete from CUSTOMER where [Customer ID]=6

select * from CUSTOMER
select * from Verification

-- Update Trigger for Updating values in CUSTOMERS Table
create trigger Cust_Trig_update
on CUSTOMER 
for update
as begin
declare @id int
declare @oldname nvarchar(20),@newname nvarchar(20)
declare @oldgender nvarchar(20),@newgender nvarchar(20)
declare @oldcontact nvarchar(20), @newcontact nvarchar(20)
declare @auditstring nvarchar(900)
begin
set @auditstring=''
select @id=[Customer ID],@newname=[Customer Name],
@newgender=Gender,@oldcontact=Contact
from inserted
select @oldname=[Customer Name],
@oldgender=Gender,@oldcontact=Contact
from deleted where [Customer ID]=@id
set @auditstring ='Customer with ID = '+ cast(@id as nvarchar(4))+' changed '
if(@oldname<>@newname)
 set @auditstring=@auditstring+' name from = '+@oldname+' to = '+@newname
 if(@oldgender<>@newgender)
 set @auditstring=@auditstring+' gender from = '+@oldgender +' to = '+@newgender 
 if(@oldcontact<>@newcontact)
 set @auditstring=@auditstring+' contact from='+@oldcontact+'to='+@newcontact
 insert into Verification values (@auditstring)
end
 end
  
--Updating 
update CUSTOMER set [Customer Name]= 'Mufti Anas' where [Customer ID] = 7
select * from Verification

--When a customer places a new order
create trigger Order_Trig
on ORDERS
for insert
as begin
declare @order_number int
declare @customer_id int
select @order_number=[Order No], @customer_id=[Customer ID] from inserted
insert into Verification values ('Customer ID ' + cast(@customer_id as nvarchar(10)) 
+ ' Placed Order No ' + cast(@order_number as nvarchar(10))+
' at '+ cast(getdate() as nvarchar(100)))
end

insert into ORDERS values(7, 'Tikka Karahi', 8, default, 'WT-2')
select * from ORDERS
select * from Verification

--Status Updation of ORDERS
create trigger Orders_Trig_update
on ORDERS
for update
as begin
declare @id int
declare @oldstatus nvarchar(20),@newstatus nvarchar(20)
declare @auditstring nvarchar(900)
begin
set @auditstring=''
select @id=[Customer ID],@newstatus=[Order Status]
from inserted
select @oldstatus=[Order Status]
from deleted where [Customer ID]=@id
set @auditstring ='Order status for Customer '+ cast(@id as nvarchar(4))+' changed '
if(@oldstatus<>@newstatus)
 set @auditstring= (@auditstring+' status from '+@oldstatus+' to '+@newstatus 
 + ' at '+ cast(getdate() as nvarchar(100)))
 insert into Verification values (@auditstring)
end
 end

update ORDERS set [Order Status]='Served' where [Customer ID]=8
select * from Verification

