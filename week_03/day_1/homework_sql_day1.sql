/*MVP*/
/*Q1*/ 
SELECT *
FROM employees 
WHERE department = 'Human Resources'

/*MVP*/
/*Q2*/ 
SELECT 
	first_name,
	last_name,
	country
FROM employees 
WHERE department = 'Legal';

/*MVP*/
/*Q3*/
SELECT 
	count(*) AS Portugal_staff
FROM employees 
WHERE (country = 'Portugal');

/*MVP*/
/*Q4*/
SELECT 
	count(*) AS Portugal_staff
FROM employees 
WHERE (country = 'Portugal' 
OR country = 'Spain')

/*MVP*/
/*Q5*/
SELECT 
	count(*)
FROM pay_details  
WHERE local_account_no IS NULL 

/*MVP*/
/*Q6*/
SELECT*
FROM pay_details 
WHERE local_account_no IS NULL
AND iban IS NULL ; 

/*MVP*/
/*Q7*/
SELECT 
	first_name,
	last_name
FROM employees 
ORDER BY last_name NULLS LAST 

/*MVP*/
/*Q8*/
SELECT 
	first_name,
	last_name,
	country
FROM employees 
ORDER BY 
	country NULLS LAST,
	last_name NULLS LAST;


/*MVP*/
/*Q9*/
SELECT*
FROM employees 
ORDER BY (salary) DESC NULLS LAST 
LIMIT 10

/*MVP*/
/*Q10*/
SELECT*
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary NULLS LAST 
LIMIT 1 

/*MVP*/
/*Q11*/
SELECT
	count(*)
FROM employees 
WHERE first_name like 'F%'

/*MVP*/
/*Q12*/
SELECT *
FROM employees 
WHERE email LIKE '%yahoo%'

/*MVP*/
/*Q13*/
SELECT
	count(*)
FROM employees 
WHERE country NOT IN ('France', 'Germany')
AND pension_enrol = TRUE 


/*MVP*/
/*Q14*/
SELECT 
	max(salary) AS Engineering_max_salary
FROM employees
WHERE fte_hours = 1

/*MVP*/
/*Q15*/
SELECT 
	first_name,
	last_name,
	fte_hours,
	salary,
	(fte_hours * salary) AS effective_yearly_salary
FROM employees 


/*EXT*/
/*Q1*/
SELECT
	first_name,
	last_name,
	department,
	concat(first_name, ' ', last_name,' - ', department) AS badge_label
FROM employees 
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL

/*EXT*/
/*Q2*/
SELECT
	first_name,
	last_name,
	department,
	EXTRACT(YEAR FROM start_date) AS start_year,
	concat(first_name, ' ', last_name,' - ', department, ' ', '(joined -', ' ',  EXTRACT(YEAR FROM start_date), ')' ) AS badge_label
FROM employees 
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL
AND start_date IS NOT NULL

/*EXT*/
/*Q2*/
SELECT 
	first_name,
	last_name,
	salary,
CASE WHEN salary < 40000 THEN 'low'
ELSE 'high' END AS salary_class
FROM employees
WHERE salary IS NOT NULL;





