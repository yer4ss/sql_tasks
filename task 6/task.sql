SELECT customer_id FROM Orders   --1
WHERE amount > (
  SELECT AVG(amount) FROM Orders
);


SELECT order_id FROM Orders --2
WHERE customer_id IN (
    SELECT customer_id FROM Customers
    WHERE age < 25
);


SELECT customer_id FROM Orders --3
WHERE (item, amount) IN (
    SELECT item, amount FROM Orders
    WHERE customer_id = 4
);



SELECT customer_id FROM Orders --4
WHERE amount > 800;



SELECT customer_id FROM Orders --5
WHERE item IN (
    SELECT item FROM Orders
    WHERE customer_id = 2
);



SELECT order_id FROM Orders  --6
WHERE amount = (
  	SELECT MIN(amount) FROM Orders
);


SELECT customer_id FROM Orders  --7
WHERE (item, amount) IN (
    SELECT item, amount FROM Orders
    WHERE customer_id = 3
);



SELECT order_id FROM Orders  --8
WHERE customer_id IN (
    SELECT customer_id FROM Customers
    WHERE age > (SELECT AVG(age) FROM Customers)
);



SELECT DISTINCT customer_id FROM Orders  --9
WHERE amount = (
  	SELECT amount FROM Orders 
	WHERE customer_id = 1
);



SELECT DISTINCT customer_id FROM Orders  --10
WHERE amount > 950;



SELECT order_id FROM Orders     --11
WHERE item IN (
    SELECT item FROM Orders
    GROUP BY item
    HAVING COUNT(DISTINCT customer_id) > 1
);



SELECT order_id FROM Orders  --12
WHERE customer_id IN (
    SELECT customer_id FROM Customers
    WHERE age > 30
);



SELECT customer_id FROM Orders --13
WHERE (item, amount) IN (
    SELECT item, amount FROM Orders
    WHERE customer_id = 5
);



SELECT DISTINCT customer_id FROM Orders  --14
WHERE amount > 700;



SELECT customer_id FROM Orders  --15
WHERE amount = (
	SELECT amount FROM Orders 
 	WHERE customer_id = 2
);
