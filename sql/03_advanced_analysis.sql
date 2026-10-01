-- 9. Выручка по сотрудникам
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(DISTINCT c.customer_id) AS customers_count,
    COUNT(i.invoice_id) AS invoices_count,
    ROUND(SUM(i.total), 2) AS total_revenue
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_revenue DESC;

-- 10. Количество клиентов и повторные покупки
SELECT 
    CASE 
        WHEN invoice_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers_count
FROM (
    SELECT customer_id, COUNT(invoice_id) AS invoice_count
    FROM invoice
    GROUP BY customer_id
) t
GROUP BY customer_type;

-- 11. Средний чек и количество покупок по странам
SELECT 
    billing_country,
    COUNT(*) AS invoices,
    ROUND(AVG(total), 2) AS avg_check,
    ROUND(SUM(total), 2) AS revenue
FROM invoice
GROUP BY billing_country
HAVING COUNT(*) > 5
ORDER BY revenue DESC;

-- 12. Топ-10 самых продаваемых треков
SELECT 
    t.name AS track_name,
    ar.name AS artist,
    COUNT(il.invoice_line_id) AS times_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS revenue
FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY t.track_id, t.name, ar.name
ORDER BY times_sold DESC
LIMIT 10;