--Tao table
create table Hotel (
	HoteL_ID int identity(1,1),
	Hotel_Name nvarchar(50),
	Hotel_Address nvarchar(200),
	Hotel_Area float,
	Hotel_Owner nvarchar(50)
)
go

create table Room (
	Room_No nvarchar(20),
	Room_ID_Hotel int,
	Room_Area float,
	Room_Type nvarchar(20),
	Room_Floor nvarchar(15)
)
go

create table Book (
	Book_ID int identity(1,1),
	Book_Room_No nvarchar(20),
	Book_CheckIn date,
	Book_CheckOut date,
	Book_Price money
)
go

--Nhap du lieu
insert into Hotel(Hotel_Name, Hotel_Address, Hotel_Area, Hotel_Owner)
values
('A1', '54 Le Thanh Nghi', '200', 'A'),
('A2', '285 Doi Can', '300', 'A'),
('A3', '12 Tran Duy Hung', '50', 'B')

insert into Room(Room_No, Room_ID_Hotel, Room_Area, Room_Type, Room_Floor)
values
('R001', 1, 20, 'NORMAL', 1),
('R002', 1, 15, 'VIP', 2),
('R003', 1, 30, 'VIP', 2),
('K001', 2, 20, 'NORMAL', 1),
('K002', 2, 20, 'VIP', 2)

insert into Book(Book_Room_No, Book_CheckIn, Book_CheckOut, Book_Price)
values
('R001', '2021-01-15 10:00:00', '2021-01-16 18:00:00', 100),
('R001', '2021-03-02 10:00:00', '2021-03-04 18:00:00', 500),
('R002', '2021-02-05 10:00:00', '2021-02-06 18:00:00', 200),
('R002', '2021-01-15 10:00:00', '2021-01-16 18:00:00', 150),
('K001', '2021-02-15 10:00:00', '2021-02-16 18:00:00', 200),
('K002', '2021-02-15 10:00:00', '2021-02-16 18:00:00', 300),
('R003', '2021-02-15 10:00:00', '2021-02-16 18:00:00', 800)

--Tao primary key
alter table Hotel
add constraint PK_Hotel_ID primary key (Hotel_ID)
go

alter table Room
add constraint PK_Room_No primary key (Room_No)
go

alter table Book
add constraint PK_Book_ID primary key (Book_ID)
go

--Tao foreign key

alter table Room
add constraint FK_Room_ID_Hotel foreign key (Room_ID_Hotel) references Hotel(Hotel_ID)
go

alter table Book
add constraint FK_Book_Room_No foreign key (Book_Room_No) references Room(Room_No)
go

--Hien thi tat ca du lieu khanh san
select distinct Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', Room.Room_No 'Ma Phong', Room.Room_Type 'Loai Phong' , Room.Room_Floor 'Tang'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
go

--Hien thi nhung phong co dien tich 30m2 tro len
select distinct Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', Room.Room_No 'Ma Phong', Room.Room_Type 'Loai Phong' , Room.Room_Floor 'Tang'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
and Room.Room_Area >= 30
go

--Thong ke theo du lieu tat ca
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', count(Room.Room_No) 'So phong'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
go

--Thong ke theo du lieu so phong tren 5
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', count(Room.Room_No) 'So phong'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
having  count(Room.Room_No) >= 5
order by 'So phong' desc
go

--Thong ke theo du lieu dien tich phong lon nhat
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', max(Room.Room_Area) 'Dien tich phong'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
go

--Thong ke theo du lieu dien tich phong nho nhat
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', min(Room.Room_Area) 'Dien tich phong'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
go

--Thong ke theo du lieu tong dien tich tat ca cac phong 
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', sum(Room.Room_Area) 'Tong dien tich tat ca cac phong'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
go

--Thong ke theo du lieu dien tich trung binh tat ca cac phong 
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', avg(Room.Room_Area) 'Tong dien tich tat ca cac phong'
from Hotel, Room
where Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
go

--Thong ke theo du lieu khanh san khong co phong
select Hotel.Hotel_Name 'Ten KS', Hotel.Hotel_Address 'Dia Chi', count(Room.Room_No) 'So phong'
from Hotel left join Room
on Hotel.HoteL_ID = Room.Room_ID_Hotel
group by Hotel.Hotel_Name, Hotel.Hotel_Address
having  count(Room.Room_No) = 0
go