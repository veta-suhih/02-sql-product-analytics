-- 1. Список всех таблиц
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;

-- 2. Количество клиентов, треков, инвойсов
SELECT 
    (SELECT COUNT(*) FROM customer) AS total_customers,
    (SELECT COUNT(*) FROM track) AS total_tracks,
    (SELECT COUNT(*) FROM invoice) AS total_invoices,
    (SELECT COUNT(*) FROM invoice_line) AS total_invoice_lines;

-- 3. Первые 10 клиентов
SELECT * 
FROM customer
LIMIT 10;

-- 4. Первые 10 инвойсов
SELECT * 
FROM invoice
ORDER BY invoice_date
LIMIT 10;