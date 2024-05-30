Сделать ABC анализ аптечной сети основанный на принципе Парето где "80 % прибыли приносят 20 %товара".

with a as (
select 
dr_ndrugs as product,
sum(dr_kol) as amount,
sum(dr_kol*(dr_croz -dr_czak))  as revenue,
sum(dr_kol* dr_croz -dr_czak) as profit
from sales s
group by dr_ndrugs 
)
select product,
case
when sum(amount)over(order by amount desc)/sum(amount)over()<=0.8 then 'A'
when sum(amount)over(order by amount desc)/sum(amount)over()<=0.95 then 'B'
else 'C'
end as amound_ABC
from a 