use QLHV2222
go

-- Cau 1: Danh sach cac sinh vien thi dau tat ca mon hoc da mo
select DISTINCT S.ID as studentID, S.Name as studentName
from Student S join Result R on S.ID = R.StudentID
where R.Times>= all( select R1.times
				from Result R1 where R1.studentID= R.studentID and
				R1.subjectID= R.subjectID)
	and R.Mark>=5
	and not exists(select C.SubjectID
					from Course C
					where S.ClassID=C.ClassID
					except
					select R1.SubjectID
					from Result R1 where R1.studentID= R.studentID and
					R1.Times=R.Times and R1.Mark=R.Mark) 
go

-- Cau 2: Giao vien day lop ho chu nhiem nhieu nhat
select T.ID as teacherID, T.Name as teacherName
from Teacher T
where T.ID in (select T1.ID
			from (Teacher T1 join Class Cl on T1.ID=Cl.ManagerID)
			join Course Cr on (T1.ID = Cr.TeacherID and Cl.ID=Cr.ClassID)
			group by T1.ID,Cl.ID,T1.Name
			having count(*)>= all(select count(*)
								from Teacher T2 join Class Cl1 on T2.ID=Cl1.ManagerID
								join Course Cr1 on T2.ID = Cr1.TeacherID and Cl1.ID=Cr1.ClassID
								group by T2.ID, T2.Name,Cl1.ID))
go

-- Cau 3
alter table Student
add Graduate nvarchar(50)
go

create proc isGradute @studentID nchar(10), @result nvarchar(50) output
as begin
	if(not exists (select * from Student where ID=@studentID))
		return
	--Buoc 1
	--So tin chi thi dau > 30
	set @result=N'chưa tốt nghiệp'
	declare @NumCre int
	select @NumCre = sum(Sbj.Credits) from Result R join Subject Sbj on R.SubjectID=Sbj.ID
							where R.Mark >= 5
							and R.Times >= all( select R1.times
											from Result R1 where R1.studentID= R.studentID and
											R1.subjectID= R.subjectID)
							and R.StudentID=@studentID
	if (@NumCre<=30)
		return
	-- Dau tat ca cac mon co 4 t/c cua nha truong
	declare @pass4Cre int
	select @pass4Cre = count(*)	from Result R
								where R.StudentID=@studentID
								and not exists(select Sb.ID
												from Subject Sb
												where Sb.Credits=4
												except 
												select R1.SubjectID
												from Result R1
												where R.Mark=R1.Mark and R.StudentID=R1.StudentID and R.Times=R1.Times)
								and R.Mark >= 5
								and R.Times >= all( select R1.times
											from Result R1 where R1.studentID= R.studentID and
											R1.subjectID= R.subjectID)
	if(@pass4Cre!=1) return

	--Buoc 2
	declare @gpa4cre float
	select @gpa4cre = sum(R.Mark*Sbj.Credits)/sum(Sbj.Credits) from Result R join Subject Sbj on R.SubjectID =Sbj.ID
															where R.StudentID=@studentID
															and R.Mark >= 5
															and R.Times >= all( select R1.times
															from Result R1 where R1.studentID= R.studentID and
															R1.subjectID= R.subjectID)
	if(@gpa4cre>=8)
		set @result=N'Giỏi'
	else 
		set @result=N'Khá'
end 
go

-- Cau 4 Store cap nhat graduate cua tat ca sinh vien do 1 giao vien chu nhiem 
create proc UpdateGraduateNVA @teacherName nvarchar(50)
as begin
	declare gv cursor for (select St.ID from Student St, Teacher T, Class C 
							where St.ClassID=C.ID and T.ID = C.ManagerID and T.Name=@teacherName)
	open gv
	declare @studentID nchar(10)
	declare @res nvarchar(50)
	fetch next from gv into @studentID
	while(@@FETCH_STATUS=0)
	begin
		exec isGradute @studentID, @res output
		update Student set Graduate=@res where ID=@studentID
		fetch next from gv into @studentID
	end
	close gv
	deallocate gv
end
go

-- cap nhat store cho sinh vien do gv NGuyen Van An chu nhiem
exec UpdateGraduateNVA N'Nguyễn Văn An'
go
					
					
															
			
								