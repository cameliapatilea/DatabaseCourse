--Lab 3- de la pb 10
SELECT d.department_id
FROM departments d
where lower(d.department_name) like '%re%'
--union face operatia de sau
UNION 
SELECT e.department_id
FROM employees e
WHERE e.job_id = 'SA_REP'

--la UNION ALL apar si duplicate

--12--
SELECT d.department_id
FROM departments d
MINUS
SELECT e.department_id
FROM employees e

--13
SELECT d.department_id
FROM departments d
WHERE LOWER(d.department_name) LIKE '%re%'
INTERSECT
SELECT e.department_id
FROM employees e
WHERE upper(e.job_id) = 'HR_REP'


--14--

SELECT e.employee_id, e.job_id, e.first_name
FROM employees e
WHERE e.salary > 3000
UNION
SELECT e.employee_id, e.job_id, e.first_name
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE (j.max_salary + j.min_salary)/2 = e.salary

--15
SELECT e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date > any(SELECT d.hire_date
                        FROM employees d
                        WHERE lower(d.last_name)= 'grant')

--16
SELECT e.last_name, e.salary
FROM employees e
WHERE e.department_id IN (SELECT d.department_id
                            FROM employees d
                            WHERE lower(d.last_name) = 'grant')
                            
--daca se pune = om loc de IN atunci va aparea o eroare care mentioneaza ca a doua subcerere returneaza maimult de un rand

--17
SELECT e.last_name, e.salary
FROM employees e
WHERE e.manager_id = (SELECT d.employee_id
                        FROM employees d
                        WHERE d.manager_id is NULL);
                        
--18
SELECT e.last_name, e.department_id, e.salary
FROM employees e
WHERE (e.department_id, e.salary) IN (SELECT d.department_id, d.salary
                                        FROM employees d
                                        WHERE d.commission_pct is not NULL);
                                        
--19
SELECT e.employee_id, e.department_id, e.salary
FROM employees e
WHERE e.salary > (SELECT (j.min_salary + j.max_salary)/2
                From jobs j
                WHERE  e.job_id = j.job_id)
                and
        e.department_id IN (SELECT d.department_id
                            FROM employees d
                            WHERE lower(d.last_name) LIKE '%t%'
                            and d.employee_id <> e.employee_id);


--20
SELECT e.employee_id, e.last_name
FROM employees e
WHERE e.salary> ALL(SELECT d.salary
                    FROM employees d
                    WHERE LOWER(d.job_id) LIKE '%clerk%');
--21
SELECT e.last_name, d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = e.department_id
WHERE e.commission_pct is null and e.manager_id IN (SELECT e1.manager_id
                                                    FROM employees e1
                                                    WHERE e1.commission_pct is not null);
                                                    
--22
SELECT e.last_name, e.department_id, e.salary, e.job_id
FROM employees e
WHERE (e.salary, e.commission_pct) in (SELECT d.salary, d.commission_pct
                                        FROM employees d
                                        JOIN departments d1 ON d1.department_id = d.department_id
                                        JOIN locations l ON l.location_id = d1.location_id
                                        WHERE LOWER(l.city)  = 'oxford');
                                        
--23
SELECT e.last_name, e.department_id, e.job_id
FROM employees e
WHERE e.department_id IN( SELECT d.department_id
                        FROM employees d
                        JOIN departments d1 ON d1.department_id = d.department_id
                        JOIN locations l ON l.location_id = d1.location_id
                        WHERE LOWER(l.city) = 'toronto');
                        

