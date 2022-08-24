
-- create table Trainee 

use Fsoft_Training
go

create table Trainee(
TraineeID  int identity(1,1) primary key,
Full_Name  nvarchar(50),
Birth_Date date,
Gender char(1),
ET_IQ  int constraint check_num CHECK (ET_IQ BETWEEN 0 and 20),
ET_Gmath int constraint check_num2 CHECK (ET_Gmath between 0 and 20),
ET_English int constraint ck_range CHECK (ET_English between 0 and 50),
Training_Class int ,
Evaluation_Notes text
)


ALTER TABLE Trainee
ADD Fsoft_Acount varchar(255) not null unique;

insert into Trainee values('Huynh Thanh Khoi','01/01/1990','1',10,10,30,0023,'khong co gi','KhoiHT2')
insert into Trainee values(N'Nguyễn Văn A','01/01/1990','1',10,10,30,0023,'khong co gi','CC1')
insert into Trainee values(N'Nguyễn Văn C','01/01/1990','1',10,10,30,0023,'khong co gi','CC2')
insert into Trainee values(N'Nguyễn Văn D','01/01/1990','1',10,10,30,0023,'khong co gi','DD1')
insert into Trainee values(N'Trần Văn A','01/01/1990','1',10,10,30,0023,'khong co gi','ATV1')
insert into Trainee values(N'Trần Văn B','01/01/1990','1',10,10,30,0023,'khong co gi','BTV2')
insert into Trainee values(N'Lê Nguyễn T','01/01/1990','1',10,10,30,0023,'khong co gi','TLN')
insert into Trainee values(N'Đoan Kim Nga','01/01/1990','1',10,10,30,0023,'khong co gi','NDK')
insert into Trainee values(N'Võ Văn Tèo','01/01/1990','1',10,10,30,0023,'khong co gi','TVV')
insert into Trainee values(N'Trần Thị Bé','01/01/1990','1',10,10,30,0023,'khong co gi','BTT')

--- SELECT COUNT(Gender a) FROM Trainee

-- Create view
create view Trainee_passed AS
select * from Trainee
where (ET_IQ + ET_Gmath) >=20 
AND ET_IQ>=8 AND ET_Gmath>=8 AND ET_English>=18

GO


create table PERSON (

PERSON_ID INT IDENTITY (1,1) PRIMARY KEY,
PERSON_NAME NVARCHAR (50),

)


INSERT INT PERSON VALUES()

INSERT 


SELECT CONVERT(varchar, '30/12/2019', 103);