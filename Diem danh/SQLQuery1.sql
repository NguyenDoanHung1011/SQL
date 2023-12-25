create table HocVien (
	HocVienID int primary key identity,
	Ten nvarchar(50),
	GioiTinh nvarchar(10),
	NgaySinh date,
	QueQuan nvarchar(20),
	Email nvarchar(50),
	SDT nvarchar(20)
)
go

create table GiaoVien (
	GiaoVienID int primary key identity,
	Ten nvarchar(50),
	GioiTinh nvarchar(10),
	NgaySinh date
)
go

create table MonHoc (
	MonHocID int primary key identity,
	Ten nvarchar(50),
	SoBuoi int,
)
go

create table LopHoc (
	HocVienID int references HocVien(HocVienID),
	LopHocID int primary key identity,
	NgayVao date,
	NgayRa date
)
go

create table Lich (
	LichID int primary key identity,
	GiaoVienID int references GiaoVien(GiaoVienID),
	MonHocID int references MonHoc(MonHocID),
	LopHocID int references LopHoc(LopHocID),
	NgayVao date,
	NgayRa date
)
go

create table DiemDanh (
	DiemDanhID int primary key identity,
	LichID int references Lich(LichID),
	HocVienID int references HocVien(HocVIenID),
	NgayDiemDanh date,
	DiemDanh1 nvarchar(20),
	DiemDanh2 nvarchar(20),
	GhiChu ntext
)
go

insert into HocVien
values
('Tran Van A', 'Nam', '1998-5-10', 'Nam Dinh', 'a@gmail.com', 0585076514),
('Tran Van B', 'Nam', '1991-6-11', 'Ha Noi', 'b@gmail.com', 0585076515),
('Tran Van C', 'Nu', '2000-12-1', 'Ha Noi', 'c@gmail.com', 0585076516),
('Tran Van D', 'Nu', '1998-1-19', 'Hai Phong', 'd@gmail.com', 0585076517),
('Tran Van E', 'Nam', '1998-12-1', 'Sai Gon', 'e@gmail.com', 0585076518)
go

insert into GiaoVien
values
('Nguyen Van A', 'Nam', '1989-06-30'),
('Nguyen Thi A', 'Nu', '1989-05-20'),
('Nguyen Thi B', 'Nu', '1990-12-30'),
('Nguyen Van B', 'Nam', '1989-03-10'),
('Nguyen Thi C', 'Nu', '1989-11-11')
go

insert into MonHoc(Ten, SoBuoi)
values
('Lap Trinh C', 10),
('HTML/CSS/JS', 11),
('SQL Sever', 12),
('Boostrap', 13),
('Jquery', 10)
go

insert into LopHoc
values
(1, '2020-01-12', '2020-02-12'),
(1, '2020-01-12', '2020-02-12'),
(2, '2020-01-12', '2020-02-12'),
(2, '2020-01-12', '2020-02-12'),
(3, '2020-01-12', '2020-02-12')
go

insert into Lich(GiaoVienID, MonHocID, LopHocID, NgayVao, NgayRa)
values
(1, 1, 1, '2018-07-01', '2018-07-30'),
(2, 2, 2, '2018-07-01', '2018-07-30'),
(3, 3, 3, '2018-07-01', '2018-07-30'),
(4, 4, 4, '2018-07-01', '2018-07-30'),
(5, 5, 5, '2018-07-01', '2018-07-30')
go

insert into DiemDanh(LichID, HocVienID, NgayDiemDanh, DiemDanh1, DiemDanh2, GhiChu)
values
(1, 1, '2020-12-09', 'Co', 'Co', ''),
(2, 2, '2020-12-09', 'Khong', 'Co', ''),
(3, 3, '2020-12-09', 'Co', 'Co', ''),
(4, 4, '2020-12-09', 'Co', 'Khong', ''),
(5, 5, '2020-12-09', 'Co', 'Co', '')
go

create proc proc_ThongTinHocVien
	@LopHocID int
as
	select HocVien.Ten
	from HocVien, LopHoc
	where HocVien.HocVienID = LopHoc.HocVienID and LopHoc.LopHocID = @LopHocID
go

exec proc_ThongTinHocVien 1
go

create proc proc_DanhSachDiemDanh
	@LopHocID int,
	@MonHocID int
as
	select LopHoc.LopHocID, MonHoc.Ten, HocVien.Ten, DiemDanh.DiemDanh1, DiemDanh.DiemDanh2
	from MonHoc, HocVien, LopHoc, Lich, DiemDanh
	where LopHoc.LopHocID = Lich.LopHocID
		and Lich.LichID = DiemDanh.LichID 
		and HocVien.HocVienID = DiemDanh.HocVienID
		and MonHoc.MonHocID = Lich.MonHocID
		and Lich.LopHocID = @LopHocID 
		and Lich.MonHocID = @MonHocID
go

exec proc_DanhSachDiemDanh 1, 1