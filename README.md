# 8_week_SQL

### Danny's Diner Case Study

Welcome to the **Danny's Diner** case study repository! This project aims to analyze customer behavior and provide insights that can help Danny make data-driven decisions about his diner, specifically around enhancing the customer loyalty program.

## Project Overview

Danny wants to understand his customers better by analyzing their:
1. Visiting patterns
2. Spending habits
3. Favorite menu items

By extracting these insights, Danny plans to:
- Deliver a more personalized experience for his loyal customers.
- Evaluate whether to expand the existing loyalty program.

To facilitate this, Danny has shared three datasets:
- **Sales**: Information about customer purchases.
- **Menu**: Details about menu items.
- **Members**: Data about customer membership status.

## Datasets

Below is a brief overview of the datasets used in this analysis:

### `sales`
| Column Name  | Description                 |
|--------------|-----------------------------|
| `customer_id`| Unique ID for the customer  |
| `order_date` | Date of the purchase        |
| `product_id` | ID of the purchased product |

### `menu`
| Column Name  | Description                   |
|--------------|-------------------------------|
| `product_id` | Unique ID for the menu item   |
| `product_name` | Name of the menu item       |
| `price`      | Price of the menu item        |

### `members`
| Column Name  | Description                      |
|--------------|----------------------------------|
| `customer_id`| Unique ID for the customer       |
| `join_date`  | Date the customer joined the program |


## Objectives

The main objectives of this analysis are:
- **Visiting Patterns**: Determine how frequently customers visit.
- **Spending Habits**: Analyze how much each customer spends.
- **Favorite Items**: Identify the most popular menu items.

## SQL Queries

This project contains a set of SQL queries written to extract the required insights. These queries are based on the sample dataset provided. The queries are structured to allow easy inspection of the data without requiring additional transformations.

## Repository Structure

- `dannys_diner.sql`: Contains the SQL queries for all required analyses.
- `README.md`: This documentation file.




