-- Create table dim_club
create or refresh live table marathos.gold.dim_club as
select
    row_number() over (order by athlete_club) as club_id, -- Create club ID
    athlete_club
from (
    select distinct athlete_club
    from marathos.silver.obt
    where athlete_club is not null
)