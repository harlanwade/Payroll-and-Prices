-- Vytváření dočasné tabulky, která obsahuje aktuální a předcházející ceny pro každou kategorii

with price_changes as (
    select 
        category_name,
        year,
        price_value,
        lag(price_value) over (  -- Získání předchozí ceny pro každou kategorii
            partition by category_name 
            order by year
        ) as prev_price_value
    from t_krystof_karel_project_SQL_primary_final
)

-- Hlavní dotaz pro výpočet průměrného procentuálního nárůstu ceny mezi roky pro každou kategorii

select 
    category_name,
    round(avg(  -- Výpočet průměrného procentuálního nárůstu ceny
        case 
            when prev_price_value is not null then 
                ((price_value - prev_price_value) / prev_price_value) * 100
            else null
        end
    ), 2) as avg_price_increase_percent
from price_changes
group by category_name
order by avg_price_increase_percent desc;
