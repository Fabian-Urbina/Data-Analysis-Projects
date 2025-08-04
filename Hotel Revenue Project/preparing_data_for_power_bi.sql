#Stakeholders questions
#1 Is our Hotel Revenue growing by year?, 2 Should we increase our parking lot size?, 3 General Trends
# After EDA, build Visualizations to show our findings

CREATE TEMPORARY TABLE hotels_revenue AS 
SELECT *
FROM revenue2018 
UNION
SELECT *
FROM revenue2019
UNION
SELECT *
FROM revenue2020
;


# I united the data from the 3 tables I with a CTE
SELECT hotel,ROUND(SUM((stays_in_weekend_nights+stays_in_week_nights)*adr),2) as revenue, arrival_date_year
FROM hotels_revenue
GROUP BY arrival_date_year,hotel
;

#This give us the sum or revenue from each year and hotel type, we can see that it increased from 2018 to 2019, but then decreased in 2020
#Now I'm going use the other tables

SELECT *
FROM market_segment
;
SELECT * 
FROM hotels_revenue;
SELECT *
FROM meal_cost
;

SELECT *
FROM hotels_revenue AS h
LEFT JOIN market_segment AS ms
ON h.market_segment = ms.market_segment
LEFT JOIN meal_cost AS mc
ON h.meal = mc.meal
;

#Now we have all the information needed to make visualizations in Power BI

