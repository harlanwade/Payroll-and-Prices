-- Vytváříme tabulku s průměrnými mzdami podle odvětví a průměrnými cenami podle kategorií
-- v České republice v dostupném časovém období

create table t_krystof_karel_project_SQL_primary_final as

-- Průměrné mzdy podle odvětví
select
    cpay.payroll_year as year,
    cpib.name as industry_branch_name,
    round(avg(cpay.value)::numeric, 2) as payroll_value,  -- Průměrná hodnota mzdy (zaokrouhlená na 2 desetinná místa)
    NULL as category_name,
    NULL as price_value
from czechia_payroll cpay 
join czechia_payroll_industry_branch cpib   -- Spojení s tabulkou odvětví na základě kódu
    on cpay.industry_branch_code = cpib.code   -- Filtrujeme podle typu hodnoty (měsíční mzda)
where cpay.value_type_code = 5958
group by
    cpay.payroll_year,
    cpay.industry_branch_code,
    cpib.name

union all

-- Průměrné ceny podle kategorií
select
    cpay.payroll_year as year,
    NULL as industry_branch_name,
    NULL as payroll_value,
    cpc.name as category_name,
    round(avg(cpr.value)::numeric, 2) as price_value  -- Průměrná hodnota ceny (zaokrouhlená na 2 desetinná místa)
from czechia_price cpr 
join czechia_price_category cpc 
    on cpr.category_code = cpc.code   -- Spojení s tabulkou kategorií na základě kódu kategorie
join czechia_payroll cpay
    on cpay.payroll_year = date_part('year', cpr.date_from)  -- Spojení s tabulkou výplat podle roku
where cpay.value_type_code = 5958   --Filtrujeme podle typu hodnoty (měsíční mzda)
group by
    cpay.payroll_year,
    cpc.name

-- Seřazení výsledků podle roku, odvětví a kategorie
order by year, industry_branch_name, category_name;
