SELECT TOP (1000) [User ID]
      ,[Device Type]
      ,[Usage Hours Per Day]
      ,[Energy Consumption]
      ,[User Preferences]
      ,[Malfunction Incidents]
      ,[Device Age]
      ,[Smart Home Efficiency]
  FROM [SmartHomeData].[dbo].[smart_home_device_usage]


EXEC sp_rename 'smart_home_device_usage.UserID', 'User ID', 'COLUMN';
 EXEC sp_rename 'smart_home_device_usage.DeviceType', 'Device Type', 'COLUMN';
EXEC sp_rename  'smart_home_device_usage.UsageHoursPerDay', 'Usage Hours Per Day', 'COLUMN';
EXEC sp_rename 'smart_home_device_usage.EnergyConsumption', 'Energy Consumption', 'COLUMN';
EXEC  sp_rename 'smart_home_device_usage.UserPreferences', 'User Preferences', 'COLUMN';
EXEC sp_rename 'smart_home_device_usage.MalfunctionIncidents' , 'Malfunction Incidents', 'COLUMN';
EXEC sp_rename  'smart_home_device_usage.DeviceAgeMonths' , 'Device Age', 'COLUMN';
EXEC sp_rename 'smart_home_device_usage.SmartHomeEfficiency' , 'Smart Home Efficiency', 'COLUMN';

  UPDATE smart_home_device_usage
SET DeviceType = 
    CASE 
        WHEN DeviceType = 'Smart Speaker' THEN 'Smart Lock'
        WHEN DeviceType = 'Camera' THEN 'Outdoor Camera Pro'
        WHEN DeviceType = 'Security System' THEN 'Doorbell Camera Pro'
        WHEN DeviceType = 'Thermostat' THEN 'Smart Thermosta'
        ELSE DeviceType -- Retain other values unchanged
    END
WHERE DeviceType IN ('Smart Speaker', 'Camera', 'Security System', 'Thermostat');

--LOOKING FOR NULL/ MISSING VALUES VALUES
SELECT [Usage Hours Per Day], COUNT(*) FROM smart_home_device_usage
GROUP BY [Usage Hours Per Day]
HAVING COUNT(*) > 1
ORDER BY [Usage Hours Per Day] DESC 

SELECT COUNT(*) FROM 


SELECT *
FROM smart_home_device_usage
WHERE 
    [User ID] IS NULL
    OR [Device Type] IS NULL
    OR [Usage Hours Per Day] IS NULL
    OR [Energy Consumption] IS NULL
    OR [User Preferences] IS NULL
    OR [Malfunction Incidents] IS NULL
    OR [Device Age] IS NULL
    OR [Smart Home Efficiency] IS NULL;

-- CHECKING FOR DUPLICATES
SELECT [User ID], [Device Type], [Usage Hours Per Day], [Energy Consumption], 
       [User Preferences], [Malfunction Incidents], [Device Age], [Smart Home Efficiency],
       COUNT(*) AS DuplicateCount
FROM smart_home_device_usage
GROUP BY [User ID], [Device Type], [Usage Hours Per Day], [Energy Consumption], 
         [User Preferences], [Malfunction Incidents], [Device Age], [Smart Home Efficiency]
HAVING COUNT(*) > 1;
