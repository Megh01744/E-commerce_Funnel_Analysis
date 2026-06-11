# Project Background

## Google Merchandise Store Funnel Analysis & Conversion Optimization

Google Merchandise Store is a global e-commerce platform selling Google-branded products including Apparel, Accessories, and Electronics worldwide via its website across desktop, mobile and tablet devices.

The store has significant data on customer behavior, purchase patterns, and funnel performance that has been underutilized. This project analyzes that data to uncover critical insights that will improve conversion and revenue performance.



The SQL queries utilized to inspect and perform Data Cleaning and Quality Checks [here](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/SQL%20Queries%20/Data%20Cleaning%20and%20Quality%20Checks.sql)

SQL queries utilized for funnel analysis can be found [here](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/SQL%20Queries%20/Funnel%20Metrics.sql)

Targeted SQL queries regarding business questions can be found [here](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/SQL%20Queries%20/Targeted%20Business%20Questions.Sql)

An interactive Power BI dashboard can be downloaded [here](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/Google%20Merchandise%20store.pbix)

## Data Structure

The database structure consists of three tables: events, items, and users, with a total row count of 758,884 records before cleaning and 719,386 records after removing duplicates.

![ERD](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/Google%20Merchandise%20Store%20ERD%20Diagram.png)

## Executive Summary

The dashboard provides a quick view of how customers move through the purchase funnel. The store recorded **666,071 add-to-cart events**, but only **38,604 users progressed to checkout** and **14,711 purchases were completed**, resulting in an overall funnel conversion rate of **2.21%**.

The sharp decline between the cart and checkout stages immediately stands out as the biggest concern. The dashboard also shows that purchases are concentrated in a few markets, with the **United States contributing the highest number of completed purchases**, followed by India and Canada.

Below is the overview page from the PowerBI dashboard and more examples are included throughout the report. 
The entire interactive dashboard can be downloaded [here](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/Google%20Merchandise%20store.pbix)

<img width="1420" height="797" alt="Page_1 Executive Overview" src="https://github.com/user-attachments/assets/89a9160d-111b-40d9-83b4-412d71591dcd" />


## Conversion and Drop-off Analysis

- The biggest drop happens between Add to Cart and Begin Checkout.
- Only 5.80% of users who add products to their cart move forward to checkout.
- This means nearly 94.20% leave before reaching checkout, making it the main problem area in the funnel.
- Once users reach checkout, their buying intent becomes much stronger.
- Around 38.11% of checkout events result in a completed purchase.
- Mobile has the highest overall funnel conversion rate at 2.24%, followed closely by desktop at 2.20%.
- Tablet performs the weakest, with a conversion rate of 1.84%.
- Since device conversion rates are quite similar, the issue does not appear to be limited to one device.
- The main opportunity is to understand and reduce the friction that prevents users from moving from cart to checkout.

<img width="1421" height="796" alt="Page_2 Conversion Drop-off Analysis" src="https://github.com/user-attachments/assets/b4c0a8b4-d7ea-446e-9c50-686f284fa1f6" />


## Customer & Product Intelligence

- Most users fall into the **low-value LTV segment**, accounting for **67.82%** of the customer base. Mid-value users represent **30.16%**, while high-value users make up only **2.02%**.

- Only **68 high-value users completed a purchase**, highlighting an opportunity to improve repeat buying and move more low- and mid-value users into higher-value segments.

- **Apparel** is the strongest revenue category, generating approximately **$78K** and contributing a large share of the total **$299K revenue**.

- Revenue is heavily concentrated in Apparel, while the remaining categories contribute much smaller amounts. This creates some dependence on a single category.

- **Small Goods** has the highest category conversion rate at **7.37%**, followed by **Gift Cards at 6.88%**.

- The strongest revenue category is therefore not the strongest converting category. High-converting smaller categories could be given more visibility through targeted   promotions, recommendations, or product bundles.


<img width="1425" height="798" alt="Page_3 Customer   Product Intelligence" src="https://github.com/user-attachments/assets/ca29c186-89cd-4bd2-a629-b1df0d4d4979" />


