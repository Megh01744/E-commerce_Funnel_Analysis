# Google Merchandise Store E-commerce Funnel Analysis

## Project Background

The Google Merchandise Store is an e-commerce platform where customers browse and purchase branded products. Every customer interaction generates valuable data about product interest, shopping behavior, and movement through the purchase journey.

The Google Merchandise Store generates interaction data as visitors add products to their carts, begin checkout, and complete purchases. This project analyzes activity across those three funnel stages to identify where event volume declines and how performance differs by device, country, product category, brand, and recorded lifetime value (LTV) status.

The project answers five main questions:

1. Where does the largest decline in funnel event volume occur?

2. How do funnel ratios differ across devices and high-traffic countries?

3. Which product categories and brands generate the most recorded revenue?

4. Which categories combine strong conversion ratios with meaningful traffic?

5. How is the supplied recorded LTV distributed across users?


## Data Structure

The dataset contains three related tables: **events**, **items**, and **users**. The events table originally contained **758,884 rows**. After removing exact duplicates, **719,386 event records** remained for analysis.

The ERD below shows how the three tables are connected.

![ERD](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/Google%20Merchandise%20Store%20ERD%20Diagram.png)

## Data Preparation and Quality Checks

Before starting the analysis, SQL was used to inspect the three tables and check the quality of the data.

The main issue identified was duplicate event records. The events table originally contained 758,884 rows. After removing 39,498 exact duplicates, 719,386 event records remained for analysis.

Additional checks were performed for:

* Missing values in important fields
* Duplicate records
* Event-type consistency
* Valid user and product identifiers
* Date coverage and table relationships

The SQL queries used for these checks are available [here.](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/SQL%20queries/01_Data_Cleaning_and_Quality_Checks.sql)

## SQL Analysis

After completing the quality checks, SQL was used to calculate the main funnel metrics and answer the project’s business questions.

The analysis included:

* Event totals for Add to Cart, Begin Checkout, and Purchase
* Cart-to-checkout and checkout-to-purchase ratios
* Funnel performance by device and country
* Product-category purchases and recorded revenue
* Category-level conversion ratios
* User distribution by recorded LTV

The funnel calculations are available [here.](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/SQL%20queries/02_Funnel_Metrics.sql)

The targeted business-question queries are available [here.](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/SQL%20queries/03_Targeted_Business_Questions.sql)


## Python EDA

Python, Pandas, and Matplotlib were used to inspect the SQL outputs and explore:

* Funnel-stage distribution
* Monthly purchase-event trends
* Device and country performance
* Product-category purchases and revenue
* Category-level event ratios
* Recorded user-value distribution

View the Python EDA notebook [here.](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/notebooks/Ecommerce_Funnel_Python_EDA.ipynb)

## Power BI

Power BI was used to create a three-page interactive report with slicers for country, device, and category.

Download the interactive Power BI dashboard [here.](https://github.com/Megh01744/E-commerce_Funnel_Analysis/blob/main/Google%20Merchandise%20store.pbix)

## Executive Summary
The first dashboard page provides an overall view of the purchase funnel. It recorded 666,071 add-to-cart events, 38,604 begin-checkout events, and 14,711 purchase events, resulting in a 2.21% purchase-to-cart rate.

<img width="1377" height="772" alt="Executive Overview" src="https://github.com/user-attachments/assets/0549714c-c58c-4594-a8e7-752ac3afed0b" />

## Funnel Diagnostics

The biggest funnel loss happens before checkout. Begin-checkout events represent only **5.80%** of add-to-cart events, while purchases represent **38.11%** of checkout events.

Device performance is fairly close. Desktop has the highest cart-to-checkout rate at **5.87%**, while mobile has the highest purchase-to-cart rate at **2.24%**. Tablet performs lowest at **1.84%**.

Among the high-traffic countries shown, Canada has the highest purchase-to-cart rate at **2.49%**, while Italy has the lowest at **1.49%**.

<img width="1377" height="772" alt="Funnel Diagnostics" src="https://github.com/user-attachments/assets/b20e95f3-1495-449c-9cf7-fab4495382c3" />

## Product & Customer Value

The store generated **$289,407 in recorded revenue** across **4,446 purchase sessions**, averaging **$65.09 per session**. Small Goods and Gift Cards had the highest purchase-to-cart rates at **7.37%** and **6.88%**, while Google-branded products generated around **$258K**.

Only **4,445 users (1.65%)** had a positive recorded LTV. This is a descriptive field from the dataset, not a prediction of future customer value.

<img width="1422" height="796" alt="Product and Customer Value" src="https://github.com/user-attachments/assets/fbf78666-ebfa-43f2-a6a6-1a59f58fa73e" />

## Recommendations

Based on the analysis, these are the main areas worth testing:

* **Understand the cart-to-checkout drop:** First confirm that the events are tracked correctly, then review possible friction such as delivery costs, sign-in requirements, page speed, or an unclear checkout button.

* **Bring interested shoppers back:** Test simple cart-reminder emails or messages and compare the results with customers who did not receive one.

* **Take a closer look at tablet:** Review the layout, button placement, and payment process because tablet had the lowest purchase-to-cart rate.

* **Give high-converting categories more visibility:** Test product recommendations or bundles featuring Small Goods and Gift Cards.

* **Check whether the changes work:** Measure purchase sessions, conversion rates, and additional recorded revenue before introducing changes more widely.

## Limitations

* Funnel ratios are based on **event counts**, not unique users or confirmed customer journeys. The same user may generate multiple events.

* The data covers only **November 2020 to January 2021**, so it may not represent longer-term behaviour.

* Recorded revenue is based on item prices linked to purchase events and does not include discounts, shipping, tax, or refunds.

* Since no reliable order ID was available, revenue per purchase session should not be treated as average order value.

* Recorded LTV is a field provided in the dataset, not a prediction of future customer value.

* Device, country, and category comparisons show patterns but do not prove what caused them.


