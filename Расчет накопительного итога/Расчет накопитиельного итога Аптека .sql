Расчет накопительного итога (продаж) всех розничных магазинов аптечной сети 
с партицией (раделением) по месцам за 2022 год.
 
 with a as (
    select dr_dat as date, sum((dr_kol * dr_croz) - DR_SDisc) as summ
    from sales s
    group by dr_dat
)
select date,TO_CHAR(date, 'Day')as dayofweek, round(summ::numeric, 2) as total_summ,
round(sum(summ::numeric) over (partition by to_char(date, 'MM') order by date), 2) as cumulative_sum
from a;