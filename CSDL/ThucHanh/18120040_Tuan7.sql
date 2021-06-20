use QLHV2222
go

--8.	List the teachers assigned to teach "Data Mining".
SELECT T.*
FROM Teacher T JOIN Course CR ON T.ID=CR.TeacherID 
WHERE CR.SubjectID IN (SELECT SJ.ID	
					 FROM SUBJECT SJ
					 WHERE SJ.Name = 'Data Mining')
GO

--9.	List the name of the subjects that the teacher named "Nhan Lan" was 
SELECT T.*
FROM Teacher T JOIN Course CR ON T.ID=CR.TeacherID JOIN SUBJECT SJ ON SJ.ID=CR.SubjectID
WHERE T.Name='Nhan Lan'
GO

--10.	Show how many students have passed "Basic Informatics".
SELECT COUNT(DISTINCT RS.StudentID) AS Pass_BI
FROM Result RS JOIN Subject SJ ON RS.SubjectID=SJ.ID
WHERE SJ.Name = 'Basic Informatics' AND RS.Mark>=5
AND RS.Times >= ALL (SELECT RS1.Times
					FROM Result RS1
					WHERE RS.StudentID=RS1.StudentID AND RS.SubjectID=RS1.SubjectID)
GO

--11.	List the subjects that the student named "Kieu" studies in
SELECT SJ.*
FROM Subject SJ JOIN  Course CR ON SJ.ID = CR.SubjectID
WHERE CR.ClassID IN (SELECT ST.ClassID
					FROM Student ST
					WHERE ST.Name LIKE '%Kieu%')
GO

--12.	List the teachers who are managed by another teacher.
--      Provide the information including the teacher name and the manager name.
SELECT T.Name AS Teacher, MT.Name AS Manager
FROM Teacher T JOIN Teacher MT ON T.ManagerID=MT.ID
GO

--13.	Provide information about students who have taken the most mark in 'Computer Networks'
SELECT DISTINCT ST.*
FROM Student ST
WHERE ST.ID IN (SELECT RS.StudentID
				FROM Result RS JOIN  Subject SJ ON RS.SubjectID=SJ.ID
				WHERE SJ.Name = 'Computer Networks'
				AND RS.Mark>=ALL(SELECT RS1.Mark
									FROM Result RS1 
									WHERE RS.SubjectID=RS1.SubjectID))
GO

--14.  Provide information about students who have pass the most number of subjects.
SELECT *
FROM Student
WHERE ID IN (SELECT RS.StudentID
			FROM (SELECT R.* --Chon ra ket qua cuoi cung cua tung mon hoc cua tung hoc vien
					FROM Result R
					WHERE R.Times>=ALL(SELECT R1.Times
									FROM Result R1
									WHERE R.StudentID=R1.StudentID AND R.SubjectID = R1.SubjectID)) RS
			WHERE RS.Mark>=5
			GROUP BY RS.StudentID
			HAVING COUNT(*) >= ALL(SELECT COUNT(*)
								FROM (SELECT R.* --Chon ra ket qua cuoi cung cua tung mon hoc cua tung hoc vien
								FROM Result R
								WHERE R.Times>=ALL(SELECT R1.Times
									FROM Result R1
									WHERE R.StudentID=R1.StudentID AND R.SubjectID = R1.SubjectID)) RS
								WHERE RS.Mark>=5
								GROUP BY RS.StudentID))
GO

--15.	Indicate the GPA of the student ‘Nguyen Van An’
SELECT SUM(RS.Mark * SJ.Credits) / SUM(SJ.Credits) AS 'GPA'
FROM Result RS JOIN Subject SJ ON RS.SubjectID=SJ.ID
WHERE RS.Times >= ALL(SELECT R1.Times
									FROM Result R1
									WHERE RS.StudentID=R1.StudentID AND RS.SubjectID = R1.SubjectID)
	AND RS.StudentID IN (SELECT ST.ID
						FROM Student ST
						WHERE ST.Name = N'Nguyễn Thành An')
GO



