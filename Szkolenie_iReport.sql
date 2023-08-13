--USE ecomedia_tychy
SELECT * FROM Writing_Template where Id in (26,28,30,55,59,61,66,72,140)
--SELECT * FROM Writing_Box

USE ecomedia_tychy
SELECT WT.Id as Szablon_Id, WT.Symbol, COUNT(Wb.Id) as Count_use, MAX(Wb.WritingDate) as Last_use
FROM Writing_Box WB right join Writing_Template WT ON WB.TemplateId = WT.Id
WHERE WB.WritingDate > '2020-01-01 00:00:00.000'
GROUP BY WT.Id, WT.Symbol
ORDER BY count_use DESC;

select TOP 50 * from Writing_Box;
select TOP 50 * from Writing_Template;

SELECT TOP 50 WT.Symbol, WT.Name, WB.WritingDate, WB.RegistryNo, CC.Active
FROM Writing_Box WB inner join Writing_Template WT ON WB.TemplateId = WT.Id, Common_Customer CC inner join Writing_Box ON CC.Code = Writing_Box.CustomerCode
WHERE WB.WritingDate > '2020-01-01 00:00:00.000' AND WB.WritingDate < '2022-01-01 00:00:00.000'
ORDER BY WB.WritingDate;


SELECT * FROM Writing_Template
SELECT * FROM Common_Customer


DECLARE @dateFrom varchar(20) = ISNULL($P{DATE_FROM}, (CONVERT(date, (SELECT TOP 1 min(WritingDate) FROM Writing_Box), 111)))
DECLARE @dateTo varchar(20) = ISNULL($P{DATE_TO}, (CONVERT(date, (SELECT TOP 1 max(WritingDate) FROM Writing_Box), 111)))
DECLARE @order varchar(10) = ISNULL($P{ORDER_BY}, '0')
DECLARE @desc varchar(10) = ISNULL($P{DESC}, 0)
DECLARE @limit int = ISNULL($P{LIMIT_NO}, 0)
SELECT
     TOP (@limit)
     WT."Symbol",
     WT."Name",
     WB."WritingDate",
     WB."RegistryNo",
     (SELECT Name FROM Common_Customer WHERE Common_Customer.Code = WB."CustomerCode" AND Common_Customer.Active = 1) AS Customer_Name,
     @dateFrom as DATE_FROM,
     @dateTo as DATE_TO
FROM
     "Writing_Box" WB INNER JOIN "Writing_Template" WT ON WB."TemplateId" = WT."Id"
WHERE
     WB.WritingDate > @dateFrom
 AND WB.WritingDate < @dateTo
 AND WB.CustomerCode >= $P{CUSTOMER_CODE_FROM}
 AND WB.CustomerCode <= $P{CUSTOMER_CODE_TO}
ORDER BY
     CASE WHEN @order=1 AND @desc=1 THEN WT.Symbol END DESC,
     CASE WHEN @order=1 AND @desc=0 THEN WT.Symbol END,
     CASE WHEN @order=2 AND @desc=1 THEN WT.Name END DESC,
     CASE WHEN @order=2 AND @desc=0 THEN WT.Name END,
     CASE WHEN @order=3 AND @desc=1 THEN WB.RegistryNo END DESC,
     CASE WHEN @order=3 AND @desc=0 THEN WB.RegistryNo END,
     CASE WHEN @order=4 AND @desc=1 THEN WB.WritingDate END DESC,
     CASE WHEN @order=4 AND @desc=0 THEN WB.WritingDate END,
     CASE WHEN @order=5 AND @desc=1 THEN WB.CustomerCode END DESC,
     CASE WHEN @order=5 AND @desc=0 THEN WB.CustomerCode END


