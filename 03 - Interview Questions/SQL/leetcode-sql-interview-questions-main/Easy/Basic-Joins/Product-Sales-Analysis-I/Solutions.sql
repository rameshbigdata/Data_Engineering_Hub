SELECT product_name, year, price 
FROM product 
JOIN sales 
ON product.product_id = sales.product_id;