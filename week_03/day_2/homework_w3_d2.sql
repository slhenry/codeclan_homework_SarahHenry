--MVP
--Q1a

SELECT 	
	employees.first_name, 	
	employees.last_name, 
	employees.team_id, 
	teams.id, 
	teams.name
FROM employees INNER JOIN teams 
ON employees.team_id = teams.id;

--MVP
--Q1b

SELECT 	
	employees.first_name, 	
	employees.last_name, 
	employees.team_id, 
	teams.id, 
	teams.name
FROM employees INNER JOIN teams 
ON employees.team_id = teams.id
WHERE pension_enrol = TRUE;

--MVP
--Q1c

SELECT 	
	employees.first_name, 	
	employees.last_name, 
	employees.team_id, 
	teams.id, 
	teams.name,
	teams.charge_cost 
FROM employees INNER JOIN teams 
ON employees.team_id = teams.id
WHERE charge_cost IN ('80')

--MVP
--Q2a
SELECT 
	employees.*,
	pay_details.local_account_no,
	pay_details.local_sort_code
FROM employees LEFT JOIN pay_details 
ON employees.pay_detail_id = pay_detail_id 

--MVP
--Q2b
SELECT 
	employees.*,
	pay_details.local_account_no,
	pay_details.local_sort_code,
	teams.name 
FROM (employees LEFT JOIN pay_details 
ON employees.pay_detail_id = pay_detail_id)
INNER JOIN teams 
ON employees.team_id = teams.id;

--MVP
--Q3a
SELECT 
	employees.id,
	teams.name
FROM employees LEFT JOIN teams 
ON employees.team_id = teams.id

--MVP
--Q3b
SELECT 
	teams.name,
	count(teams.name)
FROM employees LEFT JOIN teams 
ON employees.team_id = teams.id
GROUP BY teams.name

--MVP
--Q3c
SELECT 
	teams.name,
	count(teams.name) AS number_employees_team
FROM employees LEFT JOIN teams 
ON employees.team_id = teams.id
GROUP BY teams.name
ORDER BY number_employees_team

--MVP
--Q4a
SELECT 
	teams.id,
	teams.name,
	count(teams.name) AS number_employees_team
FROM employees right JOIN teams 
ON employees.team_id = teams.id
GROUP BY teams.name, teams.id

--MVP
--Q4b
SELECT 
	teams.id,
	teams.name,
	count(teams.name) AS number_employees_team,
	teams.charge_cost
FROM employees right JOIN teams 
ON employees.team_id = teams.id
GROUP BY teams.name, teams.id



--EXT
--Q5
SELECT
	employee_id, 
	count(employee_id)
FROM employees_committees 
GROUP BY employee_id 

--EXT
--Q6
SELECT 
	count(employees.id)
FROM employees FULL JOIN employees_committees 
ON employees.id = employees_committees.employee_id 
WHERE employees_committees.employee_id IS NULL




