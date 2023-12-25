--tao database
create database StudentManagementSystem

--dung database
use StudentManagementSystem

--tao bang
create table Class (
	ClassId int not null,
	ClassCode nvarchar(50)
)
go

create table Student (
	StudentId int not null,
	StudentName nvarchar(50),
	BirthDate date,
	ClassId int
)
go

create table Subject (
	SubjectId int not null,
	SubjectName nvarchar(100),
	SessionCount int
)
go

create table Result (
	StudentId int not null,
	SubjectId int not null,
	Mark int
)
go

--tao index
create nonclustered index NCI_Student_StudentName on Student(StudentName)
go

--doi loai du lieu
alter table Result
alter column Mark float
go

--them primary key
alter table Class
add constraint PK_Class primary key (ClassId)
go

alter table Student
add constraint PK_Student primary key (StudentId)
go

alter table Subject
add constraint PK_Subject primary key (SubjectId)
go

alter table Result
add constraint PK_Result primary key (StudentId, SubjectId)
go

--them foreign key
alter table Student
add constraint FK_Student_Class foreign key (ClassId) references Class(ClassId)
go

alter table Result
add constraint FK_Result_Student foreign key (StudentId) references Student(StudentId)
go

alter table Result
add constraint FK_Result_Subject foreign key (SubjectId) references Subject(SubjectId)
go

--tao check
alter table Subject
add constraint CK_Subject_SessionCount check (SessionCount > 0) 
go

--dien du lieu
insert into Class
values
	(1, 'C1106KV'),
	(2, 'C1108GV'),
	(3, 'C1108IV'),
	(4, 'C1108HV'),
	(5, 'C1109GV')
go

insert into Student
values
	(1, 'PhamTuanAnh', '1993-08-05', 1),
	(2, 'PhanVanHuy', '1992-06-10', 1),
	(3, 'NguyenHoangMinh', '1992-09-07', 2),
	(4, 'TranTuanTu', '1993-10-10', 2),
	(5, 'DoAnhTai', '1992-06-06', 3)
go

insert into Subject
values
	(1, 'C Programming', 22),
	(2, 'Web Design', 18),
	(3, 'Database Management', 23)
go

insert into Result
values
	(1, 1, 8),
	(1, 2, 7),
	(2, 3, 5),
	(3, 2, 6),
	(4, 3, 9),
	(5, 2, 8)
go

select Student.StudentId MaSinhVien, Student.StudentName TenSinhVien, Student.BirthDate NgaySinh
from Student
where Student.BirthDate between '1992-10-10' and '1993-10-10'
go

select Class.ClassId MaLop, Class.ClassCode TenLop, COUNT(Student.StudentId) SiSoLop
from Class left join Student
on Class.ClassId = Student.ClassId
group by Class.ClassId, Class.ClassCode 
go

select Student.StudentId MaSinhVien, Student.StudentName TenSinhVien, SUM(Result.Mark) TongDiem
from Student, Result
where Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName 
having SUM(Result.Mark) > 10
go