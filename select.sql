-- 1. Tampilkan nama customer, kota, judul buku, harga, & tanggal order hanya untuk customer dari Bandung atau Jakarta dan harga buku ≥ 180.000. Urutkan dari harga tertinggi ke terendah
SELECT
  c.name,
  c.city,
  o.course,
  o.price,
  o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE c.city IN ('Bandung', 'Jakarta')
  AND o.price >= 180000
ORDER BY o.price DESC;

-- 2. Cari total belanja per kota, lalu tampilkan hanya kota dengan total belanja > 3.000.000.
SELECT
  c.city,
  SUM(o.price) AS total_spending
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.city
HAVING SUM(o.price) > 3000000;

/*
3. Tampilkan daftar pesanan yang memenuhi syarat:
- Tanggal order antara 1 Februari 2024 – 31 Maret 2024
- Judul buku mengandung kata “SQL” atau “PostgreSQL”
- Tampilkan nama customer, kota, judul buku, harga, dan tanggal order
- Urutkan berdasarkan tanggal terbaru → terlama. */
SELECT
  c.name,
  c.city,
  o.course,
  o.price,
  o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date BETWEEN DATE '2024-02-01' AND DATE '2024-03-31'
  AND (
    o.course ILIKE '%SQL%'
    OR o.course ILIKE '%PostgreSQL%'
  )
ORDER BY o.order_date DESC;


-- 4. Tampilkan nama customer, kota, jumlah buku yang dibeli, total uang yang dihabiskan, & rata-rata harga buku yang dibeli. Hanya tampilkan customer yang membeli minimal 4 buku. Urutkan dari total belanja tertinggi.
SELECT
  c.name,
  c.city,
  COUNT(o.id) AS total_books,
  SUM(o.price) AS total_spending,
  AVG(o.price) AS average_price
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name, c.city
HAVING COUNT(o.id) >= 4
ORDER BY total_spending DESC;
