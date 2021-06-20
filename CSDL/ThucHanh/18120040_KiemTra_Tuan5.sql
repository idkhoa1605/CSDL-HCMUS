USE QLDT1
GO

-- C�U 1: V?i m?i b? m�n, h�y cho bi?t s? l??ng gi�o vi�n c?a b? m�n tham gia ?? t�i do tr??ng c?a
--        b? m�n ch? tr� (mabm, tenbm, SLGV)
select BM.MABM, BM.TENBM ,COUNT(DISTINCT TG.MAGV) AS SLGV
FROM (BOMON BM JOIN DETAI DT ON BM.TRUONGBM=DT.GVCNDT) JOIN THAMGIADT TG ON TG.MADT=DT.MADT
GROUP BY BM.MABM, BM.TENBM
GO

-- C�U 2: Th? hi?n 1 b?ng g?m 2 c?t magv1 v� magv2 trong ?� magv1 v� magv 2 tr�ng ng�y sinh
-- (ng�y, th�ng, n?m). L?u � ?� m?i c?p gv ch? xu?t 1 l?n.
select GV1.MAGV AS MAGV1, GV2.MAGV AS MAGV2
from GIAOVIEN GV1 join GIAOVIEN GV2 on GV1.NGSINH=GV2.NGSINH AND GV1.MAGV>GV2.MAGV
go
