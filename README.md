# 📦 Zepto Inventory Analysis — SQL Data Analysis Project

## 📌 Project Overview

This project focuses on analyzing **Zepto's product inventory data using SQL**. The objective is to explore product information, clean the dataset, analyze inventory and pricing patterns, and generate meaningful business insights.

The project covers the complete SQL analysis workflow, including:

* Database and table creation
* Data exploration
* Data quality checks
* Data cleaning
* Product and inventory analysis
* Pricing and discount analysis
* Category-level analysis
* Business-oriented SQL queries

The project is designed to demonstrate practical **SQL, data cleaning, aggregation, filtering, grouping, and analytical skills**.

---

## 🗂️ Dataset

The dataset contains product-level information related to Zepto's inventory.

### Key Columns

| Column                 | Description                                   |
| ---------------------- | --------------------------------------------- |
| `sku_id`               | Unique identifier for each product            |
| `category`             | Product category                              |
| `name`                 | Product name                                  |
| `mrp`                  | Maximum Retail Price                          |
| `discountPercent`      | Discount percentage offered                   |
| `availableQuantity`    | Quantity currently available                  |
| `discountSellingPrice` | Selling price after discount                  |
| `weightInGms`          | Product weight in grams                       |
| `outOfStock`           | Indicates whether the product is out of stock |
| `quantity`             | Product quantity information                  |

The database table is created as `zepto`.

---

## 🎯 Project Objectives

The main objectives of this project are to:

1. Understand the structure of the Zepto inventory dataset.
2. Explore product categories and inventory information.
3. Identify missing or null values.
4. Detect and remove invalid product records.
5. Convert price values into the appropriate currency format.
6. Analyze product discounts and pricing.
7. Estimate potential revenue by category.
8. Identify high-value and high-priced products.
9. Analyze product weight and inventory.
10. Generate actionable business insights using SQL.

---

## 🔍 Data Exploration

The project begins with basic data exploration to understand the dataset.

The analysis includes:

* Counting the total number of records.
* Viewing sample records.
* Checking for null values.
* Identifying unique product categories.
* Analyzing stock availability.
* Finding products that appear multiple times.

For example, the project checks product availability by grouping products according to their `outOfStock` status.

---

## 🧹 Data Cleaning

Before performing analysis, the dataset is cleaned to improve data quality.

### 1. Removing Invalid Prices

Products with an MRP of zero are identified and removed from the dataset.

```sql
DELETE FROM zepto
WHERE mrp = 0;
```

### 2. Converting Prices

The MRP and discounted selling price are converted from paise into rupees.

```sql
UPDATE zepto
SET mrp = mrp / 100.0,
    discountSellingPrice = discountSellingPrice / 100.0;
```

These steps help ensure that the pricing data is suitable for analysis.

---

# 📊 Business Analysis & Insights

The project answers several business-oriented questions using SQL.

## 1. Top 10 Best-Value Products

Identifies the top 10 products offering the highest discount percentage.

```sql
SELECT DISTINCT name,
       mrp,
       discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

**Business Value:**
Helps identify products with the most attractive discounts for customers.

---

## 2. High-MRP Products That Are Out of Stock

Finds products with an MRP above ₹250 that are currently out of stock.

```sql
SELECT DISTINCT name,
       mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 250
ORDER BY mrp DESC;
```

**Business Value:**
Helps identify expensive products that may require inventory replenishment.

---

## 3. Estimated Revenue by Category

Calculates estimated revenue for each product category using selling price and available quantity.

```sql
SELECT category,
       ROUND(SUM(discountSellingPrice * availableQuantity), 2)
       AS estimated_revenue
FROM zepto
GROUP BY category
ORDER BY estimated_revenue DESC;
```

**Business Value:**
Provides an overview of which categories have the highest potential revenue based on available inventory.

---

## 4. High-Priced Products With Low Discounts

Identifies products with an MRP greater than ₹300 and a discount below 10%.

```sql
SELECT DISTINCT name,
       mrp,
       discountPercent
FROM zepto
WHERE mrp > 300
  AND discountPercent < 10
ORDER BY mrp DESC,
         discountPercent DESC;
```

**Business Value:**
Helps identify expensive products where discount strategies could potentially be optimized.

---

## 5. Categories With the Highest Average Discount

Identifies the top 5 categories offering the highest average discount percentage.

```sql
SELECT category,
       ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY AVG(discountPercent) DESC
LIMIT 5;
```

**Business Value:**
Helps understand category-level pricing and promotional strategies.

---

## 6. Price Per Gram Analysis

Calculates the price per gram for products weighing at least 100 grams.

```sql
SELECT DISTINCT name,
       ROUND(discountSellingPrice / weightInGms, 2)
       AS price_per_gms
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gms;
```

**Business Value:**
Allows comparison of product value based on price relative to weight.

---

## 7. Product Weight Categorization

Products are grouped into three categories based on their weight:

* **Low:** Less than 1000g
* **Medium:** 1000g to less than 3000g
* **Bulk:** 3000g or more

```sql
SELECT DISTINCT name,
       weightInGms,
       CASE
           WHEN weightInGms < 1000 THEN 'Low'
           WHEN weightInGms < 3000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;
```

**Business Value:**
Helps categorize products according to their physical size and inventory requirements.

---

## 8. Total Inventory Weight by Category

Calculates the total inventory weight available for each category.

```sql
SELECT category,
       SUM(weightInGms * availableQuantity)
       AS inventory_weight
FROM zepto
GROUP BY category
ORDER BY inventory_weight DESC;
```

**Business Value:**
Helps understand inventory volume and potential storage or logistics requirements by category.

---

# 🛠️ SQL Concepts Used

This project demonstrates several important SQL concepts:

* `CREATE TABLE`
* `SELECT`
* `WHERE`
* `DISTINCT`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* `COUNT()`
* `SUM()`
* `AVG()`
* `ROUND()`
* `CASE WHEN`
* `DELETE`
* `UPDATE`
* Boolean filtering
* Aggregate functions
* Data cleaning
* Conditional categorization

---

# 📁 Project Structure

```text
Zepto-Inventory-Analysis/
│
├── Zepto Inventory.sql
├── zepto_v2.csv
└── README.md
```

---

# 🚀 How to Run the Project

### Step 1 — Clone the Repository

```bash
git clone <your-repository-url>
```

### Step 2 — Open the SQL File

Open:

```text
Zepto Inventory.sql
```

using a PostgreSQL-compatible SQL environment such as:

* PostgreSQL
* pgAdmin
* DBeaver

### Step 3 — Load the Dataset

Import the `zepto_v2.csv` file into your PostgreSQL environment.

### Step 4 — Execute the SQL Script

Run the SQL queries sequentially:

1. Create the `zepto` table.
2. Explore the dataset.
3. Perform data quality checks.
4. Clean the data.
5. Execute the analytical queries.
6. Review the generated results.

---

# 📈 Key Takeaways

This project demonstrates how SQL can be used to transform raw inventory data into meaningful business insights.

The analysis focuses on:

**Inventory Management**
Understanding stock availability and inventory quantities.

**Pricing Analysis**
Analyzing MRP, discounted prices, and price-per-gram metrics.

**Discount Analysis**
Identifying products and categories with significant discounts.

**Revenue Analysis**
Estimating potential revenue based on selling prices and available inventory.

**Product Analysis**
Understanding product categories, duplicates, weights, and availability.

---

# 💡 Future Improvements

The project can be further enhanced by:

* Creating an interactive dashboard using **Power BI** or **Tableau**.
* Adding category-level sales and revenue visualizations.
* Performing inventory turnover analysis.
* Identifying slow-moving and fast-moving products.
* Building a stock-replenishment analysis.
* Adding time-based sales and inventory trends.
* Creating KPIs for revenue, discounts, inventory value, and stock availability.
* Using advanced SQL techniques such as CTEs, window functions, and subqueries.

---

# 👨‍💻 Author

**Aryan Kumar**

Data Analytics | SQL | Data Visualization

---

## ⭐ Project Purpose

This project was created to practice and demonstrate practical **SQL data analysis and business intelligence skills** using a real-world-style e-commerce inventory dataset.
