Сделать класический RFM анализ клиентов на основании таблиц БД (customers,orders,order_details)
сегментировать клиентов если по показателям:
если >=321 то категория клиента А
если >=123 то категория клиента B
остальные клиенты категории С

with a as (
select od.order_id, c.customer_id,  date(o.order_date+interval '9500 day')as order_date , (od.unit_price*od.quantity) as amount from customers c 
left join orders o 
on c.customer_id =o.customer_id 
left join order_details od
on od.order_id =o.order_id 
),b as (
select 
customer_id as name,
coalesce (date_part('day',current_date::timestamp - max(order_date)::timestamp),0) as r ,
coalesce (count(order_id),0) as f,
coalesce (round(avg(amount)::numeric,2),0)as m
from a 
group by 1
order by r desc
),
c as(
select 
name ,
case 
	when r >=25 then 3
	when r >=100 then 2
	else 1
end as r_s,
case 
	when f >=50 then 3
	when f >=20 then 2
	else 1
end as f_s,
case 
	when m >=900 then 3
	when m >=430 then 2
	else 1
end as m_s
from b
)
select 
name,
concat(r_s,f_s,m_s) as rfm,
case 
	when concat(r_s,f_s,m_s)>= '321' then 'A' 
	when concat(r_s,f_s,m_s)>= '123' then 'B'
	else 'C'	
end as ABC
from c
order by rfm desc



