CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL
	
);

CREATE TABLE pizza_types (
    pizza_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT NOT NULL
);


CREATE TABLE pizzas (
    pizza_id SERIAL PRIMARY KEY,
    pizza_type_id INT NOT NULL REFERENCES pizza_types(pizza_type_id),
    size VARCHAR(5) NOT NULL,
    price DECIMAL(6,2) NOT NULL
);

select *from order_details 

