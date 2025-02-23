-- Vytváříme tabulku s ekonomickými údaji pro evropské země (kromě České republiky)
-- ve sledovaném období

create table t_krystof_karel_project_SQL_secondary_final as
select
    country,
    year,
    gdp,
    gini,
    population
from economies e
where country in (
    -- Výběr zemí z Evropy
    select country
    from countries c 
    where region_in_world like '%Europe'
    )
and country != 'Czech Republic'
and year >= 2000
