--Check total rows across all three tables

-- to understand dataset scale before analysis

-- Row count check

SELECT 'events' AS events, COUNT(*) AS total_rows 
FROM events
UNION ALL
SELECT 'items' AS items, COUNT(*) AS total_rows 
FROM items
UNION ALL
SELECT 'users' AS users, COUNT(*) AS total_rows 
FROM users
),

-- Confirms three funnel stages exist: add_to_cart, 
-- begin_checkout, purchase

SELECT 
type AS event_type,
COUNT(*) AS total_events
FROM events
GROUP BY event_type
ORDER BY total_events DESC
),

-- Check for missing values across all key columns
-- Identified 4,555 missing country values
-- All other columns are complete

SELECT
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS missing_user_id,
 SUM(CASE WHEN ga_session_id IS NULL THEN 1 ELSE 0 END) AS missing_session_id,
 SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
 SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS missing_type,
 SUM(CASE WHEN item_id IS NULL THEN 1 ELSE 0 END) AS missing_item_id
FROM events
),

-- Check for duplicate records by comparing total rows 
-- vs unique row combinations across key columns

  SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT user_id || ga_session_id || type || item_id || date) AS unique_rows
FROM events
),

-- Count total number of duplicate records
-- 39,498 duplicates found (758,884 - 719,386)

SELECT 
COUNT(*) - COUNT(DISTINCT user_id || ga_session_id || type || item_id || date) AS duplicate_rows
FROM events
),

-- Investigate duplicate records to understand pattern
-- Helps determine if duplicates are data errors 
-- or legitimate repeated events

SELECT user_id,
ga_session_id,  
type, 
item_id,
date,
COUNT(*) AS occurrence_count
FROM events
GROUP BY user_id,
ga_session_id,  
type, 
item_id,
date
HAVING COUNT(*) > 1
LIMIT 10 
),

----- DATA CLEANING ----

-- Remove duplicate records and create clean dataset
-- Reduces 758,884 rows to 719,386 rows

CREATE TABLE events_clean AS
SELECT DISTINCT
  user_id,
  ga_session_id,
  country,
  device,
  type,
  item_id,
  date
FROM events
),  


-- Replace missing country values with 'Unknown'
-- 4,555 null country values handled

UPDATE events_clean
SET country = 'Unknown'
WHERE country IS NULL
),


-- Verify cleaning results
-- All columns should return 0 missing values

SELECT
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS missing_user_id,
    SUM(CASE WHEN ga_session_id IS NULL THEN 1 ELSE 0 END) AS missing_session_id,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN device IS NULL THEN 1 ELSE 0 END) AS missing_device,
    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS missing_type
FROM events_clean
),
