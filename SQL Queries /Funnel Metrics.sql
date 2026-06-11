-- Funnel Analysis

-- KPI 1: Total events at each funnel stage

-- How many events occur at each stage of the funnel after cleaning?
SELECT 
type AS funnel_stage,
COUNT(*) AS total_rows
FROM events_clean 
GROUP BY type
ORDER BY total_rows DESC
),


-- KPI 2: Cart to Checkout Conversion Rate
  
-- Out of all Add-to-Cart events, how many reached Checkout?
SELECT
 ROUND(
     100.0*
SUM(CASE WHEN type= 'begin_checkout' THEN 1 ELSE 0 END)
/
SUM(CASE WHEN type='add_to_cart' THEN 1 ELSE 0 END),2) AS cart_checkout_rate
FROM events_clean
),

-- KPI 3: Checkout to Purchase Conversion Rate

-- Out of all checkout events, how many became purchases?
SELECT 
ROUND(
     100.0*
    SUM(CASE WHEN type = 'purchase' THEN 1 ELSE 0 END)
    /
    SUM(CASE WHEN type = 'begin_checkout' THEN 1 ELSE 0 END)
    ,2) AS checkout_to_purchase_rate
FROM events_clean
),

-- KPI 4: Overall Funnel Conversion Rate\
  
-- Out of all Add-to-Cart events, how many eventually became purchases?
SELECT 
     ROUND(
     100.0*
     SUM(CASE WHEN type = 'purchase' THEN 1   ELSE 0 END)
     /
     SUM(CASE WHEN type = 'add_to_cart' THEN 1 ELSE 0 END)
     ,2) AS overall_conversion_rate
FROM events_clean
),

