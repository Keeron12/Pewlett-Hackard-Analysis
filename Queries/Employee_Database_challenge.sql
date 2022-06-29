-- Creating tables for PH-EmployeeDB

CREATE TABLE departments (
	dept_no VARCHAR(4) not null,
	
	dept_name VARCHAR(40) NOT NULL,
	
	PRIMARY KEY (dept_no),
	
	UNIQUE (dept_name)
	
);



CREATE TABLE employees (
	emp_no INT not null,
	
	birth_date DATE NOT NULL,
	
	first_name VARCHAR NOT NULL,
	
	last_name VARCHAR NOT NULL,
	
	gender VARCHAR NOT NULL,
	
	hire_date DATE NOT NULL,
	
	PRIMARY KEY (emp_no)
);



CREATE TABLE dept_manager (
	
	dept_no VARCHAR(4) NOT NULL,
	
	emp_no INT NOT NULL,
	
	from_date DATE NOT NULL,
	
	to_date DATE NOT NULL,
	
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	
	PRIMARY KEY (emp_no, dept_no)

);


CREATE TABLE salaries (
	
	emp_no INT NOT NULL,
	
	salary INT NOT NULL,
	
	from_date DATE NOT NULL,
	
	to_date DATE NOT NULL,
	
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	
	PRIMARY KEY (emp_no)

);

CREATE TABLE dept_emp (
	
	emp_no INT NOT NULL,
	
	dept_no VARCHAR(4) NOT NULL,
	
	from_Date DATE NOT NULL,
	
	to_date DATE NOT NULL,
	
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	
	PRIMARY KEY (emp_no, dept_no)
	
);


CREATE TABLE titles (
	
	emp_no INT NOT NULL,
	
	title VARCHAR NOT NULL,
	
	from_date DATE NOT NULL,
	
	to_date DATE NOT NULL,
	
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

---------------------------------------------------------------------

-- Retrieve the emp_no, first_name, and last_name
-- from employees

SELECT e.emp_no,

    e.first_name,

    e.last_name,
	
	ti.title,

    ti.from_date,

    ti.to_date
	
INTO retirement_titles

FROM employees as e

INNER JOIN titles AS ti

ON (e.emp_no = ti.emp_no)

WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')

ORDER BY e.emp_no;


-- Retrieve the employee number, first and last name, and title
-- columns from retirement titles table

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,

    rt.first_name,

    rt.last_name,

    rt.title

INTO unique_titles

FROM retirement_titles AS rt

WHERE ( to_date = '9999-01-01')

ORDER BY rt.emp_no, to_date DESC;

-- Retreive the number of employees by their most 
-- recent job title who are about to retire

SELECT COUNT(ut.title),

		ut.title

INTO retiring_titles

FROM unique_titles AS ut

GROUP BY ut.title

ORDER BY COUNT(ut.title) DESC;

--------------------------------------------------------

-- Write a query to create a Mentorship Eligibility table
-- that holds the employees who are eligible to participate in the program

SELECT DISTINCT ON (e.emp_no) e.emp_no,

    e.first_name,

    e.last_name,

    e.birth_date,

    de.from_date,

    de.to_date,

    ti.title
    
INTO mentorship_eligibility

FROM employees AS e

INNER JOIN dept_emp AS de

ON (e.emp_no = de.emp_no)

INNER JOIN titles AS ti

ON (e.emp_no = ti.emp_no)

WHERE (de.to_date = '9999-01-01')

AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

ORDER BY e.emp_no;

