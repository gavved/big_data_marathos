-- Create table dim_event
create or refresh live table marathos.gold.dim_event as
select distinct
    event_id,
    event_name,
    event_dates,
    event_distance_length,
    event_number_of_finishers,
    case 
        when event_distance_length rlike '(?i)h$'
            then 'Time'
        when event_distance_length rlike '(?i)(km|mi|miles)'
            then 'Distance'
        else 'Unknown'
    end as event_type
from
    marathos.silver.obt