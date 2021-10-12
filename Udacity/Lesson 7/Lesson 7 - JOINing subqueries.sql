SELECT COALESCE(orders.date,web_events.date) AS date,
			orders.active_sales_reps,
			orders.orders,
			web_events.web_visits
FROM (
SELECT DATE_TRUNC('day', o.occurred_at) AS date,
		COUNT(a.sales_rep_id) AS active_sales_reps,
        COUNT(o.id) AS orders
FROM   accounts a
JOIN   orders o
ON     o.account_id = a.id
GROUP BY 1
	) orders

FULL JOIN
(
SELECT DATE_TRUNC('day', we.occurred_at) AS date,
		COUNT(we.id) AS web_visits
FROM   web_events we
GROUP BY 1
) web_events

ON web_events.date = orders.date
ORDER BY 1 DESC
