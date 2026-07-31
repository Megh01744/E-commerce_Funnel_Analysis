/* =========================================================
   Google Merchandise Store
   Funnel Metrics
   ========================================================= */


/* Compare event volume across the three funnel stages */

WITH funnel_counts AS (
    SELECT
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
)

SELECT
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
        NULLIF(begin_checkout_events, 0),
        2
    ) AS checkout_to_purchase_rate_pct,

    ROUND(
        purchase_events * 100.0 /
        NULLIF(add_to_cart_events, 0),
        2
    ) AS purchase_to_cart_rate_pct

FROM funnel_counts;
