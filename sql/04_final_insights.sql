-- 13. Выручка по годам и месяцам
SELECT 
    EXTRACT(YEAR FROM invoice_date) AS year,
    EXTRACT(MONTH FROM invoice_date) AS month,
    COUNT(*) AS invoices,
    ROUND(SUM(total), 2) AS revenue
FROM invoice
GROUP BY year, month
ORDER BY year, month;

-- 14. Клиенты с самой высокой средней суммой покупки
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.country,
    COUNT(i.invoice_id) AS invoices,
    ROUND(AVG(i.total), 2) AS avg_check,
    ROUND(SUM(i.total), 2) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
HAVING COUNT(i.invoice_id) >= 5
ORDER BY avg_check DESC
LIMIT 10;