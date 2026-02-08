CREATE TABLE customers (
  customer_id serial PRIMARY KEY,
  name varchar(100) NOT NULL,
  city varchar(100) NOT NULL
);

CREATE TABLE orders (
  orders_id serial PRIMARY KEY,
  title varchar(100) NOT NULL,
  price integer NOT NULL,
  customer_id integer REFERENCES customers(customer_id),
  date date NOT NULL
);

INSERT INTO customers (name, city) VALUES 
('Andi','Bandung'),
('Budi','Jakarta'),
('Citra','Surabaya'),
('Dewi','Bandung'),
('Eka','Yogyakarta'),
('Fajar','Malang'),
('Gilang','Jakarta'),
('Hana','Bandung'),
('Irfan','Solo'),
('Joko','Semarang'),
('Karin','Jakarta'),
('Lutfi','Bandung');


INSERT INTO orders (title, price, customer_id, date) VALUES 
('Machine Learning',300000,1,'2024-01-10'),
('Kubernetes Basic',350000,1,'2024-01-15'),
('System Design',280000,1,'2024-01-20'),
('React Guide',180000,1,'2024-02-10'),
('Backend NodeJS',200000,1,'2024-03-05'),
('Docker for Dev',220000,1,'2024-03-20'),

('Kubernetes Basic',350000,2,'2024-01-12'),
('Machine Learning',300000,2,'2024-01-18'),
('System Design',280000,2,'2024-02-01'),
('React Guide',180000,2,'2024-02-10'),
('Backend NodeJS',200000,2,'2024-03-01'),

('Machine Learning',300000,3,'2024-01-15'),
('Kubernetes Basic',350000,3,'2024-01-25'),
('System Design',280000,3,'2024-02-05'),
('React Guide',180000,3,'2024-02-15'),
('Docker for Dev',220000,3,'2024-03-10'),

('PostgreSQL Dasar',150000,4,'2024-02-01'),
('SQL untuk Pemula',120000,4,'2024-02-10'),
('Backend NodeJS',200000,4,'2024-03-01'),
('React Guide',180000,4,'2024-03-15'),

('Machine Learning',300000,5,'2024-01-20'),
('Kubernetes Basic',350000,5,'2024-02-01'),
('System Design',280000,5,'2024-02-15'),
('Docker for Dev',220000,5,'2024-03-01'),

('Backend NodeJS',200000,6,'2024-01-10'),
('React Guide',180000,6,'2024-01-20'),
('Machine Learning',300000,6,'2024-02-05'),
('System Design',280000,6,'2024-02-20'),

('Kubernetes Basic',350000,7,'2024-01-05'),
('Machine Learning',300000,7,'2024-01-15'),
('Docker for Dev',220000,7,'2024-02-01'),
('React Guide',180000,7,'2024-02-15'),

('SQL untuk Pemula',120000,8,'2024-01-10'),
('PostgreSQL Dasar',150000,8,'2024-01-20'),
('Backend NodeJS',200000,8,'2024-02-05'),
('Docker for Dev',220000,8,'2024-02-20'),

('React Guide',180000,9,'2024-01-10'),
('Machine Learning',300000,9,'2024-01-25'),
('System Design',280000,9,'2024-02-10'),
('Kubernetes Basic',350000,9,'2024-02-25'),

('SQL untuk Pemula',120000,10,'2024-01-05'),
('PostgreSQL Dasar',150000,10,'2024-01-15'),
('React Guide',180000,10,'2024-02-01'),
('Backend NodeJS',200000,10,'2024-02-10'),

('System Design',280000,11,'2024-01-10'),
('Kubernetes Basic',350000,11,'2024-01-20'),
('Machine Learning',300000,11,'2024-02-01'),
('Docker for Dev',220000,11,'2024-02-10'),

('SQL untuk Pemula',120000,12,'2024-01-05'),
('PostgreSQL Dasar',150000,12,'2024-01-15'),
('React Guide',180000,12,'2024-02-01'),
('Backend NodeJS',200000,12,'2024-02-10');


-- 1. Tampilkan nama customer, kota, judul buku, harga, & tanggal order hanya untuk customer dari Bandung atau Jakarta dan harga buku ≥ 180.000. Urutkan dari harga tertinggi ke terendah
SELECT c.name, c.city, o.title, o.price, o.date 
FROM customers AS c 
  JOIN orders AS o ON c.customer_id=o.customer_id 
WHERE c.city IN ('Bandung', 'jakarta') AND o.price >= 180000 
ORDER BY o.price DESC;

-- 2. Cari total belanja per kota, lalu tampilkan hanya kota dengan total belanja > 3.000.000.
SELECT c.city, sum(o.price) AS total_spending 
FROM customers AS c 
  JOIN orders AS o ON c.customer_id=o.customer_id 
GROUP BY c.city 
  HAVING SUM(o.price) > 3000000;

/*
3. Tampilkan daftar pesanan yang memenuhi syarat:
- Tanggal order antara 1 Februari 2024 – 31 Maret 2024
- Judul buku mengandung kata “SQL” atau “PostgreSQL”
- Tampilkan nama customer, kota, judul buku, harga, dan tanggal order
- Urutkan berdasarkan tanggal terbaru → terlama. */
SELECT c.name, c.city, o.title, o.price, o."date"
FROM customers AS c
  JOIN orders AS o ON c.customer_id=o.customer_id
WHERE o.date BETWEEN date '2024-02-01' AND date '2024-03-31'
  AND (
    o.title ilike '%SQL%' OR o.title ilike '%PostgreSQL%'
  )
ORDER BY o."date" DESC;

-- 4. Tampilkan nama customer, kota, jumlah buku yang dibeli, total uang yang dihabiskan, & rata-rata harga buku yang dibeli. Hanya tampilkan customer yang membeli minimal 4 buku. Urutkan dari total belanja tertinggi.
SELECT c.name,
  c.city,
  COUNT(o.orders_id) AS total_books,
  SUM(o.price) AS total_spending,
  AVG(o.price) AS average_price
FROM customers AS c
JOIN orders AS o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
HAVING COUNT(o.orders_id) >= 4
ORDER BY total_spending DESC;
