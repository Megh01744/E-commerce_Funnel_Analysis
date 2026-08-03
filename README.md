# Google Merchandise Store Funnel and Conversion Analysis

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

Download the interactive Power BI dashboard[here.]


## Executive Summary
The first dashboard page provides an overall view of the purchase funnel. It recorded 666,071 add-to-cart events, 38,604 begin-checkout events, and 14,711 purchase events, resulting in a 2.21% purchase-to-cart rate.

[Page 1 - Executive Overview]
(<img width="1377" height="772" alt="Executive Overview" src="https://github.com/user-attachments/assets/0549714c-c58c-4594-a8e7-752ac3afed0b" />)




## Conversion and Drop-off Analysis

- The largest decline in event volume occurred between Add to Cart and Begin Checkout.
- Begin-checkout events represented only **5.80%** of add-to-cart events.
- Event volume therefore fell by **94.20%** between these two stages.
- Purchase events represented **38.11%** of begin-checkout events, showing a much stronger conversion ratio later in the funnel.
- Mobile recorded the highest event-based funnel conversion rate at **2.24%**, followed closely by desktop at **2.20%** and tablet at **1.84%**.
- Tablet performs the weakest, with a conversion rate of 1.84%.
- Since device conversion rates are quite similar, the issue does not appear to be limited to one device.
- The main opportunity is to understand and reduce the friction that prevents users from moving from cart to checkout.

<img width="1421" height="796" alt="Page_2 Conversion Drop-off Analysis" src="https://github.com/user-attachments/assets/b4c0a8b4-d7ea-446e-9c50-686f284fa1f6" />

## Customer & Product Intelligence

- Most users belonged to the **low-value segment**, representing **67.82%** of users. Mid-value users represented **30.16%**, while high-value users represented **2.02%**.

- The high-value segment contained **68 users**, showing that observed customer value was concentrated among a small group.

- **Apparel** is the strongest revenue category, generating approximately **$78K** and contributing a large share of the total **$299K revenue**.

- Revenue is heavily concentrated in Apparel, while the remaining categories contribute much smaller amounts. This creates some dependence on a single category.

- **Small Goods** has the highest category conversion rate at **7.37%**, followed by **Gift Cards at 6.88%**.

- The strongest revenue category is therefore not the strongest converting category. High-converting smaller categories could be given more visibility through targeted   promotions, recommendations, or product bundles.


<img width="1425" height="798" alt="Page_3 Customer   Product Intelligence" src="https://github.com/user-attachments/assets/ca29c186-89cd-4bd2-a629-b1df0d4d4979" />

## Recommendations

### Funnel & Checkout
- **Fix the cart-to-checkout drop.** At 5.8% against an industry average of 15-20%, showing shipping costs upfront and adding guest checkout should be the first priority.

- **Win back cart abandoners.** 94% leave before checkout even a simple reminder email recovering 5% of them would meaningfully impact the 2.21% overall conversion rate.

### Device Experience
- **Fix tablet experience.** Lowest conversion at 1.84% - test button placement, page speed and payment flow on tablet.

### Product & Revenue
- **Reduce Apparel dependency.** It drives $157K — 8x the next category. Give Bags and Accessories more visibility before the business becomes too reliant on one category.

- **Promote Small Goods and Gift Cards.** They convert at 7.37% and 6.88% — highest in the store yet barely show up in revenue. Bundle them with Apparel at checkout.

### Customer Retention
- **Protect the 68 high-value customers.** Their LTV reaches $3,360. A basic VIP program could retain the customers who matter most.

### Geographic Focus
- **Test everything in the US first.** 6,506 purchases - 5x India in second place. Validate any change there before rolling out globally.

## Tools Used

- **Python** (Pandas, Matplotlib) — Data Inspection and EDA
- **SQL** (SQLite3) — Data querying and analysis
- **Power BI** — Interactive dashboard and visualization

