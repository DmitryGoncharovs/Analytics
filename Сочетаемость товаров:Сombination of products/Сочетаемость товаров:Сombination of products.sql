Задача:
Написать скрипт показывающий сочетаемость товаров на основании таблицы продаж(sales)
(т.е сколько раз товар с id1 купили вместе с товваром id2...)
Пример: 
product_id1 | product_id2 | cnt
1             2             16
2  			  3             12
...

select
	product1,
	product2,
	Count(*) as kol
from
	(
	select
		a.dr_nchk,               --cheque_number
		a.dr_ndrugs as product1, --product_name
		b.dr_ndrugs as product2  --product_name
	from
		sales a
	join sales b 
on
a.dr_nchk = b.dr_nchk 
and a.dr_ndrugs < b.dr_ndrugs
	group by 
	a.dr_nchk, 
	a.dr_ndrugs, 
	b.dr_ndrugs
) AA
group by 
product1,
product2
order by kol desc

