use[eMedia_KJ];

DROP VIEW IF EXISTS View_Common_Address;

GO
CREATE VIEW View_Common_Address AS
SELECT 
Common_Customer.Code,
Common_Customer.Name,
Common_Customer.Nip,
Common_Customer.Regon,
Common_Street.City,
Common_Street.Commune,
Common_Street.Region,
Common_Street.Country,
Common_Street.PostCity,
Common_Street.PostCode,
Common_Customer.HouseNo,
Common_Customer.LocalNo,
CONCAT('ul.',Common_Street.Name,' ',IIF(ISNULL(Common_Customer.LocalNo,'') = '',Common_Customer.HouseNo+', ',IIF(ISNULL(Common_Customer.HouseNo,'') = '',Common_Customer.LocalNo+', ',Common_Customer.HouseNo+'/'+Common_Customer.LocalNo+', ')),IIF(ISNULL(Common_Street.PostCode,'') = '','',Common_Street.PostCode+', '),Common_Street.PostCity) AS Addres,
Common_AddressTeryt.Id,
'K' AS Rodzaj,
IIF(Common_Street.TerytId = NULL, 'T', 'N') AS Status
FROM Common_Customer LEFT OUTER JOIN 
Common_Street ON Common_Street.Code = Common_Customer.StreetCode LEFT OUTER JOIN
Common_AddressTeryt ON Common_AddressTeryt.Id = Common_Street.TerytId
WHERE Common_Customer.Active = 1 AND Common_Street.Active = 1

UNION

SELECT 
Common_Estate.Code,
Common_Estate.Name,
'' AS Nip,
'' AS Regon,
Common_Street.City,
Common_Street.Commune,
Common_Street.Region,
Common_Street.Country,
Common_Street.PostCity,
Common_Street.PostCode,
Common_Estate.HouseNo,
Common_Estate.LocalNo,
CONCAT('ul.',Common_Street.Name,' ',IIF(ISNULL(Common_Estate.LocalNo,'') = '',Common_Estate.HouseNo+', ',IIF(ISNULL(Common_Estate.HouseNo,'') = '',Common_Estate.LocalNo+', ',Common_Estate.HouseNo+'/'+Common_Estate.LocalNo+', ')),IIF(ISNULL(Common_Street.PostCode,'') = '','',Common_Street.PostCode+', '),Common_Street.PostCity) AS Addres,
Common_AddressTeryt.Id,
'L' AS Rodzaj,
IIF(Common_Street.TerytId = NULL, 'T', 'N') AS Status
FROM Common_Estate LEFT OUTER JOIN 
Common_Street ON Common_Street.Code = Common_Estate.StreetCode LEFT OUTER JOIN
Common_AddressTeryt ON Common_AddressTeryt.Id = Common_Street.TerytId
WHERE Common_Estate.Active = 1 AND Common_Street.Active = 1;

--SELECT * FROM View_Common_Address;

--UPDATE Common_Street SET PostCode = '00-000' WHERE Id<800;