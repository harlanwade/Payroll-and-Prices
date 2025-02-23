-- Výběr údajů o mzdových hodnotách a porovnání s předchozím rokem

select
    year,
    industry_branch_name,
    payroll_value,
    -- Výpočet hodnoty mzdy z předchozího roku pomocí funkce LAG
    lag(payroll_value) over (
        partition by industry_branch_name
        order by year
    ) as previous_year_value,
    -- Případové vyjádření pro porovnání s předchozím rokem
    case 
        -- Pokud není předchozí hodnota mzdy dostupná (NULL), zobrazí se 'N/A'
        when lag(payroll_value) over (
            partition by industry_branch_name
            order by year
        ) is null then 'N/A'
        -- Pokud je hodnota mzdy vyšší než v předchozím roce, zobrazí se 'Higher'
        when payroll_value > lag(payroll_value) over (
            partition by industry_branch_name
            order by year
        ) then 'Higher'
        -- Pokud je hodnota mzdy nižší než v předchozím roce, zobrazí se 'Lower'
        when payroll_value < lag(payroll_value) over (
            partition by industry_branch_name
            order by year
        ) then 'Lower'
        -- Pokud jsou hodnoty stejné, zobrazí se 'Same'
        else 'Same'
    end as comparison_to_previous_year  -- Výsledek porovnání
from t_krystof_karel_project_SQL_primary_final
-- Filtrujeme pouze záznamy s názvem průmyslového odvětví
where industry_branch_name is not null
-- Řadíme výsledky podle názvu odvětví a roku
order by industry_branch_name, year;
