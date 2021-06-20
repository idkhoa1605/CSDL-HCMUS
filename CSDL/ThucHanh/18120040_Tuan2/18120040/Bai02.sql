create database QLPhongMay
go
use QLPhongMay
go
create table PhongMay
(
	MaPhong char(5),
	TenPhong nvarchar(20),
	MayChu char(5),
	MaNVQL char(5),
	primary key (MaPhong)
)
go

create table MayTinh
(
	MaMT char(5),
	TenMT nvarchar(20),
	MaPM char(5),
	TinhTrang bit,
	primary key (MaMT,MaPM)
)
go

create table NhanVien
(
	MaNV char(5),
	TenNV nvarchar(50),
	MaNVQL char(5),
	Phai nchar(3),
	primary key (MaNV)
)
go

alter table MayTinh
	add constraint FK_MayTinh_PhongMay
	foreign key (MaPM)
	references PhongMay(MaPhong)
go

alter table PhongMay
	add constraint FK_PhongMay_MayTinh
	foreign key (MayChu,MaPhong)
	references MayTinh(MaMT,MaPM)
go

alter table PhongMay
	add constraint FK_PhongMay_NhanVien
	foreign key (MaNVQL)
	references NhanVien(MaNV)
go

alter table NhanVien
	add constraint C_Phai
	check (Phai in('Nam',N'Nữ'))
go

alter table NhanVien
	add constraint C_TenNV
	UNIQUE (TenNV)
go

alter table MayTinh
	add constraint C_TenMT
	UNIQUE (TenMT,MaPM)
go

alter table NhanVien
	add constraint FK_NhanVien_NhanVien
	foreign key (MaNVQL)
	references NhanVien(MaNV)
go

insert into PhongMay(MaPhong,TenPhong) values ('A01',N'Phòng Chiến Binh')
insert into PhongMay(MaPhong,TenPhong) values ('B01',N'Phòng Pháp sư')
insert into PhongMay(MaPhong,TenPhong) values ('C01',N'Phòng Kỵ sĩ')
insert into PhongMay(MaPhong,TenPhong) values ('D01',N'Phòng Cung thủ')
go

insert into MayTinh(MaMT,TenMT,MaPM,TinhTrang) values ('Dell','Dell latitude','A01',1)
insert into MayTinh(MaMT,TenMT,MaPM,TinhTrang) values ('Asus',N'Hàng hiệu','B01',1)
insert into MayTinh(MaMT,TenMT,MaPM,TinhTrang) values ('Mac',N'Apple Việt Nam','C01',0)
insert into MayTinh(MaMT,TenMT,MaPM,TinhTrang) values ('HP',N'Hạnh phúc','D01',0)
go

insert into NhanVien(MaNV,TenNV,Phai) values ('NV01',N'Nguyễn Đăng Khoa','Nam')
insert into NhanVien(MaNV,TenNV,Phai) values ('NV02',N'La Thiên Hành','Nam')
insert into NhanVien(MaNV,TenNV,Phai) values ('NV03',N'Cơ Lạc Tuyết',N'Nữ')
insert into NhanVien(MaNV,TenNV,Phai) values ('NV04',N'Dương Quá','Nam')
go

update NhanVien set MaNVQL='NV01' where MaNV!='NV01' 
go

update PhongMay set MayChu='Dell' where MaPhong='A01'
go

insert into MayTinh(MaMT,TenMT,MaPM,TinhTrang) values ('Asus1',N'Hàng dỏm','B01',0)
go

update PhongMay set MayChu='Asus1' where MaPhong='B01'
go

update PhongMay set MayChu='Mac' where MaPhong='C01'
update PhongMay set MayChu='HP' where MaPhong='D01'
go

update PhongMay set MaNVQL='NV01' where MaPhong='A01'
update PhongMay set MaNVQL='NV02' where MaPhong='B01'
update PhongMay set MaNVQL='NV03' where MaPhong='C01'
update PhongMay set MaNVQL='NV04' where MaPhong='D01'
go

