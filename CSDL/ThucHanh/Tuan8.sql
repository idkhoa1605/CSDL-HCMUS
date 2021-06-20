use QLHV2222
go

alter table Class
add evaluation nvarchar(50)
go

--Kiem tra student cua 1 class co dau tat ca cac mon co N tin chi
create proc CheckNCreSub 
 @studentID nchar(10), @NumCre int, @result int output 
 as begin
	declare @i int
	select @i = count(*) from
	(select R.StudentID, R.SubjectID, R.Times, R.Mark
	from Subject Sb join Result R on Sb.ID=R.SubjectID 
	where Sb.Credits= @NumCre and R.StudentID = @studentID 
	group by R.StudentID, R.SubjectID, R.Times, R.Mark
	having R.Times >= all (select R1.Times
						from Result R1
						where r.StudentID=r1.StudentID and r.SubjectID=r1.SubjectID
						group by R1.StudentID, R1.SubjectID, R1.Times, R1.Mark)
			and (R.Mark<5 or R.Mark is NULL)) RsTb
	if(@i!=0) --Ton tai 1 mon co khong dat
		set @result =0
	else
		set @result =1
 end
 go

--Tinh diem trung binh cua hoc sinh
create proc CalAveRes @studentID nchar(10), @result float output
as begin
	declare @num int
	declare @sum float
	set @num = 0
	set @sum = 0


	declare a cursor for (select Sb.Credits,R.Mark
	from Subject Sb join Result R on Sb.ID=R.SubjectID 
	where  R.StudentID = @studentID 
	group by Sb.Credits,R.StudentID, R.SubjectID, R.Times, R.Mark
	having R.Times >= all (select R1.Times
						from Result R1
						where r.StudentID=r1.StudentID and r.SubjectID=r1.SubjectID
						group by R1.StudentID, R1.SubjectID, R1.Times, R1.Mark)) 

	open a
	declare @temp1 int
	declare @temp2 float
	fetch next from a into @temp1, @temp2
	while (@@FETCH_STATUS = 0)
	begin
		if(@temp2 is NULL) set @temp2=0
		set @num = @num + @temp1
		set @sum = @sum + @temp2*@temp1
		fetch next from a into @temp1, @temp2
	end
	set @result = @sum/@num
	close a
	deallocate a
end
go 

create proc FillEvaClassID @classID nchar(10),
	@result nvarchar(50) output
as 
begin
	--Buoc 1
	declare @check int
	select @check = count(*) from Class where ID=@classID
	if(@check=0)	return
	
	--Buoc 2
	declare b cursor for (select ID from Student where ClassID=@classID)
	open b
	declare @flag int
	declare @stuID nchar(10)
	declare @numStu int
	declare @temp float
	declare @sum float
	set @numStu = 1
	set @sum=0
	fetch next from b into @stuID
	exec CheckNCreSub @stuID,4, @flag output
	while(@@FETCH_STATUS = 0)
	begin
		if(@flag=0)
		begin
			set @result=N'Không đạt'
			return
		end
		else
		begin
			exec CalAveRes @stuID,@temp output
			set @sum = @sum+@temp
			set @numStu=@numStu+1
		end
		fetch next from b into @stuID
	end
	-- Buoc 3: Tinh diem trung binh lop
	set @sum = @sum / (@numStu - 1)
	if (@sum > 7)
		set @result = N'Giỏi'
	else
		set @result = N'Khá'
	close b
	deallocate b

	-- Buoc 4: Cap nhat evaluation
	UPDATE Class SET evaluation = @result WHERE ID = @classID
end
go

-- Cau 3: Store cap nhat evaluation cua tat ca cac Class
create proc UpdateEvaluation
as begin
	declare c cursor for (select ID from Class)
	open c
	declare @temp nvarchar(50)
	declare @classID nchar(10)
	fetch next from c into @classID
	while(@@FETCH_STATUS=0)
	begin
		exec FillEvaClassID @classID, @temp
		fetch next from c into @classID
	end
	close c
	deallocate c
end
go

-- In tung sinh vien dau cac mon 4 tin chi
create proc StudentPassFourCredits @classID nchar(10)
as begin
	declare d cursor for (select ID, Name from Student where ClassID = @classID)
	declare @i int
	declare @teacherName nvarchar(50)
	select @teacherName = T.Name 
	from Class Cl join Teacher T on Cl.ManagerID=T.ID
	where Cl.ID = @classID

	print 'MaLop: ' + @classID + N'  Tên GVCN: ' + @teacherName
	print N'	Danh sách sinh viên thi đậu tất cả môn học có 4t/c:'
	set @i = 0
	declare @studentID nchar(10)
	declare @studentName nvarchar(50)
	open d
	fetch next from d into @studentID, @studentName
	while(@@FETCH_STATUS = 0)
	begin
		declare @flag int
		exec CheckNCreSub @studentID, 4, @flag output
		if(@flag=1)
		begin
			set @i = @i+1
			print '		' + cast(@i as varchar(10)) + N'. Tên SV: ' + @studentName
		end
		fetch next from d into @studentID, @studentName
	end
	print N'Tổng cộng: ' + cast(@i as varchar(10)) + ' SV'
	close d
	deallocate d
end
go

-- Cau 4 in report
create proc FourCreditsSubjectPassReport
as begin
	declare e cursor for (select ID from Class)
	declare @classID nchar(10)
	open e
	fetch next from e into @classID
	while(@@FETCH_STATUS = 0)
	begin
		exec StudentPassFourCredits @classID
		fetch next from e into @classID
	end
	close e
	deallocate e
end
go

exec FourCreditsSubjectPassReport
go