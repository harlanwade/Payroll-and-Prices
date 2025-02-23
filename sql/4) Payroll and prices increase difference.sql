-- Vytváření dočasné tabulky 'value_changes', která obsahuje změny mezd a cen pro jednotlivé roky
with value_changes as (

	-- Výběr údajů pro mzdy, včetně předchozích hodnot
	select
	    year,
	    industry_branch_name,
	    null as category_name,
	    payroll_value,
	    lag(payroll_value) over (  -- Získání předchozí hodnoty mzdy pro dané odvětví
	        partition by industry_branch_name 
	        order by year
	    ) as prev_payroll_value,
	    null as price_value,
	    null as prev_price_value
	from t_krystof_karel_project_SQL_primary_final
		where industry_branch_name is not null

	union all  -- Spojení s dalším výběrem pro ceny (bez mezd)

	-- Výběr údajů pro ceny, včetně předchozích hodnot
	select
	    year,
	    null as industry_branch_name,
	    category_name,
	    null as payroll_value,
	    null as prev_payroll_value,
	    price_value,
	    lag(price_value) over (  -- Získání předchozí hodnoty ceny pro danou kategorii
	        partition by category_name 
	        order by year
	    ) as prev_price_value
	from t_krystof_karel_project_SQL_primary_final
		where category_name is not null
	)
	
-- Hlavní dotaz pro výpočet průměrné změny mezd, průměrné změny cen a jejich rozdílu
select
	year,
    round(avg(  -- Výpočet průměrné procentuální změny mezd
        case 
            when prev_payroll_value is not null then 
                ((payroll_value - prev_payroll_value) / prev_payroll_value) * 100
            else null
        end
    ), 2) as avg_payroll_increase_percent,
    round(avg(  -- Výpočet průměrné procentuální změny cen
        case 
            when prev_price_value is not null then 
                ((price_value - prev_price_value) / prev_price_value) * 100
            else null
        end
    ), 2) as avg_price_increase_percent,
    (round(avg(  -- Výpočet rozdílu mezi průměrnou změnou cen a průměrnou změnou mezd
        case 
            when prev_price_value is not null then 
                ((price_value - prev_price_value) / prev_price_value) * 100
            else null
        end
    ), 2))
    -
    (round(avg(  -- Odečítání průměrné změny mezd
        case 
            when prev_payroll_value is not null then 
                ((payroll_value - prev_payroll_value) / prev_payroll_value) * 100
            else null
        end
    ), 2)) as difference  -- Výsledek je rozdíl mezi průměrnými změnami cen a mezd
from value_changes
group by year
order by year;
