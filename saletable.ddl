SELECT s.*
    , (s.quantity* p.unitcost) AS total_cost
    , (s.quantity * p.unitprice) AS total_price
    , e.exchange
FROM sales s
LEFT JOIN exchange_rates e
    ON e.date = s.orderdate
    AND e.currency = s.currencycode
LEFT JOIN products p 
    ON s.productkey = p.productkey
