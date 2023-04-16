# Analytics Engineering with dbt - Greenery Analysis

### How many users do we have?

**SQL:**
```
select count (distinct user_id) from RAW.PUBLIC.USERS limit 10;
```
We have 130 users

### On average, how many orders do we receive per hour?

**SQL:**
```
select AVG(count_per_hour) FROM 
(
SELECT DATE_TRUNC(hour, CREATED_AT) as SessHour
, COUNT(DISTINCT order_id) AS count_per_hour
FROM RAW.PUBLIC.ORDERS
GROUP BY 1) orders_oper_hour
```
On average, we received about 7.52 orders per hour. 

### On average, how long does an order take from being placed to being delivered?

**SQL:**
```
select AVG(time_taken) from (
select datediff ('day', CREATED_AT, DELIVERED_AT) as time_taken from RAW.PUBLIC.ORDERS) time_taken_avg
```
On average, it takes 3.89 days from the oder being placed to the order getting delivered. 

### How many users have only made one purchase? Two purchases? Three+ purchases?

**SQL:**
```
select 
SUM(CASE WHEN total_orders = 1 THEN 1 ELSE 0 END)  AS count_of_1_order
, SUM(CASE WHEN total_orders = 2 THEN 1 ELSE 0 END)  AS count_of_2_orders
, SUM(CASE WHEN total_orders > 3 THEN 1 ELSE 0 END)  AS count_of_more_than_3_orders
FROM(
select u.user_id
, COUNT(DISTINCT o.ORDER_ID) AS total_orders
FROM 
RAW.PUBLIC.USERS u 
LEFT JOIN 
RAW.PUBLIC.ORDERS o 
ON u.user_id = o.user_id
group by 1
ORDER BY 2 DESC) RESULT 
```

Count of users having 1 order: 25
Count of users having 2 orders : 28
Count of users having more than 3 orders: 37

### On average, how many unique sessions do we have per hour?

**SQL:**
```
select AVG(count_per_hour) FROM 
(
SELECT date_trunc(hour, CREATED_AT) as SessHour
, COUNT(DISTINCT session_id) AS count_per_hour
FROM RAW.PUBLIC.EVENTS
GROUP BY 1) orders_oper_hour
```

On average, there were 16.33 unique sessions per hour. 
