--Creating database UNIVERSITY STUDENT RECORD
Create Database StudentRecords;
use UniversityStudentRecords;

--Creating Students tables
Create Table StudentDetails(
StudentID Varchar(10) PRIMARY KEY,
FirstName Varchar(20),
LastName  Varchar(20),
DateofBirth date,
Gender Char(10),
EnrollmentYear int,
Major Char(50)
);

Select* from StudentDetails

-- Creating Courses Table
Create Table CoursesDetails(
CourseID Varchar(20) PRIMARY KEY,
CourseName VArchar(100),
Credits int,
Department Varchar(50)
)

Select* from CoursesDetails


-- Creating Grades Table
Create Table GradesDetails(
GradeID Varchar(10) PRIMARY KEY,
StudentID Varchar(10),
CourseID VArchar(10),
Grade float,
Semester Varchar (20)
);
ALTER TABLE GradesDetails
ADD CONSTRAINT FK_Grades_Students
FOREIGN KEY (StudentID) REFERENCES StudentDetails(StudentID);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Courses
FOREIGN Key (CourseID) REFERENCES CoursesDetails(CourseID)

Select* from GradesDetails

-- Creating Attendance Table
Create Table AttendanceDetails(
AttendanceID Varchar(10) PRIMARY KEY,
StudentID Varchar(10),
CourseID VArchar(10),
Date date,
Status Varchar (20)
);
Select* from AttendanceDetails

--ADDING DATA TO THE STUDENT TABLES
INSERT INTO StudentDetails(
StudentID,FirstName,LastName,DateofBirth,Gender,EnrollmentYear,Major)
VALUES
('RUG001','JOHN','DOE','2000-04-05','Male',2019,'COMPUTER SCIENCE'),
('RUG002','DAVID','ESTHER','2002-02-05','Female',2021	,'MATHEMATICS'),
('RUG003','LAWRENCE','MATTEW','2001-07-05','Male',2020	,'COMPUTER SCIENCE'),
('RUG004','VINCENT','PEACE','2005-05-12	','Female',2022	,'PHYSIS'),
('RUG005','PAUL','SAMUEL','2002-09-12','Male',2019	,'CHEMISTRY'),
('RUG006','JOHNSON','RUTH','2000-05-03','Female',2019	,'MATHEMATICS'),
('RUG007','LOVE','ALICE','2002-07-02','Female',2018	,'COMPUTER SCIENCE'),
('RUG008','IKECHI','HAPPINESS','2005-10-08','Female',2020	,'MECHANICAL ENGINEERING'),
('RUG009', 'JOVITA' ,'BLESSING','2002-08-10	','Male',2022	,'MATHEMATICS'),
('RUG010','ALABI','DAVID','2004-01-11','Male',2021	,'PHYSIS')

Select* from StudentDetails

-- ADDING DATA INTO COURSE TABLE
INSERT INTO CoursesDetails(
CourseID, CourseName, Credits,Department)
VALUES
('MAT101','INTRODUCTION TO MATHEMATICS', 3,'MATHEMATICS'),
('CSC102','INTRODUCTION TO COMPUTER', 4,'COMPUTER SCIENCE'),
('PHY103','INTRODUCTION TO PHYSIS', 3,'PHYSIS'),
('CHM101','INTRODUCTION TO CHEMISTRY', 2,'CHEMISTRY'),
('CSC104','DATA ANALYSIS', 5,'COMPUTER SCIENCE'),
('MAT105','QUADRATIC EQUATION', 4,'MATHEMATICS'),
('MEG101','INTRODUCTION TO ENGINEERING', 3,'MECHANICAL ENGINNERING'),
('CSC107','INTRODUCTION TO PROGRAMMING', 6,'COMPUTER SCIENCE'),
('PHY101','INTRODUCTION TO FORCE', 3,'PHYSIS'),
('CHM111','INTRODUCTION TO ORGANIC CHEMISTRY', 1,'CHEMISTRY')

Select* from CoursesDetails

--ADDING DATA INTO GRADE TABLE
INSERT INTO GradesDetails(
GradeID,StudentID,CourseID,Grade,Semester)
VALUES
(1,'RUG001','CSC102',3.75,'SECOND SEMESTER'),
(2,'RUG002','MAT101',3.98,'FIRST SEMESTER'),
(3,'RUG003','CSC104',4.45,'SECOND SEMESTER'),
(4,'RUG004','PHY101',3.88,'FIRST SEMESTER'),
(5,'RUG005','CHM101',3.99,'FIRST SEMESTER'),
(6,'RUG006','MAT105',4.50,'FIRST SEMESTER'),
(7,'RUG007','CSC107',3.30,'SECOND SEMESTER'),
(8,'RUG008','MEG101',3.67,'FIRST SEMESTER'),
(9,'RUG009','CHM102',3.45,'SECOND SEMESTER'),
(10,'RUG010','CHM111',4.70,'SECOND SEMESTER')

Select* from GradesDetails


--ADDING DATA INTO ATTENDANCE COLUMN
INSERT INTO AttendanceDetails(
AttendanceID,StudentID,CourseID,Date,Status)
VALUES
(1,'RUG001','MAT101','2023-09-01','PRESENT'),
(2,'RUG002','CSC101','2022-08-10','ABSENT'),
(3,'RUG003','PHY101','2024-05-12','PRESENT'),
(4,'RUG004','CHM101','2023-04-11','ABSENT'),
(5,'RUG005','MAT105','2024-01-01','LATE'),
(6,'RUG006','CSC104','2025-02-01','PRESENT'),
(7,'RUG007','MEG101','2024-03-12','ABSENT'),
(8,'RUG008','CSC107','2022-04-01','PRESENT'),
(9,'RUG009','GEO101','2024-09-06','LATE'),
(10,'RUG010','CHM102','2023-11-01','ABSENT')

Select* from AttendanceDetails


--1 list of student with their GPA(Grade Point Average)
SELECT S.StudentID, S.FirstName, S.LastName,AVG(G.Grade) AS GPA
FROM StudentDetails AS S
JOIN GradesDetails AS G
ON S.StudentID=G.StudentID
GROUP BY S.StudentID, S.FirstName, S.LastName
HAVING AVG(G.Grade)>=3.5 
ORDER BY GPA DESC

--2 ATTENDANCE PERCENTAGE FOR EACH STUDENT 
SELECT S.StudentID,S.FirstName,S.LastName,ROUND(SUM(CASE WHEN A.Status='PRESENT' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS ATTENDANCEPERCENTAGE
FROM StudentDetails AS S
JOIN AttendanceDetails AS A
ON S.StudentID=A.StudentID
GROUP BY  S.StudentID,S.FirstName,S.LastName

--3 MOST ATTENDED COURSE
SELECT C.CourseName, COUNT(*) AS ATTENDANCECOUNT
FROM AttendanceDetails AS A
JOIN CoursesDetails AS C
ON C.CourseID=A.CourseID
WHERE A.Status='PRESENT'
GROUP BY C.CourseName
ORDER BY ATTENDANCECOUNT

--4 AVERAGE GRADE FOR EACH STUDENT
SELECT S.FirstName,S.LastName,C.CourseName, AVG(G.Grade) AS AVERAGEGRADE
FROM GradesDetails AS G
JOIN CoursesDetails AS C
ON C.CourseID=G.CourseID
JOIN StudentDetails AS S
ON G.StudentID=S.StudentID
GROUP BY S.FirstName,S.LastName,C.CourseName
ORDER BY AVERAGEGRADE DESC

--5 FIND AVERAGE GPA BY MAJOR
SELECT S.Major, ROUND(AVG(G.Grade),2) AS AVERAGEGPA
FROM StudentDetails AS S
JOIN GradesDetails AS G
ON S.StudentID=G.StudentID
GROUP BY S.Major
ORDER BY AVERAGEGPA DESC

--6 IDENTIFY TOP PERFORMING STUDENT IN EACH MAJOR
SELECT S.Major,S.FirstName,S.LastName, AVG(G.Grade) AS GPA
FROM StudentDetails AS S
JOIN GradesDetails AS G
ON S. StudentID=G.StudentID
GROUP BY S.Major,S.FirstName,S.LastName
HAVING AVG(G.Grade) >=3.5
ORDER BY S.Major, GPA  DESC

