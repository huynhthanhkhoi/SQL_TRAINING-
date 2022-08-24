-- Assignment 2_Opt3: Movie Management

use Fsoft_Training
go
-- Q1 table Movie 
-- a
CREATE TABLE Movie(
Movie_ID int identity(1,1) not null PRIMARY KEY,
Movie_name nvarchar (255) not null,
Duration int constraint CK_duration CHECK (Duration >=1) not null,
Genre int constraint CK_genre CHECK (Genre between 1 and 8) not null,
Director nvarchar(255) not null,
Amount_money float not null,
Comments text 
)

go 
-- b
-- table Actor

CREATE TABLE Actor (
Actor_ID int identity (1,1) not null PRIMARY KEY,
Actor_name nvarchar(255) not null,
Age int not null,
Avg_salary float not null,
Nationality nvarchar(100) not null

)

go 

-- c
---  Table Actedin 
DROP TABLE ActedIn

CREATE TABLE ActedIn(
Movie_ID int
CONSTRAINT fk_Movie FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID),
Actor_ID int
CONSTRAINT fk_Actor FOREIGN KEY (Actor_ID) REFERENCES Actor(Actor_ID)
 
)
 
go

--- Q2 add imageLink field to movie unique

--- a
ALTER TABLE Movie
ADD Imagelink nvarchar(500) unique  

go

--- b
INSERT  INTO Movie VALUES('IRON MAN ', 3 , 1, ' abc ' , 10000000,N'không có comments', 'khong có link image')
INSERT  INTO Movie VALUES('PIDERMAN', 5 , 1, ' abc ' , 10000000,N'không có comments', 'khong có link image1')
INSERT  INTO Movie VALUES('BATMAN ', 7 , 1, ' abc ' , 10000000,N'không có comments', 'khong có link image2')
INSERT  INTO Movie VALUES('PHIM 1 ', 6 , 1, ' abc ' , 10000000,N'không có comments', 'khong có link image3')
INSERT  INTO Movie VALUES('PHIM 2 ', 1 , 1, ' abc ' , 10000000,N'không có comments', 'khong có link image4')

--- 
INSERT  INTO Actor VALUES('Nguyen Van A ', 20 , 10000000, ' viet nam ')
INSERT  INTO Actor VALUES('Nguyen Van TT ', 20 , 20000000, ' viet nam ')
INSERT  INTO Actor VALUES('Nguyen Van T ', 20 , 30000000, ' viet nam ')
INSERT  INTO Actor VALUES(N'Nguyen Van Tèo ', 20 , 500000000, ' viet nam ')
INSERT  INTO Actor VALUES(N'Nguyen Van Tí ', 20 , 60000000, ' viet nam ')

UPDATE Actor SET Actor_name=N'NGUYỄN QUANG THẮNG' WHERE Actor_name='Nguyen Van A'


INSERT INTO ActedIn VALUES (1,2)
INSERT INTO ActedIn VALUES (1,1)
INSERT INTO ActedIn VALUES (6,3)
INSERT INTO ActedIn VALUES (7,1)
INSERT INTO ActedIn VALUES (8,2)
INSERT INTO ActedIn VALUES (9,4)
INSERT INTO ActedIn VALUES (9,1)
INSERT INTO ActedIn VALUES (9,3)
INSERT INTO ActedIn VALUES (9,5)


--- Q2 Query tables 
--c
SELECT * FROM Actor WHERE Age >50
--d
SELECT Actor_name, Avg_salary FROM Actor 
ORDER BY Avg_salary DESC

--e

select a.Movie_name 
from Movie a inner join ActedIn b on  a.Movie_ID = b.Movie_ID 
inner join Actor c on c.Actor_ID = b.Actor_ID 
where c.Actor_name='Nguyen Van C'


-- f  

select a.Movie_name from Movie a inner join ActedIn b on a.Movie_ID = b.Movie_ID 
where a.Genre =1 GROUP BY a.Movie_name Having COUNT(a.Movie_name)>3