-- 5. Общая выручка и средний чек
SELECT 
    ROUND(SUM(total), 2) AS total_revenue,
    ROUND(AVG(total), 2) AS avg_check,
    COUNT(*) AS total_invoices
FROM invoice;

-- 6. Топ-10 клиентов по выручке
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.country,
    ROUND(SUM(i.total), 2) AS total_spent,
    COUNT(i.invoice_id) AS invoices_count
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
ORDER BY total_spent DESC
LIMIT 10;

-- 7. Выручка по странам
SELECT 
    billing_country,
    ROUND(SUM(total), 2) AS revenue,
    COUNT(*) AS invoices_count,
    ROUND(AVG(total), 2) AS avg_check
FROM invoice
GROUP BY billing_country
ORDER BY revenue DESC;

-- 8. Самые популярные жанры по количеству проданных треков
SELECT 
    g.name AS genre,
    COUNT(il.invoice_line_id) AS tracks_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS revenue
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY g.name
ORDER BY tracks_sold DESC
LIMIT 10;