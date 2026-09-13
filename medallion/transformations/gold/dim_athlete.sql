-- Create table dim_athlete
create or refresh live table marathos.gold.dim_athlete as
select distinct
    athlete_id,
    athlete_country,
    athlete_year_of_birth,
    athlete_gender,
    athlete_age_category
from
    marathos.silver.obt