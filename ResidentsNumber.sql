--SELECT * FROM Common_Estate WHERE Active = 1;
--SELECT * FROM Common_Street WHERE Active = 1 ORDER BY Name;

--Ile mieszkañców na danej ulicy. Ulica/Miasto/Ile mieszkañców. Tylko Active = 1. 31-12-2021

--SELECT Common_Street.Name, Common_Street.City, SUM(Common_Estate.ResidentsNo) AS ResidentsNo 
--FROM Common_Street INNER JOIN Common_Estate ON Common_Street.Code = Common_Estate.StreetCode 
--WHERE Common_Street.Active = 1 AND Common_Estate.Active = 1 
--GROUP BY Common_Street.Name, Common_Street.City
--ORDER BY Common_Street.Name;


SELECT 
(SELECT Common_Street.Name FROM Common_Street WHERE Common_Street.Code = Common_Estate.StreetCode AND Common_Street.Active = 1) AS Name, 
(SELECT Common_Street.City FROM Common_Street WHERE Common_Street.Code = Common_Estate.StreetCode AND Common_Street.Active = 1) AS City, 
SUM(Common_Estate.ResidentsNo) AS ResidentsNo

FROM Common_Estate 
WHERE Common_Estate.DateFrom < '2021-12-31 00:00:00.000' AND Common_Estate.DateTo > '2021-12-31 23:59:59.000'
GROUP BY Common_Estate.StreetCode
ORDER BY Name;