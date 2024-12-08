--1
BEGIN;
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;
COMMIT;

--2
BEGIN;
DO $$
DECLARE
    available_quantity INTEGER;
BEGIN
    SELECT quantity INTO available_quantity
    FROM Books
    WHERE book_id = 3;

    IF available_quantity < 10 THEN
        RAISE NOTICE 'Not enough stock, rolling back transaction.';
        ROLLBACK;
    ELSE

        INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, CURRENT_DATE, 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;

        COMMIT;
    END IF;
END;
$$;

--3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Books
SET price = 40.00
WHERE book_id = 2;
COMMIT;

--before committing
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price FROM Books WHERE book_id = 2;
--after committing
SELECT price FROM Books WHERE book_id = 2;
COMMIT;

--4
BEGIN;
UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;
COMMIT;

-- Verify the updated email persists
SELECT * FROM Customers WHERE customer_id = 101;
