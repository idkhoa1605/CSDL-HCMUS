USE QLDT1
GO

-- CÂU 1: V?i m?i b? môn, hãy cho bi?t s? l??ng giáo viên c?a b? môn tham gia ?? tài do tr??ng c?a
--        b? môn ch? trì (mabm, tenbm, SLGV)
select BM.MABM, BM.TENBM ,COUNT(DISTINCT TG.MAGV) AS SLGV
FROM (BOMON BM JOIN DETAI DT ON BM.TRUONGBM=DT.GVCNDT) JOIN THAMGIADT TG ON TG.MADT=DT.MADT
GROUP BY BM.MABM, BM.TENBM
GO

-- CÂU 2: Th? hi?n 1 b?ng g?m 2 c?t magv1 và magv2 trong ?ó magv1 và magv 2 trùng ngày sinh
-- (ngày, tháng, n?m). L?u ý ?ã m?i c?p gv ch? xu?t 1 l?n.
select GV1.MAGV AS MAGV1, GV2.MAGV AS MAGV2
from GIAOVIEN GV1 join GIAOVIEN GV2 on GV1.NGSINH=GV2.NGSINH AND GV1.MAGV>GV2.MAGV
go
