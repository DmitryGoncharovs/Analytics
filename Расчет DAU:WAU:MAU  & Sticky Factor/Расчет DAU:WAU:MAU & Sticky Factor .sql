Расчитать:
DAU(Активные пользователи в день)
WAU(Активные пользователи в неделю)
MAU(Активные пользователи в месяц)
Stickiness-DAU/MAU*100%
Не учитываем данные до 2021-11-19 так как приложение работало в тестовом режиме
и данные будут не валидны.
Результаты вывести в одну таблицу.

with a as(
select date(entry_at)as ymd, 
count(distinct user_id)as DAU
from userentry u 
where date(entry_at)>'2021-11-19'
group by date(entry_at)
),
DAU as(
select round(avg(dau))as dau from a
),
 b as(
select to_char(entry_at,'YYYY-WW')as ywd, 
count(distinct user_id)as WAU
from userentry u 
where date(entry_at)>'2021-11-19'
group by (to_char(entry_at,'YYYY-WW'))
having count(distinct date(entry_at))>=6 
),
WAU as(
select round(avg(wau))as wau from b
),
c as(
select to_char(entry_at,'YYYY-MM')as yd, 
count(distinct user_id)as MAU
from userentry u 
where date(entry_at)>'2021-11-19'
group by (to_char(entry_at,'YYYY-MM'))
having count(distinct date(entry_at))>=25
),
MAU as(
select round(avg(mau))as MAU from c
),
SF as(
select round((dau*100/mau),2)as Stickiness 
from dau,mau
)
select DAU,WAU,MAU,Stickiness from mau,dau,wau,sf
