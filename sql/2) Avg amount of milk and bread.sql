-- Vytváříme dočasnou tabulku pro zjištění minimálního a maximálního roku
with years as (
    select min(year) as min_year, max(year) as max_year
    from t_krystof_karel_project_SQL_primary_final
    where price_value is not null
)

-- Hlavní dotaz pro výpočet průměrného počtu jednotek 'Mléko polotučné pasterované' a 'Chléb konzumní kmínový'
select 
    -- Vypočítáme průměrnou hodnotu mzdy v minimálním roce, vydělenou cenou za mléko v tomtéž roce
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

    -- Vypočítáme průměrnou hodnotu mzdy v maximálním roce, vydělenou cenou za mléko v maximálním roce
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

    -- Vypočítáme průměrnou hodnotu mzdy v minimálním roce, vydělenou cenou za chléb v tomtéž roce
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

    -- Vypočítáme průměrnou hodnotu mzdy v maximálním roce, vydělenou cenou za chléb v maximálním roce
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
