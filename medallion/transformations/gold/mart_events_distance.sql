-- View for distance-type events statistics
create or replace view marathos.gold.mart_events_distance as

select
    e.event_id,
    e.event_name,
    e.event_dates,
    e.event_distance_length,
    e.event_number_of_finishers,
    e.event_type,

    count(f.result_id) as participants

from marathos.gold.fct_results f
join marathos.gold.dim_event e on f.event_id = e.event_id
where e.event_type = 'Distance'
group by 
    e.event_id,
    e.event_name,
    e.event_dates,
    e.event_distance_length,
    e.event_number_of_finishers,
    e.event_type