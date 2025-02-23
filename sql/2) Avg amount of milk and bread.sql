with years as (
    select min(year) as min_year, max(year) as max_year
    from t_krystof_karel_project_SQL_primary_final
    where price_value is not null
)
select 
    (
        select avg(payroll_value) 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select min_year from years)
    ) 
    / 
    (
        select price_value 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select min_year from years)
        and category_name = 'Mléko polotučné pasterované'
    ) as amount_of_milk_avg_min_year,

    (
        select avg(payroll_value) 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select max_year from years)
    ) 
    / 
    (
        select price_value 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select max_year from years)
        and category_name = 'Mléko polotučné pasterované'
    ) as amount_of_milk_avg_max_year,

    (
        select avg(payroll_value) 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select min_year from years)
    ) 
    / 
    (
        select price_value 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select min_year from years)
        and category_name = 'Chléb konzumní kmínový'
    ) as amount_of_bread_avg_min_year,

    (
        select avg(payroll_value) 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select max_year from years)
    ) 
    / 
    (
        select price_value 
        from t_krystof_karel_project_SQL_primary_final
        where year = (select max_year from years)
        and category_name = 'Chléb konzumní kmínový'
    ) as amount_of_bread_avg_max_year;
