# -*- coding: utf-8 -*-

"""Util module."""

from pyspark.sql import DataFrame, SparkSession


def save_overwrite_unmanaged_table(spark: SparkSession, dataframe: DataFrame, table_name: str, path: str):
    """When trying to read and overwrite the same table, you get this error:
    'Cannot overwrite table dw.dim_parking_bay that is also being read from;'
    This utility function workarounds this by saving to a temporary table first prior to overwriting.
    """
    temp_table_name = table_name + "___temp"
    spark.sql("DROP TABLE IF EXISTS " + temp_table_name).collect()
    # Save temp table
<<<<<<< HEAD
    dataframe.write.saveAsTable(temp_table_name, overwrite=True)
    # Read temp table and overwrite original table
    spark.read.table(temp_table_name)\
        .write.option("path", path)\
        .insertInto(table_name, overwrite=True)
=======
    dataframe.write.saveAsTable(temp_table_name)
    # Read temp table and overwrite original table
    spark.read.table(temp_table_name)\
        .write.mode("overwrite")\
        .option("path", path)\
        .saveAsTable(table_name)
>>>>>>> f06c799 (fix(parking_sensors_synapse): clarity in README in parking sensor synapse sample, add requirement for Synapse extension, comment out debugging in script by default, add general troubleshooting section (#466))
    # Drop temp table
    spark.sql("DROP TABLE " + temp_table_name).collect()
