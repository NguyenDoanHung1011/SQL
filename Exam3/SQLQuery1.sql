create database MusicStore

use MusicStore

create table MusicType (
	TypeID int primary key identity,
	Name nvarchar(50) not null,
	Description nvarchar(100)
)
go

create table Album (
	AlbumID nvarchar(20) primary key,
	Title nvarchar(100) not null,
	TypeID int references MusicType(TypeID),
	Artists nvarchar(50),
	Rate int default '0' check(Rate <= 5)
)
go

create table Song (
	SongID int primary key identity,
	AlbumID nvarchar(20) references Album(AlbumID),
	SongTitle nvarchar(200) not null,
	Artists nvarchar(50),
	Author nvarchar(50),
	Hits int check(Hits >= 0)
)
go

create index IX_SongTitle on Song(SongTitle)

create index IX_Artists on Song(Artists)

insert into MusicType(Name, Description) 
values 
('Indie', 'Chill and Melodious music'), 
('Rock', 'Solid and Tough music'),
('EDM', 'Electronic and Dance music'),
('Jazz', 'Traditional blues and ragtime music'),
('Funk', 'Rhythmic ang danceable music')
go

insert into Album (AlbumID, Title, TypeID, Artists, Rate)
values 
('1', 'MomentEP', 1, 'Peggy Gou', 4),
('2', 'Justice', 2, 'Justin Bieber', 2),
('3', 'Motion', 3, 'Calvin Harris', 3),
('4', 'Mommy', 1, 'Duc Anh', 5),
('5', 'Goodbye Swallow', 2, 'Tran Tien', 4)
go

insert into Song (AlbumID, SongTitle, Artists, Author, Hits) 
values 
('1', 'Peaches', 'Justin Bieber', 'Michelle', 10000),
('2', 'Han Pan', 'Peggy Gou', 'Peggy Gou', 434847),
('3', 'Summer', 'Calvin Harris', 'Calvin Harris', 4447),
('4', 'Random', 'Duc Anh', 'Chris', 12),
('5', 'Chim Bo Cau', 'Dong Nhi', 'Tran Tien', 334),
('5', 'Mat Nai', 'O Cao Thang', 'Tran Tien', 12)
go

select * 
from Album
where Album.Rate = 5
go

select Song.SongTitle
from Album, Song
where Album.AlbumID = Song.AlbumID and Album.Title = 'Goodbye Swallow'
go

create view v_Albums
as
	select Album.AlbumID, Album.Title, MusicType.Name, Album.Rate
	from Album, MusicType
	where MusicType.TypeID = Album.TypeID
go

select * from v_Albums
go

create view v_TopSongs
as
	select top(10) *
	from Song
	order by Song.Hits desc
go

select * from v_TopSongs
go

create proc sp_SearchByArtist
	@name nvarchar(50)
as
	select *
	from Song
	where Song.Artists = @name
go

exec sp_SearchByArtist 'Justin Bieber'
go

create proc sp_ChangeHits
	@SongID int,
	@Hits int
as
	update Song set Hits = @Hits where Song.SongID = @SongID
go

exec sp_ChangeHits 1, 2000
go