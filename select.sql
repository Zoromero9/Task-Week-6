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
