-- Exploring & cleaning of dataset
SELECT TOP 5 * FROM Salary_Data;

--Checking if Age, Years_of_Experience and Salary column contain non-integer 
SELECT DISTINCT Age from Salary_Data
WHERE isnumeric(Age) = 0; --null value detected
SELECT DISTINCT Years_of_Experience from Salary_Data
WHERE isnumeric(Years_of_Experience) = 0; --null value detected
SELECT DISTINCT Salary from Salary_Data
WHERE isnumeric(Salary) = 0; --null value detected

--removing rows where Salary = NULL
SELECT * from Salary_Data
WHERE Salary IS NULL; --5 rows detected 
--deleting 5 rows from 6704 rows
DELETE FROM Salary_Data
WHERE Salary IS NULL;

--Exploring distinct values of Age, Gender, Job_Title
SELECT DISTINCT Age FROM Salary_Data;

SELECT DISTINCT Gender FROM Salary_Data;

SELECT DISTINCT Job_Title FROM Salary_Data;
SELECT * FROM Salary_Data
WHERE Job_Title IS NULL;

--Checking distinct values of Education_Level. null detected, 
SELECT DISTINCT Education_Level FROM Salary_Data;

--Clean: Bachelor's Degree == Bachelors, Master's Degree == Master's
SELECT DISTINCT REPLACE(Education_Level, 'Bachelor''s Degree', 'Bachelor''s')
FROM Salary_Data;

UPDATE Salary_Data
SET Education_Level = 
(CASE
	WHEN Education_Level LIKE 'Bachelor''s Degree' THEN 'Bachelor''s'
	WHEN Education_Level LIKE 'Master''s Degree' THEN 'Master''s'
	ELSE Education_Level
END);

--Change datatype of Years_of_Experirnce from nvchar to float
ALTER TABLE Salary_Data
ALTER COLUMN Years_of_Experience FLOAT;

SELECT
(CASE 
WHEN Years_of_Experience <5 THEN '0 - 5'
WHEN Years_of_Experience BETWEEN 5 AND 10 THEN '0 - 10'
WHEN Years_of_Experience >10 THEN 'more than 10'
ELSE 'Others'
END) AS Exp_Years
FROM Salary_Data ;

SELECT
(CASE 
WHEN Salary <35000 THEN 'below 35,000'
WHEN Salary BETWEEN 35000 AND 60000 THEN '35,000 - 60,000'
WHEN Salary BETWEEN 60000 AND 100000 THEN '60,000 - 100,000'
WHEN Salary BETWEEN 100000 AND 150000 THEN '100,000 - 150,000'
WHEN Salary BETWEEN 150000 AND 200000 THEN '150,000 - 200,000'
WHEN Salary >200000 THEN 'more than 200,000'
ELSE 'Others'
END) AS Salary_Range
FROM Salary_Data ;

--Analyse dataset

--Relationship between Gender and Job_Title
SELECT COUNT(Job_Title) AS Number_of, Gender, Job_Title
FROM Salary_Data
GROUP BY Gender, Job_Title
ORDER BY Job_Title;

--Relationship between Job_Title, AVG(Salary)
SELECT Job_Title, AVG(Salary) AS Avg_Salary
FROM Salary_Data
GROUP BY Job_Title
ORDER BY Avg_Salary DESC

--Relationship between Gender, Job_Title,Avg(Salary)
SELECT Gender, Job_Title,AVG(Salary) AS Avg_Salary
FROM Salary_Data
GROUP BY GENDER, Job_Title
ORDER BY Avg_Salary DESC;

--Relationship between Gender, Education_Level
SELECT Gender, Education_Level, COUNT(Education_level) AS Num_of
FROM Salary_Data
GROUP BY Education_Level, Gender
ORDER BY Education_Level

--Relationship between Gender, Education_Level, Avg_Salary
SELECT Gender, Education_Level, COUNT(Education_level) AS Num_of, AVG(Salary) AS Avg_Salary
FROM Salary_Data
GROUP BY Education_Level, Gender
ORDER BY Education_Level

SELECT * 
FROM Salary_Data
WHERE Education_Level IS NULL

--Relationship between Gender, Education_Level, Job_Title, Avg_Salary
SELECT Gender, Education_Level, COUNT(Education_level) AS Num_of, Job_Title ,AVG(Salary) AS Avg_Salary
FROM Salary_Data
GROUP BY Education_Level, Gender, Job_Title
ORDER BY Job_Title, Avg_Salary DESC

--Relationship between Education_Level, Job_Title, AVG(Salary)
SELECT Education_Level, Job_Title, AVG(Salary) AS Avg_Salary
FROM Salary_Data
GROUP BY Education_Level, Job_Title
ORDER BY AVG(Salary) DESC

--Relationship between Education_Level, Job_Title, AVG(Salary) and Years_of_Experience
SELECT Education_Level,
Job_Title, AVG(Salary) AS Avg_Salary,
(CASE 
WHEN Years_of_Experience <5 THEN '0 - 5'
WHEN Years_of_Experience BETWEEN 5 AND 10 THEN '0 - 10'
WHEN Years_of_Experience >10 THEN 'more than 10'
ELSE 'Others'
END) AS Exp_Years
FROM Salary_Data
GROUP BY Education_Level, Job_Title,
(CASE 
WHEN Years_of_Experience <5 THEN '0 - 5'
WHEN Years_of_Experience BETWEEN 5 AND 10 THEN '0 - 10'
WHEN Years_of_Experience >10 THEN 'more than 10'
ELSE 'Others'
END)
ORDER BY Avg_Salary DESC;

--Relationship between Gender, Education_Level, Job_Title, Avg_Salary, Years_of_Experience
SELECT Gender, Education_Level, COUNT(Education_level) AS Num_of, Job_Title ,
(CASE 
WHEN Years_of_Experience <5 THEN '0 - 5'
WHEN Years_of_Experience BETWEEN 5 AND 10 THEN '0 - 10'
WHEN Years_of_Experience >10 THEN 'more than 10'
ELSE 'Others'
END) AS Exp_Years,
AVG(Salary) AS Avg_Salary,
SUM(Salary) AS Sum_Salary
FROM Salary_Data
GROUP BY Education_Level, Gender, Job_Title,
(CASE 
WHEN Years_of_Experience <5 THEN '0 - 5'
WHEN Years_of_Experience BETWEEN 5 AND 10 THEN '0 - 10'
WHEN Years_of_Experience >10 THEN 'more than 10'
ELSE 'Others'
END)
ORDER BY Job_Title, Sum_Salary DESC
