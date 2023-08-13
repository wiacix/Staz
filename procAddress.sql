use[eMedia_KJ];

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE procAddress @num int
AS
BEGIN
DECLARE @Street varchar(100), @LocalNo varchar(100),@HouseNo varchar(100),@PostCode varchar(100),@PostCity varchar(100)

SET @Street = (SELECT TOP 1 Name FROM Common_Street WHERE Code = @num AND Active = 1)
SET @LocalNo = (SELECT TOP 1 LocalNo FROM Common_Customer WHERE StreetCode = @num AND Active = 1 )
SET @HouseNo = (SELECT TOP 1 HouseNo FROM Common_Customer WHERE StreetCode = @num AND Active = 1 )
SET @PostCode = (SELECT TOP 1 PostCode FROM Common_Street WHERE Code = @num AND Active = 1)
SET @PostCity = (SELECT TOP 1 PostCity FROM Common_Street WHERE Code = @num AND Active = 1)

exec('SELECT CONCAT(''ul.'','''+@street+''','' '',IIF(ISNULL('''+@LocalNo+''','''') = '''','''+@HouseNo+'''+'', '',IIF(ISNULL('''+@HouseNo+''','''') = '''','''+@LocalNo+'''+'', '','''+@HouseNo+'''+''/''+'''+@LocalNo+'''+'', '')),IIF(ISNULL('''+@PostCode+''','''') = '''','''','+@PostCode+'+'', ''),'''+@PostCity+''')')

END

--EXEC procAddress @num = 12