-- Device Analysis -- 

--Desktop leads traffic but does mobile convert better? Where should UX investment go?
SELECT
    device,
    COUNT(*) AS total_events
FROM events_clean
GROUP BY device
ORDER BY total_events DESC
),

-- At which funnel stage does each device lose the most users?
SELECT
    device,
    type,
    COUNT(*) AS total_events
FROM events_clean
GROUP BY device, type
ORDER BY total_events DESC

),

-- Mobile accounts for 40% of traffic but converts at 2.24% higher than desktop at 2.20%. Does this justify a mobile-first checkout redesign
SELECT
    device,
    ROUND(
        100.0 * SUM(CASE WHEN type = 'purchase' THEN 1 ELSE 0 END)
        / SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END)
    , 2) AS conversion_rate
FROM events_clean
GROUP BY device
ORDER BY conversion_rate DESC
),

-- All devices show critically low checkout rates (under 6%). Is the cart-to-checkout barrier a UI problem or a pricing/trust issue affecting all devices equally
SELECT
    device,
    ROUND(
        100.0 * 
  SUM(CASE WHEN type = 'begin_checkout' THEN 1 ELSE 0 END)
  / SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END)
    , 2) AS checkout_rate
FROM events_clean
GROUP BY device
ORDER BY checkout_rate DESC
),

-- Country Analysis --
-- US dominates traffic at 330K events but are high-traffic countries also the highest converting
SELECT
    country,
    COUNT(*) AS total_events
FROM events_clean
GROUP BY country
ORDER BY total_events DESC
LIMIT 10
),

-- Which countries actually convert to purchases? High traffic countries may not be top buyers
SELECT
    country,
    COUNT(*) AS total_purchases
FROM events_clean
WHERE type = 'purchase'
GROUP BY country
ORDER BY total_purchases DESC
LIMIT 10
),

-- Nigeria leads conversion at 7.62% — are smaller markets outperforming high-traffic ones like US?
SELECT
    country,
    ROUND(
        100.0 * 
  SUM(CASE WHEN type = 'purchase' THEN 1 ELSE 0 END)
  / 
  SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END)
   ,2) AS conversion_rate
FROM events_clean
GROUP BY country
HAVING SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END) > 100
ORDER BY conversion_rate DESC
LIMIT 10
),

-- Which countries have zero conversion despite significant traffic
SELECT
    country,
    ROUND(
        100.0 *
        SUM(CASE WHEN type = 'purchase' THEN 1 ELSE 0 END)
        /
        SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END)
    ,2) AS conversion_rate
FROM events_clean
GROUP BY country
HAVING SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END) >100
ORDER BY conversion_rate ASC
LIMIT 10
),

-- Product Analysis -- 


-- Apparel dominates purchases at 4,858, 3x the next category. Is the business too dependent on one category
SELECT
    i.category,
    COUNT(*) AS total_purchases
FROM events_clean AS e
JOIN items AS i ON e.item_id = i.id
WHERE e.type = 'purchase'
GROUP BY i.category
ORDER BY total_purchases DESC
LIMIT 10
),

-- Google brand drives 12,714 purchases than Android. Are non-Google brands being promoted enough or is the store effectively a Google-only shop
SELECT
    i.brand,
    COUNT(*) AS total_purchases
FROM events_clean AS e
JOIN items AS i ON e.item_id = i.id
WHERE e.type = 'purchase'
GROUP BY i.brand
ORDER BY total_purchases DESC
LIMIT 10
),

-- How is revenue distributed across product categories

 SELECT i.category,
   ROUND(SUM(i.price_in_usd),2) AS total_revenue
FROM events_clean e
JOIN items i 
ON e.item_id = i.id
WHERE e.type = 'purchase'
GROUP BY i.category
ORDER BY total_revenue DESC
LIMIT 10
),

-- Which categories convert browsers into buyers most effectively
SELECT i.category,
    ROUND(
    100.0 * 
     SUM(CASE WHEN e.type = 'purchase' THEN 1 ELSE 0 END)
     /
      SUM(CASE WHEN e.type = 'add_to_cart' THEN 1 ELSE 0 END)
      ,2) AS conversion_rate 
FROM events_clean e
JOIN items i
ON e.item_id = i.id
GROUP BY i.category 
HAVING SUM(CASE WHEN e.type = 'add_to_cart' THEN 1 ELSE 0 END) > 50
ORDER BY conversion_rate DESC
LIMIT 10
),

-- Customer Value Analysis (LTV) --

-- What is the spread of customer lifetime value? Avg LTV of $1.51 vs max $3,360 suggests a small group of high-value customers
SELECT
    ROUND(MIN(ltv), 2) AS min_ltv,
    ROUND(MAX(ltv), 2) AS max_ltv,
    ROUND(AVG(ltv), 2) AS avg_ltv
FROM users
),

-- How are customers distributed across value segments? 68 high-value customers vs 268K low-value where should retention efforts be focused
SELECT
    CASE 
        WHEN ltv < 100 THEN 'Low_value'
        WHEN ltv BETWEEN 100 AND 500 THEN 'Medium_value'
        ELSE 'High_value'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM users
GROUP BY customer_segment
),

-- Which customer segment drives the most purchases? Low-value customers lead in volume but high-value customers are more efficient buyers
SELECT
    CASE 
        WHEN u.ltv < 100 THEN 'Low_value'
        WHEN u.ltv BETWEEN 100 AND 500 THEN 'Medium_value'
        ELSE 'High_value'
    END AS customer_segment,
    COUNT(*) AS total_purchases
FROM events_clean AS e
JOIN users AS u ON e.user_id = u.id
WHERE e.type = 'purchase'
GROUP BY customer_segment
ORDER BY total_purchases DESC
),

-- What is the average order value per customer segment, helps understand revenue quality not just volume
SELECT
    CASE 
        WHEN u.ltv < 100 THEN 'Low_value'
        WHEN u.ltv BETWEEN 100 AND 500 THEN 'Medium_value'
        ELSE 'High_value'
    END AS customer_segment,
    ROUND(AVG(i.price_in_usd), 2) AS avg_order_value,
    COUNT(*) AS total_purchases
FROM events_clean AS e
JOIN users AS u ON e.user_id = u.id
JOIN items AS i ON e.item_id = i.id
WHERE e.type = 'purchase'
GROUP BY customer_segment
ORDER BY avg_order_value DESC
),


