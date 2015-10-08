-- create corresponding table in BigSQL
-- the table points to the ParquetSink 
-- output folder and queries parquet file
-- generated by it  
-----------------------------------------------------------------------------------------
SET SCHEMA myschema;
-----------------------------------------------------------------------------------------
DROP   TABLE IF EXISTS partitioned_events ;
-----------------------------------------------------------------------------------------
CREATE EXTERNAL HADOOP TABLE partitioned_events (
        ts              VARCHAR (25) NOT NULL, 
        computer_id     VARCHAR (20) NOT NULL, 
        process_name    VARCHAR (25) NOT NULL, 
        operation       VARCHAR (20) NOT NULL, 
        oper_result     VARCHAR (20) NOT NULL, 
        source_host     VARCHAR (15) NOT NULL, 
        source_port     INTEGER NOT NULL, 
        tcp_length      INTEGER NOT NULL, 
        mms             BIGINT NOT NULL, 
        dest_host       VARCHAR (15) NOT NULL, 
        dest_port       INTEGER NOT NULL, 
        filename        VARCHAR (30) NOT NULL, 
        file_length     BIGINT NOT NULL
,       PRIMARY KEY ( ts, computer_id, process_name, source_host, dest_host)
) 
PARTITIONED BY (
        year    SMALLINT NOT NULL, 
        month   TINYINT NOT NULL, 
        day     TINYINT NOT NULL, 
        hour    TINYINT NOT NULL
)
STORED AS PARQUETFILE
LOCATION '/Data/Bigsql/parquetTest';
---------------------------------------------
MSCK REPAIR TABLE PTEST.partitioned_events;
SELECT * FROM PTEST.partitioned_events;

quit;

