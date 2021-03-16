CREATE OR REPLACE PACKAGE BODY employee IS

PROCEDURE create_employee(p_employee_name IN employees.employee_name%TYPE,
						  p_job_title     IN employees.job_title%TYPE,
						  p_manager_id    IN employees.manager_id%TYPE,
                          p_date_hired    IN employees.date_hired%TYPE,
                          p_salary        IN employees.salary%TYPE,
                          p_department_id IN employees.department_id%TYPE)

IS
BEGIN

	INSERT INTO employees 
	VALUES (employee_seq.NEXTVAL, 
	        p_employee_name,
            p_job_title,			
			p_manager_id, 
			p_date_hired,
			p_salary, 
			p_department_id);						  

	COMMIT;
	
END create_employee;

PROCEDURE modify_salary(p_employee_id       IN employees.employee_id%TYPE,
                        p_percentage_change IN NUMBER)
						

IS
	new_salary NUMBER := 0;
	current_salary NUMBER := 0;
BEGIN
	
	--dbms_output.put_line  (p_percentage_change); 
	--dbms_output.put_line ((current_salary / 100) * (100 - p_percentage_change));
	
	SELECT salary 
	INTO current_salary 
	FROM employees 
	WHERE employee_id =  p_employee_id;
	
	IF p_percentage_change < 0  THEN --Salary decrease
		new_salary := (current_salary / 100) * (p_percentage_change + 100);
	
	ELSIF p_percentage_change = 0 THEN --No change
		new_salary := current_salary;
	
	ELSE --Salary increase
		new_salary := (current_salary / 100) * p_percentage_change + current_salary;
	END IF;
	
	UPDATE employees 
	SET salary = new_salary 
	WHERE employee_id = p_employee_id;
	
	COMMIT;
	
END modify_salary;

PROCEDURE transfer_department(p_employee_id     IN employees.employee_id%TYPE,
                              p_department_name IN departments.department_name%TYPE)

IS
BEGIN
	
	UPDATE employees 
	SET department_id = (SELECT department_id 
	                       FROM departments 
						  WHERE department_name = p_department_name) 
	WHERE employee_id = p_employee_id;
	
	COMMIT;
	
END transfer_department;

FUNCTION get_salary(p_employee_id IN employees.employee_id%TYPE)
RETURN employees.salary%TYPE

IS

	employee_salary employees.salary%TYPE;

BEGIN
	
	SELECT salary 
	INTO employee_salary
	FROM employees
	WHERE employee_id = p_employee_id;
	
RETURN employee_salary;

END get_salary;

							  
END employee;