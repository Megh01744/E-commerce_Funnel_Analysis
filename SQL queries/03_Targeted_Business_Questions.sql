/* =========================================================
   Google Merchandise Store

   Targeted Business Questions
   ========================================================= */


/* =========================================================
   1. Country Funnel Performance

   Among the ten countries with the highest add-to-cart
   activity, which recorded the strongest funnel rates?
   ========================================================= */

WITH country_funnel AS (
    SELECT
        country,

        SUM(
            CASE WHEN type = 'add_to_cart'
                 THEN 1 ELSE 0 END
        ) AS add_to_cart_events,

        SUM(
            CASE WHEN type = 'begin_checkout'
                 THEN 1 ELSE 0 END
        ) AS begin_checkout_events,

        SUM(
            CASE WHEN type = 'purchase'
                 THEN 1 ELSE 0 END
        ) AS purchase_events

    FROM events_clean
    GROUP BY country
),

top_traffic_countries AS (
    SELECT *
    FROM country_funnel
    ORDER BY add_to_cart_events DESC
    LIMIT 10
)

SELECT
    country,
    add_to_cart_events,
    begin_checkout_events,
    purchase_events,

    ROUND(
        begin_checkout_events * 100.0 /
        NULLIF(add_to_cart_events, 0),
        2
    ) AS cart_to_checkout_rate_pct,

    ROUND(
        purchase_events * 100.0 /
        NULLIF(add_to_cart_events, 0),
        2
    ) AS purchase_to_cart_rate_pct

FROM top_traffic_countries
ORDER BY purchase_to_cart_rate_pct DESC;


/* =========================================================
   2. Brand Performance

   Which brands generated the most purchase activity
   and recorded product revenue?
   ========================================================= */

WITH brand_performance AS (
    SELECT
        COALESCE(NULLIF(TRIM(i.brand), ''), 'Unknown') AS brand,
        COUNT(*) AS purchase_events,
        SUM(i.price_in_usd) AS revenue_usd

    FROM events_clean AS e

    LEFT JOIN items AS i
        ON e.item_id = i.id

    WHERE e.type = 'purchase'

    GROUP BY
        COALESCE(NULLIF(TRIM(i.brand), ''), 'Unknown')
),

brand_totals AS (
    SELECT
        SUM(purchase_events) AS total_purchase_events,
        SUM(revenue_usd) AS total_revenue
    FROM brand_performance
)

SELECT
    bp.brand,
    bp.purchase_events,

    ROUND(
        bp.purchase_events * 100.0 /
        NULLIF(bt.total_purchase_events, 0),
        2
    ) AS purchase_event_share_pct,

    ROUND(bp.revenue_usd, 2) AS revenue_usd,

    ROUND(
        bp.revenue_usd * 100.0 /
        NULLIF(bt.total_revenue, 0),
        2
    ) AS revenue_share_pct

FROM brand_performance AS bp

CROSS JOIN brand_totals AS bt

ORDER BY bp.revenue_usd DESC;


/* =========================================================
   3. Recorded Customer Value and Purchase Behaviour

   How does purchase activity differ between users with
   zero recorded LTV and positive recorded LTV?

   The LTV field comes directly from users.csv.
   It is not calculated or predicted here.
   ========================================================= */

WITH user_purchase_activity AS (
    SELECT
        u.id AS user_id,
        u.ltv,

        CASE
            WHEN u.ltv > 0 THEN 'Positive LTV'
            ELSE 'Zero LTV'
        END AS ltv_status,

        SUM(
            CASE WHEN e.type = 'purchase'
                 THEN 1 ELSE 0 END
        ) AS purchase_events

    FROM users AS u

    LEFT JOIN events_clean AS e
        ON u.id = e.user_id

    GROUP BY
        u.id,
        u.ltv
)

SELECT
    ltv_status,
    COUNT(*) AS total_users,

    SUM(
        CASE WHEN purchase_events > 0
             THEN 1 ELSE 0 END
    ) AS users_with_purchase,

    ROUND(
        SUM(
            CASE WHEN purchase_events > 0
                 THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS users_with_purchase_pct,

    SUM(purchase_events) AS purchase_events,

    COALESCE(
        ROUND(
            SUM(purchase_events) * 1.0 /
            NULLIF(
                SUM(
                    CASE WHEN purchase_events > 0
                         THEN 1 ELSE 0 END
                ),
                0
            ),
            2
        ),
        0
    ) AS avg_purchase_events_per_purchasing_user,

    ROUND(SUM(ltv), 2) AS total_recorded_ltv,
    ROUND(AVG(ltv), 2) AS average_recorded_ltv

FROM user_purchase_activity

GROUP BY ltv_status

ORDER BY average_recorded_ltv DESC;


/* =========================================================
   4. Revenue per Purchase Session

   What is the average recorded product revenue per
   purchase session?

   The dataset has no order ID, so user_id and
   ga_session_id are used together as a session-level proxy.
   ========================================================= */

WITH purchase_sessions AS (
    SELECT
        e.user_id,
        e.ga_session_id,
        COUNT(*) AS purchase_events,

        SUM(
            COALESCE(i.price_in_usd, 0)
        ) AS session_revenue_usd

    FROM events_clean AS e

    LEFT JOIN items AS i
        ON e.item_id = i.id

    WHERE e.type = 'purchase'

    GROUP BY
        e.user_id,
        e.ga_session_id
)

SELECT
    COUNT(*) AS purchase_sessions,
    SUM(purchase_events) AS purchase_events,

    ROUND(
        SUM(session_revenue_usd),
        2
    ) AS total_recorded_revenue_usd,

    ROUND(
        AVG(session_revenue_usd),
        2
    ) AS average_revenue_per_session_usd,

    ROUND(
        MIN(session_revenue_usd),
        2
    ) AS minimum_session_revenue_usd,

    ROUND(
        MAX(session_revenue_usd),
        2
    ) AS maximum_session_revenue_usd

FROM purchase_sessions;
