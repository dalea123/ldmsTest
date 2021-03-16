    SELECT e.*
      FROM employees e
INNER JOIN departments d on d.department_id = e.department_id
     WHERE d.department_name = 'Engineering';