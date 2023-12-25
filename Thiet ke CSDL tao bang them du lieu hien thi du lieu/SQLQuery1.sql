create table Customer (
		Cust_No nvarchar(10),
		Cust_Name nvarchar(50),
		Phone_No nvarchar(15)
)
go

create table Items (
		Item_No nvarchar(10),
		Description nvarchar(50),
		Price int
)
go

create table Order_Details (
		Ord_No nvarchar(10),
		Item_No nvarchar(10),
		Qty int
)
go

create table Order_August (
		Ord_No nvarchar(15),
		Ord_Date nvarchar(20),
		Cust_No nvarchar(10)
)
go

insert into Customer(Cust_No, Cust_Name, Phone_No)
values
(N'001', N'David Gordon', N'0231-5466356'),
(N'002', N'Prince Fernandes', N'0221-5762382'),
(N'003', N'Charles Yale', N'0321-8734723'),
(N'004', N'Ryan Ford', N'0241-2343444'),
(N'005', N'Bruce Smith', N'0241-8472198')
go

insert into Items(Item_No, Description, Price)
values
(N'HW!', N'Power Supply', 4000),
(N'HW2', N'Key Board', 2000),
(N'HW3', N'Mouse', 800),
(N'SW1', N'Office Suite', 15000),
(N'SW2', N'Payroll Software', 8000)
go

insert into Order_Details(Ord_No, Item_No, Qty)
values
(N'101', N'HW3', 50),
(N'101', N'SW1', 150),
(N'102', N'HW2', 10),
(N'103', N'HW3', 50),
(N'104', N'HW2', 25),
(N'104', N'HW3', 100),
(N'105', N'SW1', 100)
go

insert into Order_August(Ord_No, Ord_Date, Cust_No)
values
(N'101', N'02-08-12', N'001'),
(N'102', N'11-08-12', N'002'),
(N'103', N'21-08-12', N'003'),
(N'104', N'28-08-12', N'004'),
(N'105', N'30-08-12', N'005')
go

select * from Customer
select * from Items
select * from Order_Details
select * from Order_August