use[eMedia_KJ];

DECLARE @Street varchar(100), @LocalNo varchar(100),@HouseNo varchar(100),@PostCode varchar(100),@PostCity varchar(100),@num int
SET @num = 17

SET @Street = (SELECT TOP 1 Name FROM Common_Street WHERE Code = @num AND Active = 1)
SET @LocalNo = (SELECT TOP 1 LocalNo FROM Common_Customer WHERE StreetCode = @num AND Active = 1 )
SET @HouseNo = (SELECT TOP 1 HouseNo FROM Common_Customer WHERE StreetCode = @num AND Active = 1 )
SET @PostCode = (SELECT TOP 1 PostCode FROM Common_Street WHERE Code = @num AND Active = 1)
SET @PostCity = (SELECT TOP 1 PostCity FROM Common_Street WHERE Code = @num AND Active = 1)

exec('SELECT CONCAT(''ul.'','''+@street+''','' '',IIF(ISNULL('''+@LocalNo+''','''') = '''','''+@HouseNo+'''+'', '',IIF(ISNULL('''+@HouseNo+''','''') = '''','''+@LocalNo+'''+'', '','''+@HouseNo+'''+''/''+'''+@LocalNo+'''+'', '')),IIF(ISNULL('''+@PostCode+''','''') = '''','''','+@PostCode+'+'', ''),'''+@PostCity+''')')

SELECT TOP 1 Common_Street.Name,LocalNo,HouseNo,PostCode,PostCity FROM Common_Street INNER JOIN Common_Customer ON Common_Street.Code = Common_Customer.StreetCode WHERE Common_Street.Code = @num AND Common_Street.Active = 1