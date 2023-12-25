create table BaiDoXe (
	TenBai nvarchar(50),
	Ma_BDX int primary key identity(1,1),
	DiaChi_BDX nvarchar(200)
)
go

create table ThongTinGui (
	TenXe nvarchar(50),
	BienSoXe nvarchar(20),
	Ma_BDX int,
	NgayGui date,
	NgayLay date,
	ChiPhi money,
	ID_CSH int
)
go

create table ChuSoHuu (
	ID_CSH int identity(1,1),
	Ten nvarchar(50),
	So_CMTND nvarchar(20),
	DiaChi_CSH nvarchar(200)
)
go

alter table BaiDoXe
add constraint PK_BaiDoXe_Ma_BDX primary key (Ma_BDX)
go

alter table ChuSoHuu
add constraint pk_ChuSoHuu_ID_CSH primary key (ID_CSH)
go

alter table ThongTinGui
add constraint fk_ThongTinGui_Ma_BDX foreign key (Ma_BDX) references BaiDoXe(Ma_BDX)
go

alter table ThongTinGui
add constraint fk_ThongTinGui_ID_CSH foreign key (ID_CSH) references ChuSoHuu(ID_CSH)
go

insert into BaiDoXe(TenBai, DiaChi_BDX)
values
('Bai A','Ha Noi'),
('Bai B','Nam Dinh'),
('Bai C','Hai Phong')
go

insert into ThongTinGui(TenXe, BienSoXe, Ma_BDX, NgayGui, NgayLay, ChiPhi, ID_CSH)
values
	('Vinfast', 'AB1-123-868', 3, '2021-03-03', '2021-03-10', 70000, 2),
	('Toyota', 'AB1-123-989', 1, '2021-03-06', '2021-03-10', 40000, 1),
	('Toyota', 'AB1-123-999', 1, '2021-03-05', '2021-03-20', 50000, 1)
go

insert into ChuSoHuu(Ten,So_CMTND,DiaChi_CSH)
values
	('Nguyen Van A','1123344321','Ha Noi'),
	('Nguyen Van B','25434321','Cao Bang'),
	('Nguyen Van C','577244321','Lang Son')
go

select ChuSoHuu.So_CMTND, ChuSoHuu.Ten, BaiDoXe.TenBai, ThongTinGui.BienSoXe
from ChuSoHuu, BaiDoXe, ThongTinGui	
where ChuSoHuu.ID_CSH = ThongTinGui.ID_CSH and BaiDoXe.Ma_BDX = ThongTinGui.Ma_BDX
go

create proc proc_DemSoLuotGuiXe
	@ID_CSH int
as
begin
	select ChuSoHuu.Ten, COUNT(ThongTinGui.ID_CSH) as SoLanGui
	from ChuSoHuu, ThongTinGui	
	where ChuSoHuu.ID_CSH = ThongTinGui.ID_CSH and ChuSoHuu.ID_CSH = @ID_CSH
	group by ChuSoHuu.Ten
end

exec proc_DemSoLuotGuiXe 1

create proc proc_TongChiPhi
	@ID_CSH int
as
begin
	select ChuSoHuu.Ten, SUM(ThongTinGui.ChiPhi) TongChiPhi
	from ChuSoHuu, ThongTinGui	
	where ChuSoHuu.ID_CSH = ThongTinGui.ID_CSH and ChuSoHuu.ID_CSH = @ID_CSH
	group by ChuSoHuu.Ten
end

exec proc_TongChiPhi 1

create proc proc_GuiXe
	@ID_CSH_GuiXe date
as
begin
	select ChuSoHuu.So_CMTND, ChuSoHuu.Ten, BaiDoXe.TenBai, ThongTinGui.BienSoXe
	from ChuSoHuu, BaiDoXe, ThongTinGui	
	where ChuSoHuu.ID_CSH = ThongTinGui.ID_CSH
		and BaiDoXe.Ma_BDX = ThongTinGui.Ma_BDX
		and ThongTinGui.NgayGui < @ID_CSH_GuiXe and ThongTinGui.NgayLay > @ID_CSH_GuiXe
end

exec proc_GuiXe '2021-03-11'

create proc proc_XeDaTungGui
	@ID_CSH int
as
begin
	select BaiDoXe.TenBai, ThongTinGui.BienSoXe
	from BaiDoXe, ThongTinGui
	where BaiDoXe.Ma_BDX = ThongTinGui.Ma_BDX and ThongTinGui.ID_CSH = @ID_CSH
end

exec proc_XeDaTungGui 1 