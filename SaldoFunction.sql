
SELECT
	SUM(S_SO.WN-S_SO.MA) as WINIEN,
	S_SO.SettlementHeaderId
FROM
	Settlement_SettlementOperation S_SO
GROUP BY
	S_SO.SettlementHeaderId
HAVING
	SUM(S_SO.WN-S_SO.MA) > 0
ORDER BY
	S_SO.SettlementHeaderId

-- Kod klienta i datê. Zaleg³oœæ na dany dzieñ
-- SELECT * FROM Settlement_SettlementOperation WHERE SettlementHeaderId is NOT NULL AND SettlementHeaderId = 713 ORDER BY SettlementHeaderId
-- SELECT * FROM Settlement_SettlementOperation WHERE SettlementHeaderId is NOT NULL AND CustomerCode = 60 ORDER BY SettlementHeaderId
DROP FUNCTION dbo.saldoFunction
GO

CREATE FUNCTION dbo.saldoFunction(
	@CustomerCode INT,
	@Date date
)
RETURNS TABLE
AS
RETURN(
	SELECT SUM(SUM_WN) - SUM(SUM_MA) as SALDO
	FROM (
		SELECT SSO.SettlementHeaderId,
			SUM(SSO.WN) SUM_WN,
			SUM(SSO.MA) SUM_MA
		FROM Settlement_SettlementOperation SSO 
		WHERE SSO.OperationDate <= @Date AND SSO.CustomerCode = @CustomerCode AND SSO.PaymentDate < @Date
		GROUP BY SSO.SettlementHeaderId) as SSO
	WHERE SUM_WN>SUM_MA
	HAVING SUM(SUM_WN) > SUM(SUM_MA))


GO
select * from dbo.saldoFunction(4, '2023-05-05')


SELECT 
SUM(SUM_WN), SUM(SUM_MA)
FROM (SELECT 
		SSO.SettlementHeaderId SHId,
		SUM(SSO.WN) SUM_WN,
		SUM(SSO.MA) SUM_MA
		FROM Settlement_SettlementOperation SSO 
		WHERE SSO.OperationDate <= '2019-05-05' AND SSO.CustomerCode = 3 AND SSO.PaymentDate < '2019-05-05'
		GROUP BY SSO.SettlementHeaderId) as SSO
WHERE SUM_WN>SUM_MA
HAVING SUM(SUM_WN) > SUM(SUM_MA)