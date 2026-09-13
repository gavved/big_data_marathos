-- Create table fct_results
create or refresh live table marathos.gold.fct_results as
select
    row_number() over (order by s.event_id, s.athlete_id) as result_id,
    s.event_id,
    s.athlete_id,
    c.club_id,
    s.performance_seconds,
    s.athlete_average_speed

from marathos.silver.obt as s
left join marathos.gold.dim_club as c on s.athlete_club = c.athlete_club