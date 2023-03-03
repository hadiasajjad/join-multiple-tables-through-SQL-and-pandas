import pandas as pd
import numpy as np

# create customers table
customers = pd.DataFrame({
    'customer_id': [1, 2, 3, 4, 5],
    'customer_name': ['Alice', 'Bob', 'Charlie', 'Dave', 'Eve']
})

# create orders table
orders = pd.DataFrame({
    'order_id': [1, 2, 3, 4, 5, 6, 7, 8],
    'customer_id': [1, 2, 2, 3, 3, 3, 4, 5],
    'product_id': [1, 2, 3, 1, 2, 3, 2, 1],
    'order_date': ['2022-01-01', '2022-01-02', '2022-01-03', '2022-01-04', '2022-01-05', '2022-01-06', '2022-01-07', '2022-01-08'],
    'order_amount': [100, 200, 150, 75, 50, 125, 175, 225]
})

# create products table
products = pd.DataFrame({
    'product_id': [1, 2, 3],
    'product_name': ['Widget A', 'Widget B', 'Widget C'],
    'product_cost': [50, 75, 100]
})

# join orders and products tables on product_id
order_products = orders.merge(products, on='product_id')

# calculate total revenue for each product
product_revenue = order_products.groupby(['product_id', 'product_name'])['order_amount'].sum().reset_index(name='revenue')

# join customers table to orders table on customer_id
customer_orders = customers.merge(orders, on='customer_id')

# calculate total revenue for each customer and product
total_revenue = customer_orders.groupby(['customer_id', 'customer_name', 'product_id'], as_index=False)['order_amount'].sum()

# merge products table to get product names
total_revenue = total_revenue.merge(products, on='product_id')

# merge product_revenue table to get total revenue for each product
total_revenue = total_revenue.merge(product_revenue, on=['product_id', 'product_name'])

# calculate profit by subtracting product cost from order amount
total_revenue['profit'] = total_revenue['order_amount'] - total_revenue['product_cost']

# group by customer name and product name to find total profit per customer and product
profit_by_customer_and_product = total_revenue.groupby(['customer_name', 'product_name'], as_index=False)['profit'].sum()
print(customer_orders)
print(profit_by_customer_and_product)