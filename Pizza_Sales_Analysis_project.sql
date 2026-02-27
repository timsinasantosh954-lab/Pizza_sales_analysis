CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);


Select *from orders;

CREATE TABLE pizza_types (
    pizza_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT NOT NULL
);
ALTER TABLE pizza_types
ALTER COLUMN pizza_type_id TYPE VARCHAR(50);


select *from pizza_types;

INSERT INTO pizza_types (pizza_type_id, name, category, ingredients) VALUES
('bbq_ckn','The Barbecue Chicken Pizza','Chicken','Barbecued Chicken, Red Peppers, Green Peppers, Tomatoes, Red Onions, Barbecue Sauce'),
('cali_ckn','The California Chicken Pizza','Chicken','Chicken, Artichoke, Spinach, Garlic, Jalapeno Peppers, Fontina Cheese, Gouda Cheese'),
('ckn_alfredo','The Chicken Alfredo Pizza','Chicken','Chicken, Red Onions, Red Peppers, Mushrooms, Asiago Cheese, Alfredo Sauce'),
('ckn_pesto','The Chicken Pesto Pizza','Chicken','Chicken, Tomatoes, Red Peppers, Spinach, Garlic, Pesto Sauce'),
('southw_ckn','The Southwest Chicken Pizza','Chicken','Chicken, Tomatoes, Red Peppers, Red Onions, Jalapeno Peppers, Corn, Cilantro, Chipotle Sauce'),
('thai_ckn','The Thai Chicken Pizza','Chicken','Chicken, Pineapple, Tomatoes, Red Peppers, Thai Sweet Chilli Sauce'),
('big_meat','The Big Meat Pizza','Classic','Bacon, Pepperoni, Italian Sausage, Chorizo Sausage'),
('classic_dlx','The Classic Deluxe Pizza','Classic','Pepperoni, Mushrooms, Red Onions, Red Peppers, Bacon'),
('hawaiian','The Hawaiian Pizza','Classic','Sliced Ham, Pineapple, Mozzarella Cheese'),
('ital_cpcllo','The Italian Capocollo Pizza','Classic','Capocollo, Red Peppers, Tomatoes, Goat Cheese, Garlic, Oregano'),
('napolitana','The Napolitana Pizza','Classic','Tomatoes, Anchovies, Green Olives, Red Onions, Garlic'),
('pep_msh_pep','The Pepperoni, Mushroom, and Peppers Pizza','Classic','Pepperoni, Mushrooms, Green Peppers'),
('pepperoni','The Pepperoni Pizza','Classic','Mozzarella Cheese, Pepperoni'),
('the_greek','The Greek Pizza','Classic','Kalamata Olives, Feta Cheese, Tomatoes, Garlic, Beef Chuck Roast, Red Onions'),
('brie_carre','The Brie Carre Pizza','Supreme','Brie Carre Cheese, Prosciutto, Caramelized Onions, Pears, Thyme, Garlic'),
('calabrese','The Calabrese Pizza','Supreme','Nduja Salami, Pancetta, Tomatoes, Red Onions, Friggitello Peppers, Garlic'),
('ital_supr','The Italian Supreme Pizza','Supreme','Calabrese Salami, Capocollo, Tomatoes, Red Onions, Green Olives, Garlic'),
('peppr_salami','The Pepper Salami Pizza','Supreme','Genoa Salami, Capocollo, Pepperoni, Tomatoes, Asiago Cheese, Garlic'),
('prsc_argla','The Prosciutto and Arugula Pizza','Supreme','Prosciutto di San Daniele, Arugula, Mozzarella Cheese'),
('sicilian','The Sicilian Pizza','Supreme','Coarse Sicilian Salami, Tomatoes, Green Olives, Luganega Sausage, Onions, Garlic'),
('soppressata','The Soppressata Pizza','Supreme','Soppressata Salami, Fontina Cheese, Mozzarella Cheese, Mushrooms, Garlic'),
('spicy_ital','The Spicy Italian Pizza','Supreme','Capocollo, Tomatoes, Goat Cheese, Artichokes, Peperoncini verdi, Garlic'),
('spinach_supr','The Spinach Supreme Pizza','Supreme','Spinach, Red Onions, Pepperoni, Tomatoes, Artichokes, Kalamata Olives, Garlic, Asiago Cheese'),
('five_cheese','The Five Cheese Pizza','Veggie','Mozzarella Cheese, Provolone Cheese, Smoked Gouda Cheese, Romano Cheese, Blue Cheese, Garlic'),
('four_cheese','The Four Cheese Pizza','Veggie','Ricotta Cheese, Gorgonzola Piccante Cheese, Mozzarella Cheese, Parmigiano Reggiano Cheese, Garlic'),
('green_garden','The Green Garden Pizza','Veggie','Spinach, Mushrooms, Tomatoes, Green Olives, Feta Cheese'),
('ital_veggie','The Italian Vegetables Pizza','Veggie','Eggplant, Artichokes, Tomatoes, Zucchini, Red Peppers, Garlic, Pesto Sauce'),
('mediterraneo','The Mediterranean Pizza','Veggie','Spinach, Artichokes, Kalamata Olives, Sun-dried Tomatoes, Feta Cheese, Plum Tomatoes, Red Onions'),
('mexicana','The Mexicana Pizza','Veggie','Tomatoes, Red Peppers, Jalapeno Peppers, Red Onions, Cilantro, Corn, Chipotle Sauce, Garlic'),
('spin_pesto','The Spinach Pesto Pizza','Veggie','Spinach, Artichokes, Tomatoes, Sun-dried Tomatoes, Garlic, Pesto Sauce'),
('spinach_fet','The Spinach and Feta Pizza','Veggie','Spinach, Mushrooms, Red Onions, Feta Cheese, Garlic'),
('veggie_veg','The Vegetables + Vegetables Pizza','Veggie','Mushrooms, Tomatoes, Red Peppers, Green Peppers, Red Onions, Zucchini, Spinach, Garlic');


select *from pizza_types ;



CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50) NOT NULL,
    size VARCHAR(10) NOT NULL,
    price NUMERIC(6,2) NOT NULL,
    CONSTRAINT fk_pizza_type
        FOREIGN KEY (pizza_type_id)
        REFERENCES pizza_types(pizza_type_id)
);


select *from  pizzas 




CREATE TABLE order_details (
    order_details_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),

    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_pizza
        FOREIGN KEY (pizza_id)
        REFERENCES pizzas(pizza_id)
        ON DELETE CASCADE
);



Select *from order_details ;



--Basic:
--Q1. Retrieve the total number of orders placed.

Select Count(*) as total_oders from orders;

--Q2.Calculate the total revenue generated from pizza sales.

select Sum(od.quantity *p.price) as Total_revenue
from order_details od
Join pizzas p 
on od.pizza_id=p.pizza_id;


--Q3.Identify the highest-priced pizza.

Select name,price
from pizzas p
join pizza_types pt
on p.pizza_type_id=pt.pizza_type_id

where p.price=(Select Max(price) from pizzas)
;

select max(price) from pizzas;

--Q4.Identify the most common pizza size ordered.

SELECT 
    p.size,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;

--q5.List the top 5 most ordered pizza types along with their quantities.

Select pt.name,
sum(od.quantity) as total_quantity_ordered
from order_details od
join pizzas p
on od.pizza_id=p.pizza_id
join pizza_types pt 
on p.pizza_type_id=pt.pizza_type_id
group By pt.name
order by total_quantity_ordered desc
limit 5;


--Intermediate:
--Join the necessary tables to find the total quantity of each pizza category ordered.

Select pt.name,pt.category, sum(quantity) as Total_quantity_order
from order_details od
join pizzas p
on od.pizza_id=p.pizza_id
join pizza_types pt
on p.pizza_type_id=pt.pizza_type_id
group by pt.name,pt.category
order by Total_quantity_order desc

--Determine the distribution of orders by hour of the day.
select 
EXTRACT(HOUR FROM order_time) AS order_hour,
count(*)
from orders
group by order_hour

--Join relevant tables to find the category-wise distribution of pizzas.
Select pt.name, o.order_date,pt.category,sum(od.quantity) as quantity_sold

from orders o
join order_details od on o.order_id = od.order_id
join pizzas p on od.pizza_id=p.pizza_id
join  pizza_types pt on p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name,o.order_date,pt.category
order by quantity_sold desc;

--Determine the top 3 most ordered pizza types based on revenue.

-- Determine the top 3 most ordered pizza types based on revenue

SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;

--Advanced:
--Calculate the percentage contribution of each pizza type to total revenue.
-- Calculate the percentage contribution of each pizza type to total revenue

SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
    ROUND(
        SUM(od.quantity * p.price) * 100.0 /
        SUM(SUM(od.quantity * p.price)) OVER (),
        2
    ) AS percentage_contribution
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY percentage_contribution DESC;
--Analyze the cumulative revenue generated over time.
SELECT
    o.date,
    ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue,
    
    ROUND(
        SUM(SUM(od.quantity * p.price)) 
        OVER (ORDER BY o.date),
        2
    ) AS cumulative_revenue

FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id

GROUP BY o.date
ORDER BY o.date;
--Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT *
FROM (
    SELECT
        pt.category,
        pt.name AS pizza_type,
        ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY pt.category
            ORDER BY SUM(od.quantity * p.price) DESC
        ) AS rn
    FROM order_details od
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt 
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) t
WHERE rn <= 3
ORDER BY category, total_revenue DESC;





