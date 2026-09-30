# Total Transaction amount---
SELECT SUM(Transaction_count) AS total_transactions,
SUM(Transaction_amount) AS total_transaction_amount 
FROM Phone_pay;

# States having highest transaction volume----
SELECT state,
SUM(Transaction_amount) AS total_transaction_amount FROM Phone_pay 
GROUP BY State
ORDER BY Total_transaction_amount DESC;

# Transaction Type having highest number of transactions----
SELECT Transaction_type,
SUM(Transaction_count) AS total_transactions FROM Phone_pay 
GROUP BY Transaction_type 
ORDER BY total_transactions; 

# Transaction performance vary by transaction type and year-----
SELECT Year,Transaction_type,
SUM(Transaction_amount) AS total_amount 
FROM Phone_pay 
GROUP BY Year,Transaction_type 
ORDER BY Year,total_amount DESC;

# Quarter has the highest transaction value----
SELECT Quarter,SUM(Transaction_amount) AS total_amount FROM Phone_pay 
GROUP BY Quarter 
ORDER BY total_amount DESC;

# How do transactions change quarter-over-quarter----
SELECT Year,Quarter,SUM(Transaction_count) AS total_transactions,SUM(Transaction_amount) AS total_amount FROM Phone_pay GROUP BY Year, Quarter ORDER BY Year,Quarter;

# Compare transactions volume across regions and years----
SELECT Year,Region,SUM(Transaction_amount) AS total_amount FROM Phone_pay GROUP BY Year,Region ORDER BY Year,total_amount DESC;

# Top 5 states by transaction amount----
SELECT State,SUM(Transaction_amount) as total_amount FROM Phone_pay GROUP BY State ORDER BY total_amount DESC LIMIT 5;

# Top 3 states within each region---
WITH ranked_states AS(
SELECT Region,
State,
SUM(Transaction_amount) AS total_amount,
RANK() OVER( 
PARTITION BY Region 
ORDER BY SUM(Transaction_amount) DESC) AS state_rank 
FROM Phone_pay GROUP BY Region,State )
SELECT * FROM ranked_states WHERE state_rank<=3; 

# Average transaction value for each transaction type----
SELECT Transaction_type,
ROUND(AVG(Transaction_amount),2) avg_amount FROM Phone_pay 
GROUP BY Transaction_type 
ORDER BY avg_amount DESC;

# States with high transaction volume but relatively low average transaction value-----
SELECT State,
SUM(Transaction_count) AS total_count,
SUM(Transaction_amount) AS total_transaction,
SUM(Transaction_amount)/NULLIF(SUM(Transaction_count),0) 
AS avg_transaction_value 
FROM Phone_pay 
GROUP BY State 
ORDER BY avg_transaction_value;
