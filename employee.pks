CREATE OR REPLACE PACKAGE employee IS

PROCEDURE create_employee(p_employee_name IN employees.employee_name%TYPE,
						  p_job_title     IN employees.job_title%TYPE,
						  p_manager_id    IN employees.manager_id%TYPE,
                          p_date_hired    IN employees.date_hired%TYPE,
                          p_salary        IN employees.salary%TYPE,
                          p_department_id IN employees.department_id%TYPE);
						  
PROCEDURE modify_salary(p_employee_id       IN employees.employee_id%TYPE,
                        p_percentage_change IN NUMBER);

PROCEDURE transfer_department(p_employee_id     IN employees.employee_id%TYPE,
                              p_department_name IN departments.department_name%TYPE);

FUNCTION get_salary(p_employee_id     IN employees.employee_id%TYPE)
RETURN employees.salary%TYPE;							  

END employee;