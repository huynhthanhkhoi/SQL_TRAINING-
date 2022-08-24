-- Create table Employee, Status = 1: are working
CREATE DATABASE EMS
USE EMS
GO
CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL
,	[EmpName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[BirthDay] [datetime] NOT NULL
,	[DeptNo] [int] NOT NULL
, 	[MgrNo] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[StartDate] [datetime] NOT NULL
,	[Salary] [money] NOT NULL
,	[Status] [int] NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
,	[Level] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE Employee 
ADD CONSTRAINT PK_Emp PRIMARY KEY (EmpNo)
GO

ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Level] 
	CHECK  (([Level]=(7) OR [Level]=(6) OR [Level]=(5) OR [Level]=(4) OR [Level]=(3) OR [Level]=(2) OR [Level]=(1)))
GO
ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Status] 
	CHECK  (([Status]=(2) OR [Status]=(1) OR [Status]=(0)))

GO
ALTER TABLE [dbo].[Employee]
ADD Email NCHAR(30) 
GO

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT chk_Email CHECK (Email IS NOT NULL)
GO

ALTER TABLE [dbo].[Employee] 
ADD CONSTRAINT chk_Email1 UNIQUE(Email)

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_EmpNo DEFAULT 0 FOR EmpNo

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status

GO
CREATE TABLE [dbo].[Skill](
	[SkillNo] [int] IDENTITY(1,1) NOT NULL
,	[SkillName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Skill
ADD CONSTRAINT PK_Skill PRIMARY KEY (SkillNo)

GO
CREATE TABLE [dbo].[Department](
	[DeptNo] [int] IDENTITY(1,1) NOT NULL
,	[DeptName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Department
ADD CONSTRAINT PK_Dept PRIMARY KEY (DeptNo)

GO
CREATE TABLE [dbo].[Emp_Skill](
	[SkillNo] [int] NOT NULL
,	[EmpNo] [int] NOT NULL
,	[SkillLevel] [int] NOT NULL
,	[RegDate] [datetime] NOT NULL
,	[Description] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT PK_Emp_Skill PRIMARY KEY (SkillNo, EmpNo)
GO

ALTER TABLE Employee  
ADD  CONSTRAINT [FK_1] FOREIGN KEY([DeptNo])
REFERENCES Department (DeptNo)

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_2] FOREIGN KEY ([EmpNo])
REFERENCES Employee([EmpNo])

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_3] FOREIGN KEY ([SkillNo])
REFERENCES Skill([SkillNo])

GO

--Question A THÊM 8 DÒNG DỮ LIỆU CHO MỖI TABLE 

INSERT Department(DeptName, Note) VALUES
(N'Lãnh đạo', NULL),
(N'Hành chính', null),
(N'Kế toán', null),
(N'Sản xuất', null),
(N'Kinh doanh', null),
(N'Tổng hợp', null),
(N'Logictis', null),
(N'Quản Lý', null)

GO
INSERT Skill(SkillName, Note) VALUES
(N'JavaScript', null),
(N'C', null),
(N'C#', null),
(N'Java', null),
(N'.Net', null),
(N'PHP', null),
(N'Python', null),
(N'Ruby', null)

INSERT Employee(EmpNo, EmpName, BirthDay, DeptNo, StartDate, Salary, [Level], [Status], Note, Email, MgrNo) VALUES
(1, N'Huỳnh Thanh Khởi ', '19900101', 1,'20220816', 900.5, 1, 0,N'Tốt', 'khoi@gmail.com',N'NV01'),
(2, N'Phan Phú Thọ', '19960101', 2,'20220816', 700.5, 4, 0,N'Tốt', 'tho@gmail.com',N'NV02'),
(3, N'Phạm Phú Huy', '19970101', 3,'20220816', 40.5, 5, 2, N'Tốt', 'huy@gmail.com',N'NV03'),
(4, N'Nguyễn Văn Hiển', '19980101', 4,'20220816', 300.5, 3, 1, N'Tốt', 'hien@gmail.com',N'NV04'),
(5, N'Nguyễn Anh Tài', '19970101', 5,'20220816', 400.5, 2, 1, null, 'tai@gmail.com',N'NV05'),
(6, N'Lê Bá Ôn', '20000101', 1,'20220816', 900.5, 1, 0, N'Tốt', 'on@gmail.com',N'NV06'),
(7, N'Phạm Ngọc Thạch', '20010101', 2,'20220816', 700.5, 4, 0, N'Tốt', 'thach@gmail.com',N'NV07'),
(8, N'Lê Dương', '19970101', 3,'20220816', 40.5, 5, 2, N'Tốt', 'duong@gmail.com',N'NV08'),
(9, N'Nguyễn Đình Tâm','19970101', 4,'20220816', 300.5, 3, 1, N'Tốt', 'tam@gmail.com',N'NV09')

GO

INSERT Emp_Skill(SkillNo, EmpNo, SkillLevel, RegDate, [Description]) VALUES
(1, 2, 5, '20221003', null),
(1, 3, 2, '20210103', null),
(2, 1, 5, '20190203', null),
(3, 1, 3, '20011003', null),
(4, 4, 5, '20190528', null),
(5, 5, 5, '20221101', null),
(2, 6, 1, '20210303', null),
(7, 7, 2, '20211003', null),
(1, 8, 3, '20021203', null),
(3, 8, 5, '20221012', null)

GO

--Question B tên , email departmentname của nhân viên làm việc ít nhất 6 tháng 

SELECT Em.EmpName,EM.Email,D.DeptName 
FROM Employee EM INNER JOIN Department D ON EM.DeptNo=D.DeptNo
WHERE DATEDIFF(month, EM.StartDate, GETDATE()) >= 6


--Question C NHÂN VIÊN CÓ SKILL C++ HOẶC .NET
SELECT A.EmpName, C.SkillName 
FROM Employee A INNER JOIN Emp_Skill B
ON B.EmpNo = A.EmpNo INNER JOIN Skill C 
ON B.SkillNo = C.SkillNo 
WHERE SkillName = N'C++' OR SkillName = '.Net'

--Question d Liệt kê tất cả tên nhân viên, tên người quản lý, email người quản lý của những nhân viên đó. Không có người quản lý trong db

--Question e lấy phong ban có từ 2 nhân viên trở lên và in ra tên nhân viên của mỗi phòng ban

SELECT D.DeptName, E.EmpName FROM Employee E INNER JOIN Department D ON E.DeptNo = D.DeptNo AND D.DeptName IN (
SELECT D.DeptName FROM Employee E INNER JOIN Department D ON E.DeptNo = D.DeptNo GROUP BY DeptName HAVING  COUNT(E.EmpName) >=2
) ORDER BY D.DeptName

-- Question f Liệt kê tất cả tên, email và số kỹ năng của nhân viên và sắp xếp thứ tự tăng dần theo tên của nhân viên.
SELECT E.EmpName, E.Email, COUNT(S.SkillName) AS NumSkill 
FROM Employee E INNER JOIN Emp_Skill ES
ON ES.EmpNo = E.EmpNo INNER JOIN Skill S
ON S.SkillNo =ES.SkillNo 
GROUP BY E.Email, E.EmpName 
ORDER BY E.EmpName 

-- Question G tạo view để liệt kê tất cả nhân viên đang làm việc (bao gồm: tên nhân viên và tên kỹ năng, tên bộ phận).
CREATE VIEW EmployeeWork AS
SELECT E.EmpName, S.SkillName, D.DeptName 
FROM Employee E INNER JOIN Emp_Skill ES
ON E.EmpNo = ES.EmpNo INNER JOIN Skill S ON S.SkillNo = ES.SkillNo INNER JOIN Department D 
ON E.DeptNo = D.DeptNo 
