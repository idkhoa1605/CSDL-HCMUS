use QLHV2222
go

-- 1. Viet function cho biet diem trung binh cua @classID

create function GetGPA(@studentID varchar(10))
returns int
as begin
	declare @gpa float
	select @gpa=sum(R.Mark*S.Credits)/sum(S.Credits)
	from Result R, Subject S
	where R.SubjectID=s.ID
	and R.StudentID=@studentID
	and R.Times >= all (select R1.Times
						from Result R1 where R1.StudentID= R.StudentID and
						R1.SubjectID= R.SubjectID)
	return @gpa
end
go



create function GetClassGPA(@classID nchar(10))
returns float
as begin
	if(not exists(select * from Class where ID=@classID))
		return 0
	declare @gpa float
	select @gpa = sum(dbo.GetGPA(St.ID))/count(*)
					from Student St
					where St.ClassID=@classID
	return @gpa
end
go

-- Them 1 cot evaluation vao bang Class
alter table Class
add evaluation nvarchar(50)
go

-- Cap nhat evaluation tat ca cac lop do giao vien Nguyen Van An chu nhiem
declare ptr cursor for (select ID from Class where ManagerID in (select T.ID from Teacher T where T.Name=N'Nguyễn Văn An'))
open ptr
declare @classID nchar(10)
fetch next from ptr into @classID
while(@@FETCH_STATUS=0)
begin
	declare @tmp nvarchar(50)
	exec FillEvaClassID @classID, @tmp output
	Update Class set evaluation=@tmp where ID = @classID
	fetch next from ptr into @classID	
end
close ptr
deallocate ptr
go

