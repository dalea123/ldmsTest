SET SERVEROUT ON

--3. Test the employee.create_employee procedure

BEGIN
	DBMS_OUTPUT.PUT_LINE('Creating new employee record');
	employee.create_employee('dale adams', 'oracle developer', 90007,TO_DATE('15/04/2020','dd/mm/yyyy'),37500,3);
	
	COMMIT;
    
END;
/


SELECT * FROM (SELECT * FROM employees 
ORDER BY employee_id DESC) 
WHERE ROWNUM = 1;

--4a/6. Test the modify_salary procedure and get_salary function
DECLARE
	salary_op NUMBER;

BEGIN
	DBMS_OUTPUT.PUT_LINE('Increasing an employees salary by 10%');
	
	SELECT employee.get_salary(90001)
    INTO salary_op
	FROM dual;
	
	DBMS_OUTPUT.PUT_LINE('original salary - '||salary_op);
	
	employee.modify_salary(90001, 10);
	
	SELECT employee.get_salary(90001)
    INTO salary_op
	FROM dual;
	
	DBMS_OUTPUT.PUT_LINE('new salary - '||salary_op);
END;
/
--4b/6. Test the modify_salary procedure and get_salary function
DECLARE
	salary_op NUMBER;

BEGIN
	DBMS_OUTPUT.PUT_LINE('Decreasing an employees salary by 10%');
	
	SELECT employee.get_salary(90001)
    INTO salary_op
	FROM dual;
	
	DBMS_OUTPUT.PUT_LINE('original salary - '||salary_op);
	
	employee.modify_salary(90001, -10);
	
	SELECT employee.get_salary(90001)
    INTO salary_op
	FROM dual;
	
	DBMS_OUTPUT.PUT_LINE('new salary - '||salary_op);
END;
/
--4c/6. Test the modify_salary procedure and get_salary function
DECLARE
	salary_op NUMBER;

BEGIN
	DBMS_OUTPUT.PUT_LINE('Increasing an employees salary by 0%');
	
	SELECT employee.get_salary(90001)
    INTO salary_op
	FROM dual;
	
	DBMS_OUTPUT.PUT_LINE('original salary - '||salary_op);
	
	employee.modify_salary(90001, 0);
	
	SELECT employee.get_salary(90001)
    INTO salary_op
	FROM dual;
	
	DBMS_OUTPUT.PUT_LINE('new salary - '||salary_op);
END;
/

--5 test the transfer_department procedure
DECLARE
	department VARCHAR(50);

BEGIN
	DBMS_OUTPUT.PUT_LINE('Changing department to engineering');
	
	SELECT d.department_name
	INTO department
	FROM departments d
	INNER JOIN employees e on e.department_id = d.department_id
	WHERE e.employee_id = 90001;
	
	DBMS_OUTPUT.PUT_LINE('original department - '||department);
	
	employee.transfer_department(90001, 'Engineering');
	
	SELECT d.department_name
	INTO department
	FROM departments d
	INNER JOIN employees e on e.department_id = d.department_id
	WHERE e.employee_id = 90001;
	
	DBMS_OUTPUT.PUT_LINE('new department - '||department);
	
END;
/
