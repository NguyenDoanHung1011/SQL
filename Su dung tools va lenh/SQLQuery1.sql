create table students (
	roll_number nvarchar(10) primary key,
	first_name nvarchar(10),
	last_name nvarchar(10),
	subjects nvarchar(15),
	marks int,
)
go

insert into students (roll_number, first_name, last_name, subjects, marks) 
values
(N'1', N'Jones', N'Bill', N'Maths', 84),
(N'2', N'Jones', N'Bill', N'Science', 75),
(N'3', N'Mary', N'Mathew', N'Science', 80)
go

select roll_number 'Roll Number', first_name 'First Name', last_name 'Last Name', subjects 'Subject', marks 'Marks' from students
go