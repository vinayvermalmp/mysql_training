SELECT * FROM titles LIMIT 10;

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

INSERT INTO titles
(
emp_no,
title,
from_date
)
VALUES
(
	 999903,
    'Senior Engineer',
    '1997-10-01'
);

SELECT
    *
FROM
    titles
ORDER BY emp_no DESC;

-- *************
SELECT
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into dept_emp
(
	emp_no,
    dept_no,
    from_date,
    to_date
)
values
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);

INSERT INTO departments VALUES ('d010', 'Business Analysis');
SELECT * FROM departments;

-- ************ inserting data into a new table...ALTER
CREATE TABLE departments_dup
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) not NULL
);

SELECT * FROM departments_dup;

INSERT INTO departments_dup
(
dept_no,
dept_name
)
SELECT * FROM departments;

