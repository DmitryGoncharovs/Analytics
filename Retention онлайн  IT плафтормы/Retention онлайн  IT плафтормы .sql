Построить график Retention платформы для изучения языка програмирования.
На основании таблицы userentry и таблицы пользователей users
Для построения графика учитывать только User_id больше 94

with a as(
select
	u.user_id ,
	extract (days from u.entry_at-u2.date_joined) as day
from
	userentry u
join users u2 
on
	u.user_id = u2.id
	where u.user_id>=94
	), b as (
	select day,
	count(distinct user_id) as cnt
	from a  
	group by day
	)
	select 
	day,
	cnt*100.0/first_value (cnt)over(order by day ) retention
	 from b 