create database QLCacTruong
go
use QLCacTruong
go
create table Truong
(
	MaTruong char(10),
	TenTruong char(24),
	primary key(MaTruong)
)
go

alter table Truong
alter column TenTruong nvarchar(50)
go

create table DayNha
(
	MaDay char(10),
	TenDay char(24),
	MaTruong char(10),
	primary key(MaDay,MaTruong)
)
go

alter table DayNha
	add constraint FK_DayNha_Truong
	foreign key(Matruong)
	references Truong(MaTruong)
go

create table Phong
(
	MaPhong char(10),
	MaDay char(10),
	MaTruong char(10),
	MaPhongQuanLy char(10),
	primary key(MaPhong,MaDay,MaTruong)
)
go

alter table Phong
	add constraint FK_Phong_DayNha
	foreign key(MaDay,MaTruong)
	references DayNha(MaDay,MaTruong)
go

alter table Phong
	add constraint FK_Phong_PhongQL
	foreign key(MaPhongQuanLy,MaDay,MaTruong)
	references Phong(MaPhong,MaDay,MaTruong)
go

insert into Truong(MaTruong,TenTruong) values ('QST',N'Đại học KHTN')
insert into Truong(MaTruong,TenTruong) values ('QSB',N'Đại học BK')
insert into Truong(MaTruong,TenTruong) values ('QSC',N'Đại học CNTT')
insert into Truong(MaTruong,TenTruong) values ('QSQ',N'Đại học Quốc Tế')
go

insert into DayNha(MaDay,TenDay,MaTruong) values ('A001',N'Đông tà','QST')
insert into DayNha(MaDay,TenDay,MaTruong) values ('B010',N'Tây Độc','QSB')
insert into DayNha(MaDay,TenDay,MaTruong) values ('C011',N'Nam Đế','QSC')
insert into DayNha(MaDay,TenDay,MaTruong) values ('D100',N'Bắc Cái','QSQ')
go

insert into Phong(MaPhong,MaDay,MaTruong,MaPhongQuanLy) values ('AA01','A001','QST',null)
insert into Phong(MaPhong,MaDay,MaTruong,MaPhongQuanLy) values ('BB01','B010','QSB',null)
insert into Phong(MaPhong,MaDay,MaTruong,MaPhongQuanLy) values ('CC01','C011','QSC',null)
insert into Phong(MaPhong,MaDay,MaTruong,MaPhongQuanLy) values ('DD01','D100','QSQ',null)
go