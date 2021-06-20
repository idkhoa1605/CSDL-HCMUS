create database QLDT1
go
use QLDT1
go

create table GIAOVIEN
(
	MAGV char (5), 
	HOTEN nvarchar(40), 
	LUONG float, 
	PHAI nchar(3), 
	NGSINH datetime, 
	DIACHI nvarchar(100), 
	GVQLCM char(5), 
	MABM nchar(5)
	PRIMARY KEY (MAGV)
)
go

create table GV_DT 
(
	MAGV char(5), 
	DIENTHOAI char(12),
	PRIMARY KEY (MAGV, DIENTHOAI)
)
go
create table BOMON 
(
	MABM nchar(5),
	TENBM nvarchar(40), 	 
	PHONG char(5),
	DIENTHOAI char(12), 
	TRUONGBM char(5), 
	MAKHOA char(4), 	
	NGAYNHANCHUC datetime,
	PRIMARY KEY (MABM)
)
go
create table KHOA 
(
	MAKHOA char(4), 
	TENKHOA nvarchar(40), 
	NAMTL int, 
	PHONG char(5), 
	DIENTHOAI char(12), 	
	TRUONGKHOA char(5), 
	NGAYNHANCHUC datetime,
	PRIMARY KEY (MAKHOA)	
)
go
create table DETAI 
(
	MADT char(3), 
	TENDT nvarchar(100), 
	CAPQL nvarchar(40), 
	KINHPHI float, 
	NGAYBD datetime, 
	NGAYKT datetime, 	
	MACD nchar(4),
	GVCNDT char(5), 	
	PRIMARY KEY (MADT)
)
go
create table CHUDE 
(
	MACD nchar(4), 
	TENCD nvarchar(50),
	PRIMARY KEY (MACD)
)
go

create table CONGVIEC 
(
	MADT char(3), 
	SOTT int, 
	TENCV nvarchar(40), 
	NGAYBD datetime, 
	NGAYKT datetime,
	PRIMARY KEY (MADT, SOTT) 
)
go

create table THAMGIADT 
(
	MAGV char(5), 
	MADT char(3), 
	STT int, 
	PHUCAP float , 
	KETQUA nvarchar(40),
	PRIMARY KEY (MAGV, MADT, STT)
)
go

create table NGUOITHAN 
(
	MAGV char(5), 
	TEN nvarchar(20), 
	NGSINH datetime, 
	PHAI nchar(3),
	PRIMARY KEY (MAGV, TEN)
)
go

alter table GIAOVIEN add
	constraint FK_GIAOVIEN_BOMON foreign key (MABM) references BOMON (MABM),
	constraint FK_GIAOVIEN_GIAOVIEN foreign key (GVQLCM) references GIAOVIEN (MAGV)

alter table KHOA add 
	constraint FK_KHOA_GIAOVIEN foreign key (TRUONGKHOA) references GIAOVIEN (MAGV)

alter table BOMON add 
	constraint FK_BOMON_KHOA foreign key (MAKHOA) references KHOA(MAKHOA),
	constraint FK_BOMON_GIAOVIEN foreign key (TRUONGBM) references GIAOVIEN (MAGV)

alter table NGUOITHAN add
	constraint FK_NGUOITHAN_GIAOVIEN foreign key (MAGV)references GIAOVIEN (MAGV)

alter table THAMGIADT add
	constraint FK_PHANCONG_GIAOVIEN foreign key (MAGV)references GIAOVIEN (MAGV),
	constraint FK_PHANCONG_CONGVIEC foreign key (MADT, STT)references CONGVIEC(MADT, SOTT)

alter table DETAI add
	constraint FK_DETAI_CHUDE foreign key (MACD)references CHUDE (MACD)

alter table DETAI add
	constraint FK_DETAI_GIAOVIEN foreign key (GVCNDT)references GIAOVIEN (MAGV)

alter table GV_DT add
	constraint FK_DIENTHOAI_GIAOVIEN foreign key (MAGV)references GIAOVIEN (MAGV)

alter table CONGVIEC add 	
	constraint FK_CONGVIEC_DETAI foreign key (MADT)references DETAI (MADT)
go

------------
----------------
insert into KHOA values ('CNTT',N'Công ngh? thông tin',1995,'B11','0838123456',null,'02/20/2005')
insert into KHOA values ('VL',N'V?t lý',1976,'B21','0838223223',null,'09/18/2003')
insert into KHOA values ('SH',N'Sinh h?c',1980,'B31','0838454545',null,'10/11/2000')
insert into KHOA values ('HH',N'Hóa h?c',1980,'B41','0838456456',null,'10/15/2001')
----------------
insert into BOMON values (N'HTTT',N'H? th?ng thông tin','B13','0838125125',null,'CNTT','09/20/2004')
insert into BOMON values (N'CNTT',N'Công ngh? tri th?c','B15','0838126126',null, 'CNTT', null)
insert into BOMON values (N'MMT',N'M?ng máy tính','B16','0838676767 ',null,'CNTT','05/15/2005')
insert into BOMON values (N'VL?T',N'V?t lý ?i?n t?','B23','0838234234',null, 'VL', null)	
insert into BOMON values (N'VL?D',N'V?t lý ?ng d?ng','B24','0838454545',null,'VL','02/18/2006')
insert into BOMON values (N'VS',N'Vi sinh','B32','0838909090',null,'SH','01/01/2007')
insert into BOMON values (N'SH',N'Sinh hóa','B33','0838898989',null, 'SH', null)	
insert into BOMON values (N'HL',N'Hóa lý','B42','0838878787',null, 'HH', null)	
insert into BOMON values (N'HPT',N'Hóa phân tích','B43','0838777777',null,'HH','10/15/2007')
insert into BOMON values (N'HHC',N'Hóa h?u c?','B44','838222222',null, 'HH', null)	
----------------
insert into GIAOVIEN values ('001',N'Nguy?n Hoài An',2000,N'Nam','02/15/1973',N'25/3 L?c Long Quân, Q.10, TP HCM', null, N'MMT')
insert into GIAOVIEN values ('002',N'Tr?n Trà H??ng',2500,N'N?','06/20/1960',N'125	Tr?n H?ng ??o, Q.1,TP HCM', null, N'HTTT')
insert into GIAOVIEN values ('003',N'Nguy?n Ng?c Ánh',2200,N'N?','05/11/1975',N'12/21	Võ V?n Ngân	Th? ??c, TP HCM', '002',N'HTTT')
insert into GIAOVIEN values ('004',N'Tr??ng Nam S?n',2300,N'Nam','06/20/1959',N'215	Lý Th??ng Ki?t,TP Biên Hòa',null, N'VS')
insert into GIAOVIEN values ('005',N'Lý Hoàng Hà',2500,N'Nam','10/23/1954',N'22/5	Nguy?n Xí, Q.Bình Th?nh, TP HCM',null, N'VL?T')
insert into GIAOVIEN values ('006',N'Tr?n B?ch Tuy?t',1500,N'N?','05/20/1980',N'127	Hùng V??ng, TP M? Tho','004',N'VS')
insert into GIAOVIEN values ('007',N'Nguy?n An Trung',2100,N'Nam','06/05/1976',N'234 3/2, TP Biên Hòa',null, N'HPT')
insert into GIAOVIEN values ('008',N'Tr?n Trung Hi?u',1800,N'Nam','08/06/1977',N'22/11 Lý Th??ng Ki?t, TP M? Tho','007',N'HPT')
insert into GIAOVIEN values ('009',N'Tr?n Hoàng Nam',2000,N'Nam','11/22/1975',N'234	Tr?n Não, An Phú,TP HCM','001',N'MMT')
insert into GIAOVIEN values ('010',N'Ph?m Nam Thanh',1500,N'Nam','12/12/1980',N'221	Hùng V??ng, Q.5, TP HCM','007',N'HPT')
----------------
insert into GV_DT values ('001','0903123123')
insert into GV_DT values ('001','0838912112')
insert into GV_DT values ('002','0913454545')
insert into GV_DT values ('003','0903656565')
insert into GV_DT values ('003','0838121212')
insert into GV_DT values ('003','0937125125')
insert into GV_DT values ('006','0937888888')
insert into GV_DT values ('008','0913232323')
insert into GV_DT values ('008','0653717171')
----------------
insert into CHUDE values (N'QLGD',N'Qu?n lý giáo d?c')
insert into CHUDE values (N'NCPT',N'Nghiên c?u phát tri?n')
insert into CHUDE values (N'?DCN',N'?ng d?ng công ngh?')
----------------
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('001',N'HTTT qu?n lý các tr??ng ?H',20,N'?HQG','10/20/2007','10/20/2008',N'QLGD','002')
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('002',N'HTTT qu?n lý giáo v? cho m?t Khoa','20',N'Tr??ng','10/12/2000','10/12/2001',N'QLGD','002')
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('003',N'Nghiên c?u ch? t?o s?i Nanô Platin','300',N'?HQG','05/15/2008','05/15/2010',N'NCPT','005')
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('004',N'T?o v?t li?u sinh h?c b?ng màng ?i ng??i','100',N'Nhà n??c','01/01/2007','12/31/2009',N'NCPT','004')
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('005',N'?ng d?ng hóa h?c xanh','200',N'Tr??ng','10/10/2003','12/10/2004',N'?DCN','007')
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('006',N'Nghiên c?u t? bào g?c','4000',N'Nhà n??c','10/20/2006','10/20/2009',N'NCPT','004')
insert into DETAI (MADT, TENDT, KINHPHI, CAPQL, NGAYBD, NGAYKT, MACD, GVCNDT) values ('007',N'HTTT qu?n lý th? vi?n ? các tr??ng ?H','20',N'Tr??ng','5/10/2009','05/10/2010',N'QLGD','001')
----------------
set dateformat dmy

insert into CONGVIEC values ('001',1,N'Kh?i t?o và L?p k? ho?ch','20/10/2007','20/12/2008')
insert into CONGVIEC values ('001',2,N'Xác ??nh yêu c?u','21/12/2008','21/03/2008')
insert into CONGVIEC values ('001',3,N'Phân tích h? th?ng','22/03/2008','22/5/2008')
insert into CONGVIEC values ('001',4,N'Thi?t k? h? th?ng','23/05/2008','23/06/2008')
insert into CONGVIEC values ('001',5,N'Cài ??t th? nghi?m','24/06/2008','20/10/2008')
insert into CONGVIEC values ('006',1,N'L?y m?u','20/10/2006','20/02/2007')
insert into CONGVIEC values ('006',2,N'Nuôi c?y','21/02/2007','21/08/2008')
insert into CONGVIEC values ('002',1,N'Kh?i t?o và L?p k? ho?ch','10/05/2009','10/07/2009')
insert into CONGVIEC values ('002',2,N'Xác ??nh yêu c?u','11/07/2009','11/10/2009')
insert into CONGVIEC values ('002',3,N'Phân tích h? th?ng','12/10/2009','20/12/2009')
insert into CONGVIEC values ('002',4,N'Thi?t k? h? th?ng','21/12/2009','22/03/2010')
insert into CONGVIEC values ('002',5,N'Cài ??t th? nghi?m','23/03/2010','10/05/2010')
set dateformat mdy
----------------
insert into THAMGIADT values ('003','001',1,1,N'??t')
insert into THAMGIADT values ('003','001',2,0,N'??t')
insert into THAMGIADT values ('002','001',4,2,N'??t')
insert into THAMGIADT values ('003','001',4,1,N'??t')
insert into THAMGIADT values ('004','006',1,0,N'??t')
insert into THAMGIADT values ('004','006',2,1,N'??t')
insert into THAMGIADT values ('006','006',2,1.5,N'??t')
insert into THAMGIADT values ('001','002',1,0, null)	
insert into THAMGIADT values ('001','002',2,2, null)	
insert into THAMGIADT values ('003','002',2,0, null)	
insert into THAMGIADT values ('009','002',3,0.5, null)	
insert into THAMGIADT values ('009','002',4,1.5, null)	
----------------
update KHOA set TRUONGKHOA = '002' where MAKHOA='CNTT'
update KHOA set TRUONGKHOA = '005' where MAKHOA='VL'
update KHOA set TRUONGKHOA = '004' where MAKHOA='SH'
update KHOA set TRUONGKHOA = '007' where MAKHOA='HH'
----------------
update BOMON set TRUONGBM = '002' where MABM=N'HTTT'
update BOMON set TRUONGBM = '001' where MABM=N'MMT'
update BOMON set TRUONGBM = '005' where MABM=N'VL?D'
update BOMON set TRUONGBM = '004' where MABM=N'VS'
update BOMON set TRUONGBM = '007' where MABM=N'HPT'
----------------
insert into NGUOITHAN values ('001', N'Hùng', '1/14/1990', N'Nam')
insert into NGUOITHAN values ('001', N'Th?y', '12/8/1994', N'N?')
insert into NGUOITHAN values ('003', N'Thu', '9/3/1998', N'N?')
insert into NGUOITHAN values ('003', N'Hà', '9/3/1998', N'N?')
insert into NGUOITHAN values ('008', N'Nam', '5/6/1991', N'Nam')
insert into NGUOITHAN values ('010', N'Nguy?t', '1/14/2006', N'N?')
insert into NGUOITHAN values ('007', N'Vy', '2/14/2000', N'N?')
insert into NGUOITHAN values ('007', N'Mai', '3/26/2003', N'N?')
insert into NGUOITHAN values ('009', N'An', '8/19/1996', N'Nam')
go

--- Q1. Ho ten, muc luong cua giao vien nu
select HOTEN,LUONG
from GIAOVIEN
where PHAI = N'Nữ'
go

--- Q2. Ho ten, luong sau khi tang 10%
select HOTEN, LUONG*1.1 as LUONG_SAU
from GIAOVIEN
go

--- Q3. mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 hoặc,giáo viên là trưởng bộ môn nhận chức sau năm 1995.
select MAGV
from GIAOVIEN
where HOTEN like N'Nguyễn%' and LUONG > 2000
union
select TRUONGBM
from BOMON
where year(NGAYNHANCHUC)>=1995
go

--- Q4. Cho biết tên những giáo viên khoa Công nghệ thông tin.
select DISTINCT HOTEN AS GV_CNTT
from GIAOVIEN, BOMON BM JOIN KHOA K ON BM.MAKHOA=K.MAKHOA
where K.TENKHOA like N'Công nghệ thông tin' AND BM.MABM=GIAOVIEN.MABM
go

--- Q5. Cho biết thông tin của bộ môn cùng thông tin giảng viên làm trưởng bộ môn đó
select *
from GIAOVIEN GV join BOMON BM on GV.MABM=BM.MABM
where GV.MAGV=BM.TRUONGBM
go

--- Q6. Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc
select *
from GIAOVIEN as GV,BOMON as BM
where GV.MABM = BM.MABM
go

--- Q7. Cho biết tên đề tài và giáo viên chủ nhiệm đề tài
select DT.TENDT, GV.MAGV, GV.HOTEN
from DETAI DT join GIAOVIEN GV on DT.GVCNDT=GV.MAGV
go

--- Q8. Với mỗi khoa cho biết thông tin trưởng khoa.
select K.MAKHOA, K.TENKHOA, GV.*
from KHOA K join GIAOVIEN GV on K.TRUONGKHOA=GV.MAGV
go

--- Q9. Cho biết các giáo viên của bộ môn “Vi sinh” có tham gia đề tài 006
select DISTINCT GV.*
from (GIAOVIEN GV join THAMGIADT TGDT on GV.MAGV=TGDT.MAGV) join BOMON BM on GV.MABM=BM.MABM
where BM.TENBM like N'Vi sinh' and TGDT.MADT=006
go

--- Q10. Với những đề tài thuộc cấp quản lý “Thành phố”, cho biết mã đề tài, đề tài thuộc về chủ  đề nào, 
---  họ tên người chủ nghiệm đề tài cùng với ngày sinh và địa chỉ của người ấy.
select DT.MADT, CD.TENCD, GV.HOTEN,GV.NGSINH, GV.DIACHI
from (DETAI DT join GIAOVIEN GV on GV.MAGV=DT.GVCNDT) join CHUDE CD on CD.MACD=DT.MACD
where DT.CAPQL like N'Thành phố' 
go

--- Q11. Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó
select GV.MAGV, GV.HOTEN, GVQL.MAGV as MA_GVQL, GVQL.HOTEN as HOTEN_GVQL
from GIAOVIEN GV join GIAOVIEN GVQL on GV.GVQLCM=GVQL.MAGV
go

--- Q12. Tìm họ tên của những giáo viên được “Nguyễn Thanh Tùng” phụ trách trực tiếp.
select GV.MAGV, GV.HOTEN
from GIAOVIEN GV join GIAOVIEN GVQL on GV.GVQLCM=GVQL.MAGV
where GVQL.HOTEN like N'Nguyễn Thanh Tùng'
go

--- Q13. Cho biết tên giáo viên là trưởng bộ môn “Hệ thống thông tin”.
select GV.HOTEN
from GIAOVIEN as GV, BOMON as BM
where GV.MAGV=BM.TRUONGBM and BM.TENBM like N'Hệ thống thông tin'
go

--- Q14. Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
select DISTINCT GV.HOTEN
from (DETAI DT join GIAOVIEN GV on GV.MAGV=DT.GVCNDT) join CHUDE CD on CD.MACD=DT.MACD
where CD.TENCD like N'Quản lý giáo dục'
go

--- Q15. Cho biết tên các công việc của đề tài HTTT quản lý các trường ĐH có thời gian bắt đầu trong tháng 3/2008.
select CV.TENCV
from (DETAI DT join CONGVIEC CV on CV.MADT=DT.MADT) 
where DT.TENDT like N'HTTT quản lý các trường ĐH'
go

--- Q16. Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
select GV.HOTEN, GVQL.HOTEN as HOTEN_GVQL
from GIAOVIEN GV join GIAOVIEN GVQL on GV.GVQLCM=GVQL.MAGV
go

--- Q17. Cho các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
select * 
from CONGVIEC as CV
where CV.NGAYBD between '2007-01-01 00:00:00.000' and '2007-08-01 00:00:00.000'
go

--- Q18. Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”.
select GV1.HOTEN
from GIAOVIEN GV1 join GIAOVIEN GV2 on (GV2.HOTEN like N'Trần Trà Hương' and GV1.MABM=Gv2.MABM and GV1.HOTEN not like N'Trần Trà Hương')
go


--- Q19. Tìm những giáo viên vừa là trưởng bộ môn vừa chủ nhiệm đề tài.
select GV.MAGV, GV.HOTEN, BM.TENBM, DT.MADT, DT.TENDT
from (BOMON BM join DETAI DT on BM.TRUONGBM=DT.GVCNDT) join GIAOVIEN GV on BM.TRUONGBM=GV.MAGV
order by GV.MAGV ASC
go

--- Q20. Cho biết tên những giáo viên vừa là trưởng khoa và vừa là trưởng bộ môn.
select GV.MAGV, GV.HOTEN, K.TENKHOA, TENBM
from (BOMON BM join KHOA K on BM.TRUONGBM=K.TRUONGKHOA) join GIAOVIEN GV on BM.TRUONGBM=GV.MAGV
order by GV.MAGV ASC
go

--- Q21. Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài.
select DISTINCT GV.HOTEN
from (BOMON BM join DETAI DT on BM.TRUONGBM=DT.GVCNDT) join GIAOVIEN GV on BM.TRUONGBM=GV.MAGV
go

--- Q22. Cho biết mã số các trưởng khoa có chủ nhiệm đề tài.
select DISTINCT K.TRUONGKHOA
from DETAI DT join KHOA K on DT.GVCNDT=K.TRUONGKHOA 
order by K.TRUONGKHOA ASC
go

--- Q23. Cho biết mã số các giáo viên thuộc bộ môn “HTTT” hoặc có tham gia đề tài mã “001”.
select DISTINCT GV.MAGV
from GIAOVIEN GV join THAMGIADT TGDT on GV.MAGV=TGDT.MAGV
where TGDT.MADT=001 and GV.MABM = 'HTTT'
go

--- Q24. Cho biết giáo viên làm việc cùng bộ môn với giáo viên 002.
select GV.*
from GIAOVIEN GV join GIAOVIEN GV1 on (GV.MABM=GV1.MABM and GV1.MAGV=002 and GV.MAGV<>002)
go

--- Q25. Tìm những giáo viên là trưởng bộ môn.
select GV.*
from GIAOVIEN as GV,BOMON
where GV.MAGV=BOMON.TRUONGBM
order by GV.MAGV
go

--- Q26. Cho biết họ tên và mức lương của các giáo viên.
select HOTEN,LUONG
from GIAOVIEN
go

