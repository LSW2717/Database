SELECT first_name, last_name, salary, salary * 1.1 AS incressed_salary
FROM employee
WHERE branch_id = 1;

SELECT first_name, last_name, salary
FROM employee
WHERE sex = 'M' AND salary BETWEEN 60000 AND 80000;

SELECT first_name, last_name, branch_id, salary
FROM employee
ORDER BY branch_id DESC, salary ASC;

SELECT e.first_name, e.last_name, w.total_sales
FROM employee e
JOIN works_with w ON e.emp_id = w.emp_id
JOIN client c ON w.client_id = c.client_id
WHERE c.client_name = 'FedEx' AND e.salary >= 60000;

SELECT SUM(salary) AS total_salary, MAX(salary) AS max_salary, MIN(salary) AS min_salary, AVG(salary) AS avg_salary
FROM employee;

SELECT COUNT(*) AS total_employees
FROM employee;

SELECT b.branch_name, COUNT(e.emp_id) AS employee_in_branch
FROM branch b
LEFT JOIN employee e ON b.branch_id = e.branch_id
GROUP BY b.branch_name;
