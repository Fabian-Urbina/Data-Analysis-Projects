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


# I united the data from the 3 tables in a temp table
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

CREATE TABLE revenue_total AS (
SELECT hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, babies, country, distribution_channel, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, booking_changes, deposit_type, agent, company, days_in_waiting_list, customer_type, adr, required_car_parking_spaces, total_of_special_requests, reservation_status, reservation_status_date, Discount, h.market_segment, Cost, mc.meal
FROM hotels_revenue AS h
LEFT JOIN market_segment AS ms
ON h.market_segment = ms.market_segment
LEFT JOIN meal_cost AS mc
ON h.meal = mc.meal
)
;
SELECT *
FROM revenue_total
;


#Now we have all the information needed to make visualizations in Power BI

