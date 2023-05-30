/*1. Employee Address
Write a query that selects:
• employee_id
• job_title
• address_id
• address_text
Return the first 5 rows sorted by address_id in ascending order.*/

SELECT 
    e.employee_id, e.job_title, a.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;

/*2. Addresses with Towns
Write a query that selects:
• first_name
• last_name
• town
• address_text
Sort the result by first_name in ascending order then by last_name. Select first 5 employees.*/

SELECT 
    e.first_name, e.last_name, t.name AS town, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
        JOIN
    towns AS t ON a.town_id = t.town_id
ORDER BY e.first_name , e.last_name
LIMIT 5;

/*3. Sales Employee
Write a query that selects:
© SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
 Follow us: Page 2 of 7
• employee_id
• first_name
• last_name
• department_name
Sort the result by employee_id in descending order. Select only employees from the "Sales" department.*/

/*4. Employee Departments
Write a query that selects:
• employee_id
• first_name
• salary
• department_name
Filter only employees with salary higher than 15000. Return the first 5 rows sorted by department_id in
descending order.*/

SELECT 
    e.employee_id,
    e.first_name,
    e.salary,
    d.name AS 'department_name'
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

/*5. Employees Without Project
Write a query that selects:
• employee_id
• first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.*/

SELECT 
    e.employee_id, e.first_name
FROM
    employees AS e
       LEFT JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
WHERE
    ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

/*6. Employees Hired After
Write a query that selects:
• first_name
• last_name
• hire_date
• dept_name
Filter only employees hired after 1/1/1999 and from either the "Sales" or the "Finance" departments. Sort the
result by hire_date (ascending).*/

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    d.name AS 'dept_name'
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.hire_date > '1999-01-01'
        AND d.name IN ('Sales' , 'Finance')
ORDER BY e.hire_date;

/*7. Employees with Project
Write a query that selects:
• employee_id
• first_name
• project_name
Filter only employees with a project, which has started after 13.08.2002 and it is still ongoing (no end date). Return
the first 5 rows sorted by first_name then by project_name both in ascending order.*/

SELECT 
    e.employee_id, e.first_name, p.name AS 'project_name'
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON ep.project_id = p.project_id
WHERE
    DATE(p.start_date) > '2002-08-13'
        AND p.end_date IS NULL
ORDER BY e.first_name , `project_name`
LIMIT 5;

/*8. Employee 24
Write a query that selects:
• employee_id
• first_name
• project_name
© SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
 Follow us: Page 4 of 7
Filter all the projects of employees with id 24. If the project has started after 2005 inclusively the return value
should be NULL. Sort the result by project_name alphabetically.*/

SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) >= 2005,
        NULL,
        p.name)
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON p.project_id = ep.project_id
WHERE
    e.employee_id = 24
ORDER BY p.name;

/*9. Employee Manager
Write a query that selects:
• employee_id
• first_name
• manager_id
• manager_name
Filter all employees with a manager who has id equal to 3 or 7. Return all rows sorted by employee first_name
in ascending order.*/

/*10. Employee Summary
Write a query that selects:
• employee_id
• employee_name
• manager_name
• department_name
Show the first 5 employees (only for employees who have a manager) with their managers and the departments
they are in (show the departments of the employees). Order by employee_id*/

SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS 'employee_name',
    CONCAT_WS(' ', m.first_name, m.last_name) AS 'manager_name',
    d.name
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id
        JOIN
    departments AS d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;

/*11. Min Average Salary
Write a query that returns the value of the lowest average salary of all departments.*/

SELECT 
    AVG(e.salary) AS 'min_avg_salary'
FROM
    employees AS e
GROUP BY e.department_id
ORDER BY min_avg_salary
LIMIT 1;

/*12. Highest Peaks in Bulgaria
Write a query that selects:
• country_code
• mountain_range
• peak_name
• elevation
Filter all peaks in Bulgaria with elevation over 2835. Return all rows sorted by elevation in descending order*/

SELECT 
    c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON m.id = mc.mountain_id
        JOIN
    peaks AS p ON p.mountain_id = m.id
WHERE
    c.country_name = 'Bulgaria'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;

/*13. Count Mountain Ranges
Write a query that selects:
• country_code
• mountain_range
Filter the count of the mountain ranges in the United States, Russia and Bulgaria. Sort result by mountain_range
count in decreasing order.*/

SELECT 
    c.country_code,
    COUNT(mc.mountain_id) AS mountains_range_count
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
GROUP BY c.country_code
HAVING c.country_code IN ('BG' , 'US', 'RU')
ORDER BY mountains_range_count DESC;

/*14. Countries with Rivers
Write a query that selects:
• country_name
© SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
 Follow us: Page 6 of 7
• river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.*/

SELECT 
    c.country_name, r.river_name
FROM
    countries AS c
        LEFT JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
        LEFT JOIN
    rivers AS r ON r.id = cr.river_id
WHERE
    c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

/*15. *Continents and Currencies
Write a query that selects:
• continent_code
• currency_code
• currency_usage
Find all continents and their most used currency. Filter any currency that is used in only one country. Sort the result
by continent_code and currency_code.*/

SELECT 
    c.continent_code,
    c.currency_code,
    COUNT(*) AS currency_usage
FROM
    countries AS c
GROUP BY continent_code , c.currency_code
HAVING currency_usage > 1
    AND currency_usage = (SELECT 
        COUNT(*) AS count_of_currencies
    FROM
        countries AS c2
    WHERE
        c2.continent_code = c.continent_code
    GROUP BY c2.currency_code
    ORDER BY count_of_currencies DESC
    LIMIT 1)
ORDER BY c.continent_code , c.currency_code;

/*16. Countries Without Any Mountains
Find the count of all countries which don't have a mountain.*/

/*17. Highest Peak and Longest River by Country
For each country, find the elevation of the highest peak and the length of the longest river, sorted by the highest
peak_elevation (from highest to lowest), then by the longest river_length (from longest to smallest), then
by country_name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the
first 5 rows.*/


