USE ecomedia_tychy

SELECT * FROM Vindication_WritingType WHERE Symbol = 'UP' AND Active = 1
SELECT TOP 10 * FROM Settlement_SettlementHeader where Type = 'K'
SELECT * FROM Settlement_SettlementOperation WHERE TypeOfPayment is not null

SELECT TOP 1 * FROM Vindication_WritingPosition

SELECT TOP 10 * FROM Settlement_SettlementHeader where Type = 'K'

SELECT * FROM Writing_Box WHERE Id = 8283
SELECT * FROM Vindication_WritingHeader WHERE WritingBoxId = 8283
SELECT * FROM Vindication_WritingPosition WHERE WritingHeaderId = 12
SELECT * FROM Settlement_SettlementHeader WHERE Id = 939
SELECT * FROM Settlement_SettlementHeader WHERE RegistryNo = 1906 order by DocumentNo
--SELECT * FROM Settlement_SettlementOperation WHERE SettlementHeaderId = 939
SELECT * FROM Vindication_WritingType WHERE Id = 13
SELECT SystemSymbol FROM Settlement_SettlementHeader GROUP BY SystemSymbol



CREATE OR ALTER TRIGGER	Settlement_Vindication
ON Writing_Box
AFTER UPDATE
AS
BEGIN
	IF UPDATE(DeliveryDate)
	BEGIN
		DECLARE @WritingBoxId int = (SELECT Id FROM INSERTED)
		DECLARE @CustomerCode int = (SELECT CustomerCode FROM Writing_Box WHERE Id = @WritingBoxId)
		DECLARE @WritingHeaderId int = (SELECT Id FROM Vindication_WritingHeader WHERE WritingBoxId = @WritingBoxId)
		DECLARE @DocumentNo varchar(50) = CONVERT(varchar, YEAR(GETDATE())) + '/' + CONVERT(varchar, 9319) + '/'
		DECLARE @No varchar(10) = (SELECT TOP 1 SUBSTRING(DocumentNo, CHARINDEX('/',DocumentNo,CHARINDEX('/',DocumentNo)+1)+1, 2) FROM Settlement_SettlementHeader WHERE DocumentNo LIKE @DocumentNo+'%' ORDER BY DocumentNo DESC)
		SET @DocumentNo = @DocumentNo + CONVERT(varchar, CONVERT(int, @No)+1)
		INSERT INTO Settlement_SettlementHeader (DocumentNo, Type, SystemSymbol, IssueDate, PaymentDate, WN, MA, CustomerCode) VALUES (@DocumentNo, 'K', 'S', GETDATE(), GETDATE(), 0.00, 0.00, @CustomerCode)
		DECLARE @SettlementHeaderId int = (SELECT TOP 1 Id FROM Settlement_SettlementHeader WHERE DocumentNo = @DocumentNo)
		INSERT INTO Settlement_SettlementOperation (SettlementHeaderId, SystemSymbol, WN, MA, Account, OperationDate, PaymentDate, CustomerCode, IsValid, Actual) VALUES(@SettlementHeaderId, 'S', 16.00, 0.00, '221000019000000', GETDATE(), GETDATE(), @CustomerCode, 1, 1)
		INSERT INTO Vindication_WritingPosition (WritingHeaderId, PositionNo, SettlementHeaderId) VALUES(@WritingHeaderId, (SELECT MAX(PositionNo) FROM Vindication_WritingPosition WHERE WritingHeaderId = @WritingHeaderId)+1, @SettlementHeaderId)
	END
END



SELECT * FROM Writing_Box WHERE Id = 8283
SELECT * FROM Settlement_SettlementHeader WHERE Id = (SELECT MAX(Id) FROM Settlement_SettlementHeader)
SELECT * FROM Settlement_SettlementOperation WHERE SettlementHeaderId = (SELECT MAX(Id) FROM Settlement_SettlementHeader)
SELECT * FROM Vindication_WritingPosition WHERE SettlementHeaderId = (SELECT MAX(Id) FROM Settlement_SettlementHeader)
UPDATE Writing_Box SET DeliveryDate = null WHERE Id = 8283
DELETE FROM Settlement_SettlementOperation WHERE SettlementHeaderId = (SELECT MAX(Id) FROM Settlement_SettlementHeader)
DELETE FROM Vindication_WritingPosition WHERE SettlementHeaderId = (SELECT MAX(Id) FROM Settlement_SettlementHeader)
DELETE FROM Settlement_SettlementHeader WHERE Id = (SELECT MAX(Id) FROM Settlement_SettlementHeader)

SELECT Id FROM Vindication_WritingHeader WHERE WritingBoxId = 8283
SELECT WritingHeaderId, PositionNo, SettlementHeaderId FROM Vindication_WritingPosition WHERE WritingHeaderId = 2