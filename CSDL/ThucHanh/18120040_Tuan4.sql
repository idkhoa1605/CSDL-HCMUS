use QLDT1
go

--- Q27. Cho biết số lượng giáo viên và tổng lương của họ. 
select count(*) as SO_LUONG_GV, sum(LUONG) as TONG_LUONG
from GIAOVIEN
go

--- Q28. Cho biết số lượng giáo viên và lương trung bình từng bộ môn. 
select MABM, count(*) as SO_LUONG_GV, sum(LUONG) as TONG_LUONG
from GIAOVIEN
group by MABM
go

--- Q29. Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó.
select CD.TENCD, count(*) as SO_LUONG_DE_TAI
from CHUDE CD join DETAI DT on CD.MACD=DT.MACD
group by CD.MACD,CD.TENCD
go

--- Q30. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.
select GV.HOTEN, count(distinct TGDT.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN GV left join THAMGIADT TGDT on GV.MAGV=TGDT.MAGV
group by GV.MAGV,GV.HOTEN
go

--- Q31. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm.
select GV.HOTEN, count(distinct DT.MADT) as SO_LUONG_DE_TAI_CN
from GIAOVIEN GV left join DETAI DT on GV.MAGV=DT.GVCNDT
group by GV.MAGV,GV.HOTEN
go

--- Q32. Với mỗi giáo viên cho tên giáo viên và số người thân của giáo viên đó.
select GV.MAGV, GV.HOTEN, count(NT.TEN) as SO_NGUOI_THAN 
from GIAOVIEN GV left join NGUOITHAN NT on GV.MAGV=NT.MAGV
group by GV.MAGV,GV.HOTEN
go

--- Q33. Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
select GV.HOTEN, count(distinct TGDT.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN GV left join THAMGIADT TGDT on GV.MAGV=TGDT.MAGV
group by GV.MAGV,GV.HOTEN
having count(distinct TGDT.MADT)>=3
go
 
 -- Q34. Cho biết số lượng giáo viên đã tham gia vào đề tài Ứng dụng hóa học xanh.
select count(distinct TGDT.MAGV) as SO_LUONG_GV
from DETAI DT join THAMGIADT TGDT on DT.MADT=TGDT.MADT
where DT.TENDT LIKE N'Ứng dụng hóa học xanh'
go

