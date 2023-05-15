with
    tc as (
        select
            date_part('year', now()) - date_part('year', '1993-01-01'::date) as t1,
            {{ age_in_years("'1993-01-01'::date") }} as t2

    )

select *
from tc
where t1 <> t2
