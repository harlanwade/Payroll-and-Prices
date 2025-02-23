-- Vytváříme tabulku s průměrnými mzdami podle odvětví a průměrnými cenami podle kategorií
-- v České republice v dostupném časovém obdoví

create table t_krystof_karel_project_SQL_primary_final as

-- Průměrné mzdy podle odvětví
select
    cpay.payroll_year as year,  -- Rok
    cpib.name as industry_branch_name,  -- Název odvětví
    round(avg(cpay.value)::numeric, 2) as payroll_value,  -- Průměrná mzda
    NULL as category_name,
    NULL as price_value
from czechia_payroll cpay 
join czechia_payroll_industry_branch cpib 
    on cpay.industry_branch_code = cpib.code  -- Spojení s odvětvím
where cpay.value_type_code = 5958  -- Filtr na mzdy
group by
    cpay.payroll_year,  -- Seskupení podle roku
    cpay.industry_branch_code,  -- Seskupení podle kódu odvětví
    cpib.name  -- Seskupení podle názvu odvětví

union all

-- Průměrné ceny podle kategorií
select
    cpay.payroll_year as year,  -- Rok
    NULL as industry_branch_name,
    NULL as payroll_value,
    cpc.name as category_name,  -- Název kategorie
    round(avg(cpr.value)::numeric, 2) as price_value  -- Průměrná cena
from czechia_price cpr 
join czechia_price_category cpc 
    on cpr.category_code = cpc.code  -- Spojení s kategorií
join czechia_payroll cpay
    on cpay.payroll_year = date_part('year', cpr.date_from)  -- Spojení s rokem výplaty
where cpay.value_type_code = 5958  -- Filtr na mzdy
group by
    cpay.payroll_year,  -- Seskupení podle roku
    cpc.name  -- Seskupení podle názvu kategorie

-- Seřazení výsledků podle roku, odvětví a kategorie
order by year, industry_branch_name, category_name;
