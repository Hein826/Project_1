CREATE TABLE date_table AS
SELECT 
    d.date,
    EXTRACT(YEAR FROM d.date) AS year,
    EXTRACT(MONTH FROM d.date) AS month,
    EXTRACT(DAY FROM d.date) AS day,
    EXTRACT(DOW FROM d.date) AS weekday,
    TO_CHAR(d.date, 'Month') AS month_name
FROM (
    SELECT 
    generate_series(
        (SELECT DATE_TRUNC('year', MIN(orderdate)) FROM sales),
        (SELECT DATE_TRUNC('year', MAX(orderdate)) + INTERVAL '1 year - 1 day' FROM sales),
        INTERVAL '1 day'
    )::date AS date
     ) AS d;


     DROP TABLE date_table;

     SELECT * FROM date_table;