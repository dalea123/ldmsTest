SELECT SUM(e.salary) AS total_salary,
	   d.department_name
      FROM employees e
INNER JOIN departments d on d.department_id = e.department_id
  GROUP BY d.department_name;