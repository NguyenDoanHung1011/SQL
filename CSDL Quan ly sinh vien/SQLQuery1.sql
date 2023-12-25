create table tblStudent (
	RollNo nvarchar(5) not null,
	Fullname nvarchar(30),
	Age int,
	Address ntext,
	Email nvarchar(100),
	PhoneNumber nvarchar(15),
	Gender nvarchar(10)
)
go

create table tblSubject (
	SubjectID nvarchar(10) not null,
	SubjectName nvarchar(20)
)
go

create table tblMark (
	Mark int,
	RollNo nvarchar(5) not null,
	SubjectID nvarchar(10) not null,
)
go

create table tblClass (
	ClassID nvarchar(10),
	ClassName nvarchar(10)
)
go

create table tblRoom (
	RoomName nvarchar(10),
	RoomID nvarchar(10),
	RoomTable int,
	RoomChair int,
	RoomAddress ntext
)
go

alter table tblStudent
add constraint PK_tblSinhVien_RollNo primary key (RollNo)
go

alter table tblSubject
add constraint PK_tblSubject_SubjectID primary key (SubjectID)
go

alter table tblMark
add constraint FK_tblMark_RollNo foreign key (RollNo) references tblSinhVien(RollNo)
go

alter table tblMark
add constraint FK_tblMark_SubjectID foreign key (SubjectID) references tblSubject(SubjectID)
go

insert into tblStudent values
	('001','Nguyen Van A',20,'12 street ha noi','a@gmail.com',0921063488,'nam'),
	('002','Nguyen Van B',20,'12 street ha noi','b@gmail.com',0921063488,'nam'),
	('003','Nguyen Van C',20,'12 street ha noi','c@gmail.com',0921063488,'nam'),
	('004','Nguyen Van D',20,'12 street ha noi','d@gmail.com',0921063488,'nam'),
	('005','Nguyen Van E',20,'12 street ha noi','e@gmail.com',0921063488,'nam')
go

insert into tblSubject values
	('A1','CNTT'),
	('A2','QTDL'),
	('A3','KTCT'),
	('A4','QTKD'),
	('A5','NNA')
go

insert into tblMark values
	(10,'001',1),
	(7,'001',1),
	(8,'002',2),
	(9,'003',3),
	(5,'004',4)
go

insert into tblClass values
	('A','R001'),
	('B','R001'),
	('C','R002'),
	('D','R003'),
	('E','R005')
go

insert into tblRoom values
	('1', 'B001', 7,20,'5'),
	('2', 'B002', 10,30,'2'),
	('3', 'B003', 3,10,'5'),
	('4', 'B004', 15,20,'1'),
	('5', 'B005', 5,15,'8')
go

select * from tblStudent
select * from tblSubject
select * from tblMark
select * from tblClass
select * from tblRoom

select tblRoom.RoomID, tblRoom.RoomName, tblRoom.RoomAddress, tblRoom.RoomTable, tblRoom.RoomChair
from tblRoom
where tblRoom.RoomTable > 5 
and tblRoom.RoomChair > 5
go

select tblRoom.RoomID, tblRoom.RoomName, tblRoom.RoomAddress, tblRoom.RoomTable, tblRoom.RoomChair
from tblRoom
where tblRoom.RoomTable between 5 and 20 
and tblRoom.RoomChair between 5 and 20
go