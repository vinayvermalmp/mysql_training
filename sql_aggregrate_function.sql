/*
What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?
*/
use employees;

SELECT
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
/*
1. Which is the lowest employee number in the database?
2. Which is the highest employee number in the database?
*/
SELECT
    MIN(emp_no)
FROM
    employees;

SELECT
    MAX(emp_no)
FROM
    employees;
    
/*
What is the average annual salary paid to employees who started after the 1st of January 1997?
*/
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; 
    
/*
Round the average amount of money spent on salaries for all contracts 
that started after the 1st of January 1997 to a precision of cents.
*/
SELECT 
    round(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; 

/*
intro and hou to use IF NULL() and coalesce() 
*/
SELECT * FROM departments_dup;
-- change notnull constrant to null ... to hold dept_name column null value..
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');
SELECT * FROM departments_dup ORDER BY dept_no ASC;
ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;
SELECT * FROM departments_dup ORDER BY dept_no ASC;
COMMIT;
SELECT
	dept_no,
    ifnull(dept_name, 'department not found') as dept_name
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT
	dept_no,
    dept_name,
    -- ifnull(dept_name, 'department not found') as dept_name,
    coalesce(dept_manager, dept_name, 'N/A') as dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
HAVING emps_with_same_salary > 15
ORDER BY salary;

SELECT 
	emp_no , count(from_date) 
FROM 
dept_emp
WHERE 
 from_date > '2000-01-01'
 GROUP BY emp_no
 HAVING count(from_date) > 1
 ORDER BY emp_no;
