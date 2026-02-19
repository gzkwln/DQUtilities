USE [WRKDQUtilities]
GO
/****** Object:  UserDefinedFunction [dbo].[GetConfigStatus]    Script Date: 2/12/2026 5:13:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   FUNCTION [dbo].[GetConfigStatus]
(
	@System nvarchar(20),
	@LookUpName nvarchar(40),
	@SourceTable nvarchar(50),
	@SourceValue nvarchar(50)
)
RETURNS nvarchar(20)
	--WITH SCHEMABINDING, RETURNS NULL ON NULL INPUT
AS
BEGIN
	DECLARE @status nvarchar(20) 
	select @status = DQActive from DQ_ConfigLookup where [System]=@system and LookUpName=@LookUpName and SourceTable=@SourceTable and SourceValue=@SourceValue

	

	RETURN (@status);
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetJoinCondition]    Script Date: 2/12/2026 5:13:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetJoinCondition]
(
    @LeftTable NVARCHAR(128),
    @RightTable NVARCHAR(128)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @JoinCondition NVARCHAR(MAX) = '';
    -- Loop through the join conditions table to dynamically form the SQL JOIN condition
    SELECT @JoinCondition = STRING_AGG(
            CONCAT( l.lefttable, '.', l.field_a, ' = ', l.righttable, '.', l.field_b), 
            ' AND '
        ) WITHIN GROUP (ORDER BY priority)
    FROM [webSystemTypes_TableRelationshipsHor] l
    WHERE l.lefttable = @LeftTable
      AND l.righttable = @RightTable;
 
    RETURN @JoinCondition;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetViewColumnCount]    Script Date: 2/12/2026 5:13:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetViewColumnCount](@ViewName NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
    DECLARE @ColumnCount INT;
 
    -- Check if the view exists
    IF EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.VIEWS
        WHERE TABLE_NAME = @ViewName
    )
    BEGIN
        -- Get the column count
        SELECT @ColumnCount = COUNT(*)
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @ViewName;
    END
    ELSE
    BEGIN
        -- Return 0 if the view does not exist
        SET @ColumnCount = 0;
    END
 
    RETURN @ColumnCount;
END;

GO
/****** Object:  UserDefinedFunction [dbo].[webGetDatatypeForTable]    Script Date: 2/12/2026 5:13:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[webGetDatatypeForTable](@Dataset nvarchar(200), @Field nvarchar(200))
returns nvarchar(200)
as
begin

declare @result nvarchar(200)
select @result=
case when Data_type='nvarchar' then Data_type +'('+cast(CHARACTER_MAXIMUM_LENGTH as nvarchar)+')'
	when Data_type='decimal' then DATA_TYPE+'('+cast(NUMERIC_PRECISION as nvarchar)+','+cast(NUMERIC_SCALE as nvarchar)+')'
	when DATA_TYPE='INT' then DATA_TYPE
	--Add as required
	else 'nvarchar(256)' end
 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME=@Dataset and COLUMN_NAME=@field


return @result

end
GO
