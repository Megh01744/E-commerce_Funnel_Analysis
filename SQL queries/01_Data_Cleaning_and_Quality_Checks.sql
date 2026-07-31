/* =========================================================
   Google Merchandise Store

   Data Cleaning and Quality Checks
   ========================================================= */


/* 1. Check the size of all three source tables */

SELECT
    'events_raw' AS table_name,
    COUNT(*) AS total_rows
FROM events_raw

UNION ALL

SELECT
    'items' AS table_name,
    COUNT(*) AS total_rows
FROM items

UNION ALL

SELECT
    'users' AS table_name,
    COUNT(*) AS total_rows
FROM users;


/* 2. Check missing values in the raw event data */

SELECT
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END)
        AS missing_user_id,

    SUM(CASE WHEN ga_session_id IS NULL THEN 1 ELSE 0 END)
        AS missing_session_id,

    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END)
        AS missing_country,

    SUM(CASE WHEN device IS NULL THEN 1 ELSE 0 END)
        AS missing_device,

    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END)
        AS missing_event_type,

    SUM(CASE WHEN item_id IS NULL THEN 1 ELSE 0 END)
        AS missing_item_id,

    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END)
        AS missing_date
FROM events_raw;


/* 3. Count exact duplicate groups and extra rows */

WITH duplicate_groups AS (
    SELECT
        user_id,
        ga_session_id,
        country,
        device,
        type,
        item_id,
        date,
        COUNT(*) AS occurrence_count
    FROM events_raw
    GROUP BY
        user_id,
        ga_session_id,
        country,
        device,
        type,
        item_id,
        date
    HAVING COUNT(*) > 1
)

SELECT
    COUNT(*) AS duplicate_groups,
    SUM(occurrence_count - 1) AS duplicate_rows_to_remove
FROM duplicate_groups;


/* 4. Create the cleaned event table */

DROP TABLE IF EXISTS events_clean;

CREATE TABLE events_clean AS
SELECT DISTINCT
    user_id,
    ga_session_id,
    COALESCE(country, 'Unknown') AS country,
    device,
    type,
    item_id,
    date
FROM events_raw;


/* 5. Validate the cleaned event table */

SELECT
    COUNT(*) AS cleaned_rows,

    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END)
        AS missing_country,

    SUM(CASE WHEN country = 'Unknown' THEN 1 ELSE 0 END)
        AS unknown_country_rows,

    COUNT(*) - (
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT *
            FROM events_clean
        )
    ) AS exact_duplicate_rows

FROM events_clean;
