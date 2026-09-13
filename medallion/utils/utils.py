import re
from pyspark.sql import functions
from pyspark.sql.window import Window


def to_snake_case(name):
    name = name.strip().casefold()
    name = re.sub(r"[\s/]+", "_", name)
    return name


def rename_columns_to_snake_case(df):
    new_columns = [to_snake_case(column) for column in df.columns]
    return df.toDF(*new_columns)


def filter_invalid_performances(df):
    # If event has unit km or mi then performance should be in h
    # If event has unit h then performance should be in km
    # Else it gets filtered out
    return df.filter(
        (
            (
                functions.col("event_distance_length").contains("km")
                | functions.col("event_distance_length").contains("mi")
            )
            & functions.col("athlete_performance").contains("h")
        )
        | (
            functions.col("event_distance_length").contains("h")
            & functions.col("athlete_performance").contains("km")
        )
    )


def remove_day_performances(df):
    # If event has d (days) in athlete performance it gets filtered out
    return df.filter(~functions.col("athlete_performance").contains("d"))


def add_performance_seconds(df):
    # Only convert time-based performances to seconds
    # Distance-based performances (km) are kept as-is
    time_based = df.filter(
        functions.col("athlete_performance").contains("h")
    )

    # Split time for time-based performances
    time_units_filtered = functions.split(
        functions.trim(
            functions.split(functions.col("athlete_performance"), "h").getItem(0)
        ),
        ":"
    )

    time_based = time_based.withColumn(
        "performance_seconds",
        time_units_filtered.getItem(0).try_cast("int") * 3600
        + time_units_filtered.getItem(1).try_cast("int") * 60
        + time_units_filtered.getItem(2).try_cast("int")
    )

    # For distance-based performances, keep original value without conversion
    distance_based = df.filter(
        functions.col("athlete_performance").contains("km")
    ).withColumn("performance_seconds", functions.lit(None).cast("int"))

    return time_based.unionByName(distance_based)


def add_event_id(df):

    window = Window.orderBy(
        "event_name",
        "event_dates"
    )

    return df.withColumn(
        "event_id", functions.dense_rank().over(window)
    )













