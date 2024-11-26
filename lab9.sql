--1
CREATE OR REPLACE FUNCTION increase_value(input_value INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN input_value + 10;
END;
$$ LANGUAGE plpgsql;

--2
CREATE OR REPLACE FUNCTION compare_numbers(num1 INTEGER, num2 INTEGER)
RETURNS TEXT AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'Greater';
    ELSIF num1 = num2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END;
$$ LANGUAGE plpgsql;

--3
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series_value INTEGER) AS $$
BEGIN
    FOR series_value IN 1..n LOOP
        RETURN NEXT series_value;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


--4
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(employee_id INTEGER, name VARCHAR, department_id INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT employee_id, name, department_id
    FROM employees
    WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;

--5
CREATE OR REPLACE FUNCTION list_products(category_name VARCHAR)
RETURNS TABLE(product_id INTEGER, product_name VARCHAR, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT product_id, product_name, price
    FROM products
    WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;

--6.1
CREATE OR REPLACE FUNCTION calculate_bonus(salary NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN salary * 0.1; -- 10% bonus
END;
$$ LANGUAGE plpgsql;
--6.2
CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER)
RETURNS VOID AS $$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO current_salary FROM employees WHERE employee_id = emp_id;

    bonus := calculate_bonus(current_salary);
    UPDATE employees SET salary = current_salary + bonus WHERE employee_id = emp_id;
END;
$$ LANGUAGE plpgsql;

--7
CREATE OR REPLACE FUNCTION complex_calculation(num1 INTEGER, str1 VARCHAR)
RETURNS TEXT AS $$
DECLARE
    numeric_result INTEGER;
    string_result VARCHAR;
BEGIN
    <<main_block>>
    BEGIN
        <<numeric_block>>
        BEGIN

        END;
        <<string_block>>
        BEGIN
            string_result := CONCAT('Hello, ', str1);
        END;

        RETURN CONCAT(string_result, ' - Your number is: ', numeric_result);
    END;
END;
$$ LANGUAGE plpgsql;
