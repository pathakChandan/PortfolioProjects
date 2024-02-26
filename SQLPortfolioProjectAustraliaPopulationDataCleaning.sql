

--PERFORMING SQL DATA CLEANING QUERRIES


--The data is taken from KAGGLE

SELECT *
FROM AustraliaPopulation

--"This data contains statistics about the population and components of change (births, deaths, migration) for Australia and its states and territories covering between 01.06.1981 and 1.09.2020. Data was collected quarterly."


--Attempting to separate data entries and fields 

ALTER TABLE AustraliaPopulation
ADD Date Nvarchar(100)

UPDATE AustraliaPopulation
SET Date = SUBSTRING(CompressedDataField, 1, CHARINDEX(';', CompressedDataField)-1)

ALTER TABLE AustraliaPopulation
ADD Births int

ALTER TABLE AustraliaPopulation
ADD Deaths int

ALTER TABLE AustraliaPopulation
ADD InterstateArrivals int

ALTER TABLE AustraliaPopulation
ADD InterstateDepartures int

ALTER TABLE AustraliaPopulation
ADD OverseasArrivals int

ALTER TABLE AustraliaPopulation
ADD OverseasDepartures int

--So far, 7 fields have been created and date field has been retrieved


ALTER TABLE AustraliaPopulation --from here (STR1, STR2, STR3, STR4, STR5 and STR6 ) new fields will be created. Each later fields will be created by trimming of the front segments of the former segment. 
ADD STR1 Nvarchar(100)          --PARSENAME doesn't apply here because, it has more than 4 segments

UPDATE AustraliaPopulation
SET STR1 = SUBSTRING(CompressedDataField, CHARINDEX(';', CompressedDataField)+1, LEN(CompressedDataField))

UPDATE AustraliaPopulation
SET Births = SUBSTRING(STR1, 1, CHARINDEX(';', STR1)-1)

ALTER TABLE AustraliaPopulation
ADD STR2 Nvarchar(100)

UPDATE AustraliaPopulation
SET STR2 = SUBSTRING(STR1, CHARINDEX(';', STR1)+1, LEN(STR1))

UPDATE AustraliaPopulation
SET Deaths = SUBSTRING(STR2, 1, CHARINDEX(';', STR2)-1)

ALTER TABLE AustraliaPopulation
ADD STR3 Nvarchar(100)

UPDATE AustraliaPopulation
SET STR3 = SUBSTRING(STR2, CHARINDEX(';', STR2)+1, LEN(STR2))

UPDATE AustraliaPopulation
SET InterstateArrivals = SUBSTRING(STR3, 1, CHARINDEX(';', STR3)-1)

ALTER TABLE AustraliaPopulation
ADD STR4 Nvarchar(100)

UPDATE AustraliaPopulation
SET STR4 = SUBSTRING(STR3, CHARINDEX(';', STR3)+1, LEN(STR3))

UPDATE AustraliaPopulation
SET InterstateDepartures = SUBSTRING(STR4, 1, CHARINDEX(';', STR4)-1)

ALTER TABLE AustraliaPopulation
ADD STR5 Nvarchar(100)

UPDATE AustraliaPopulation
SET STR5 = SUBSTRING(STR4, CHARINDEX(';', STR4)+1, LEN(STR4))

UPDATE AustraliaPopulation
SET OverseasArrivals = SUBSTRING(STR5, 1, CHARINDEX(';', STR5)-1)

ALTER TABLE AustraliaPopulation
ADD STR6 Nvarchar(100)

UPDATE AustraliaPopulation
SET STR6 = SUBSTRING(STR5, CHARINDEX(';', STR5)+1, LEN(STR5))

UPDATE AustraliaPopulation
SET OverseasDepartures = STR6


--Just extracted seven original data fields with their respective entries. CompressedDataField, STR1,...,STR6 are useless, hence, will be removed 

ALTER TABLE AustraliaPopulation
DROP COLUMN CompressedDataField, STR1, Str2, STR3, STR4, STR5, STR6

SELECT *
FROM AustraliaPopulation


--Changing the Date Format from dd.mm.yyyy to dd/mm.yyyy

UPDATE AustraliaPopulation
SET Date = REPLACE(Date, '.', '/')

SELECT *
FROM AustraliaPopulation
