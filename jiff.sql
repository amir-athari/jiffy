------ 1 --------------------
SELECT 
      count(ordered_at_utc)
      
  FROM [jiff].[dbo].[orders]
WHERE ordered_at_utc >= '2018-01-01' and ordered_at_utc <= '2018-12-31'

------ 2 --------------------

SELECT 
--count([jiff].[dbo].[line_items].[order_number])

 [jiff].[dbo].[line_items].[line_item_number] , [jiff].[dbo].[line_items].[order_number], [jiff].[dbo].[line_items].[units_sold], 
 [jiff].[dbo].[line_items].[product_id]
      
FROM [jiff].[dbo].[orders]
Left Join  [jiff].[dbo].[line_items]
ON [jiff].[dbo].[line_items].order_number = jiff.dbo.orders.order_number


WHERE ordered_at_utc >= '2018-01-01' and ordered_at_utc <= '2018-12-31'
AND
[jiff].[dbo].[line_items].[units_sold] >= 10

------ 3 --------------------

SELECT 
--count([jiff].[dbo].[line_items].[order_number])

O.[order_number], O.[ordered_at_utc], O.[customer_uuid], O.[discount],O.[order_number],
L.[line_item_number] , L.[order_number], L.[units_sold], L.[product_id],
P.[model_number], P.[description], P.[size], P.[color], P.[selling_price], P.[supplier_cost]
    
FROM [jiff].[dbo].[orders] AS O
Left Join  [jiff].[dbo].[line_items] AS L ON O.order_number = L.order_number
Left Join  [jiff].[dbo].[products] AS P ON L.[product_id] = P.[product_id]
WHERE O.discount >0 AND P.size = 'M'

------ 4 --------------------
SELECT 
O.[order_number], O.[ordered_at_utc], O.[customer_uuid], O.[discount],O.[order_number],
L.[line_item_number] , L.[order_number], L.[units_sold], L.[product_id],
P.[model_number], P.[description], P.[size], P.[color], P.[selling_price], P.[supplier_cost]

,L.[units_sold] * 		((P.[selling_price]* (1 - O.[discount])) -  P.[supplier_cost] ) AS profit
																			
    
FROM [jiff].[dbo].[orders] AS O
Left Join  [jiff].[dbo].[line_items] AS L ON O.order_number = L.order_number
Left Join  [jiff].[dbo].[products] AS P ON L.[product_id] = P.[product_id]
ORDER BY profit Desc
