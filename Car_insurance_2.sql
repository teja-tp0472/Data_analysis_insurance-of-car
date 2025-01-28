USE [Car_Insurance_Database]
GO

select * from Car_Insurance_data_tobe_cleaned;

-- now checking total number of rows in the table
select COUNT (*) as Total_num_rows_in_table from Car_Insurance_data_tobe_cleaned;

-- now checking total number of columns in the table

select Count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Car_Insurance_data_tobe_cleaned';

--now finding all the columns
SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Car_Insurance_data_tobe_cleaned'; 

-- now finding the null values
SELECT 'TotalRows' AS ColumnName, COUNT(*) AS NullCount FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullAgeCount', SUM(CASE WHEN AGE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullGENDERCount', SUM(CASE WHEN GENDER IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullRACECount', SUM(CASE WHEN RACE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullDRIVING_EXPERIENCECount', SUM(CASE WHEN DRIVING_EXPERIENCE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullEDUCATIONCount', SUM(CASE WHEN EDUCATION IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullINCOMECount', SUM(CASE WHEN INCOME IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullCREDIT_SCORECount', SUM(CASE WHEN CREDIT_SCORE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullVEHICLE_OWNERSHIPCount', SUM(CASE WHEN VEHICLE_OWNERSHIP IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullVEHICLE_YEARCount', SUM(CASE WHEN VEHICLE_YEAR IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullMARRIEDCount', SUM(CASE WHEN MARRIED IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullCHILDRENCount', SUM(CASE WHEN CHILDREN IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullPOSTAL_CODECount', SUM(CASE WHEN POSTAL_CODE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullANNUAL_MILEAGECount', SUM(CASE WHEN ANNUAL_MILEAGE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullVEHICLE_TYPECount', SUM(CASE WHEN VEHICLE_TYPE IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullSPEEDING_VIOLATIONSCount', SUM(CASE WHEN SPEEDING_VIOLATIONS IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullDUISCount', SUM(CASE WHEN DUIS IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullPAST_ACCIDENTSCount', SUM(CASE WHEN PAST_ACCIDENTS IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned
UNION ALL
SELECT 'NullOUTCOMECount', SUM(CASE WHEN OUTCOME IS NULL THEN 1 ELSE 0 END) FROM Car_Insurance_data_tobe_cleaned;

-- checking for duplicate
SELECT 
    CREDIT_SCORE, 
    ANNUAL_MILEAGE, 
    AGE, 
    GENDER, 
    RACE, 
    DRIVING_EXPERIENCE, 
    EDUCATION, 
    INCOME, 
    VEHICLE_OWNERSHIP, 
    VEHICLE_YEAR, 
    MARRIED, 
    CHILDREN, 
    POSTAL_CODE, 
    VEHICLE_TYPE, 
    SPEEDING_VIOLATIONS, 
    DUIS, 
    PAST_ACCIDENTS, 
    OUTCOME, 
    COUNT(*) AS DuplicateCount
FROM Car_Insurance_data_tobe_cleaned
GROUP BY 
    CREDIT_SCORE, 
    ANNUAL_MILEAGE, 
    AGE, 
    GENDER, 
    RACE, 
    DRIVING_EXPERIENCE, 
    EDUCATION, 
    INCOME, 
    VEHICLE_OWNERSHIP, 
    VEHICLE_YEAR, 
    MARRIED, 
    CHILDREN, 
    POSTAL_CODE, 
    VEHICLE_TYPE, 
    SPEEDING_VIOLATIONS, 
    DUIS, 
    PAST_ACCIDENTS, 
    OUTCOME
HAVING COUNT(*) > 1;

-- keeping only one duplicate instance and deleting all other suplicates
WITH CTE AS (
    SELECT 
        ROW_NUMBER() OVER (
            PARTITION BY CREDIT_SCORE, ANNUAL_MILEAGE, AGE, GENDER, RACE, DRIVING_EXPERIENCE, 
                         EDUCATION, INCOME, VEHICLE_OWNERSHIP, VEHICLE_YEAR, MARRIED, 
                         CHILDREN, POSTAL_CODE, VEHICLE_TYPE, SPEEDING_VIOLATIONS, DUIS, 
                         PAST_ACCIDENTS, OUTCOME
            ORDER BY ID
        ) AS RowNumber,
        ID
    FROM Car_Insurance_data_tobe_cleaned
)
DELETE FROM Car_Insurance_data_tobe_cleaned
WHERE ID IN (
    SELECT ID
    FROM CTE
    WHERE RowNumber > 1
);

--reverifying the duplicates 
SELECT 
    CREDIT_SCORE, 
    ANNUAL_MILEAGE, 
    AGE, 
    GENDER, 
    RACE, 
    DRIVING_EXPERIENCE, 
    EDUCATION, 
    INCOME, 
    VEHICLE_OWNERSHIP, 
    VEHICLE_YEAR, 
    MARRIED, 
    CHILDREN, 
    POSTAL_CODE, 
    VEHICLE_TYPE, 
    SPEEDING_VIOLATIONS, 
    DUIS, 
    PAST_ACCIDENTS, 
    OUTCOME, 
    COUNT(*) AS DuplicateCount
FROM Car_Insurance_data_tobe_cleaned
GROUP BY 
    CREDIT_SCORE, 
    ANNUAL_MILEAGE, 
    AGE, 
    GENDER, 
    RACE, 
    DRIVING_EXPERIENCE, 
    EDUCATION, 
    INCOME, 
    VEHICLE_OWNERSHIP, 
    VEHICLE_YEAR, 
    MARRIED, 
    CHILDREN, 
    POSTAL_CODE, 
    VEHICLE_TYPE, 
    SPEEDING_VIOLATIONS, 
    DUIS, 
    PAST_ACCIDENTS, 
    OUTCOME
HAVING COUNT(*) > 1;

--calculating the mean of non-nullvalues
SELECT 
    AVG(CREDIT_SCORE) AS MeanCreditScore,
    AVG(ANNUAL_MILEAGE) AS MeanAnnualMileage
FROM Car_Insurance_data_tobe_cleaned
WHERE CREDIT_SCORE IS NOT NULL AND ANNUAL_MILEAGE IS NOT NULL;


--now updating the null values, with this mean values, depending on project we can even delete them,
--but as of here there percentage in teh whole dataset is more, i decided to overwrite them with the mean values
UPDATE Car_Insurance_data_tobe_cleaned
SET CREDIT_SCORE = 0.516367731526986
WHERE CREDIT_SCORE IS NULL;

UPDATE Car_Insurance_data_tobe_cleaned
SET ANNUAL_MILEAGE = 11693.459320162
WHERE ANNUAL_MILEAGE IS NULL;

--reverifying the null values in teh above two columns
SELECT 
    SUM(CASE WHEN CREDIT_SCORE IS NULL THEN 1 ELSE 0 END) AS NullCREDIT_SCORECount,
    SUM(CASE WHEN ANNUAL_MILEAGE IS NULL THEN 1 ELSE 0 END) AS NullANNUAL_MILEAGECount
FROM Car_Insurance_data_tobe_cleaned;

--making sure that there are no duplicate values in the updated rows
SELECT 
    CREDIT_SCORE, 
    ANNUAL_MILEAGE, 
    COUNT(*) AS DuplicateCount
FROM Car_Insurance_data_tobe_cleaned
GROUP BY CREDIT_SCORE, ANNUAL_MILEAGE
HAVING COUNT(*) > 1;
 -- now removing the duplicates 
 WITH CTE AS (
    SELECT 
        ROW_NUMBER() OVER (
            PARTITION BY CREDIT_SCORE, ANNUAL_MILEAGE 
            ORDER BY ID
        ) AS RowNumber,
        ID
    FROM Car_Insurance_data_tobe_cleaned
)
DELETE FROM Car_Insurance_data_tobe_cleaned
WHERE ID IN (
    SELECT ID
    FROM CTE
    WHERE RowNumber > 1
);
-- once again checking whole data for duplicates
SELECT *
FROM Car_Insurance_data_tobe_cleaned
WHERE CREDIT_SCORE = 0.516367731526986 AND ANNUAL_MILEAGE = 10000;


----
SELECT 
    CREDIT_SCORE, 
    ANNUAL_MILEAGE, 
    COUNT(*) AS DuplicateCount
FROM Car_Insurance_data_tobe_cleaned
GROUP BY CREDIT_SCORE, ANNUAL_MILEAGE
HAVING COUNT(*) > 1;


---- count of total rows
SELECT COUNT(*) AS TotalRows FROM Car_Insurance_data_tobe_cleaned;

--counting all the columns
select Count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Car_Insurance_data_tobe_cleaned';

--triming all teh extra spaces from all string values

UPDATE Car_Insurance_data_tobe_cleaned
SET GENDER = UPPER(TRIM(GENDER)),
    RACE = UPPER(TRIM(RACE)),
    DRIVING_EXPERIENCE = TRIM(DRIVING_EXPERIENCE),
    EDUCATION = TRIM(EDUCATION),
    VEHICLE_YEAR = TRIM(VEHICLE_YEAR),
    VEHICLE_TYPE = TRIM(VEHICLE_TYPE);

-- Verify the changes
SELECT TOP 10 GENDER, RACE, DRIVING_EXPERIENCE, EDUCATION, VEHICLE_YEAR, VEHICLE_TYPE
FROM Car_Insurance_data_tobe_cleaned;

--merging columns
SELECT 
    ID,
    AGE,
    GENDER,
    RACE,
    DRIVING_EXPERIENCE,
    CONCAT(EDUCATION, ' - ', INCOME) AS Education_Income_Group,
    CREDIT_SCORE,
    ANNUAL_MILEAGE
FROM Car_Insurance_data_tobe_cleaned;

---including the updated table
ALTER TABLE Car_Insurance_data_tobe_cleaned ADD Education_Income_Group NVARCHAR(MAX);

UPDATE Car_Insurance_data_tobe_cleaned
SET Education_Income_Group = CONCAT(EDUCATION, ' - ', INCOME);

select * from Car_Insurance_data_tobe_cleaned;


--counting all the columns
select Count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Car_Insurance_data_tobe_cleaned';

--performing left join Using ROW_NUMBER to Keep the Latest or Best Row
--car_insurance_claim_data table,Remove Duplicates
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ID
               ORDER BY 
                   CASE WHEN CREDIT_SCORE IS NULL THEN 1 ELSE 0 END, -- NULLs last
                   CREDIT_SCORE DESC -- Highest non-null CREDIT_SCORE
           ) AS RowNumber
    FROM Car_Insurance_Claim
)
-- Keep only the first row for each ID
SELECT *
INTO Car_Insurance_Claim_Cleaned
FROM CTE
WHERE RowNumber = 1;

--remove nulls
DELETE FROM Car_Insurance_Claim_Cleaned
WHERE CREDIT_SCORE IS NULL AND ANNUAL_MILEAGE IS NULL; 

--left joins
SELECT 
    c.ID,
    c.AGE,
    c.GENDER,
    c.RACE,
    c.DRIVING_EXPERIENCE,
    c.EDUCATION,
    c.INCOME,
    COALESCE(c.CREDIT_SCORE, cl.CREDIT_SCORE) AS CREDIT_SCORE, -- Prefer cleaned data
    COALESCE(c.ANNUAL_MILEAGE, cl.ANNUAL_MILEAGE) AS ANNUAL_MILEAGE,
    c.VEHICLE_OWNERSHIP,
    c.VEHICLE_YEAR,
    c.MARRIED,
    c.CHILDREN,
    c.POSTAL_CODE,
    c.VEHICLE_TYPE,
    c.SPEEDING_VIOLATIONS,
    c.DUIS,
    c.PAST_ACCIDENTS,
    c.OUTCOME
INTO Car_Insurance_Joined
FROM Car_Insurance_data_tobe_cleaned c
LEFT JOIN Car_Insurance_Claim_Cleaned cl
ON c.ID = cl.ID;


-- count
SELECT COUNT(*) AS TotalRows FROM Car_Insurance_Joined;

--checking for nulls
SELECT 
    SUM(CASE WHEN CREDIT_SCORE IS NULL THEN 1 ELSE 0 END) AS NullCREDIT_SCORECount,
    SUM(CASE WHEN ANNUAL_MILEAGE IS NULL THEN 1 ELSE 0 END) AS NullANNUAL_MILEAGECount
FROM Car_Insurance_Joined;

--checking for duplicates
SELECT 
    ID, 
    COUNT(*) AS DuplicateCount
FROM Car_Insurance_Joined
GROUP BY ID
HAVING COUNT(*) > 1;

--groupby
SELECT 
    AGE,
    GENDER,
    AVG(CREDIT_SCORE) AS Average_Credit_Score,
    AVG(ANNUAL_MILEAGE) AS Average_Annual_Mileage,
    COUNT(*) AS Total_Customers
FROM Car_Insurance_Joined
GROUP BY AGE, GENDER;

select * from Car_Insurance_Joined

