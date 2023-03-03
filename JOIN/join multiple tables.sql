-- Create the tables
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT,
  email TEXT
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  order_date DATE,
  total_amount DECIMAL,
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER,
  product_name TEXT,
  quantity INTEGER,
  price DECIMAL,
  FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- Insert some data into the tables
INSERT INTO customers VALUES
  (1, 'John Smith', 'john@example.com'),
  (2, 'Jane Doe', 'jane@example.com'),
  (3, 'Bob Johnson', 'bob@example.com');

INSERT INTO orders VALUES
  (1001, 1, '2022-01-01', 100.00),
  (1002, 2, '2022-01-02', 200.00),
  (1003, 1, '2022-01-03', 50.00),
  (1004, 3, '2022-01-04', 75.00),
  (1005, 2, '2022-01-05', 150.00);

INSERT INTO order_items VALUES
  (1, 1001, 'Product A', 2, 25.00),
  (2, 1001, 'Product B', 1, 50.00),
  (3, 1002, 'Product A', 3, 25.00),
  (4, 1003, 'Product C', 1, 50.00),
  (5, 1004, 'Product B', 2, 25.00),
  (6, 1004, 'Product C', 1, 25.00),
  (7, 1005, 'Product A', 1, 100.00);

-- Calculate the total revenue for each customer
SELECT 
  c.customer_name, 
  SUM(o.total_amount) AS total_revenue
FROM 
  customers c 
  JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY 
  c.customer_id;

-- Calculate the total profit for each customer and product
SELECT 
  c.customer_name, 
  oi.product_name, 
  SUM(oi.quantity * (oi.price - 10.00)) AS total_profit
FROM 
  customers c 
  JOIN orders o ON c.customer_id = o.customer_id 
  JOIN order_items oi ON o.order_id = oi.order_id 
GROUP BY 
  c.customer_id, 
  oi.product_name;