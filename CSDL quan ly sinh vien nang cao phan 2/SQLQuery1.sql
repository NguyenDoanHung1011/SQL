create table Student (
	rollno nvarchar(10) primary key,
	fullname nvarchar(20),
	age int,
	address nvarchar(100),
	email nvarchar(50),
	phonenumber nvarchar(15),
	gender nvarchar(10)
)
go

create table Subject (
	subjectid nvarchar(10) primary key,
	subjectname nvarchar(10)
)
go

create table Mark (
	mark int,
	rollno nvarchar(10) references Student(rollno),
	subjectid nvarchar(10) references Subject(subjectid)
)
go

create table Class (
	classid nvarchar(10) primary key,
	classname nvarchar(10)
)
go

create table ClassManager (
	classid nvarchar(10) references Class(classid),
	rollno nvarchar(10) references Student(rollno)
)
go

create table Room (
	roomname nvarchar(10),
	roomid nvarchar(10) primary key,
	roomtable int,
	roomchair int,
	roomoaddress nvarchar(100)
)
go

create table BookClass (
	subjectid nvarchar(10) references Subject(subjectid),
	classid nvarchar(10) references Class(classid),
	startclass nvarchar(10),
	endclass nvarchar(10),
	roomid nvarchar(10) references Room(roomid)
)
go

insert into Student(rollno, fullname, age, address, email, phonenumber, gender) values
	(N'001', N'Tran Van A', 18, N'a', N'a@gmail.com', N'1234567890', N'Male'),
	(N'002', N'Nguyen Thi B', 17, N'b', N'b@gmail.com', N'2234567890', N'Female'),
	(N'003', N'Tran Van C', 15, N'c', N'c@gmail.com', N'3234567890', N'Male'),
	(N'004', N'Tran Van D', 20, N'd', N'd@gmail.com', N'4234567890', N'Male'),
	(N'005', N'Nguyen Thi E', 28, N'e', N'e@gmail.com', N'5234567890', N'Female')
go

insert into Subject(subjectid, subjectname) values
	('C201', 'CNTT'),
	('C202', 'QTKD'),
	('C203', 'KTCT'),
	('C204', 'NNA'),
	('C205', 'TRIET')
go

insert into Mark(mark, rollno, subjectid) values
	(10, '001', 'C201'),
	(9, '002', 'C202'),
	(8, '003', 'C203'),
	(7, '004', 'C204'),
	(6, '005', 'C205')
go

insert into Class(classid, classname) values
	('C2010L', 'CNTT'),
	('C2011L', 'QTKD'),
	('C2012L', 'KTCT'),
	('C2013L', 'NNA'),
	('C2014L', 'TRIET')
go

insert into ClassManager(classid, rollno) values
	('C2010L', N'001'),
	('C2011L', N'001'),
	('C2012L', N'002'),
	('C2013L', N'002'),
	('C2014L', N'003')
go

insert into Room(roomname, roomid, roomtable, roomchair, roomoaddress) values
	('P-CNTT', 'cntt', 5, 20, 'tang 5'),
	('P-QTKD', 'qtkd', 5, 20, 'tang 6'),
	('P-KTCT', 'ktct', 5, 20, 'tang 7'),
	('P-NNA', 'nna', 5, 20, 'tang 8'),
	('P-TRIET', 'triet', 5, 20, 'tang 9')
go

insert into BookClass(subjectid, classid, startclass, endclass, roomid) values
	('C201', 'C2010L', 6, 8, 'cntt'),
	('C202', 'C2011L' ,6, 8, 'qtkd'),
	('C203', 'C2012L', 6, 8, 'ktct'),
	('C204', 'C2013L', 6, 8, 'nna'),
	('C205', 'C2014L', 6, 8, 'triet')
go

select * from Student
select * from Subject
select * from Mark
select * from Class
select * from ClassManager

select * 
from Student
where Student.address = 'Nam Dinh'
go

select * 
from Class
where Class.classid = 'A8'
go

select Student.rollno, Student.fullname, Mark.mark
from Student, Mark
where Student.rollno = Mark.rollno and Student.fullname = 'Tran Van A'
go

select Student.rollno, Student.fullname, Mark.mark
from Student, Mark
where Student.rollno = Mark.rollno
go

select Student.rollno, Student.fullname, Mark.mark, Subject.subjectname
from Student, Mark, Subject
where Student.rollno = Mark.rollno and Mark.subjectid = Subject.subjectid
go