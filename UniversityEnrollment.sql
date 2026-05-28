DECLARE @TableName NVARCHAR(255)
DECLARE @SQL NVARCHAR(MAX)

DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

OPEN table_cursor

FETCH NEXT FROM table_cursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = '
    PRINT ''===== ' + @TableName + ' =====''
    SELECT TOP 5 * FROM [' + @TableName + ']'

    EXEC(@SQL)

    FETCH NEXT FROM table_cursor INTO @TableName
END

CLOSE table_cursor
DEALLOCATE table_cursor
GO