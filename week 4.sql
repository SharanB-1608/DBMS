CREATE DATABASE EmployeeManagementDB; 
USE EmployeeManagementDB; 

CREATE TABLE Department ( 
    department_id INT PRIMARY KEY, 
    department_name VARCHAR(100) NOT NULL, 
    location VARCHAR(100) 
); 

CREATE TABLE Employee ( 
    employee_id INT PRIMARY KEY, 
    employee_name VARCHAR(100) NOT NULL, 
    email VARCHAR(100), 
    phone VARCHAR(15), 
    department_id INT, 
    job_role VARCHAR(80), 
    salary DECIMAL(10,2), 
    joining_date DATE, 
    status VARCHAR(20), 
    FOREIGN KEY (department_id) REFERENCES Department(department_id) 
); 

INSERT INTO Department 
(department_id, department_name, location) 
VALUES 
(1, 'Human Resources', 'Chennai'), 
(2, 'Information Technology', 'Bangalore'), 
(3, 'Finance', 'Hyderabad'), 
(4, 'Marketing', 'Chennai'), 
(5, 'Operations', 'Pune');

INSERT INTO Employee 
(employee_id, employee_name, email, phone, department_id, job_role, salary, joining_date, status) 
VALUES 
(201, 'Arun Kumar', 'arun@company.com', '9876500010', 2, 'Software Developer', 55000.00, '2025-06-10', 'Active'), 
(202, 'Priya Sharma', 'priya@company.com', '9876500011', 1, 'HR Executive', 42000.00, '2025-07-15', 'Active'), 
(203, 'Karthik Raj', 'karthik@company.com', '9876500012', 3, 'Accountant', 48000.00, '2025-08-20', 'Active'), 
(204, 'Sneha Devi', 'sneha@company.com', '9876500013', 4, 'Marketing Executive', 45000.00, '2025-09-05', 'Active'), 
(205, 'Rahul Das', 'rahul@company.com', '9876500014', 5, 'Operations Manager', 62000.00, '2025-10-12', 'Active'), 
(206, 'Meena Rao', 'meena@company.com', '9876500015', 2, 'Database Administrator', 58000.00, '2026-01-08', 'Active');

SELECT * FROM Department;  

SELECT * FROM Employee;

UPDATE Employee 
SET job_role = 'Senior Software Developer' 
WHERE employee_id = 201; 

UPDATE Employee 
SET salary = 65000.00 
WHERE employee_id = 205;

UPDATE Employee 
SET status = 'Inactive' 
WHERE employee_id = 203; 

SELECT 
    Employee.employee_name, 
    Employee.job_role, 
    Department.department_name, 
    Department.location, 
    Employee.salary, 
    Employee.joining_date, 
    Employee.status 
FROM Employee 
JOIN Department 
ON Employee.department_id = Department.department_id 
ORDER BY Employee.employee_name; 

SELECT 
    Department.department_name, 
    Employee.employee_name, 
    Employee.job_role, 
    Employee.salary 
FROM Department 
JOIN Employee 
ON Department.department_id = Employee.department_id 
ORDER BY Department.department_name; 

