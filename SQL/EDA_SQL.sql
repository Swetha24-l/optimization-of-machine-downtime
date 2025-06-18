Show databases;
create database machine;
use machine;
CREATE TABLE downtime (
    Date DATE,
    Machine_ID VARCHAR(50),
    Assembly_Line_No VARCHAR(50),
    Hydraulic_Pressure_bar FLOAT,
    Coolant_Pressure_bar FLOAT,
    Air_System_Pressure_bar FLOAT,
    Coolant_Temperature FLOAT,
    Hydraulic_Oil_Temperature_C FLOAT,
    Spindle_Bearing_Temperature_C FLOAT,
    Spindle_Vibration FLOAT,
    Tool_Vibration FLOAT,
    Spindle_Speed_RPM INT,
    Voltage_volts INT,
    Torque_Nm FLOAT,
    Cutting_kN FLOAT,
    Downtime VARCHAR(50)
);
select * from downtime;
select * from downtime limit 5; #Top 5 rows
select * from downtime order by machine_id desc limit 5; #Last 5 rows
select * from downtime order by machine_id asc limit 10; #Top 10 rows
describe downtime;  #column names
select count(*) from downtime;  #No of rows
show columns from downtime; #Column names and data type
SELECT COUNT(*) AS column_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'machine'
  AND table_name = 'downtime';  #No of columns
select count(distinct Machine_ID) as unique_values from downtime; #Finding the unique values from column

SELECT 
  MIN(Hydraulic_Pressure_bar) AS min_val,
  MAX(Hydraulic_Pressure_bar) AS max_val,
  AVG(Hydraulic_Pressure_bar) AS avg_val,
  STDDEV(Hydraulic_Pressure_bar) AS std_dev,
  COUNT(Hydraulic_Pressure_bar) AS non_null_count
FROM downtime;

#First Moment Business Decision 
#Mean (Average)
SELECT AVG(Hydraulic_Pressure_bar) AS mean_hydraulic_pressure,
avg(Coolant_Pressure_bar) as mean_Coolant_Pressure_bar,
avg(Air_System_Pressure_bar) as mean_Air_System_Pressure_bar,
avg(Coolant_Temperature) as mean_Coolant_Temperature,
avg(Hydraulic_Oil_Temperature_C) as mean_Hydraulic_Oil_Temperature_C,
avg(Spindle_Bearing_Temperature_C) as mean_Spindle_Bearing_Temperature_C,
avg(Spindle_Vibration) as mean_Spindle_Vibration,
avg(Tool_Vibration) as mean_Tool_Vibration,
avg(Spindle_Speed_RPM) as mean_Spindle_Speed_RPM,
avg(Voltage_volts) as mean_Voltage_volts,
avg(Torque_Nm) as mean_Torque_Nm,
avg(Cutting_kN) as mean_Cutting_kN
FROM downtime;

#Median (Middle value) 

SELECT AVG(Hydraulic_Pressure_bar) AS Median_Hydraulic_Pressure_bar
FROM (
  SELECT Hydraulic_Pressure_bar
  FROM downtime
  ORDER BY Hydraulic_Pressure_bar
  LIMIT 2500 OFFSET 1
) AS sub;

#Mode (Most frequent value)
SELECT Hydraulic_Pressure_bar FROM downtime GROUP BY Hydraulic_Pressure_bar ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Coolant_Pressure_bar FROM downtime GROUP BY Coolant_Pressure_bar ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Air_System_Pressure_bar FROM downtime GROUP BY Air_System_Pressure_bar ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Coolant_Temperature FROM downtime GROUP BY Coolant_Temperature ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Hydraulic_Oil_Temperature_C FROM downtime GROUP BY Hydraulic_Oil_Temperature_C ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Spindle_Bearing_Temperature_C FROM downtime GROUP BY Spindle_Bearing_Temperature_C ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Spindle_Vibration FROM downtime GROUP BY Spindle_Vibration ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Tool_Vibration FROM downtime GROUP BY Tool_Vibration ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Spindle_Speed_RPM FROM downtime GROUP BY Spindle_Speed_RPM ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Voltage_volts FROM downtime GROUP BY Voltage_volts ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Torque_Nm FROM downtime GROUP BY Torque_Nm ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Cutting_kN FROM downtime GROUP BY Cutting_kN ORDER BY COUNT(*) DESC LIMIT 1;


#Second Moment Business Decision
#Variance
SELECT VAR_SAMP(Hydraulic_Pressure_bar) AS Variance_Hydraulic_Pressure_bar,
VAR_SAMP(Coolant_Pressure_bar) as Variance_Coolant_Pressure_bar,
VAR_SAMP(Air_System_Pressure_bar) as Variance_Air_System_Pressure_bar,
VAR_SAMP(Coolant_Temperature) as Variance_Coolant_Temperature,
VAR_SAMP(Hydraulic_Oil_Temperature_C) as Variance_Hydraulic_Oil_Temperature_C,
VAR_SAMP(Spindle_Bearing_Temperature_C) as Variance_Spindle_Bearing_Temperature_C,
VAR_SAMP(Spindle_Vibration) as Variance_Spindle_Vibration,
VAR_SAMP(Tool_Vibration) as Variance_Tool_Vibration,
VAR_SAMP(Spindle_Speed_RPM) as Variance_Spindle_Speed_RPM,
VAR_SAMP(Voltage_volts) as Variance_Voltage_volts,
VAR_SAMP(Torque_Nm) as Variance_Torque_Nm,
VAR_SAMP(Cutting_kN) as Variance_Cutting_kN
FROM downtime;

#Standard Deviation

SELECT STDDEV(Hydraulic_Pressure_bar) AS Stddev_Hydraulic_Pressure_bar,
STDDEV(Coolant_Pressure_bar) as Stddev_Coolant_Pressure_bar,
STDDEV(Air_System_Pressure_bar) as Stddev_Air_System_Pressure_bar,
STDDEV(Coolant_Temperature) as Stddev_Coolant_Temperature,
STDDEV(Hydraulic_Oil_Temperature_C) as Stddeve_Hydraulic_Oil_Temperature_C,
STDDEV(Spindle_Bearing_Temperature_C) as Stddeve_Spindle_Bearing_Temperature_C,
STDDEV(Spindle_Vibration) as Stddeve_Spindle_Vibration,
STDDEV(Tool_Vibration) as Stddeve_Tool_Vibration,
STDDEV(Spindle_Speed_RPM) as Stddeve_Spindle_Speed_RPM,
STDDEV(Voltage_volts) as Stddeve_Voltage_volts,
STDDEV(Torque_Nm) as Stddeve_Torque_Nm,
STDDEV(Cutting_kN) as Stddeve_Cutting_kN
FROM downtime;

#Range (Min - Max) 
SELECT 
    MAX(Hydraulic_Pressure_bar) - MIN(Hydraulic_Pressure_bar) AS range_Hydraulic_Pressure_bar,
    MAX(Coolant_Pressure_bar) - MIN(Coolant_Pressure_bar) AS range_Coolant_Pressure_bar,
    MAX(Air_System_Pressure_bar) - MIN(Air_System_Pressure_bar) AS range_Air_System_Pressure_bar,
    MAX(Coolant_Temperature) - MIN(Coolant_Temperature) AS range_Coolant_Temperature,
    MAX(Hydraulic_Oil_Temperature_C) - MIN(Hydraulic_Oil_Temperature_C) AS range_Hydraulic_Oil_Temperature_C,
    MAX(Spindle_Bearing_Temperature_C) - MIN(Spindle_Bearing_Temperature_C) AS range_Spindle_Bearing_Temperature_C,
    MAX(Spindle_Vibration) - MIN(Spindle_Vibration) AS range_Spindle_Vibration,
    MAX(Tool_Vibration) - MIN(Tool_Vibration) AS range_Tool_Vibration,
    MAX(Spindle_Speed_RPM) - MIN(Spindle_Speed_RPM) AS range_Spindle_Speed_RPM,
    MAX(Voltage_volts) - MIN(Voltage_volts) AS range_Voltage_volts,
    MAX(Torque_Nm) - MIN(Torque_Nm) AS range_Torque_Nm,
    MAX(Cutting_kN) - MIN(Cutting_kN) AS range_Cutting_kN
FROM downtime;

#Third moment business decision
SELECT
    COUNT(*) AS n,
    AVG(Cutting_kN) AS mean,
    STDDEV(Cutting_kN) AS stddev,
    SUM(POWER(Cutting_kN - (SELECT AVG(Cutting_kN) FROM downtime), 3)) / 
    (COUNT(*) * POWER((SELECT STDDEV(Cutting_kN) FROM downtime), 3)) AS skewness
FROM downtime;

#Fourth moment business decision
SELECT
    COUNT(*) AS n,
    AVG(Hydraulic_Pressure_bar) AS mean,
    STDDEV(Hydraulic_Pressure_bar) AS stddev,
    SUM(POWER(Hydraulic_Pressure_bar - (SELECT AVG(Hydraulic_Pressure_bar) FROM downtime), 4)) / 
    (COUNT(*) * POWER((SELECT STDDEV(Hydraulic_Pressure_bar) FROM downtime), 4)) AS kurtosis
FROM downtime;

#Categorical Column
#Mode (Most frequent value)
SELECT Machine_ID FROM downtime GROUP BY Machine_ID ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Assembly_Line_No FROM downtime GROUP BY Assembly_Line_No ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Downtime FROM downtime GROUP BY Downtime ORDER BY COUNT(*) DESC LIMIT 1;





