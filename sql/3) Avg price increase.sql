with price_changes as (
    select 
        category_name,
        year,
        price_value,
        lag(price_value) over (
            partition by category_name 
            order by year
        ) as prev_price_value
    from t_krystof_karel_project_SQL_primary_final
)
select 
    category_name,
    round(avg(
        case 
            when prev_price_value is not null then 
                ((price_value - prev_price_value) / prev_price_value) * 100
            else null
        end
    ), 2) as avg_price_increase_percent
from price_changes
group by category_name
order by avg_price_increase_percent desc;
