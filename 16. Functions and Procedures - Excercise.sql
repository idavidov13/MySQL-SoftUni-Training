/* 1. Employees with Salary Above 35000
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees' first and last
names for whose salary is above 35000. The result should be sorted by first_name then by last_name
alphabetically, and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE procedure usp_get_employees_salary_above_35000 ()
BEGIN
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    salary > 35000
ORDER BY first_name , last_name , employee_id;
END

/* 2. Employees with Salary Above Number
Create stored procedure usp_get_employees_salary_above that accept a decimal number (with precision, 4
digits after the decimal point) as parameter and return all employee's first and last names whose salary is above or
equal to the given number. The result should be sorted by first_name then by last_name alphabetically and id
ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge. */

CREATE PROCEDURE usp_get_employees_salary_above (salary_limit DOUBLE(19, 4))
BEGIN
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    salary >= salary_limit
ORDER BY first_name , last_name , employee_id;
END

/* 3. Town Names Starting With
Write a stored procedure usp_get_towns_starting_with that accept string as parameter and returns all town
names starting with that string. The result should be sorted by town_name alphabetically. Submit your query
statement as Run skeleton, run queries & check DB in Judge.*/

CREATE PROCEDURE usp_get_towns_starting_with (name_starts_with VARCHAR(50))
BEGIN
SELECT 
    name
FROM
    towns
WHERE
    name LIKE concat(name_starts_with, '%')
ORDER BY name;
END

/* 4. Employees from Town
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter and return
the employees first and last name that live in the given town. The result should be sorted by first_name then by
last_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check
DB in Judge.*/

CREATE PROCEDURE usp_get_employees_from_town (town_name VARCHAR(50))
BEGIN
SELECT 
    first_name, last_name
FROM
    employees AS e
    JOIN addresses as a ON e.address_id = a.address_id
    JOIN towns as t ON t.town_id = a.town_id
WHERE t.name = town_name
ORDER BY first_name , last_name , employee_id;
END

/* 5. Salary Level Function
Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
• If salary is < 30000 return "Low"
• If salary is between 30000 and 50000 (inclusive) return "Average"
• If salary is > 50000 return "High"
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19, 4))
RETURNS VARCHAR(7)
RETURN (
	CASE
		WHEN salary < 30000 THEN 'Low'
		WHEN salary <= 50000 THEN 'Average'
		ELSE 'High'
	END
);

/* 6. Employees by Salary Level
Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary
(low, average or high) and print the names of all employees that have given level of salary. The result should be
sorted by first_name then by last_name both in descending order.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
SELECT 
    first_name, last_name
FROM
    employees
WHERE salary < 30000 AND salary_level = 'Low'
OR salary >= 30000 AND salary <= 50000 AND salary_level = 'Average'
OR salary > 50000 AND salary_level = 'High'
ORDER BY first_name DESC, last_name DESC;
END

/* 7. Define Function
Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50)) that
returns 1 or 0 depending on that if the word is a comprised of the given set of letters.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
RETURN word REGEXP(concat('^[', set_of_letters, ']+$'));

/* 8. Find Full Name
You are given a database schema with tables:
• account_holders(id (PK), first_name, last_name, ssn)
and
• accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. The result should be
sorted by full_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries &
check DB in Judge.*/

CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
SELECT 
    CONCAT_WS(' ', first_name, last_name) as full_name
FROM
    account_holders
ORDER BY full_name;
END

/* 9. People with Balance Higher Than
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than that accepts a
number as a parameter and returns all people who have more money in total of all their accounts than the
supplied number. The result should be sorted by account_holders.id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(money_to_compare DECIMAL (19, 4))
BEGIN
SELECT 
    ah.first_name, ah.last_name
FROM
    account_holders AS ah
        JOIN
    accounts AS a ON a.account_holder_id = ah.id
GROUP BY ah.id
HAVING SUM(a.balance) > money_to_compare
ORDER BY ah.id;
END

/* 10. Future Value Function
Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum (with
precision, 4 digits after the decimal point), yearly interest rate (double) and number of years(int). It should
calculate and return the future value of the initial sum. The result from the function must be decimal, with
percision 4.
Using the following formula: FV=Ix((1 + R)^T)
• I – Initial sum
• R – Yearly interest rate
• T – Number of years
Submit your query statement as Run skeleton, run queries & check DB in Judge. */

CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(19, 4), interest_rate DECIMAL(19, 4), number_of_years INT)
RETURNS DECIMAL(19, 4)
RETURN initial_sum*POW((1+interest_rate), number_of_years);

/* 11. Calculating Interest
Your task is to create a stored procedure usp_calculate_future_value_for_account that accepts as
parameters – id of account and interest rate. The procedure uses the function from the previous problem to give
an interest to a persons account for 5 years, along with information about his/her account id, first name, last name
and current balance as it is shown in the example below. It should take the account_id and the interest_rate as
parameters. Interest rate should have precision up to 0.0001, same as the calculated balance after 5 years. Be
extremely careful to achieve the desired precision!
© SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
 Follow us: Page 5 of 6
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(19, 4), interest_rate DECIMAL(19, 4), number_of_years INT)
RETURNS DECIMAL(19, 4)
RETURN initial_sum*POW((1+interest_rate), number_of_years);

CREATE PROCEDURE usp_calculate_future_value_for_account(
    account_id INT, interest_rate DECIMAL(19, 4))
BEGIN
    SELECT 
         a.id AS 'account_id', h.first_name, h.last_name, a.balance AS 'current_balance',
         ufn_calculate_future_value(a.balance, interest_rate, 5) AS 'balance_in_5_years'
    FROM
        `account_holders` AS h
            JOIN
        `accounts` AS a ON h.id=a.account_holder_id
    WHERE a.id = account_id;
END

/* 12. Deposit Money
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. The
procedure should produce exact results working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

CREATE PROCEDURE usp_deposit_money(
    account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    IF money_amount > 0 THEN
        START TRANSACTION;
        
        UPDATE `accounts` AS a 
        SET 
            a.balance = a.balance + money_amount
        WHERE
            a.id = account_id;
        
        IF (SELECT a.balance 
            FROM `accounts` AS a 
            WHERE a.id = account_id) < 0
            THEN ROLLBACK;
        ELSE
            COMMIT;
        END IF;
    END IF;
END

CALL usp_deposit_money(1, 10);

SELECT 
    a.id AS 'account_id', a.account_holder_id, a.balance
FROM
    `accounts` AS a
WHERE
    a.id = 1;
    
/* 13. Withdraw Money
Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive
number. Work with precision up to fourth sign after decimal point. The procedure should produce exact results
working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

/* 14. Money Transfer
Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that
transfers money from one account to another. Consider cases when one of the account_ids is not valid, the
amount of money is negative number, outgoing balance is enough or transferring from/to one and the same
account. Make sure that the whole procedure passes without errors and if error occurs make no change in the
database.
Make sure to guarantee exact results working with precision up to fourth sign after decimal point.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

/* 15. Log Accounts Trigger
Create another table – logs(log_id, account_id, old_sum, new_sum). Add a trigger to the accounts
table that enters a new entry into the logs table every time the sum on an account changes.
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

/* 16. Emails Trigger
Create another table – notification_emails(id, recipient, subject, body). Add a trigger to logs table
to create new email whenever new record is inserted in logs table. The following data is required to be filled for
each email:
• recipient – account_id
• subject – "Balance change for account: {account_id}"
• body - "On {date (current date)} your balance was changed from {old} to {new}."
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/


