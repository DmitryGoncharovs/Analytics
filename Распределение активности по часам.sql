
На основании таблиц с активностью пользователей
(CodeRun, CodeSubmit, TestStart)
нужно было найти распределение активности по часам суток (от 0 до 23).
 
код выполнения:
with a as(
select date_part('hour', c.created_at)as hour,
count(*)as cnt_coderun
from coderun c
group by 1
order by 1
),
b as(
select date_part('hour',c2.created_at)as hour,
count(*)as cnt_codesubmit
from codesubmit c2
group by 1
order by 1
),
c as(
select date_part('hour',t.created_at)as hour,
count(*)as cnt_teststart
from teststart t 
group by 1
order by 1
)
select a.hour,a.cnt_coderun,b.cnt_codesubmit,c.cnt_teststart,
(a.cnt_coderun+b.cnt_codesubmit+c.cnt_teststart)as cnt_total from a 
join b 
on a.hour=b.hour
join c 
on b.hour=c.hour

