CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT NOT NULL
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  course TEXT NOT NULL,
  price INT NOT NULL,
  customer_id INT REFERENCES customers(id),
  order_date DATE
);
