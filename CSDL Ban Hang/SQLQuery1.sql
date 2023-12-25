create table HangHoa (
	HangHoaID int primary key identity,
	TenMatHang nvarchar(50),
	NhaSanXuat nvarchar(100),
	XuatXu nvarchar(20),
	GiaNhap money,
	GiaBan money,
	NgaySanXuat date
)
go

create table BanHang (
	BanHangID int primary key identity,
	HangHoaID int references HangHoa(HangHoaID),
	ChuThich ntext,
	NgayBan date,
	SoLuong int
)
go

insert into HangHoa(TenMatHang, NhaSanXuat, XuatXu, GiaNhap, GiaBan, NgaySanXuat)
values
('Thit ga', 'CN', 'Viet Nam', 10000, 15000, '2000-10-10'),
('Thit ga', 'CN', 'Trung Quoc', 8000, 10000, '2000-10-10'),
('Thit bo', 'CN', 'Viet Nam', 18000, 20000, '2000-10-10'),
('Thit lon', 'CN', 'Viet Nam', 15000, 18000, '2000-10-10'),
('Thit bo ', 'CN', 'My', 25000, 30000, '2000-10-10'),
('Ca hoi', 'CN', 'Uc', 20000, 25000, '2000-10-10'),
('Ca hoi', 'CN', 'Nhat', 25000, 30000, '2000-10-10'),
('Cua hoang de', 'CN', 'Nhat', 35000, 40000, '2000-10-10'),
('Cua hoang de', 'CN', 'Han Quoc', 30000, 38000, '2000-10-10'),
('Trung', 'CN', 'Viet Nam', 3000, 5000, '2000-10-10')

insert into BanHang(HangHoaID, ChuThich, NgayBan, SoLuong)
values
(1, '', '2000-12-12', 10),
(2, '', '2000-12-12', 15),
(3, '', '2000-12-12', 5),
(4, '', '2000-12-12', 8),
(5, '', '2000-12-12', 3),
(6, '', '2000-12-12', 5),
(7, '', '2000-12-12', 5),
(8, '', '2000-12-12', 10),
(9, '', '2000-12-12', 10),
(10, '', '2000-12-12', 20)
go

select * 
from BanHang
go

select * 
from HangHoa, BanHang
where HangHoa.HangHoaID = BanHang.HangHoaID and HangHoa.XuatXu = 'Viet Nam'
go

select HangHoa.TenMatHang, BanHang.SoLuong ,HangHoa.GiaBan * BanHang.SoLuong as TongGiaBan
from HangHoa, BanHang
where HangHoa.HangHoaID = BanHang.HangHoaID
go