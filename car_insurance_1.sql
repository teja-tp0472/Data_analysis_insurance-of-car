USE [Car_Insurance_Database]
GO

--loading the table
select * from Car_Insurance_Claim;

-- now checking total number of rows in the table
select COUNT (*) as Total_num_rows_in_table from Car_Insurance_Claim;

-- now checking total number of columns in the table

select Count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Car_Insurance_Claim';

--getting all columns name and datatype
SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Car_Insurance_Claim' 

--creating new table 
select * from Car_Insurance_data_tobe_cleaned;
select count(*) as totalrows from Car_Insurance_data_tobe_cleaned;
select COLUMN_NAME,DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Car_Insurance_data_tobe_cleaned';
select count(*) as totalcaolumns from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Car_Insurance_data_tobe_cleaned';



