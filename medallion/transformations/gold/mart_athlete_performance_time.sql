-- View for athlete performances in time-type events
create or replace view marathos.gold.mart_athlete_performance_time as

select
    f.result_id,
    f.performance_seconds,
    f.athlete_average_speed,

    a.athlete_id,
    a.athlete_country,
    a.athlete_gender,
    a.athlete_age_category,

    e.event_name,
    e.event_dates,
    e.event_distance_length,
    e.event_type,

    c.athlete_club

from marathos.gold.fct_results f
join marathos.gold.dim_event e on f.event_id = e.event_id
join marathos.gold.dim_athlete a on f.athlete_id = a.athlete_id
join marathos.gold.dim_club c on f.club_id = c.club_id
where e.event_type = 'Time'