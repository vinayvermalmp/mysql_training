SELECT
    *
FROM
    employees
WHERE
    gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');
    
SELECT
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
SELECT
    *
FROM
    employees
WHERE
    first_name NOT IN ('John', 'Mark', 'Jacob');
    
SELECT
    *
FROM
    employees
WHERE
    first_name LIKE('Mark%');
    
SELECT * FROM employees WHERE hire_date LIKE('%2000%');
SELECT * FROM employees WHERE emp_no LIKE('1000_');
SELECT * FROM salaries WHERE salary BETWEEN 66000 AND 70000;  
SELECT * FROM employees WHERE emp_no NOT BETWEEN '10004' AND '10012';
SELECT dept_name FROM departments WHERE dept_no BETWEEN 'd003' AND 'd006';

SELECT * FROM employees WHERE gender = 'F' AND (hire_date like('2000%'));

SELECT * FROM employees WHERE hire_date >= '2000-01-01'AND gender = 'F';

SELECT * FROM salaries WHERE salary > 150000;
SELECT DISTINCT
    hire_date
FROM
    employees;

SELECT count(*) FROM salaries WHERE salary >= 100000;
SELECT
    COUNT(*)
FROM
    dept_manager;
    
SELECT * FROM employees ORDER BY hire_date DESC;

SELECT
    first_name, count(first_name) AS names_count
FROM
    employees
 GROUP BY first_name
 ORDER BY first_name;
 
 -- extract all salaries that appear more then 20 times in the salary table and also salaary must be > 80000 dollar
 SELECT salary, count(emp_no) AS emps_with_same_salary
 FROM salaries
 WHERE salary > 80000 -- AND count(emp_no) > 20, you can't use agg function here
 GROUP BY salary
 HAVING count(emp_no) > 20 -- use agg function here ...with HAVING clouse
 ORDER BY salary;
 
 
 /* 
 Select all employees whose average salary is higher than $120,000 per annum.
Hint: You should obtain 101 records.
 */ 
 
 SELECT
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no; -- not working
 
SELECT
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000; -- not working 

-- final solution 
SELECT
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;
/*
When using WHERE instead of HAVING, the output is larger because in the output 
we include individual contracts higher than $120,000 per year. The output does not contain average salary values.

Finally, using the star symbol instead of “emp_no” extracts a list that contains all columns from the “salaries” table.
*/ 

/*
New Challaenge 
Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.

Hint: To solve this exercise, use the “dept_emp” table.
*/
SELECT 
	emp_no
FROM
	dept_emp
WHERE from_date > '2000-1-1'
GROUP BY emp_no
HAVING count(from_date) > 1
ORDER BY emp_no;

SELECT 
    COUNT(*)
FROM
    employees.salaries
WHERE
    salary >= 100000;

SELECT * from employees.salaries ORDER BY salary desc LIMIT 4;

-- second highest salary -- '157821'
 SELECT
  MAX(salary)
from employees.salaries
WHERE salary < (SELECT MAX(salary) FROM employees.salaries);

-- 4th highest salary -- '155377'
SELECT
  MIN(salary)
from employees.salaries
where salary IN (
 SELECT
  salary
from employees.salaries
ORDER BY salary DESC 
);

SELECT DISTINCT salary FROM employees.salaries ORDER BY salary DESC LIMIT 1 OFFSET 4;
