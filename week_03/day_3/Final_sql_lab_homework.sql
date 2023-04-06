--MVP
--Q1

SELECT 
	count(id) AS number_employees_null
FROM employees 
WHERE salary IS NULL 
AND grade IS NULL


--MVP
--Q2
SELECT 
	department, 
	concat(first_name, ' ', last_name) AS full_name
FROM employees 
ORDER BY department, last_name 


--MVP
--Q3
SELECT *
FROM employees 
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLs LAST 
LIMIT 10

--MVP
--Q4
SELECT 
	department, 
	count(department) AS num_department
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department


--MVP
--Q5
SELECT 
	department,
	fte_hours,
	count(id) AS num_employees
FROM employees 
GROUP BY department, fte_hours 
ORDER BY department, fte_hours 

--MVP
--Q6
--Provide a breakdown of the numbers of employees enrolled, not enrolled, 
--and with unknown enrollment status in the corporation pension scheme.

SELECT 
	pension_enrol, 
	count(id) AS count_pension_enrol
FROM employees
GROUP BY pension_enrol 


--MVP
--Q7
--Obtain the details for the employee with the highest salary in the ‘Accounting’ department who is not enrolled in the pension scheme?

SELECT *
FROM employees 
WHERE department = 'Accounting'
	AND pension_enrol = FALSE 
ORDER BY salary DESC NULLS LAST 
LIMIT 1

-- MVP
--Q8
--Get a table of country, number of employees in that country, and the average salary of employees in that country 
--for any countries in which more than 30 employees are based. 
--Order the table by average salary descending.


SELECT 
	country,
	count(id) AS employees_per_country,
	avg(salary) AS ave_salary
FROM employees 
GROUP BY country
HAVING count(id) > 30
ORDER BY ave_salary DESC 

--MVP
--Q9
--Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, and a new column effective_yearly_salary 
--which should contain fte_hours multiplied by salary. 
--Return only rows where effective_yearly_salary is more than 30000.


SELECT 
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary AS effective_yearly_salary
FROM employees 
WHERE fte_hours * salary > 30000

--MVP
--Q10
--Find the details of all employees in either Data Team 1 or Data Team 2

SELECT *
FROM employees LEFT JOIN teams 
ON employees.team_id = teams.id 
WHERE teams.name IN ('Data Team 1', 'Data Team 2')

--MVP
--Q11
SELECT 
	employees.first_name,
	employees.last_name,
	pay_details.local_tax_code
FROM employees INNER JOIN pay_details 
ON employees.pay_detail_id = pay_details.id
WHERE pay_details.local_tax_code IS NULL 


--MVP
--Q12
--The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
--where charge_cost depends upon the team to which the employee belongs. 
--Get a table showing expected_profit for each employee.

SELECT
	e.first_name,
	e.last_name,
	e.salary,
	e.fte_hours, 
	t.charge_cost, 
	(48 * 35 * charge_cost::INT - salary) * FTE_hours AS expected_profit
FROM employees AS e JOIN teams AS t 
ON e.team_id = t.id

--MVP
--Q13
--Find the first_name, last_name and salary of the lowest paid employee in Japan who works the least common full-time equivalent hours across the corporation.
-- first part of questions

SELECT 
	first_name,
	last_name,
	country,
	salary
FROM employees 
WHERE country = 'Japan' 



-- second part of the question
SELECT
	fte_hours, 
	count(id)
FROM employees 
GROUP BY fte_hours 
ORDER BY count 
LIMIT 1

-- full thing

SELECT
	first_name,
	last_name,
	country,
	salary
FROM employees
WHERE (country = 'Japan') 
AND (fte_hours = (SELECT fte_hours
				  FROM employees
				  GROUP BY fte_hours
                  ORDER BY count(id)
                  LIMIT 1
))
ORDER BY salary
LIMIT 1;


--MVP
--Q14
--Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
--Order the table in descending order of the number of employees lacking a first name, and then in alphabetical order by department.


SELECT 
	department,
	count(id) AS numbers_name_null
FROM employees 
WHERE first_name IS NULL 
GROUP BY department
HAVING count(id) >= 2
ORDER BY count(id)DESC, department ASC 

--MVP
--Q15

--Return a table of those employee first_names shared by more than one employee, together with a count of the number of times each first_name occurs. 
--Omit employees without a stored first_name from the table. Order the table descending by count, and then alphabetically by first_name.

SELECT 
	first_name,
	count(id)
FROM employees 
WHERE first_name IS NOT NULL 
GROUP BY first_name 
HAVING count(id) >= 2
ORDER BY count(id) desc, first_name 

--MVP
--Q16
-- Find the proportion of employees in each department who are grade 1.
--Think of the desired proportion for a given department as the number of employees in that department who are grade 1, divided by the total number of employees in that department.
--You can write an expression in a SELECT statement, e.g. grade = 1. This would result in BOOLEAN values.
--If you could convert BOOLEAN to INTEGER 1 and 0, you could sum them. The CAST() function lets you convert data types.
--In SQL, an INTEGER divided by an INTEGER yields an INTEGER. To get a REAL value, you need to convert the top, bottom or both sides of the division to REAL.

-- first part
--count total number of employees in department, 

SELECT 
	department,
	count(id) AS total_employees_department
FROM employees 
GROUP BY department 

--so we can calculate the proportion at Grade 1
SELECT 
	department,
	SUM(CAST(grade = '1' AS INT)) / CAST(count(id) AS REAL) AS proportional_grade1
FROM employees 
GROUP BY department


--EXT
--Q1

--Get a list of the id, first_name, last_name, department, salary and fte_hours of employees in the largest department. 
--Add two extra columns showing the ratio of each employee’s salary to that department’s average salary, and each employee’s fte_hours to that department’s average fte_hours.
