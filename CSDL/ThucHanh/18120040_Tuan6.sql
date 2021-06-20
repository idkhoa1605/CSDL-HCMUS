USE QLDT1
GO

--Q58. Cho	biết	tên	giáo	viên	nào	mà	tham	gia	đề tài đủ tất	cả các	chủ đề.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT TG.MAGV
				FROM THAMGIADT TG
				WHERE NOT EXISTS (SELECT DT.MADT
								FROM DETAI DT
								EXCEPT
								SELECT TG1.MADT
								FROM THAMGIADT TG1
								WHERE TG1.MAGV=TG1.MADT))
GO


--Q59. Cho	biết tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	bộ môn	HTTT	tham	gia
SELECT DT.TENDT
FROM DETAI DT
WHERE DT.MADT IN (SELECT TG.MADT
			FROM THAMGIADT TG
			WHERE NOT EXISTS (SELECT GV.MAGV
							FROM GIAOVIEN GV
							WHERE GV.MABM='HTTT'
							EXCEPT
							SELECT TG1.MAGV
							FROM THAMGIADT TG1
							WHERE TG1.MADT=TG1.MADT AND TG.STT=TG1.STT AND TG.KETQUA=TG1.KETQUA))
GO

--Q60. Cho	biết	tên	đề tài	có	tất	cả giảng	viên	bộ môn	“Hệ thống	thông	tin”	tham	gia
SELECT DT.TENDT
FROM DETAI DT
WHERE DT.MADT IN (SELECT TG.MADT
			FROM THAMGIADT TG
			WHERE NOT EXISTS (SELECT GV.MAGV
							FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM=BM.MABM
							WHERE BM.TENBM=N'Hệ thống thông tin'
							EXCEPT
							SELECT TG1.MAGV
							FROM THAMGIADT TG1
							WHERE TG1.MADT=TG1.MADT AND TG.STT=TG1.STT AND TG.KETQUA=TG1.KETQUA))
GO


--Q61. Cho	biết	giáo	viên	nào	đã	tham	gia	tất	cả các	đề tài	có	mã	chủ đề là	QLGD.
SELECT GV.*
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT TG.MAGV
				FROM THAMGIADT TG
				WHERE NOT EXISTS (SELECT DT.MADT
								FROM DETAI DT JOIN CHUDE CD ON CD.MACD=DT.MACD
								WHERE CD.MACD='QLGD'
								EXCEPT
								SELECT TG1.MADT
								FROM THAMGIADT TG1
								WHERE TG1.MAGV=TG1.MAGV AND TG.STT=TG1.STT AND TG.KETQUA=TG1.KETQUA))
GO

--Q62. Cho biết tên giáo viên nào tham gia tất	cả các	đề tài	mà	giáo viên Trần Trà Hương đã	tham gia
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.HOTEN<>N'Trần Trà Hương' AND GV.MAGV IN (SELECT TG.MAGV
												FROM THAMGIADT TG
												WHERE NOT EXISTS (SELECT TG1.MADT
																FROM THAMGIADT TG1 JOIN GIAOVIEN TTH ON TG1.MAGV=TTH.MAGV
																WHERE TTH.HOTEN=N'Trần Trà Hương'
																EXCEPT
																SELECT TG2.MADT
																FROM THAMGIADT TG2
																WHERE TG2.MAGV=TG.MAGV AND TG.STT=TG2.STT AND TG.KETQUA=TG2.KETQUA))
GO

--Q63. Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	bộ môn	Hóa	Hữu	Cơ	tham	gia.
SELECT DT.TENDT
FROM DETAI DT
WHERE DT.MADT IN (SELECT TG.MADT
				FROM THAMGIADT TG
				WHERE NOT EXISTS(SELECT GV.MAGV
								FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM=BM.MABM
								WHERE BM.TENBM = N'Hóa hữu cơ'
								EXCEPT
								SELECT TG1.MAGV
								FROM THAMGIADT TG1
								WHERE TG.MADT=TG1.MADT AND TG.STT=TG1.STT AND TG.KETQUA=TG1.KETQUA))
GO
									
-- Q64. Cho	biết	tên	giáo	viên	nào	mà	tham	gia	tất	cả các	công	việc	của	đề tài	006.
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV JOIN THAMGIADT TG ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS( SELECT CV.MADT, CV.SOTT
				FROM CONGVIEC CV
				WHERE CV.MADT = '006'
				EXCEPT
				SELECT TG1.MADT, TG1.STT
				FROM THAMGIADT TG1
				WHERE TG1.MAGV=TG.MAGV AND TG1.KETQUA=TG.KETQUA)
GO

-- Q65. Cho	biết	giáo	viên	nào	đã	tham	gia	tất	cả các	đề tài	của	chủ đề Ứng	dụng	công	nghệ.
SELECT DISTINCT GV.*
FROM GIAOVIEN GV JOIN THAMGIADT TG ON GV.MAGV = TG.MAGV
WHERE NOT EXISTS(SELECT DT.MADT
				FROM DETAI DT JOIN CHUDE CD ON DT.MACD = CD.MACD
				WHERE CD.TENCD=N'Ứng dụng công nghệ'
				EXCEPT
				SELECT TG1.MADT
				FROM THAMGIADT TG1
				WHERE TG.MAGV=TG1.MAGV AND TG.KETQUA=TG1.KETQUA)
GO

-- Q66. Cho	biết	tên	giáo	viên	nào	đã	tham	gia	tất	cả các	đề tài	của	do	Trần	Trà	Hương	làm	chủ nhiệm.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.HOTEN<>N'Trần Trà Hương' AND GV.MAGV IN (SELECT TG.MAGV
												FROM THAMGIADT TG
												WHERE NOT EXISTS (SELECT DT.MADT
																FROM DETAI DT JOIN GIAOVIEN TTH ON DT.GVCNDT=TTH.MAGV
																WHERE TTH.HOTEN=N'Trần Trà Hương'
																EXCEPT
																SELECT TG1.MADT
																FROM THAMGIADT TG1
																WHERE TG1.MAGV=TG.MAGV ))
GO

-- Q67. Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	khoa	CNTT	tham	gia. 
SELECT DT.TENDT
FROM DETAI DT
WHERE DT.MADT IN (SELECT TG.MADT
				FROM THAMGIADT TG
				WHERE NOT EXISTS(SELECT GV.MAGV
								FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM=BM.MABM 
								WHERE BM.MAKHOA='CNTT'
								EXCEPT
								SELECT TG1.MAGV
								FROM THAMGIADT TG1
								WHERE TG.MADT=TG1.MADT))
GO

-- Q68. Cho	biết	tên	giáo	viên	nào	mà	tham	gia	tất	cả các	công	việc	của	đề tài	Nghiên	cứu	tế bào	gốc.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT TG.MAGV
				FROM THAMGIADT TG
				WHERE NOT EXISTS(SELECT DT.MADT, CV.SOTT
								FROM DETAI DT JOIN CONGVIEC CV ON DT.MADT=CV.MADT
								WHERE DT.TENDT = N'Nghiên cứu tế bào gốc'
								EXCEPT
								SELECT TG1.MADT, TG1.STT
								FROM THAMGIADT TG1
								WHERE TG.MAGV = TG1.MAGV))
GO

-- Q69. Tìm	tên	các	giáo	viên	được	phân	công	làm	tất	cả các	đề tài	có	kinh	phí	trên	100	triệu?
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT TG.MAGV
				FROM THAMGIADT TG
				WHERE NOT EXISTS( SELECT DT.MADT
								FROM DETAI DT
								WHERE DT.KINHPHI > 100
								EXCEPT
								SELECT TG1.MADT
								FROM THAMGIADT TG1
								WHERE TG.MAGV = TG1.MAGV))
GO

-- Q70. Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	khoa	Sinh	Học	tham	gia
SELECT DT.TENDT
FROM DETAI DT
WHERE DT.MADT IN (SELECT TG.MADT
				FROM THAMGIADT TG
				WHERE NOT EXISTS(SELECT GV.MAGV
								FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM=BM.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA
								WHERE K.TENKHOA=N'Sinh học'
								EXCEPT
								SELECT TG1.MAGV
								FROM THAMGIADT TG1
								WHERE TG.MADT=TG1.MADT))
GO

-- Q71. Cho	biết mã	số,	họ tên,	ngày sinh của giáo viên tham gia tất cả các	công việc của đề tài“ Ứng dụng hóa học xanh”.
SELECT GV.MAGV, GV.HOTEN, GV.NGSINH
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT TG.MAGV
				FROM THAMGIADT TG
				WHERE NOT EXISTS( SELECT DT.MADT, CV.SOTT
								FROM DETAI DT JOIN CONGVIEC CV ON DT.MADT = CV.MADT
								WHERE DT.TENDT=N'Ứng dụng hóa học xanh'
								EXCEPT
								SELECT TG1.MADT, TG1.STT
								FROM THAMGIADT TG1
								WHERE TG.MAGV = TG1.MAGV))
GO

--Q72. Cho	biết mã	số,	họ tên,	tên	bộ môn	và	tên	người quản lý	chuyên	môn	của	giáo viên tham	gia	tất	cả các	đề tài	
--thuộc	chủ đề “Nghiên	cứu	phát	triển”.
SELECT GV.MAGV, GV.HOTEN, BM.TENBM, GVQL.HOTEN
FROM GIAOVIEN GV JOIN GIAOVIEN GVQL ON GV.GVQLCM=GVQL.MAGV JOIN BOMON BM ON GV.MABM=BM.MABM
WHERE GV.MAGV IN (SELECT TG.MAGV
				FROM THAMGIADT TG
				WHERE NOT EXISTS(SELECT DT.MADT
								FROM DETAI DT JOIN CHUDE CD ON DT.MACD = CD.MACD
								WHERE CD.TENCD = N'Nghiên cứu phát triển'
								EXCEPT
								SELECT TG1.MADT
								FROM THAMGIADT TG1
								WHERE TG.MAGV=TG1.MAGV))
GO


