from pyspark import pipelines as dp
from utils.utils import (rename_columns_to_snake_case,
                        filter_invalid_performances,
                        remove_day_performances,
                        add_performance_seconds,
                        add_event_id)

@dp.table(
    name="marathos.silver.obt",
    comment="Cleaned marathos data",
    table_properties={
        "delta.columnMapping.mode": "name",
        "delta.minReaderVersion": "2",
        "delta.minWriterVersion": "5",
    },
)

def cleaned_supply_chain():

    df = spark.sql("SELECT * FROM marathos.bronze.raw_data")


    df = rename_columns_to_snake_case(df)
    df = filter_invalid_performances(df)
    df = remove_day_performances(df)
    df = add_performance_seconds(df)
    df = add_event_id(df)

    return df