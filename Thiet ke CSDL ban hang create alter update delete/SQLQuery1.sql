--Tao bang
create table Product (
	Product_ID int identity(1,1),
	Product_Title nvarchar(20),
	Product_Thumbnail nvarchar(50),
	Product_Content ntext
)
go

create table Item (
	Item_ID int identity(1,1),
	Item_Name nvarchar(20)
)
go

--Them cot
alter table Product
add Product_Price money,
	Product_Num int,
	Product_CreatedAt date,
	Product_UpdatedAt date,
	Product_Item_ID int
go

--Tao primary key
alter table Product
add constraint PK_Product_ID primary key (Product_ID)
go

alter table Item
add constraint PK_Item_ID primary key (Item_ID)
go

--Tao foreign key
alter table Product
add constraint FK_Product_Item_ID foreign key (Product_Item_ID) references Item(Item_ID)
go

--Them 5 san pham vao bang Product
insert into Product(Product_Title, Product_Thumbnail, Product_Content, Product_Price, Product_Num, Product_CreatedAt, Product_UpdatedAt)
values
	('ao khoac','link','mua dong',10000,25,'2020-04-03','2020-04-05'),
	('quan bo','link','rach mong',20000,15,'2021-04-01','2021-04-04'),
	('ao long vu','link','sieu mong', 0,10,'2015-04-02','2021-04-05'),
	('quan au','link','dang dep',20000,20,'2021-04-1','2021-04-04'),
	('dong phuc','link','cong so',40000,5,'2021-04-03','2021-04-05')
go

--Them 3 san pham vao bang Item
insert into Item(Item_Name)
values
	('do nam'),
	('do nu'),
	('full bo')
go

--Cap nhat gia
update Product set Product_Price = 5000 where Product_Price = 0 or  Product_Price = null
go

--Sua gia ban san pham truoc ngay 2020/06/06
update Product set Product_Price = Product_Price * 0.9 where Product_CreatedAt < '2020-06-06'
go

--Xoa san pham truoc 2016/12/31
delete from Product where Product_CreatedAt < '2016-12-31'
go