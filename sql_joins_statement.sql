use employees;

ALTER TABLE employees.departments_dup
DROP COLUMN dept_manager; 
SELECT * FROM departments_dup ORDER BY dept_no ASC;
ALTER TABLE employees.departments_dup
CHANGE COLUMN dept_no dept_no VARCHAR(4) NULL;

INSERT INTO employees.departments_dup (dept_name) VALUES('Public Relations');
COMMIT;
DELETE FROM employees.departments_dup WHERE dept_no = 'd002';

-- create another table name dept_manager_dup

DROP TABLE IF EXISTS employees.dept_manager_dup;

CREATE TABLE employees.dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);
INSERT INTO employees.dept_manager_dup
select * from employees.dept_manager;

INSERT INTO employees.dept_manager_dup (emp_no, from_date)
VALUES 
(999904, '2017-01-01'), 
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM employees.dept_manager_dup WHERE dept_no = 'd001';
/*
inner join....
*/
SELECT * FROM employees.dept_manager_dup ORDER BY dept_no ASC;
SELECT * FROM employees.departments_dup ORDER BY dept_no ASC;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN  -- INNER JOIN = JOIN same same 	
    departments_dup d ON m.dept_no = d.dept_no
-- GROUP BY m.emp_no to handel duplicate record if two table have any duplicate record
ORDER BY dept_no ASC;

/*
Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
*/
SELECT 
    emp.emp_no,
    emp.first_name,
    emp.last_name,
    dm.dept_no,
    emp.hire_date
FROM
    employees emp
        INNER JOIN
    dept_manager dm ON emp.emp_no = dm.emp_no
ORDER BY emp.emp_no ASC;

/*
Left JOIN 
all matching values of the two table + 
all values from the left table that matches no value from the right table.
order matter in this join.
LEFT JOIN  = LEFT OUTER JOIN.
left joins can deliver a list with all records from the left table that
do not match any rows from the right table use where clouse
*/

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
      LEFT JOIN  -- LEFT JOIN = LEFT OUTER JOIN 	
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no ASC;

SELECT 
    emp.emp_no,
    emp.first_name,
    emp.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees emp
        LEFT JOIN
    dept_manager dm ON emp.emp_no = dm.emp_no
    WHERE emp.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC, emp.emp_no;


/*
Right JOIN 
identical functionality like LEFT JOIN only difference being that 
the direction of operation is inverted
*/
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
      RIGHT JOIN  -- RIGHT JOIN = RIGHT OUTER JOIN 	
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no ASC;

/*
The new and the old join syntax - exercise
Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date.
Use the old type of join syntax to obtain the result.
*/

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;

-- New Join Syntax:
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no; 
/*
Join & where used togather
*/

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
    WHERE 
    s.salary > 145000; 
    
-- select @@global.sql_mode;
-- set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
-- set @@global.sql_mode := concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);

-- Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
    WHERE e.first_name = 'Margareta' and e.last_name = 'Markovitch'
    ORDER BY e.emp_no;
    
    /*
    CROSS JOIN - exercise 1
Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
*/
SELECT
    dm.*, d.*  
FROM  
    departments d  
        CROSS JOIN  
    dept_manager dm  
WHERE  
    d.dept_no = 'd009'  
ORDER BY d.dept_no;

    /*
    CROSS JOIN - exercise 2
Return a list with the first 10 employees with all the departments they can be assigned to.
Hint: Don’t use LIMIT; use a WHERE clause.
*/

SELECT
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

-- using aggregrate funtion with joins 
SELECT 
    -- e.emp_no,
    e.gender, AVG(s.salary) AS avg_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

/*
Join more than two tables in SQL - exercise
Select all managers’ first and last name, hire date, job title, start date, and department name.
*/

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

-

--  2nd Solution:
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        AND m.from_date = t.from_date
ORDER BY e.emp_no;

/*
Tips and tricks for joins - exercise
How many male and how many female managers do we have in the ‘employees’ database?
*/
SELECT
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

/*
UNION vs UNION ALL - exercise
Go forward to the solution and execute the query. What do you think is the meaning of the
 minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)? 
*/
SELECT
    *
FROM
    (SELECT
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;

/*
Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
*/

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');