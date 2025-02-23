select
	year,
	industry_branch_name,
	payroll_value,
	lag(payroll_value) over (
        partition by industry_branch_name
        order by year
	    ) as previous_year_value,
    case 
        when lag(payroll_value) over (
            partition by industry_branch_name
            order by year
        ) is null then 'N/A'
        when payroll_value > lag(payroll_value) over (
            partition by industry_branch_name
            order by year
        ) then 'Higher'
        when payroll_value < lag(payroll_value) over (
            partition by industry_branch_name
            order by year
        ) then 'Lower'
        else 'Same'
    end as comparison_to_previous_year
from t_krystof_karel_project_SQL_primary_final
where industry_branch_name is not null
order by industry_branch_name, year;
