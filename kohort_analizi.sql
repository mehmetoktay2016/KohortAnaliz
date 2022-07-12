-- KOHORT ANALIZI

SELECT
                customer_month_count.cohort_month,
                customer_month_count.order_month,
                COUNT(DISTINCT customer_month_count.CustomerID) CustomerCounts,
                DATEDIFF(month, customer_month_count.cohort_month , customer_month_count.order_month) PeriodNumber
FROM


(
SELECT 
	CustomerID, cohort_month,  order_month 
FROM
	(SELECT 
		CustomerID,
		 DATEFROMPARTS(
						  YEAR(InvoiceDate)
						  ,MONTH(InvoiceDate)
						  ,1) order_month
	
	FROM 
		[dbo].[online_retail_new_]
	WHERE 
		CustomerID IS NOT NULL) order_
INNER JOIN
(

SELECT 
		CustomerID  CustomerID_cohort,
		 DATEFROMPARTS(
						  YEAR(MIN(InvoiceDate))
						  ,MONTH(MIN(InvoiceDate))
						  ,'01') cohort_month
	
	FROM 
		[dbo].[online_retail_new_]
	GROUP BY
		CustomerID

) cohort ON order_.CustomerID = cohort.CustomerID_cohort
) customer_month_count

GROUP BY
                customer_month_count.cohort_month,
                customer_month_count.order_month

