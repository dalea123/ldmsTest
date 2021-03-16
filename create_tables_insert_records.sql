--Create tables

CREATE TABLE departments(
    department_id   NUMBER(5)   NOT NULL, 
    department_name VARCHAR(50) NOT NULL,
    location        VARCHAR(50) NOT NULL,
    CONSTRAINT departments_PK_department_id PRIMARY KEY(department_id)
);


CREATE TABLE employees(
    employee_id   NUMBER(10)  NOT NULL,
    employee_name VARCHAR(50) NOT NULL,
	job_title     VARCHAR(50) NOT NULL,
    manager_id    NUMBER(10)      NULL,
    date_hired    DATE        NOT NULL,
    salary        NUMBER(10)  NOT NULL,
    department_id NUMBER(5)   NOT NULL,
    CONSTRAINT employees_PK_employee_id   PRIMARY KEY(employee_id),
    CONSTRAINT employees_FK_department_id FOREIGN KEY(department_id) REFERENCES departments(department_id),
    CONSTRAINT employees_FK_manager_id    FOREIGN KEY(manager_id)    REFERENCES employees(employee_id) ON DELETE SET NULL --Self referential constraint. Deleteing a manager would potentially delete all employees managed by that manager by a cascade delete. Setting to null on delete avoids this. 
);


--Insert data
INSERT ALL 
	INTO departments(department_id, department_name, location) VALUES (1,'Management','London')
	INTO departments(department_id, department_name, location) VALUES (2,'Engineering','Cardiff')
	INTO departments(department_id, department_name, location) VALUES (3,'Research '||chr(38)||' Development','Edinburgh')
	INTO departments(department_id, department_name, location) VALUES (4,'Sales','Belfast')
SELECT * FROM dual;

INSERT ALL --Some rows have been reordered from original spec, to allow parent keys for maneger field.
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90001,'John Smith','CEO', NULL, TO_DATE('01/01/95', 'dd/mm/yyyy'), 100000, 1)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90002,'Jimmy Willis','Manager', 90001, TO_DATE('23/09/03', 'dd/mm/yyyy'), 52500, 4)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90003,'Roxy Jones','Salesperson', 90002, TO_DATE('11/02/17', 'dd/mm/yyyy'), 35000, 4)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90004,'Selwyn Field','Salesperson', 90003, TO_DATE('20/05/15', 'dd/mm/yyyy'), 32000, 4)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90006,'Sarah Phelps','Manager', 90001, TO_DATE('21/03/15', 'dd/mm/yyyy'), 45000, 2)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90005,'David Hallett','Engineer', 90006, TO_DATE('17/04/18', 'dd/mm/yyyy'), 40000, 2)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90007,'Louise Harper','Engineer', 90006, TO_DATE('01/01/13', 'dd/mm/yyyy'), 47000, 2)
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90009,'Gus Jones','Manager', 90001, TO_DATE('15/05/18', 'dd/mm/yyyy'), 50000, 3) 
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90008,'Tina Hart','Engineer', 90009, TO_DATE('28/07/14', 'dd/mm/yyyy'), 45000, 3) 
	INTO employees(employee_id, employee_name, job_title, manager_id, date_hired, salary, department_id) VALUES (90010,'Mildred Hall','Secretary', 90001, TO_DATE('12/10/96', 'dd/mm/yyyy'), 35000, 1)
SELECT * FROM dual;

COMMIT;

--Create ID sequences (Now that initial data is loaded in, we need a mechanism to generate new IDs for future inserts)

CREATE SEQUENCE department_seq
	START WITH 5
	INCREMENT BY 1;
	
CREATE SEQUENCE employee_seq
	START WITH 90011
	INCREMENT BY 1;