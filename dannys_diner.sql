CREATE TABLE restuarant.sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO restuarant.sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 
 CREATE TABLE restuarant.menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO restuarant.menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE restuarant.members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO restuarant.members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
/* --------------------
   Case Study Questions
   --------------------*/
   
   -- 1. What is the total amount each customer spent at the restaurant?
   SELECT customer_id, sum(price) as total_amt_spent
   FROM sales as s
   INNER JOIN menu as m
   ON s.product_id = m.product_id
   GROUP BY customer_id;
   
   -- 2. How many days has each customer visited the restaurant?
   SELECT customer_id, COUNT(DISTINCT DATE(order_date)) as num_days
   FROM sales
   GROUP BY customer_id;
   
   -- 3. What was the first item from the menu purchased by each customer?
   WITH first_purchase as (SELECT customer_id, 
   ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date, s.product_id) as rn, 
   product_name
   FROM sales as s
   INNER JOIN menu as m
   ON s.product_id = m.product_id)
   
   SELECT customer_id, product_name
   FROM first_purchase
   WHERE rn = 1;
   
   -- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
   SELECT s.product_id, COUNT(s.product_id) AS purchased_count, m.product_name
   FROM sales AS s
   INNER JOIN menu AS m
   ON s.product_id = m.product_id
   GROUP BY s.product_id, m.product_name
   ORDER BY purchased_count DESC
   LIMIT 1;
    
    -- 5. Which item was the most popular for each customer?
    WITH popular_items as (SELECT customer_id, 
	        s.product_id,
		RANK() OVER(PARTITION BY customer_id  ORDER BY COUNT(s.product_id) DESC) as rank_product,
	        product_name
    FROM sales as s
    INNER JOIN menu as m
    ON s.product_id = m.product_id
    GROUP BY s.product_id, customer_id, product_name)
    
    SELECT customer_id, product_name
    FROM popular_items
    WHERE rank_product = 1;
    
    -- 6. Which item was purchased first by the customer after they became a member?
    WITH next_food_item as (SELECT customer_id, product_id
    FROM (SELECT s.customer_id, 
	    s.product_id, 
	    s.order_date, 
	    m.join_date,
    	    RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date ASC) as rn
    FROM sales as s
    INNER JOIN members as m
    ON s.customer_id = m.customer_id
    WHERE s.order_date > m.join_date) as next_item
    WHERE rn = 1)
    
    SELECT customer_id, product_name
    FROM next_food_item as n
    INNER JOIN menu as m
    ON n.product_id = m.product_id
    ORDER BY customer_id;
    
    -- 7. Which item was purchased just before the customer became a member?
    WITH next_food_item as (SELECT customer_id, product_id
    FROM (SELECT s.customer_id, 
    s.product_id, 
    s.order_date, 
    m.join_date,
    RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date ASC) as rn
    FROM sales as s
    INNER JOIN members as m
    ON s.customer_id = m.customer_id
    WHERE s.order_date < m.join_date) as next_item
    WHERE rn = 1)
    
    SELECT customer_id, product_name
    FROM next_food_item as n
    INNER JOIN menu as m
    ON n.product_id = m.product_id
    ORDER BY customer_id;
    
    -- 8. What is the total items and amount spent for each member before they became a member?
    SELECT s.customer_id, count(s.product_id) as total_items, SUM(price) as total_amt_spent
    FROM sales as s
    INNER JOIN members as m
    ON s.customer_id = m.customer_id
    INNER JOIN menu as me
    ON s.product_id = me.product_id
    WHERE s.order_date < m.join_date
    GROUP BY s.customer_id;
    
    -- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
    SELECT s.customer_id, 
    SUM(CASE WHEN m.product_name != 'sushi' THEN 10*price ELSE 2*10*price END ) AS points
    FROM sales as s
    INNER JOIN menu as m
    ON s.product_id = m.product_id
    GROUP BY s.customer_id;
    
    -- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
    SELECT s.customer_id, 
    SUM(2*10*price) AS points
    FROM sales as s
    INNER JOIN menu as m
    ON s.product_id = m.product_id
    INNER JOIN members as me
    ON s.customer_id = me.customer_id
    WHERE s.order_date >= me.join_date
    GROUP BY s.customer_id;
    
    
    
    
    
    
    
    

   
