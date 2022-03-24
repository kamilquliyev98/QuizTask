-- 1) Academy databazasını yaradın
CREATE DATABASE CodeAcademy

USE CodeAcademy

-- 2) Groups(İd,Name) ve Students(İd,Name,Surname,Groupİd) table-ları yaradın(one-to-many), təkrar qrup adı əlavə etmək olmasın
CREATE TABLE  Groups
(
	Id int Primary key Identity,
	Name nvarchar(20) unique
)

CREATE TABLE Students
(
	Id int Primary key Identity,
	Name nvarchar(25),
	Surname nvarchar(25),
	GroupId int references Groups(Id)
)

-- 3) Students table-na Grade (int) kalonunu əlavə etmək
ALTER TABLE Students
ADD Grade int

-- 4) Groups table-na 3 data(P224,P124,P221), Students table-na 4 data əlavə edin(1 tələbə p221 qrupna, 3 tələbə p224 qrupuna aid olsun)
INSERT INTO Groups
VALUES('P224'),
('P124'),
('P221')

INSERT INTO Students(Name, Surname, Grade, GroupId)
VALUES('Ali', 'Aliyev', 55, 3),
('Sarkhan', 'Rzayev', 90, 1),
('Kamil', 'Guliyev', 84, 1),
('Vaqif', 'Semedov', 75, 1)

-- 5) P224 qrupuna aid olan tələbələrin siyahisini gosterin
SELECT s.Name 'Telebenin adi', s.Surname 'Telebenin soyadi', s.Grade 'Topladigi bal', g.Name 'Oxudugu qrup' FROM Students s
JOIN Groups g
ON s.GroupId = g.Id
WHERE g.Id = 1

-- 6) Her qrupda neçə tələbə olduğunu göstərən siyahı çıxarmaq
SELECT g.Name 'Qrup', COUNT(*) 'Telebe sayi' FROM Groups g
JOIN Students s
ON g.Id = s.GroupId
Group by g.Name

-- 7) View yaratmaq - tələbə adını, qrupun adını-qrup kimi , tələbə soyadını, tələbənin balını göstərməli
CREATE VIEW usv_ShowTable
AS
SELECT s.Name 'Telebenin adi', s.Surname 'Telebenin soyadi', s.Grade 'Telebenin bali', g.Name 'Qrup' FROM Students s
JOIN Groups g
ON s.GroupId = g.Id

SELECT * FROM usv_ShowTable

-- 8) Procedure yazmalı - göndərilən baldan yüksək bal alan tələbələrin siyahısını göstərməlidir
CREATE PROCEDURE usp_ShowGradesTable(@Grade int)
AS
BEGIN
SELECT * FROM Students
WHERE Grade > @Grade
END

exec usp_ShowGradesTable 80

-- 9) Funksiya yazmalı - göndərilən qrup adina uyğun neçə tələbə olduğunu göstərməlidir
CREATE FUNCTION dbo_StudentCount(@GroupName nvarchar)
AS
BEGIN
SELECT Count(*) 'Telebe sayi' FROM Groups g
JOIN Students s
ON g.Id = s.GroupId
END