create table t_krystof_karel_project_SQL_primary_final as
select
    cpay.payroll_year as year,
    cpib.name as industry_branch_name,
    round(avg(cpay.value)::numeric, 2) as payroll_value,
    NULL as category_name,
    NULL as price_value
from czechia_payroll cpay 
join czechia_payroll_industry_branch cpib 
    on cpay.industry_branch_code = cpib.code
where cpay.value_type_code = 5958
group by
    cpay.payroll_year,
    cpay.industry_branch_code,
    cpib.name

union all

select
    cpay.payroll_year as year,
    NULL as industry_branch_name,
    NULL as payroll_value,
    cpc.name as category_name,
    round(avg(cpr.value)::numeric, 2) as price_value
from czechia_price cpr 
join czechia_price_category cpc 
    on cpr.category_code = cpc.code
join czechia_payroll cpay
    on cpay.payroll_year = date_part('year', cpr.date_from)
where cpay.value_type_code = 5958
group by
    cpay.payroll_year,
    cpc.name

order by year, industry_branch_name, category_name;
