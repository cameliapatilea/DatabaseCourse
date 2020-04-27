--laborator 2 - exercitii cu JOIN

SELECT *
FROM employees;



SELECT *
FROM employees e
WHERE e.employee_id = 200;

SELECT e.last_name, e.job_id, e.employee_id, j.job_title
FROM employees e, jobs j
WHERE e.employee_id = 200 AND e.job_id = j.job_id;


SELECT e.last_name, e.job_id, e.employee_id, j.job_title
FROM employees e
JOIN jobs j ON  e.job_id = j.job_id
WHERE e.employee_id = 200;


--ex 17

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
JOIN departments d ON d.department_id = e.department_id;

--ex 18
--cu un singur join
SELECT j.job_title, e.department_id
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
WHERE e.department_id = 30;

--cu doua joinuri
SELECT j.job_title, d.department_id
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id = 30;


--ex 19
SELECT e.last_name, d.department_name, e.commission_pct, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.commission_pct  is not null;

--ex 20

SELECT e.last_name, e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE LOWER(e.last_name) LIKE '%a%';

--EX 21
SELECT e.last_name, j.job_title, e.employee_id, d.department_name, l.city
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Oxford';


--ex 22
SELECT e.employee_id as "ANG#", e.last_name as "Angajat", f.employee_id as "Mgr#", f.last_name
FROM employees e
JOIN employees f ON e.manager_id = f.employee_id;


--ex 23
SELECT e.employee_id as "ANG#", e.last_name as "Angajat", f.employee_id as "Mgr#", f.last_name
FROM employees e
LEFT JOIN employees f ON e.manager_id = f.employee_id;

--ex 24
SELECT e.last_name, e.department_id, f.last_name as "Coleg"
FROM employees e
JOIN employees f ON e.department_id = f.department_id
WHERE e.last_name <> f.last_name; 


--ex 25
SELECT e.last_name, j.job_id, j.job_title, d.department_name, e.salary
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
JOIN departments d ON e.department_id = d.department_id;

--ex 26
SELECT e.last_name, e.hire_date
FROM employees e
JOIN employees f ON f.hire_date < e.hire_date
WHERE f.last_name = 'Gates';


-- ex 27

SELECT e.last_name as "Angajat", e.hire_date as "Data_ang", f.last_name as "Manager", f.hire_date as "Data_manager"
FROM employees e
JOIN employees f ON e.hire_date < f.hire_date 
WHERE e.manager_id = f.employee_id;

--laborator 3

--ex 1
SELECT e.last_name, TO_CHAR(e.hire_date, 'MONTH.YYYY')
FROM employees e
JOIN employees f ON e.department_id = f.department_id 
WHERE LOWER(e.last_name) LIKE '%a%' and e.last_name != 'Gates' and f.last_name = 'Gates';


--ex 2
SELECT DISTINCT e.employee_id, e.last_name, d.department_id, d.department_name
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN employees f ON f.department_id = e.department_id
WHERE e.employee_id <> f.employee_id and LOWER(f.last_name) LIKE '%t%';

--ex 3

SELECT e.last_name, e.salary, j.job_title, l.city, c.country_name
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON d.department_id = e.department_id
JOIN locations l ON l.location_id = d.location_id
JOIN countries c ON c.country_id = l.country_id
JOIN employees f ON f.employee_id = e.manager_id
WHERE f.last_name = 'King';

-- ex 4
SELECT d.department_id, d.department_name, e.last_name, j.job_title, TO_CHAR(e.salary,'$99,999.00')
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN jobs j ON j.job_id = e.job_id
WHERE LOWER(e.last_name) LIKE '%ti%'
ORDER BY d.department_name, e.last_name;

-- EX 5
SELECT  e.last_name, d.department_id, d.department_name, l.city,j.job_title
FROM employees e
JOIN departments d ON d.department_id= e.department_id
JOIN jobs j ON j.job_id = e.job_id
JOIN locations l ON l.location_id = d.location_id
WHERE l.city = 'Oxford';


--ex 6

SELECT DISTINCT e.employee_id, e.last_name, e.salary
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
JOIN employees f ON f.department_id = e.department_id
WHERE e.salary > (j.min_salary + j.max_salary) / 2 and LOWER(f.last_name) LIKE '%t%'; 


--ex 7
SELECT d.department_name, e.last_name
FROM employees e
LEFT OUTER JOIN departments d ON d.department_id = e.department_id;

--ex 8
SELECT d.department_name, e.last_name
FROM employees e
RIGHT OUTER JOIN departments d ON d.department_id = e.department_id;



