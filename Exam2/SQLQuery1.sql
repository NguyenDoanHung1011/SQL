create database ProductManagementSystem

use ProductManagementSystem

create table tblUser (
	UserID int not null,
	UserName nvarchar(50)
)
go

create table tblOrder (
	OrderID int not null,
	UserID int not null,
	OrderDate datetime
)
go

create table tblProduct (
	ProductID int not null,
	ProductName nvarchar(50),
	Quantity int,
	Price money,
	Description Ntext
)
go

create table tblOrderDetail (
	OrderID int not null,
	ProductID int not null,
	Quantity int,
	Price money
)
go

create clustered index CI_tblUser_UserID on tblUser(UserID)
go

drop index CI_tblUser_UserID on tblUser(UserID)
go

alter table tblUser
add BirthDate datetime
go

alter table tblOrder
add constraint DF_tblOrder_OrderDate default getdate() for OrderDate
go

alter table tblUser
add constraint PK_tblUser primary key (UserID)
go

alter table tblOrder
add constraint PK_tblOrder primary key (OrderID)
go

alter table tblProduct
add constraint PK_tblProduct primary key (ProductID)
go

alter table tblOrderDetail
add constraint PK_tblOrderDetail primary key (OrderID, ProductID)
go

alter table tblOrder
add constraint PK_tblOrder_tblUser foreign key (UserID) references tblUser(UserID)
go

alter table tblOrderDetail
add constraint PK_tblOrderDetail_tblOrder foreign key (OrderID) references tblOrder(OrderID)
go

alter table tblOrderDetail
add constraint PK_tblOrderDetail_tblProduct foreign key (ProductID) references tblProduct(ProductID)
go

alter table tblOrderDetail
add constraint CK_tblOrder_tblOrderDate check (OrderDate between '2000-01-01' and getdate())
go

alter table tblUser
add constraint UN_tblUser_UserName unique (UserName)
go

insert into tblUser(UserID, UserName, BirthDate) values
	(1, 'stevejobs', 1996-08-28),
	(2, 'billgates', 1998-06-18),
	(3, 'larry', 1997-05-25),
	(4, 'mark', 1984-03-27),
	(5, 'dell', 1955-08-15),
	(6, 'eric', 1955-07-28)
go

insert into tblOrder(OrderID, UserID, OrderDate) values
	(1, 2, 2002-12-01),
	(2, 3, 2000-03-02),
	(3, 2, 2004-08-03),
	(4, 1, 2001-05-12),
	(5, 4, 2002-10-04),
	(6, 6, 2002-03-08),
	(7, 5, 2002-05-02)
go

insert into tblProduct(ProductID, ProductName, Quantity, Price, Description) values
	(1, N'Asus Zen', 2, 10, N'See what others cant see'),
	(2, 'BPhone', 10, 20, N'The first flat-design smartphone in the world'),
	(3, 'iPhone', 13, 300, N'The only thing thats changed is everything'),
	(4, 'XPeria', 7, 80, N'The worlds first 4K smartphone'),
	(5, N'Galaxy Note', 12, 120, N'Created to reflect your desire.')
go

insert into tblOrderDetail(OrderID, ProductID, Quantity, Price) values
	(1, 1, 10, 10),
	(1, 2, 4, 20),
	(2, 3, 5, 50),
	(3, 3, 6, 80),
	(4, 2, 21, 120),
	(5, 2, 122, 300)
go

update tblProduct set Price = Price * 0.9 where ProductID = 3

select tblUser.UserID, tblUser.UserName, tblOrder.OrderID, tblOrder.OrderDate, tblOrderDetail.Quantity, tblOrderDetail.Price, tblProduct.ProductName 
from tblOrder left join tblUser on tblUser.UserID = tblOrder.UserID
			right join tblOrderDetail on tblOrder.OrderID = tblOrderDetail.OrderID
			left join tblProduct on tblOrderDetail.ProductID = tblProduct.ProductID
go

create view [view_Top2Product]
as
select top(2) tblProduct.ProductID, tblProduct.ProductName, tblProduct.Price, SUM(tblOrderDetail.Quantity) as TotalQuantity
from tblOrderDetail left join tblProduct on tblOrderDetail.ProductID = tblProduct.ProductID
group by tblProduct.ProductID, tblProduct.ProductName, tblProduct.Price
order by TotalQuantity desc
go

create proc [sp_TimSanPham]
	@GiaMua money,
	@count int output
as
begin 
	select tblProduct.ProductID, tblProduct.ProductName, tblProduct.Quantity, tblProduct.Price, tblProduct.Description
	from tblProduct
	where tblProduct.Price <= @GiaMua

	select @count = count(*)
		from tblProduct
		where tblProduct.Price <= @GiaMua
end

declare @count int
exec sp_TimSanPham 50, @count = @count output
print N'Tim thay ' + CONVERT(nvarchar(20), @count) + ' san pham'

create trigger TG_tblUser_Update on tblUser
for update
as
begin
	if update(UserName)
	begin 
		print N'You dont update the column UserName!'
		rollback transaction
	end
end