--Tao bang
create table QuanLyTrongTai (
	QuanLyTrongTai_ID int identity(1,1),
	QuanLyTrongTai_FullName nvarchar(50) not null,
	QuanLyTrongTai_Address nvarchar(200) not null,
	QuanLyTrongTai_Level float,
	QuanLyTrongTai_Exp date
)
go

create table LichSuBat (
	LichSuBat_ID int identity(1,1),
	LichSuBat_IDTrongTai int,
	LichSuBat_GiaiDau nvarchar(100) not null,
	LichSuBat_NgayBat date,
	LichSuBat_Rate float,
	LichSuBat_ID_Club_1 int,
	LichSuBat_ID_Club_2 int,
	LichSuBat_Note nvarchar(500)
)
go

create table DoiBong (
	DoiBong_ID int identity(1,1),
	DoiBong_TenDoiBong nvarchar(50),
	DoiBong_SanChuNha nvarchar(100),
	DoiBong_HuanLuyenVien nvarchar(50)
)
go

create table CauThu (
	CauThu_ID int identity(1,1),
	CauThu_FullName nvarchar(50),
	CauThu_BirthDay date,
	CauThu_Salary money,
	CauThu_NgayBatDauDa date
)
go

create table DoiBongCauThu (
	DoiBongCauThu_ID_Club int,
	DoiBongCauThu_ID_Player int,
	DoiBongCauThu_NgayThamGiaDoiBong date
)
go

--Primary key
alter table QuanLyTrongTai
add constraint PK_QuanLyTrongTai_ID primary key (QuanLyTrongTai_ID)
go

alter table LichSuBat
add constraint PK_LichSuBat_ID primary key (LichSuBat_ID)
go

alter table DoiBong
add constraint PK_DoiBong_ID primary key (DoiBong_ID)
go

alter table CauThu
add constraint PK_CauThu_ID primary key (CauThu_ID)
go

--Foreign key
alter table LichSuBat
add constraint FK_LichSuBat_IDTrongTai foreign key (LichSuBat_IDTrongTai) references QuanLyTrongTai(QuanLyTrongTai_ID)
go

alter table LichSuBat
add constraint FK_LichSuBat_ID_Club_1 foreign key (LichSuBat_ID_Club_1) references DoiBong(DoiBong_ID)
go

alter table LichSuBat
add constraint FK_LichSuBat_ID_Club_2 foreign key (LichSuBat_ID_Club_2) references DoiBong(DoiBong_ID)
go

alter table DoiBongCauThu
add constraint FK_DoiBongCauThu_ID_Club foreign key (DoiBongCauThu_ID_Club) references DoiBong(DoiBong_ID)
go

alter table DoiBongCauThu
add constraint FK_DoiBongCauThu_ID_Player foreign key (DoiBongCauThu_ID_Player) references CauThu(CauThu_ID)
go

--Nhap du lieu
insert into QuanLyTrongTai(QuanLyTrongTai_FullName, QuanLyTrongTai_Address, QuanLyTrongTai_Level, QuanLyTrongTai_Exp)
values 
	('Trong Tai A', 'Ha Noi', 6, '2021-3-20'),
	('Trong Tai B', 'Ha Nam', 7, '2021-2-15'),
	('Trong Tai C', 'Nam Dinh', 9, '2021-1-10'),
	('Trong Tai D', 'Vinh', 8, '2021-2-25'),
	('Trong Tai E', 'Ho Chi Minh', 5, '2021-3-10')
go

insert into CauThu(CauThu_FullName, CauThu_BirthDay, CauThu_Salary, CauThu_NgayBatDauDa)
values
	('Nguyen Van A','2000-5-15',1000,'2021-1-1'),
	('Nguyen Nam B','2000-4-5',1100,'2021-1-1'),
	('Nguyen Dao C','2000-3-10',1200,'2021-1-1'),
	('Nguyen Tran D','2000-2-3',1300,'2021-1-1'),
	('Nguyen Hung E','2000-4-10',1400,'2021-1-1')
go

insert into DoiBong(DoiBong_TenDoiBong, DoiBong_SanChuNha, DoiBong_HuanLuyenVien)
values
	('FC_HaNoi', 'SanBong_HaNoi', 'Tran Nguyen A'),
	('FC_HaNam', 'SanBong_HaNam', 'Tran Nguyen B'),
	('FC_NamDinh', 'SanBong_NamDinh', 'Tran Nguyen C'),
	('FC_Vinh', 'SanBong_Vinh', 'Tran Nguyen D'),
	('FC_HoChiMinh', 'SanBong_HoChiMinh', 'Tran Nguyen E')
go

insert into LichSuBat(LichSuBat_IDTrongTai, LichSuBat_GiaiDau, LichSuBat_NgayBat, LichSuBat_Rate, LichSuBat_ID_Club_1, LichSuBat_ID_Club_2, LichSuBat_Note) 
values
	(1, 'FIFA_HANOI', '2021-4-20', 9, 5, 3, 'Giai to nhat'),
	(3, 'FIFA_HANAM', '2021-4-20', 10, 2, 5, 'Giai binh thuong'),
	(4, 'FIFA_NAMDINH', '2021-4-20', 9, 4, 3, 'Giai kha nho'),
	(2, 'FIFA_VINH', '2021-4-20', 5, 1, 2, 'Giai qua be'),
	(5, 'FIFA_HOCHIMINH', '2021-4-20', 7, 4, 1, 'Giai Vua Vua')
go

insert into DoiBongCauThu(DoiBongCauThu_ID_Club, DoiBongCauThu_ID_Player, DoiBongCauThu_NgayThamGiaDoiBong) 
values
	(5, 1, '2020-5-5'),
	(4, 5, '2020-5-4'),
	(3, 4, '2020-5-3'),
	(2, 3, '2020-5-2'),
	(1, 2, '2020-5-1')
go

--Thong tin lich su bat trong tai
select QuanLyTrongTai.QuanLyTrongTai_FullName, QuanLyTrongTai.QuanLyTrongTai_Level, QuanLyTrongTai.QuanLyTrongTai_Exp, LichSuBat.LichSuBat_GiaiDau, Team1.DoiBong_ID, Team2.DoiBong_ID
from QuanLyTrongTai, LichSuBat, DoiBong as Team1, DoiBong as Team2
where QuanLyTrongTai.QuanLyTrongTai_ID = LichSuBat.LichSuBat_IDTrongTai
	and LichSuBat.LichSuBat_ID_Club_1 = Team1.DoiBong_ID
	and LichSuBat.LichSuBat_ID_Club_2 = Team2.DoiBong_ID
go

create view vw_LichSuBat
as
	select QuanLyTrongTai.QuanLyTrongTai_FullName, QuanLyTrongTai.QuanLyTrongTai_Level, QuanLyTrongTai.QuanLyTrongTai_Exp, LichSuBat.LichSuBat_GiaiDau, Team1.DoiBong_ID, Team2.DoiBong_ID
	from QuanLyTrongTai, LichSuBat, DoiBong as Team1, DoiBong as Team2
	where QuanLyTrongTai.QuanLyTrongTai_ID = LichSuBat.LichSuBat_IDTrongTai
		and LichSuBat.LichSuBat_ID_Club_1 = Team1.DoiBong_ID
		and LichSuBat.LichSuBat_ID_Club_2 = Team2.DoiBong_ID
go

select * from vw_LichSuBat
go

select DoiBong.DoiBong_TenDoiBong, CauThu.*
from CauThu, DoiBong, DoiBongCauThu
where CauThu.CauThu_ID = DoiBongCauThu.DoiBongCauThu_ID_Player
and DoiBong.DoiBong_ID = DoiBongCauThu.DoiBongCauThu_ID_Club
go

create view vw_CauThu
as
	select DoiBong.DoiBong_TenDoiBong, CauThu.*
	from CauThu, DoiBong, DoiBongCauThu
	where CauThu.CauThu_ID = DoiBongCauThu.DoiBongCauThu_ID_Player
	and DoiBong.DoiBong_ID = DoiBongCauThu.DoiBongCauThu_ID_Club
go

create proc proc_TimLichSuBat
	@TeamID int
as
begin
	select QuanLyTrongTai.QuanLyTrongTai_FullName, QuanLyTrongTai.QuanLyTrongTai_Level, QuanLyTrongTai.QuanLyTrongTai_Exp, LichSuBat.LichSuBat_GiaiDau, Team1.DoiBong_ID, Team2.DoiBong_ID
	from QuanLyTrongTai, LichSuBat, DoiBong as Team1, DoiBong as Team2
	where QuanLyTrongTai.QuanLyTrongTai_ID = LichSuBat.LichSuBat_IDTrongTai
		and LichSuBat.LichSuBat_ID_Club_1 = Team1.DoiBong_ID
		and LichSuBat.LichSuBat_ID_Club_2 = Team2.DoiBong_ID
		and (LichSuBat.LichSuBat_ID_Club_1 = @TeamID or LichSuBat.LichSuBat_ID_Club_2 = @TeamID)
end
go

exec proc_TimLichSuBat 2