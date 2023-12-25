create table BaiDoXe (
	ten_bai nvarchar(50),
	maBDX int primary key identity(1,1),
	dia_chiBDX nvarchar(200)
)
go

create table ThongTinGui (
	id int identity(1,1),
	ten_xe nvarchar(50),
	bien_so_xe nvarchar(20),
	maBDX int,
	idCSH int
)
go

create table ChuSoHuu (
	idCSH int identity(1,1),
	ten nvarchar(50),
	so_cmtnd nvarchar(20),
	dia_chiCSH nvarchar(200)
)
go

alter table BaiDoXe
add constraint pk_BaiDoXe_maBDX primary key (maBDX)
go

alter table ThongTinGui
add constraint pk_ThongTinGui_id primary key (id)
go

alter table ChuSoHuu
add constraint pk_ChuSoHuu_idCSH primary key (idCSH)
go

alter table ThongTinGui
add constraint fk_ThongTinGui_maBDX foreign key (maBDX) references BaiDoXe(maBDX)
go

alter table ThongTinGui
add constraint fk_ThongTinGui_idCSH foreign key (idCSH) references ChuSoHuu(idCSH)
go

insert into BaiDoXe(ten_bai,dia_chiBDX)
values
('Bai A','Ha Noi'),
('Bai B','Nam Dinh'),
('Bai C','Hai Phong'),
('Bai D','Son La'),
('Bai E','Ha Tay')
go

insert into ThongTinGui(ten_xe,bien_so_xe,maBDX,idCSH)
values
('vios','29C-1133',1,1),
('toyota','29A-2133',2,2),
('honda','29C-1642',5,3),
('mitsubishi','29C-3263',1,4),
('audi','29C-5543',4,5)
go

insert into ChuSoHuu(ten,so_cmtnd,dia_chiCSH)
values
('Nguyen Van A','1123344321','Ha Noi'),
('Le Thi B','324344321','Ha Noi'),
('Nguyen Van C','25434321','Cao Bang'),
('Nguyen Van D','577244321','Lang Son'),
('Le Thi E','981244321','Quang Ninh')
go

select ChuSoHuu.so_cmtnd, ChuSoHuu.ten, BaiDoXe.ten_bai, ThongTinGui.bien_so_xe
from ChuSoHuu, BaiDoXe, ThongTinGui	
where ChuSoHuu.idCSH = ThongTinGui.idCSH and BaiDoXe.maBDX = ThongTinGui.maBDX
go

select BaiDoXe.ten_bai, ThongTinGui.bien_so_xe, ChuSoHuu.ten, ChuSoHuu.so_cmtnd, COUNT(ThongTinGui.idCSH) as SoLanGui
from ChuSoHuu, BaiDoXe, ThongTinGui	
where ChuSoHuu.idCSH = ThongTinGui.idCSH and BaiDoXe.maBDX = ThongTinGui.maBDX
group by BaiDoXe.ten_bai, ThongTinGui.bien_so_xe, ChuSoHuu.ten, ChuSoHuu.so_cmtnd