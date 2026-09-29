Below is a **30-day SQL-for-data-analysis study plan based directly on the uploaded book**. I’ve structured it for **PostgreSQL**, since the book’s examples use PostgreSQL-style SQL and you’ve been working with PostgreSQL recently.

**Daily target:** 2–3 hours
**Every day:** read → reproduce examples → modify them → solve exercises without looking → save your SQL.

## Databases you will use

Instead of using one database for everything, rotate through several datasets so you learn to adapt to unfamiliar data.

| Database               | Main purpose                            |
| ---------------------- | --------------------------------------- |
| **Retail Sales**       | dates, aggregation, time series         |
| **Legislators**        | cohort and retention analysis           |
| **UFO Sightings**      | text analysis                           |
| **Earthquakes**        | anomaly detection                       |
| **A/B Test**           | experiment analysis                     |
| **E-commerce**         | complex SQL, funnels, customer analysis |
| **Final Analytics DB** | portfolio project                       |

The book itself uses **retail sales, legislators, UFO sightings, earthquakes, and experiment data** for its examples, so these are the natural datasets to build your practice around.

---

# 30-Day SQL Data Analysis Plan

## WEEK 1 — SQL foundations + preparing data

### Day 1 — Understand SQL as an analysis tool

**Book:** Chapter 1

Learn:

* What data analysis is
* Relational databases
* Tables, rows and columns
* Primary keys
* Foreign keys
* OLTP vs analytical databases
* PostgreSQL basics
* `SELECT`
* `FROM`
* `WHERE`
* `ORDER BY`
* `LIMIT`

### Database

Create a simple **sales database**:

```text
customers
orders
products
```

### Exercises

Write queries to:

1. Display all customers.
2. Display only customer names.
3. Display products over R500.
4. Display orders from 2025.
5. Sort products from most expensive to cheapest.
6. Return the 10 most expensive products.
7. Find customers from Gauteng.
8. Find orders above R1,000.

### Deliverable

Save:

```text
day01_sql.sql
```

with at least **15 queries**.

---

# Day 2 — Data types and database structure

**Book:** Chapter 2

Study:

* `INTEGER`
* `DECIMAL`
* `VARCHAR`
* `TEXT`
* `BOOLEAN`
* `DATE`
* `TIMESTAMP`
* `NULL`

### Database

Use your sales database.

Inspect:

```sql
SELECT *
FROM customers;
```

Then:

```sql
SELECT *
FROM orders;
```

### Exercises

Determine:

* Which columns contain numbers?
* Which contain dates?
* Which contain text?
* Which can contain `NULL`?
* Which columns should be keys?

Then find:

```sql
SELECT COUNT(*)
FROM customers;
```

and:

```sql
SELECT COUNT(*)
FROM orders;
```

### Exercise

Find:

* number of customers
* number of orders
* earliest order
* latest order
* minimum order value
* maximum order value
* average order value

---

# Day 3 — SQL query structure

Study:

```text
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
```

### Exercises

Using `orders`:

1. Total sales.
2. Number of orders.
3. Average order.
4. Highest order.
5. Lowest order.
6. Sales by customer.
7. Orders by month.
8. Customers with more than 5 orders.
9. Products generating more than R10,000.
10. Top 10 customers.

### Important

Learn the difference between:

```sql
WHERE
```

and:

```sql
HAVING
```

---

# Day 4 — Data profiling

This is extremely important for data analyst work.

Study:

* `COUNT`
* `COUNT(DISTINCT)`
* `MIN`
* `MAX`
* `AVG`
* `SUM`
* frequencies
* duplicate detection
* missing values

### Exercises

For every table, determine:

```text
row count
column count
unique customers
unique products
NULL values
minimum values
maximum values
duplicate records
```

Practice:

```sql
SELECT COUNT(DISTINCT customer_id)
FROM orders;
```

### Challenge

Create a **data-quality report** for your database.

---

# Day 5 — Duplicates

Learn how to identify duplicate records.

Practice:

```sql
GROUP BY
HAVING COUNT(*) > 1
```

### Exercises

Find:

* duplicate customers
* duplicate emails
* duplicate orders
* duplicate transactions
* customers with multiple accounts

Then investigate whether each duplicate is:

```text
real duplicate
or
legitimate repeated record
```

This distinction is important in real data analysis.

---

# Day 6 — NULL values and cleaning

Study:

```sql
IS NULL
IS NOT NULL
COALESCE()
NULLIF()
```

### Exercises

Create deliberately dirty data:

```text
NULL customer names
NULL phone numbers
NULL prices
NULL dates
```

Then fix/report them.

Practice:

```sql
COALESCE(phone, 'Unknown')
```

and:

```sql
NULLIF(value, 0)
```

### Challenge

Find the percentage of records containing missing values.

---

# Day 7 — CASE and data transformation

Study:

```sql
CASE
WHEN
THEN
ELSE
END
```

### Exercises

Create:

```text
customer_segment
```

using:

```text
High value
Medium value
Low value
```

based on spending.

Create:

```text
order_category
```

such as:

```text
Small
Medium
Large
```

### Weekly project

Take the dirty sales database and produce a **clean analytical dataset**.

You should now be able to:

* inspect data
* identify problems
* clean data
* transform columns
* aggregate data

---

# WEEK 2 — Time-series analysis

## Day 8 — Dates

**Book:** Chapter 3

Learn:

* extracting year/month/day
* date formatting
* date differences
* date arithmetic

Practice:

```sql
EXTRACT(YEAR FROM order_date)
```

and PostgreSQL date functions.

### Exercises

Calculate:

* orders per year
* orders per month
* sales per month
* sales per day
* sales per quarter
* average daily sales

---

# Day 9 — Build a date dimension

Create:

```text
date_dim
```

Include:

```text
date
date_key
day
day_name
week
month
month_name
quarter
year
```

Practice generating dates from:

```text
2020-01-01
to
2030-12-31
```

### Challenge

Join:

```text
orders
→ date_dim
```

and analyze sales using the date dimension.

---

# Day 10 — Trending analysis

Study:

```sql
GROUP BY date
```

### Exercises

Using Retail Sales:

1. Daily sales.
2. Weekly sales.
3. Monthly sales.
4. Quarterly sales.
5. Yearly sales.

Then calculate:

```text
month-over-month growth
```

Example concept:

```text
January = R100,000
February = R120,000
Growth = 20%
```

---

# Day 11 — Window functions

This is a major milestone.

Learn:

```sql
OVER()
```

```sql
PARTITION BY
```

```sql
ORDER BY
```

Practice:

```sql
SUM(sales) OVER (...)
```

```sql
AVG(sales) OVER (...)
```

```sql
ROW_NUMBER()
```

```sql
RANK()
```

### Exercises

Find:

* top customer per month
* ranking of products
* cumulative sales
* customer ranking
* monthly ranking

---

# Day 12 — Rolling calculations

Learn rolling windows.

Calculate:

```text
7-day sales
30-day sales
7-day average
30-day average
```

### Exercises

For every day:

```text
daily sales
7-day rolling sales
7-day rolling average
30-day rolling sales
```

### Challenge

Find days where sales were significantly above the recent average.

---

# Day 13 — Period-over-period analysis

Study:

* MoM
* YoY
* previous period
* `LAG()`
* `LEAD()`

Practice:

```sql
LAG(sales) OVER (...)
```

### Exercises

Calculate:

```text
current month
previous month
difference
percentage change
```

Then:

```text
2025 sales
2024 sales
YoY change
```

---

# Day 14 — Time-series project

Use Retail Sales.

Answer:

1. Which month had the highest sales?
2. Which month had the lowest?
3. Which products grew fastest?
4. Which customers increased spending?
5. Which months show seasonal patterns?
6. What was the largest month-over-month decline?
7. What was the largest year-over-year increase?

### Deliverable

Create:

```text
retail_time_series.sql
```

with at least **25 analytical queries**.

---

# WEEK 3 — Cohorts + text analysis

# Day 15 — Cohort analysis

**Book:** Chapter 4

Use the **Legislators dataset** from the book or an e-commerce customer dataset.

Understand:

```text
cohort
cohort date
observation period
metric
```

### Exercises

Group customers by:

```text
first purchase month
```

Then calculate:

```text
number of customers per cohort
```

---

# Day 16 — Retention

Calculate:

```text
Month 0
Month 1
Month 2
Month 3
...
```

For each cohort.

### Example

```text
January cohort
Month 0 = 100%
Month 1 = 72%
Month 2 = 61%
Month 3 = 48%
```

### Exercises

Build a retention table using SQL.

---

# Day 17 — Cohort challenges

Handle:

* missing months
* sparse data
* customers returning after inactivity
* different cohort definitions

Calculate:

```text
retention
returnship
survival
cumulative users
```

### Challenge

Compare:

```text
2024 customer cohorts
vs
2025 customer cohorts
```

---

# Day 18 — Cohort project

Answer:

1. Which cohort acquired the most customers?
2. Which has the highest Month-1 retention?
3. Which has the highest Month-3 retention?
4. How does customer spending change by cohort?
5. Are newer cohorts behaving differently?

### Deliverable

```text
cohort_analysis.sql
```

---

# Day 19 — Text analysis

**Book:** Chapter 5

Use the **UFO Sightings dataset**.

Study:

```sql
LENGTH()
LOWER()
UPPER()
TRIM()
SUBSTRING()
REPLACE()
POSITION()
SPLIT_PART()
```

### Exercises

Find:

* longest descriptions
* shortest descriptions
* descriptions containing specific words
* common locations
* common shapes
* empty descriptions
* descriptions containing numbers

---

# Day 20 — Parsing text

Practice extracting information from messy text.

Example:

```text
"Johannesburg, Gauteng, South Africa"
```

Extract:

```text
city
province
country
```

### Exercises

Parse:

* locations
* names
* categories
* codes
* identifiers

---

# Day 21 — Regular expressions

Learn PostgreSQL regex:

```sql
~
~
*
```

and related pattern matching.

### Exercises

Find:

* records containing numbers
* records containing email addresses
* phone numbers
* unusual characters
* specific word patterns
* malformed values

### Challenge

Create categories from free-text descriptions.

---

# WEEK 4 — Anomalies + experiments + complex SQL

# Day 22 — Anomaly detection

**Book:** Chapter 6

Use the **Earthquakes dataset**.

Study:

* minimum
* maximum
* average
* standard deviation
* percentiles
* outliers

### Exercises

Find:

```text
largest earthquakes
smallest earthquakes
unusual depths
unusual magnitudes
```

Calculate:

```text
mean
median
standard deviation
```

---

# Day 23 — Statistical anomaly detection

Create rules for:

```text
Magnitude > threshold
Depth > threshold
Value > mean + 2 standard deviations
```

Use:

```sql
STDDEV()
```

and window functions.

### Challenge

Create an anomaly flag:

```text
NORMAL
ANOMALY
```

Then investigate whether each anomaly could be:

```text
real event
or
data-quality problem
```

---

# Day 24 — Experiment analysis / A-B testing

**Book:** Chapter 7

Create an experiment dataset:

```text
user_id
experiment_group
date
converted
revenue
```

Groups:

```text
control
treatment
```

### Calculate

```text
users
conversions
conversion rate
revenue
average revenue
```

Compare the groups descriptively.

Learn the concepts of:

* hypothesis
* success metric
* control
* treatment
* random assignment
* statistical significance
* guardrail metrics

---

# Day 25 — A/B testing project

Create a complete SQL analysis.

Calculate:

```text
Control conversion rate
Treatment conversion rate
Difference
Relative difference
Revenue per user
```

Then investigate:

```text
conversion by device
conversion by country
conversion by day
```

### Important

Do not conclude that a treatment caused an effect merely because one group has a higher observed rate. Learn how experiment design and statistical testing support causal conclusions.

---

# Day 26 — Complex SQL

**Book:** Chapter 8

Study:

```sql
Subqueries
CTEs
Temporary tables
UNION
JOINs
```

Start with:

```sql
WITH sales AS (...)
SELECT ...
```

### Exercises

Build a query using:

```text
CTE 1 → customer totals
CTE 2 → customer ranking
CTE 3 → customer segmentation
Final query → analytical dataset
```

---

# Day 27 — Advanced CTE + window project

Build an **e-commerce customer 360 dataset**.

One row per customer:

```text
customer_id
first_order_date
last_order_date
total_orders
total_revenue
average_order_value
days_since_last_order
customer_rank
customer_segment
first_purchase_month
```

### Customer segments

Create:

```text
New
Active
Lapsed
High Value
Low Value
```

Use CTEs and window functions.

---

# Day 28 — Funnel analysis

**Book:** Chapter 9

Create an e-commerce funnel:

```text
Visit
↓
Product View
↓
Add to Cart
↓
Checkout
↓
Purchase
```

Database:

```text
events
```

with:

```text
user_id
event_name
event_time
```

### Calculate

```text
users at each stage
conversion rate
drop-off rate
```

Example:

```text
Visitors       10,000
Product View   7,500
Cart           3,000
Checkout       1,500
Purchase         900
```

Then identify where users are dropping out.

---

# Day 29 — Final SQL analysis

Combine everything you've learned.

Use your e-commerce database.

Produce:

### 1. Data quality

```text
duplicates
NULLs
invalid values
```

### 2. Customer analysis

```text
customers
orders
revenue
AOV
```

### 3. Time series

```text
daily
weekly
monthly
YoY
MoM
```

### 4. Cohorts

```text
customer acquisition cohorts
retention
```

### 5. Anomalies

```text
unusual orders
unusual revenue
```

### 6. Funnel

```text
visit → purchase
```

### 7. Customer segmentation

```text
high value
medium value
low value
lapsed
```

Everything should be generated with SQL.

---

# Day 30 — Portfolio project

Today you stop following tutorials.

Build the project **from scratch without copying the book**.

## Project

### "E-Commerce Business Performance Analysis"

Your database should contain:

```text
customers
products
orders
order_items
payments
events
date_dim
```

### Part 1 — Data preparation

Write SQL to:

* inspect tables
* check row counts
* check NULLs
* check duplicates
* validate dates
* validate prices
* identify bad records

### Part 2 — Sales analysis

Calculate:

* total revenue
* total orders
* total customers
* average order value
* revenue by product
* revenue by category
* revenue by customer

### Part 3 — Time series

Calculate:

* daily revenue
* monthly revenue
* YoY growth
* MoM growth
* rolling 30-day revenue

### Part 4 — Customer analysis

Calculate:

* first purchase
* last purchase
* lifetime revenue
* order frequency
* customer segments

### Part 5 — Cohort analysis

Calculate:

* acquisition cohort
* Month-1 retention
* Month-3 retention
* Month-6 retention

### Part 6 — Funnel

Calculate:

```text
Visitors
→ Product views
→ Cart
→ Checkout
→ Purchase
```

### Part 7 — Anomalies

Find:

* unusually large orders
* unusual revenue days
* unusual customer activity
* potential duplicate transactions

### Part 8 — Final SQL file

Your final project should have:

```text
01_data_quality.sql
02_sales_analysis.sql
03_time_series.sql
04_customer_analysis.sql
05_cohort_analysis.sql
06_funnel_analysis.sql
07_anomaly_detection.sql
08_final_analysis.sql
```

---

# Your daily SQL routine

Use this **every single day**:

### First 30 minutes

Read the relevant book section.

### Next 30 minutes

Type out the examples yourself.

**Don't copy/paste.**

### Next 45 minutes

Change the examples.

For example, if the book calculates:

```sql
SUM(revenue)
```

you should change it to:

```sql
AVG(revenue)
COUNT(*)
MAX(revenue)
MIN(revenue)
```

### Next 45 minutes

Do the day's exercises **without looking at the solution**.

### Last 15 minutes

Write down:

```text
What I learned:
What confused me:
SQL functions learned:
Queries I can now write:
What I need to practice tomorrow:
```

---

# Skills you should have after 30 days

By the end, you should be comfortable with:

```text
SELECT
WHERE
ORDER BY
GROUP BY
HAVING
DISTINCT
CASE
COALESCE
NULLIF

JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN

Subqueries
CTEs
UNION

COUNT
SUM
AVG
MIN
MAX

DATE functions
Time-series analysis
Rolling calculations
LAG
LEAD

ROW_NUMBER
RANK
PARTITION BY

Cohort analysis
Retention analysis

Text analysis
Regex

Anomaly detection

A/B testing concepts

Funnel analysis

Customer segmentation

Data profiling
Data cleaning
Data quality

Complex analytical SQL
```

## The progression you should follow

```text
DAYS 1–7
SQL + Data Preparation
        ↓
DAYS 8–14
Time Series
        ↓
DAYS 15–18
Cohort Analysis
        ↓
DAYS 19–21
Text Analysis
        ↓
DAYS 22–23
Anomaly Detection
        ↓
DAYS 24–25
Experiment Analysis
        ↓
DAYS 26–27
Complex SQL
        ↓
DAY 28
Funnel Analysis
        ↓
DAY 29
Integrated Analysis
        ↓
DAY 30
Portfolio Project
```

**Most important rule:** don't measure your progress by how many chapters you read. Measure it by how many SQL problems you can solve **without looking at the book**.
