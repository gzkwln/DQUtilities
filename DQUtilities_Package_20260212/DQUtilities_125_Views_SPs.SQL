USE [WRKDQUtilities]
GO
/****** Object:  View [dbo].[ztSAPTableList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[ztSAPTableList]
 AS SELECT T.name AS Table_Name ,
       C.name AS Column_Name ,
       P.name AS Data_Type ,
       C.max_length AS Size ,
       CAST(P.precision AS VARCHAR) + '/' + CAST(P.scale AS VARCHAR) AS Precision_Scale
FROM   [SRCSAPECCDEMO].sys.objects AS T
       JOIN [SRCSAPECCDEMO].sys.columns AS C ON T.object_id = C.object_id
       JOIN [SRCSAPECCDEMO].sys.types AS P ON C.system_type_id = P.system_type_id
	   where T.type = 'U'
GO
/****** Object:  View [dbo].[webSAPTableList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webSAPTableList] AS
Select Distinct Table_Name From ztSAPTableList
GO
/****** Object:  View [dbo].[webSAPFieldList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webSAPFieldList] AS 
Select Distinct Table_Name,Column_Name From ztSAPTableList
GO
/****** Object:  View [dbo].[webDataSetTableList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE view [dbo].[webDataSetTableList]      
as      
select A.DataSetID,DatasetName,DatasetTableID,A.TableID,TableName from Dataset_Tables A inner join AvailableTables B on A.TableID=B.TableID
left outer join Dataset_master on A.DatasetID=Dataset_master.DatasetID
GO
/****** Object:  View [dbo].[webDataSetTable_ColumnList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataSetTable_ColumnList]  
as  
  select DatasetID, DatasetName, 
         DataSetTableID,  
         A.TableId,  
         ColumnID,  
         ColumnName  
  from   webdatasettablelist A  
         inner join TableColumns B  
                 on A.TableID = B.TableID  
  where  Active = 1 
GO
/****** Object:  View [dbo].[WebAccountGroup_VendorCustomer_Config_MasterData_Hor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[WebAccountGroup_VendorCustomer_Config_MasterData_Hor]
as
select 'Vendor' as Category,LIFNR as Number,LAND1,NAME1,NAME2,ORT01,PSTLZ,REGIO,MCOD1,KTOKK as AccountGroup from [srcSAPECCIDS900]..LFA1
union all
select 'Customer' as Category,KUNNR as Number,LAND1,NAME1,NAME2,ORT01,PSTLZ,REGIO,MCOD1,KTOKD as AccountGroup from [srcSAPECCIDS900]..KNA1
GO
/****** Object:  View [dbo].[WebAccountGroup_VendorCustomer_Config_MasterData_Summary]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[WebAccountGroup_VendorCustomer_Config_MasterData_Summary]
as
select Category,AccountGroup,count(*) as [#Records] from WebAccountGroup_VendorCustomer_Config_MasterData_Hor
group by Category,AccountGroup
GO
/****** Object:  View [dbo].[webAccountGroup_VendorCustomer_ConfigHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webAccountGroup_VendorCustomer_ConfigHor]
as
  select -- [Platform],
       --  A.SourcesystemID,
         A.Category,
         /*[Platform] +*/ A.AccountGroup as [Key],
         A.AccountGroup,
         TXT30,--[Missing in Source], 
         case
           when [Missing in Source] = 1 then '393da3e0-b2e2-4cb1-956c-619a8e043e34'
           else '29a732d4-59b4-4d76-8bbe-565312e2d2a3'
         end                       as AvailabilityStatus,
         [Account Group - Type],
         [Account Group - Group],
         [DPAAS Group],
         A.Active,
         ActiveForMatch,
         MatchScenario,
         Comments,
         [S/4 Obsolete Scope],
         [Obsolete Account Group],
         [MDG Scope],
         NULL                      as Refresh,
		 isnull([#Records],0) as [#Records],
         A.ChangedBy,
         A.ChangedOn,
         A.ChangedVia,
         A.boaStatus
  from   AccountGroup_VendorCustomer_Config A
       --  inner join dswHarmonization..ztSources B
        --         on A.SourcesystemID = B.[Name] 
				 left outer join WebAccountGroup_VendorCustomer_Config_MasterData_Summary C on /*A.SourcesystemID=C.SourcesystemID and */A.Category=C.Category and A.AccountGroup=C.AccountGroup
GO
/****** Object:  View [dbo].[boaColumnList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaColumnList] AS 

SELECT	sys.objects.name AS TableName,
		sys.columns.name AS ColumnName,
		sys.columns.column_id AS ColOrder,
		sys.objects.type
FROM	sys.columns INNER JOIN sys.objects ON sys.columns.object_id = sys.objects.object_id
WHERE   (sys.objects.type IN ('U', 'V'))
GO
/****** Object:  View [dbo].[boaObjectList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaObjectList] AS 

SELECT	[name],
		[type]
FROM	[sys].[objects]
WHERE	[type] IN ('U', 'V', 'FN', 'P')
GO
/****** Object:  View [dbo].[boaProcedureList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaProcedureList] AS 

SELECT	name as [name]
FROM	sys.procedures
GO
/****** Object:  View [dbo].[boaSqlList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaSqlList] AS 

SELECT	sys.objects.name,
		sys.objects.type AS xtype,
		sys.sql_modules.definition AS SQL
FROM	sys.sql_modules INNER JOIN
		sys.objects ON sys.sql_modules.object_id = sys.objects.object_id
WHERE	sys.objects.type IN ('V', 'FN', 'P')
GO
/****** Object:  View [dbo].[boaTableAndViewList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaTableAndViewList] AS 

SELECT  [name],
        rtrim(type) AS [xtype]
FROM    sys.objects
WHERE   [type] IN ('U', 'V')
GO
/****** Object:  View [dbo].[boaTableList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaTableList] AS 

SELECT	name as [Name]
FROM	sys.tables
GO
/****** Object:  View [dbo].[boaUDFList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaUDFList] AS 

  SELECT ROUTINE_NAME AS name
  FROM   INFORMATION_SCHEMA.ROUTINES
  WHERE  ROUTINE_Type = 'FUNCTION'
GO
/****** Object:  View [dbo].[boaViewList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[boaViewList] AS 

SELECT	name as [Name]
FROM	sys.views
GO
/****** Object:  View [dbo].[IV_CSM_001_KNB1_CustomerMaster_CompanyCode]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IV_CSM_001_KNB1_CustomerMaster_CompanyCode]
AS


SELECT A.KUNNR, 
[KTOKD],
[BUKRS],
[AKONT],
[ZWELS],
[ZTERM],
[VZSKZ],
[TOGRU],
[GUZTE]

FROM WRKDQPREP..[CM__KNA1_T] as a
LEFT OUTER JOIN  WRKDQPREP..[CM__KNB1_T] as b
on a.kunnr = b.kunnr
WHERE A.LOEVM = '' AND B.LOEVM = ''


GO
/****** Object:  View [dbo].[IV_CSM_002_KNA1_CustomerMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IV_CSM_002_KNA1_CustomerMaster] AS

SELECT
	[ttKNA1].MANDT AS MANDT,
	[ttKNA1].[KUNNR] AS [KUNNR],
	[ttKNA1].[NAME1] AS [NAME1],
	[ttKNA1].[KTOKD] AS [KTOKD],
--	[T077X].[TXT30] AS [TXT30],
	DQ_ConfigLookup.SourceValue AS [SourceValue],
	DQ_ConfigLookup.TargetValue AS [TargetValue],
	DQ_ConfigLookup.TargetValueDescription AS [TargetValueDescription],
	DQ_ConfigLookup.SourceValueDescription,
	[ttKNA1].[ADRNR] AS [ADRNR],
	[ttKNA1].[BBSNR] AS [BBSNR],
	[ttKNA1].[ERDAT] AS [ERDAT],
	[ttKNA1].[KUKLA] AS [KUKLA],
	[ttKNA1].[STCEG] AS [STCEG],
	[ttKNA1].[CIVVE] AS [CIVVE]
	
	
FROM srcSAPECCIDS900.dbo.[KNA1] AS [ttKNA1]
INNER JOIN [WRKDQUtilities].[dbo].[DQ_ConfigLookup] AS DQ_ConfigLookup
				--ON [ttKNA1].zSourceSystemID = DQ_ConfigLookup.SystemID
				ON  DQ_ConfigLookup.LookUpName = 'LKP_CUSTOMER_ACCGROUP'
				AND DQ_ConfigLookup.SourceField = 'KNA1.KTOKD'
				AND DQ_ConfigLookup.SourceValue	= [ttKNA1].[KTOKD]
				AND DQ_ConfigLookup.ProjectRule = 'ACTIVE'
 
--LEFT OUTER JOIN srcSAPECCIDS900.dbo.T077D_T077X] AS [T077X]
--				ON [ttKNA1].[zSourceSystemID] = [T077X].[SourceSystemID]
--				AND [ttKNA1].[KTOKD] = [T077X].[KTOKD]
 
WHERE ISNULL([ttKNA1].[LOEVM], '') = ''
	  --AND (DQ_ConfigLookup.TargetValue <> 'TBD' 
			--OR UPPER(DQ_ConfigLookup.TargetValue) <> UPPER('Out of Scope'))


GO
/****** Object:  View [dbo].[IV_CSM_901_KNB1_CustomerMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[IV_CSM_901_KNB1_CustomerMaster]
AS


SELECT A.KUNNR, 
A.NAME1,
A.SORTL,
A.PSTLZ,
A.STCD1,
A.STCD2


FROM WRKDQPREP..[CM__KNA1_T] as a
--LEFT OUTER JOIN  WRKDQPREP..[CM__KNB1_T] as b
--on a.kunnr = b.kunnr
WHERE A.LOEVM = '' --AND B.LOEVM = ''


GO
/****** Object:  View [dbo].[IV_CSM_902_KNA1_CustomerMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IV_CSM_902_KNA1_CustomerMaster] AS

SELECT
	[ttKNA1].[KUNNR] AS [KUNNR],
	[ttKNA1].[NAME1] AS [NAME1],
	[ttKNA1].[KTOKD] AS [KTOKD],
--	[T077X].[TXT30] AS [TXT30],
	--DQ_ConfigLookup.SourceValue AS [SourceValue],
	--DQ_ConfigLookup.TargetValue AS [TargetValue],
	--DQ_ConfigLookup.TargetValueDescription AS [TargetValueDescription],
	--DQ_ConfigLookup.SourceValueDescription,
	[ttKNA1].[ADRNR] AS [ADRNR],
	[ttKNA1].[TELF1] AS [TELF1],
	[ttKNA1].[MCOD1] AS [MCOD1]
	
	
FROM srcSAPECCIDS900.dbo.[KNA1] AS [ttKNA1]
--INNER JOIN [WRKDQUtilities].[dbo].[DQ_ConfigLookup] AS DQ_ConfigLookup
--				--ON [ttKNA1].zSourceSystemID = DQ_ConfigLookup.SystemID
--				ON  DQ_ConfigLookup.LookUpName = 'LKP_CUSTOMER_ACCGROUP'
--				AND DQ_ConfigLookup.SourceField = 'KNA1.KTOKD'
--				AND DQ_ConfigLookup.SourceValue	= [ttKNA1].[KTOKD]
--				AND DQ_ConfigLookup.ProjectRule = 'ACTIVE'
 
--LEFT OUTER JOIN srcSAPECCIDS900.dbo.T077D_T077X] AS [T077X]
--				ON [ttKNA1].[zSourceSystemID] = [T077X].[SourceSystemID]
--				AND [ttKNA1].[KTOKD] = [T077X].[KTOKD]
 
WHERE ISNULL([ttKNA1].[LOEVM], '') = ''
	  --AND (DQ_ConfigLookup.TargetValue <> 'TBD' 
			--OR UPPER(DQ_ConfigLookup.TargetValue) <> UPPER('Out of Scope'))


GO
/****** Object:  View [dbo].[IV_MAM_003_MARA_MaterialMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[IV_MAM_003_MARA_MaterialMaster] AS

SELECT
	[ttMARA].MANDT AS MANDT,
	[ttMARA].[MATNR] AS [MATNR],
	[ttMARA].[MTART] AS [MTART],
	DQ_ConfigLookup.SourceValue AS [SourceValue],
	DQ_ConfigLookup.TargetValue AS [TargetValue],
	DQ_ConfigLookup.TargetValueDescription AS [TargetValueDescription],
	DQ_ConfigLookup.SourceValueDescription,
	[ttMARA].[MATKL] AS [MATKL],
	[ttMARA].[BISMT] AS [BISMT],
	[ttMARA].[GEWEI] AS [GEWEI],
	[ttMARA].[VOLEH] AS [VOLEH],
	[ttMARA].[SPART] AS [SPART],
	[ttMARA].[PRDHA] AS [PRDHA]
	
	
FROM srcSAPECCIDS900.dbo.[MARA] AS [ttMARA]
INNER JOIN [WRKDQUtilities].[dbo].[DQ_ConfigLookup] AS DQ_ConfigLookup
				--ON [ttMARA].zSourceSystemID = DQ_ConfigLookup.SystemID
				ON  DQ_ConfigLookup.LookUpName = 'LKP_MATERIAL_TYPE'
				AND DQ_ConfigLookup.SourceField = 'MARA.MTART'
				AND DQ_ConfigLookup.SourceValue	= [ttMARA].[MTART]
				AND DQ_ConfigLookup.ProjectRule = 'ACTIVE'
 
--LEFT OUTER JOIN srcSAPECCIDS900.dbo.T077D_T077X] AS [T077X]
--				ON [ttMARA].[zSourceSystemID] = [T077X].[SourceSystemID]
--				AND [ttMARA].[MTART] = [T077X].[MTART]
 
WHERE ISNULL([ttMARA].[LVORM], '') = ''
	  --AND (DQ_ConfigLookup.TargetValue <> 'TBD' 
			--OR UPPER(DQ_ConfigLookup.TargetValue) <> UPPER('Out of Scope'))


GO
/****** Object:  View [dbo].[IV_MAM_903_MARA_MaterialMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE VIEW [dbo].[IV_MAM_903_MARA_MaterialMaster] AS  
  
SELECT  
 [ttMARA].MANDT AS MANDT,  
 [ttMARA].[MATNR] AS [MATNR],  
 [ttMARA].[MTART] AS [MTART],  
 --DQ_ConfigLookup.SourceValue AS [SourceValue],  
 --DQ_ConfigLookup.TargetValue AS [TargetValue],  
 --DQ_ConfigLookup.TargetValueDescription AS [TargetValueDescription],  
 --DQ_ConfigLookup.SourceValueDescription,  
 [ttMARA].[MATKL] AS [MATKL],  
 CAST([ttMARA].[BRGEW] AS NVARCHAR(50)) AS [BRGEW],  
 [ttMARA].[NTGEW] AS [NTGEW],  
 [ttMARA].[VOLUM] AS [VOLUM],  
 CAST([ttMARA].[MSTDE] AS NVARCHAR(50)) AS [MSTDE]  
   
   
FROM srcSAPECCIDS900.dbo.[MARA] AS [ttMARA]  
--INNER JOIN [WRKDQUtilities].[dbo].[DQ_ConfigLookup] AS DQ_ConfigLookup  
--    --ON [ttMARA].zSourceSystemID = DQ_ConfigLookup.SystemID  
--    ON  DQ_ConfigLookup.LookUpName = 'LKP_MATERIAL_TYPE'  
--    AND DQ_ConfigLookup.SourceField = 'MARA.MTART'  
--    AND DQ_ConfigLookup.SourceValue = [ttMARA].[MTART]  
--    AND DQ_ConfigLookup.ProjectRule = 'ACTIVE'  
   
--LEFT OUTER JOIN srcSAPECCIDS900.dbo.T077D_T077X] AS [T077X]  
--    ON [ttMARA].[zSourceSystemID] = [T077X].[SourceSystemID]  
--    AND [ttMARA].[MTART] = [T077X].[MTART]  
   
WHERE ISNULL([ttMARA].[LVORM], '') = ''  
   --AND (DQ_ConfigLookup.TargetValue <> 'TBD'   
   --OR UPPER(DQ_ConfigLookup.TargetValue) <> UPPER('Out of Scope'))  
  
  
GO
/****** Object:  View [dbo].[IV_VEM_001_LFA1_VendorMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IV_VEM_001_LFA1_VendorMaster]
AS
SELECT        ttLFA1.MANDT, ttLFA1.KUNNR, ttLFA1.NAME1, ttLFA1.LAND1, ttLFA1.LIFNR, ttLFA1.KTOKK, ttLFA1.LOEVM, ttLFA1.STCD1, ttLFA1.PSTLZ, ttLFA1.ORT01, ttLFA1.STRAS, ttLFA1.BEGRU, ttLFA1.ADRNR, ttLFA1.BBSNR, 
                         ttLFA1.ERDAT, ttLFA1.STCEG, DQ_ConfigLookup.SourceValue, DQ_ConfigLookup.TargetValue, DQ_ConfigLookup.TargetValueDescription, DQ_ConfigLookup.SourceValueDescription
FROM            srcSAPECCIDS900.dbo.LFA1 AS ttLFA1 INNER JOIN
                         dbo.DQ_ConfigLookup AS DQ_ConfigLookup ON DQ_ConfigLookup.LookUpName = 'LKP_VENDOR_ACCGROUP' AND DQ_ConfigLookup.SourceField = 'LFA1.KTOKK' AND 
                         DQ_ConfigLookup.SourceValue = ttLFA1.KTOKK AND DQ_ConfigLookup.ProjectRule = 'ACTIVE'
WHERE        (ISNULL(ttLFA1.LOEVM, N'') = '')
GO
/****** Object:  View [dbo].[IV_VEM_901_LFA1_VendorMaster]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* and DQ_ConfigLookup.TargetValue <> 'TBD'
 or UPPER (DQ_ConfigLookup.TargetValue) <> UPPER ('Out of Scope'))*/
CREATE VIEW [dbo].[IV_VEM_901_LFA1_VendorMaster]
AS
SELECT        MANDT, LIFNR, NAME1, LAND1, KTOKK, LOEVM, STCD1, PSTLZ, ORT01, STRAS, BEGRU, ADRNR, BBSNR, ERDAT, STCEG, TELF1
FROM            srcSAPECCIDS900.dbo.LFA1 AS ttLFA1
WHERE        (ISNULL(LOEVM, N'') = '')
GO
/****** Object:  View [dbo].[ObjectSummary_AttributeCounts]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[ObjectSummary_AttributeCounts]
as
SELECT 

    od.ObjectDataset,Child.[Group],

    COUNT(DISTINCT c.COLUMN_NAME) AS DistinctColumnCount

FROM 

    ObjectSummary od
	inner join ObjectSummary_Dataset child on od.ObjectDataset=child.ObjectDataset

JOIN 

    INFORMATION_SCHEMA.COLUMNS c

    ON c.TABLE_NAME = child.Dataset

GROUP BY 

    od.ObjectDataset,Child.[Group];

GO
/****** Object:  View [dbo].[web_Matrix_DQReporting_Completeness_Hor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[web_Matrix_DQReporting_Completeness_Hor]
AS
  SELECT [ReportingID],
         [DQReportGrouping],
         [Table],
         [Field],
         [Field Key],
         [FieldDescription],
		-- t3.SCRTEXT_L as [FieldDescription],
         [Active]
  from   [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness]
  --LEFT JOIN [dgMDG_S12_100_DPaaS].dbo.DD03L t2 ON [DQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].[Table] = t2.TABNAME and [DQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].FIELD = t2.FIELDNAME
  --LEFT JOIN [dgMDG_S12_100_DPaaS].dbo.DD04T t3 ON t2.ROLLNAME = t3.ROLLNAME AND t3.DDLANGUAGE = 'E'
GO
/****** Object:  View [dbo].[webAccountGroup_DQ_MappingHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[webAccountGroup_DQ_MappingHor]
as
select SourcesystemID,
KTOKD,
AccountGroupDescription,
KTOKD_Target,
TargetAccountGroupDescription from AccountGroup_DQ_Mapping
GO
/****** Object:  View [dbo].[webAvailableTables_List]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webAvailableTables_List]
as
select TableID,DatabaseName+' - '+TableName as TableName from availabletables
GO
/****** Object:  View [dbo].[webAvailableTablesHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webAvailableTablesHor]
as
select TableID,DatabaseName,TableName,DisplayName,IsActive, Null as GetFields, Null as Fields from availabletables
GO
/****** Object:  View [dbo].[webConfig_MaterialTypeMappingHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[webConfig_MaterialTypeMappingHor]
as
select SourceSystemID,
[Legacy Material Type],
LegacyMaterialTypeDescription,
TargetMaterialType,
TargetMaterialTypeDesc from config_materialtypemapping
GO
/****** Object:  View [dbo].[webCustomer_AccountGroup_Segment]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webCustomer_AccountGroup_Segment]  
as  
--customer account group  
   
select DQ_ConfigLookup.SystemID SourcesystemID,    
  DQ_ConfigLookup.SourceValue AS KTOKD,    
  DQ_ConfigLookup.SourceValueDescription  AS AccountGroupDescription,    
  DQ_ConfigLookup.TargetValue  AS KTOKD_Target,    
  DQ_ConfigLookup.TargetValueDescription AS TargetAccountGroupDescription   
from [WRKDQUtilities].[dbo].[DQ_ConfigLookup] AS DQ_ConfigLookup  
where DQ_ConfigLookup.LookUpName = 'LKP_CUSTOMER_ACCGROUP'  
   AND DQ_ConfigLookup.SourceField = 'KNA1.KTOKD'  
   AND TargetValueDescription <> 'TBD'  
   AND ISNULL(TargetValueDescription, '') <> ''   
   AND TargetValueDescription <> 'Out of scope'  
   AND ProjectRule='Active'
GO
/****** Object:  View [dbo].[webDataQuality_ReportsDCV]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataQuality_ReportsDCV]  
as  
select ID,Dataset,Field, Report,ReportCategory,case when ReportCategory='Dummy Values' or Publish=0 then 0 else 1 end as Conditions,  
case when ReportCategory='Dummy Values' or Publish=0 then 0 else 1 end as ReportFields,
case when Publish=0 then 0 else 1 end as DisplayReport
from DataQuality_Reports
GO
/****** Object:  View [dbo].[webDataquality_ReportsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataquality_ReportsHor]
as
  select ID,
         DataSet,
         Field,
         Report,
         OpportunityReport,
         [Description],
         [ReportCategory],Publish,
         NULL                      as Conditions,
         NULL                      as ReportFields,
         NULL                      as BuildReports,
         'select * from ' + Report as DisplayReport
  from   Dataquality_Reports 
GO
/****** Object:  View [dbo].[webDataQuality_Summarydcv]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataQuality_Summarydcv]
as
  select ID,
         iif(Completeness = 1, 0, 1) as Reports
  from   DataQuality_Summary 
GO
/****** Object:  View [dbo].[webDataQuality_SummaryHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webDataQuality_SummaryHor]
as
  select ID,
         Dataset,
         [Tables],
         [Order],
         Field,
         Completeness,
         --CompletenessReport,
		 Null as Reports,
         Null as Sync,
         Null as BuildReports,
         Null as GetScore
  from   DataQuality_Summary 
GO
/****** Object:  View [dbo].[webDataset_CustomList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webDataset_CustomList]
as
  select Table_Name
  from   INFORMATION_SCHEMA.VIEWS
  where  table_name like 'IV%' --like 'IV[_]%[_]%[_]%[_]%' -- Naming convention: IV_BusinessObject_DQReportID_SAPTable_DescriptionTable  
         and table_name not in -- Removing existing Datasets from the list box. Dataset is PK and it will cause an execution error
             (select dataset
              from   DQTables) 
GO
/****** Object:  View [dbo].[webDataset_JoinConditionsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataset_JoinConditionsHor]
as
  select DatasetJoinConditionID,
         A.DatasetJoinID,
		 A.DataSetID,
         B.FromTableID,
         FromColumnID,
         B.ToTableID,
         ToColumnID,
         Operator,
         ConditionOrder
  from   Dataset_JoinConditions A
         left outer join [Dataset_Joins] B
                      on A.DatasetJoinID = B.DatasetJoinID 
GO
/****** Object:  View [dbo].[webDataSet_JoinsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE view [dbo].[webDataSet_JoinsHor]
as
  select DatasetJoinID,
         DatasetID,
         FromTableID,
         ToTableID,
         JoinType,
         AdditionalConditions,
		 JoinOrder,
         Null as Conditions
  from   [dbo].[Dataset_Joins] 
  
GO
/****** Object:  View [dbo].[webDataset_MasterHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataset_MasterHor]
as
  select DatasetID,
         DatasetName,
         [Description],
         IsActive,
		 Null as BuildViews,
         Null as [Tables],
         NULL as [Joins],
         NULL as [SelectFields]
  from   dataset_master 
GO
/****** Object:  View [dbo].[webDataSet_masterVer]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataSet_masterVer]
as
select DatasetID,DataSetName,[Select_SQL], null as ParseSQL from dataset_master
GO
/****** Object:  View [dbo].[webDataset_ObjectPageCustomList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webDataset_ObjectPageCustomList]
as
  select Table_Name
  from   INFORMATION_SCHEMA.VIEWS
  where  table_name like 'IV%'
GO
/****** Object:  View [dbo].[webDataset_SelectFieldsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataset_SelectFieldsHor]
as
  select DatasetSelectFieldID,
         DatasetID,
         DataSetTableId,
         SequenceNumber,
         ColumnID,
         ExpressionText,
         Alias,
         IsVisible,
         LookUpTable,TargetSystemTable,
         TargetSystemTableFieldName
  from   [dbo].[Dataset_SelectFields] 
GO
/****** Object:  View [dbo].[webDataSet_TablesHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDataSet_TablesHor]
as
  select DatasetTableID,
         DatasetID,
         TableID,
         Alias, TargetSystemTableName
  from   dataset_tables 
GO
/****** Object:  View [dbo].[webDatasetList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[webDatasetList]  
as  
--select DatasetID,DatasetName from Dataset_Master

select Table_Name as DatasetName
  from   INFORMATION_SCHEMA.VIEWS
  where  table_name like 'IV[_]%[_]%[_]%[_]%'  -- Naming convention: IV_BusinessObject_DQReportID_SAPTable_DescriptionTable  
GO
/****** Object:  View [dbo].[webDataSourcesList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDataSourcesList]
AS 
SELECT  [Name]
      ,[Database]
  FROM [WRKDQUtilities].[dbo].[ztSources]
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_AssetHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_AssetHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_ASSET_CLASS')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_BOMHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_BOMHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_BOM_STATUS')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_CustomerGroupingHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_CustomerGroupingHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_CUST_ACCOUNT_GROUP_GROUPING')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_CustomerHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_CustomerHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_CUSTOMER_ACCGROUP')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_GLHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_GLHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_GL_ACCGROUP')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_MaterialGroupingHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_MaterialGroupingHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_MATERIAL_TYPE_GROUPING')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_MaterialHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_MaterialHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_MATERIAL_CROSSPLANT_STATUS', 'LKP_MATERIAL_PLANT_STATUS', 'LKP_MATERIAL_TYPE')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_RelevancyHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[webDQ_ConfigLookup_RelevancyHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName LIKE 'LKP_RELEVANCY_%'
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_VendorGroupingHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_VendorGroupingHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_VEND_ACCOUNT_GROUP_GROUPING')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookup_VendorHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQ_ConfigLookup_VendorHor] 
AS 
  SELECT LookupType,
         [System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription, 
         ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
  FROM   [dbo].[DQ_ConfigLookup]   
  WHERE LookUpName IN ('LKP_VENDOR_ACCGROUP')
GO
/****** Object:  View [dbo].[webDQ_ConfigLookupHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[webDQ_ConfigLookupHor]
AS
  SELECT LookupType,
		[System],
         SystemID,
         [LookUpName],
         LookupDescription,
         [SourceTable],
         [SourceField],
         SourceValue,
         LanguageKey,
         SourceValueDescription,
         TargetValue,
         TargetValueDescription,
         --DQActive, --deprecated
		 ProjectRule,
         ChangedBy,
         ChangedOn,
         ChangedVia,
         boaStatus
 FROM   [dbo].[DQ_ConfigLookup] 
 --FROM DataConstructionServer.[dbo].[DQ_ConfigLookup] 
GO
/****** Object:  View [dbo].[webDQ_ProjectRuleHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webDQ_ProjectRuleHor]
as
select [value] from [dbo].[DQ_ProjectRuleValues]
GO
/****** Object:  View [dbo].[webDQ_ProjectRuleList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[webDQ_ProjectRuleList]
as
select [value] from [dbo].[DQ_ProjectRuleValues]
GO
/****** Object:  View [dbo].[webDQReportList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[webDQReportList] AS 
Select ReportName From WRKDQOPS.dbo.ttDQReportTracker
GO
/****** Object:  View [dbo].[webDQTableFields_ConditionsBySegment_LoadHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[webDQTableFields_ConditionsBySegment_LoadHor]
AS
SELECT        DataSet, Field, FieldDescription, CheckTable, Group01, Group02, Group03, Group04, Group05, Group06, Group07, Group08, Group09, Group10, Group11, Group12, Group13, Group14, Group15, NULL AS ValidateDatasets, NULL 
                         AS ValidateGroups, NULL AS boaStatus, NULL AS Clear
FROM            dbo.DQTableFields_ConditionsBySegment_Load
where dataset <> 'Table'
GO
/****** Object:  View [dbo].[webDQTableFields_ConditionsBySegment_LoadHor_MissingDatasetVal]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[webDQTableFields_ConditionsBySegment_LoadHor_MissingDatasetVal] as

	SELECT l.dataset, field
	FROM DQTableFields_ConditionsBySegment_Load l
		LEFT JOIN [DQTables] t on l.DataSet = t.Dataset
	WHERE t.Dataset is null
GO
/****** Object:  View [dbo].[webDQTableFields_ConditionsBySegmentHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[webDQTableFields_ConditionsBySegmentHor]
as
  select DataSet,
         Field,
         SegmentField,
         [Value],
         Mandatory,NULL as  UpdateConditions
  from   DQTableFields_ConditionsBySegment 
GO
/****** Object:  View [dbo].[webDQTableFields_ConditionsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTableFields_ConditionsHor]
as
  select ID,
         Dataset,
         [Field],
		 Report,
         ConditionalGroup,
         [Priority],
         Sourcesystem,
         [Mandatory(No Conditions)],
         ConditionalField,
         Condition,
         ManualCondition,
         NextConditionalOperator,
         null as validate
  from   DQTableFields_Conditions 
GO
/****** Object:  View [dbo].[webDQTableFields_DisplayFieldsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTableFields_DisplayFieldsHor]
as
  select ID,Dataset,
         Field,
         Report,
         [Order],
         DisplayField,
         ExpressionText,
         Alias
  from   [DQTableFields_DisplayFields] 
GO
/****** Object:  View [dbo].[webDQTableFieldsDCV]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTableFieldsDCV]
as
  select Dataset,
         Field,
         ConditionBySegment,
         case
           when ConditionBySegment = 1 then 1
           else 0
         end as DefineConditionalSegments,
		 case when CheckForDummyValues=1 then 1 
		 else 0 end as DefineDummyValues
  from   DQTableFields  
GO
/****** Object:  View [dbo].[webDQTableFieldsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTableFieldsHor]
as
  select Dataset,
         Field,
         [Description],
         [Order],
         [Key],
         Active,
         ReportDisplay,
         Mandatory,
         Conditional_Manual,
         ConditionBySegment,
         CheckForDummyValues,
         Null as Preprocess,

         Null as DefineConditionalSegments,
		 NULL as DefineDummyValues,
         Null as Reports,
         
         Null as DefineConditions,
         Null as BuildReports,
         Null as DisplayFields
  from   DQTableFields 
GO
/****** Object:  View [dbo].[webDQTableFieldsList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTableFieldsList]
as
  select Dataset,
         [Field],
         [Field] + ' - ' + [Description] as Field_Description
  from   DQTableFields 
GO
/****** Object:  View [dbo].[webDQtablefieldsVer]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQtablefieldsVer]
as
  select Dataset,
         Field,
         SegmentView,
         SegmentField,
         SegmentFieldAlias,
         ConditionField,
         ConditionFieldInDataSet,
         NULL as [Insert Segments]
  from   DQtablefields 
GO
/****** Object:  View [dbo].[webDQTables_ResultSummaryDcv]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQTables_ResultSummaryDcv]
AS
SELECT Dataset
	,CASE 
		WHEN ReportType = 'Completeness Check'
			THEN 1
		ELSE 0
		END AS GenerateCompletenessSummary
	,CASE 
		WHEN ReportType = 'Completeness Check'
			THEN 1
		ELSE 0
		END AS ViewAttributeReport
	,CASE 
		WHEN ReportType = 'Completeness Check'
			THEN 1
		ELSE 0
		END AS ViewRecordLevelReport
	,CASE 
		WHEN ReportType = 'Dummy Value Check'
			THEN 1
		ELSE 0
		END AS GenerateDummyValueSummary
	,CASE 
		WHEN ReportType = 'Dummy Value Check'
			THEN 1
		ELSE 0
		END AS DummyValuesAttributeReport
	,CASE 
		WHEN ReportType = 'Dummy Value Check'
			THEN 1
		ELSE 0
		END AS DummyValuesRecordLevelReport
FROM DQTables
GO
/****** Object:  View [dbo].[webDQTables_ResultSummaryHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webDQTables_ResultSummaryHor]  
as  
  select [Dataset],  
         [Description],  
         Active,  
           
         'Completeness'      as Completeness,  
   Null                as GenerateCompletenessSummary,  
         case  
           when Object_id (Dataset + 'Completeness_AttributeLevelResult', 'U') is not null then 'Select ''' + Dataset  
                                                                      + ''' as [Table],* from ' + Dataset  
                                                                      + 'Completeness_AttributeLevelResult'  
           else ''  
         end                 as ViewAttributeReport,  
         case  
           when Object_id (Dataset + 'Completeness_RecordLevelResult', 'U') is not null then 'Select ''' + Dataset  
                                                                                             + ''' as [Table],* from ' + Dataset  
                                                                                             + 'Completeness_RecordLevelResult'  
           else ''  
         end                 as ViewRecordLevelReport,  
         case  
           when Object_id (Dataset + 'Completeness_RecordLevelSummary', 'U') is not null then 'Select ''' + Dataset  
                                                                                              + ''' as [Table],* from ' + Dataset  
                                                                                              + 'Completeness_RecordLevelSummary'  
           else ''  
         end                 as ViewRecordLevelSummary,  
         'Dummy Value Check' as Dummy,  
   NULL as GenerateDummyValueSummary,  
         case  
           when Object_id (Dataset + '_DummyValues_AttributeLevel', 'U') is not null then 'Select ''' + Dataset  
                                                                                          + ''' as [Table],* from ' + Dataset  
                                                                                          + '_DummyValues_AttributeLevel'  
           else ''  
         end                 as DummyValuesAttributeReport,  
         case  
           when Object_id (Dataset + '_DummyValues_RecordLevel', 'U') is not null then 'Select ''' + Dataset  
                                                                                       + ''' as [Table],* from ' + Dataset  
                                                                                       + '_DummyValues_RecordLevel'  
           else ''  
         end                 as DummyValuesRecordLevelReport,  
         Null                as Reports  
  --Null as Fields  
  from   DQTables  
  where  Active = 1 

GO
/****** Object:  View [dbo].[webDQTablesHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTablesHor]
as
  select [Dataset],
         [Description],
         ReportType,
         Active,
		 SAPTable,
         Null as GetFields,
         Null as Fields
  from   DQTables
GO
/****** Object:  View [dbo].[webDQTablesVer]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDQTablesVer]  
as  
  select [Dataset],  
         [Description],  
         Active,  
   SegmentView,  
   SegmentField,  
   SegmentFieldAlias,  
   ConditionField,  
   ConditionFieldInDataSet ,
   NULL as UpdateFieldSegments
           
  from   DQTables
GO
/****** Object:  View [dbo].[webDummyValuesHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webDummyValuesHor]
as
  select DummyValueID,
         Dataset,
         Field,
		 MatchType,
         DummyValue,
         Null as [Synonyms]
  from   Dummyvalues 
GO
/****** Object:  View [dbo].[webDummyValueSynonymsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[webDummyValueSynonymsHor]
as
select SynonymID,DummyValueID,[Synonym],[Language] from DummyValueSynonyms
GO
/****** Object:  View [dbo].[webFieldUsageHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	Create View [dbo].[webFieldUsageHor] AS
	select 
	UsedInID,
	FieldID,
	UsedIn
	FROM ztFieldUsage
GO
/****** Object:  View [dbo].[webJoinTypeList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webJoinTypeList]
as
select 'Inner Join' as JoinType
union all
select 'Left outer Join'
union all
select 'Right Outer Join'
GO
/****** Object:  View [dbo].[webMatchTypeList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webMatchTypeList]
as
select 'EXACT' as MatchType
union
select 'Contains'
union

select 'Starts With'
union
select 'Ends With'
GO
/****** Object:  View [dbo].[webMaterial_ConfigTablesHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webMaterial_ConfigTablesHor]
as
select [Table],[Description],[TextTable],Active from material_configtables
GO
/****** Object:  View [dbo].[webMaterial_MaterialType_Segment]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webMaterial_MaterialType_Segment]  
as  
--customer account group  
   
select DQ_ConfigLookup.SystemID SourcesystemID,    
  DQ_ConfigLookup.SourceValue AS MTART,    
  DQ_ConfigLookup.SourceValueDescription  AS MaterialTypeDescription,    
  DQ_ConfigLookup.TargetValue  AS MTART_Target,    
  DQ_ConfigLookup.TargetValueDescription AS TargetMaterialTypeDescription   
from [WRKDQUtilities].[dbo].[DQ_ConfigLookup] AS DQ_ConfigLookup  
where DQ_ConfigLookup.LookUpName = 'LKP_MATERIAL_TYPE'  
   AND DQ_ConfigLookup.SourceField = 'MARA.MTART'  
   AND TargetValueDescription <> 'TBD'  
   AND ISNULL(TargetValueDescription, '') <> ''   
   AND TargetValueDescription <> 'Out of scope'  
   AND ProjectRule='Active'
GO
/****** Object:  View [dbo].[webObjectSummary_DatasetHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webObjectSummary_DatasetHor]
as
  select ObjectDataset,
         Dataset,
         [Description],
         ReportType,
         Active,
         Extension,[Group]
  from   objectSummary_Dataset 
GO
/****** Object:  View [dbo].[webObjectSummaryHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webObjectSummaryHor]
as
  select ObjectDataset,
         [Description],
         Active,
         Null as Datasets, 
		 Null as GenerateSummary,
		 'select * from '+ObjectDataset+'_ObjectLevelSummary' as ViewReport	
  from   ObjectSummary 
GO
/****** Object:  View [dbo].[webPrecalculatedFieldsRegistryHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webPrecalculatedFieldsRegistryHor] AS
Select     FieldID, 
    FieldName , 
	[Description] ,
    ViewName  ,
    SourceTable  ,
    SourceField  ,
    TimeDimension, 
    TimeDimensionValue, 
	NULL AS Usage
	From ztPrecalculatedFieldsRegistry
GO
/****** Object:  View [dbo].[webReportCategoryList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[webReportCategoryList]
as
  select 'Mandatory' as ReportCategory
  union
  select 'Conditional Mandatory' as ReportCategory
  union
  select 'Configuration Check' as ReportCategory 
  union 
  select 'Dummy Values' as ReportCategory 
GO
/****** Object:  View [dbo].[webReportsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[webReportsHor]
as
select '1' as a
GO
/****** Object:  View [dbo].[webReportTypeList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[webReportTypeList]
as
select 'Completeness Check' as ReportType
union
select 'Dummy Value Check' as ReportType
GO
/****** Object:  View [dbo].[webSegmentView_FieldsList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webSegmentView_FieldsList]
as
select distinct Table_Name as SegmentView, COlumn_name as Field from INFORMATION_SCHEMA.COLUMNS where Table_name like 'web%Segment'
GO
/****** Object:  View [dbo].[webSegmentViewList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webSegmentViewList]
as
select distinct Table_Name as SegmentView from INFORMATION_SCHEMA.COLUMNS where Table_name like 'web%Segment'
GO
/****** Object:  View [dbo].[webStatusTypeHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webStatusTypeHor]
as
select StatusType,[Description] from ztStatusType
GO
/****** Object:  View [dbo].[webStatusTypeList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webStatusTypeList]
as
select StatusType,[Description] from ztStatusType
GO
/****** Object:  View [dbo].[webSystemTypeFieldsList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webSystemTypeFieldsList]  
as  
select D.SystemType, D.[Description] as SystemTypeDescription,B.TableName,B.[Description] as TableDescription,A.Field, A.FieldOrder, A.[Description] as FieldDescription,C.TableName as LookUpTableName,DataType,[Length], Decimals,KeyField,  
OriginalDataType,OriginalLength,OriginalDecimals from   
ztsystemtypetablefield A inner join ztSystemTypeTable B on A.SystemTypetableID=B.SystemTypeTableID   
left outer join ztSystemTypeTable C  on A.LookupTableSystemTypeTableID=C.SystemTypeTableID   
left outer join ztsystemtype D on B.SystemTypeID=D.SystemTypeID  
where  D.SystemType='SAP_ECC' 
GO
/****** Object:  View [dbo].[webSystemTypeTableFieldList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webSystemTypeTableFieldList]  
AS  
/* ACTION : Replace with specific System Type */ 
  SELECT  
 ztSystemTypeTableField.SystemTypeTableFieldID,  
 ztSystemType.SystemType,  
 ztSystemTypeTable.TableName,  
 ztSystemTypeTableField.Field,  
 ztSystemTypeTableField.FieldOrder,  
 ztSystemTypeTableField.Field+' - '+ztSystemTypeTableField.[Description] as FieldDescription,
 ztSystemTypeTableField.[Keyfield]  
  FROM  
 ztSystemType  
  INNER JOIN ztSystemTypeTable  
    ON ztSystemType.SystemTypeID = ztSystemTypeTable.SystemTypeID  
  INNER JOIN ztSystemTypeTableField  
    ON ztSystemTypeTable.SystemTypeTableID = ztSystemTypeTableField.SystemTypeTableID  
    where systemtype='SAP_ECC'
GO
/****** Object:  View [dbo].[webSystemTypeTableList]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[webSystemTypeTableList]  
as  
select D.SystemType, D.[Description] as SystemTypeDescription,B.TableName,B.[Description] as TableDescription,
C.TableName as DescriptionTableName,CF.Field as DescriptionField,CL.Field as LanguageField--,DataType,[Length], Decimals,KeyField,  
--OriginalDataType,OriginalLength,OriginalDecimals 
from   
ztSystemTypeTable B 
left outer join ztSystemTypeTable C  on B.DescriptionTableID=C.SystemTypeTableID   
left outer join ztsystemtypetablefield CF on B.DescriptionTableFieldID=CF.SystemTypeTableFieldID and B.DescriptionTableID=CF.SystemTypeTableID 
left outer join ztsystemtypetablefield CL on B.DescriptionTableLanguageFieldID=CL.SystemTypeTableFieldID and B.DescriptionTableID=CL.SystemTypeTableID
left outer join ztsystemtype D on B.SystemTypeID=D.SystemTypeID  
where  D.SystemType='SAP_ECC'
GO
/****** Object:  View [dbo].[webTableColumnsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[webTableColumnsHor]
as
  select ColumnID,
         TableID,
         ColumnName,
         DataType,
         Active,
         isExpression,
         AllowedForJoin,
         DisplayName
  from   tablecolumns 
GO
/****** Object:  View [dbo].[webVendor_AccountGroup_Segment]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webVendor_AccountGroup_Segment]
AS
SELECT        SystemID AS SourcesystemID, SourceValue AS KTOKK, SourceValueDescription AS AccountGroupDescription, TargetValue AS KTOKK_Target, TargetValueDescription AS TargetAccountGroupDescription
FROM            dbo.DQ_ConfigLookup AS DQ_ConfigLookup
WHERE        (LookUpName = 'LKP_VENDOR_ACCGROUP') AND (SourceField = 'LFA1.KTOKK') AND (TargetValueDescription <> 'TBD') AND (ISNULL(TargetValueDescription, N'') <> '') AND 
                         (TargetValueDescription <> 'Out of scope') AND (ProjectRule = 'Active')
GO
/****** Object:  View [dbo].[webztSourcesHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[webztSourcesHor] 
as select  [Name], [Database], [Active], [APO_LOGSYS], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Platform] 
	FROM ztSources
GO
/****** Object:  StoredProcedure [dbo].[InsertDataQualityReportsFromConditions]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDataQualityReportsFromConditions]
AS
BEGIN
    SET NOCOUNT ON;
 
    DECLARE @Dataset NVARCHAR(100);
    DECLARE @Field NVARCHAR(100);
    DECLARE @SegmentField NVARCHAR(128);
    DECLARE @Value NVARCHAR(256);
    DECLARE @Mandatory BIT;
    DECLARE @ReportName NVARCHAR(400);
    DECLARE @OpportunityReportName NVARCHAR(400);
    DECLARE @Description NVARCHAR(400);
    DECLARE @ReportCategory NVARCHAR(50);
    DECLARE @Exists INT;
 
    -- Cursor to loop over records where Mandatory = 1
    DECLARE ConditionCursor CURSOR FAST_FORWARD FOR
    SELECT Dataset, Field, SegmentField, [Value], Mandatory
    FROM DQTableFields_ConditionsBySegment
    WHERE Mandatory = 1;
 
    OPEN ConditionCursor;
    FETCH NEXT FROM ConditionCursor INTO @Dataset, @Field, @SegmentField, @Value, @Mandatory;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            -- Replace spaces and special characters in SegmentField and Value
            DECLARE @CleanSegmentField NVARCHAR(128) = REPLACE(REPLACE(@SegmentField, ' ', '_'), '-', '_');
            DECLARE @CleanValue NVARCHAR(256) = REPLACE(REPLACE(@Value, ' ', '_'), '-', '_');
 
            -- Construct Report Name and Opportunity Report Name
            SET @ReportName = 'tv' + @Dataset + '_' + @Field + '_' + @CleanSegmentField + '_' + @CleanValue + '_MissingSel';
            SET @OpportunityReportName = 'tv' + @Dataset + '_' + @Field + '_' + @CleanSegmentField + '_' + @CleanValue + '_OpportunitySel';
 
            -- Construct Description
            SET @Description = @Field + ' is a Mandatory field for ' + @Value;
 
            -- Set Report Category
            SET @ReportCategory = 'Conditional Mandatory';
 
            -- Check if a record with the same Report name already exists
            SELECT @Exists = COUNT(1)
            FROM DataQuality_Reports
            WHERE Report = @ReportName;
 
            IF @Exists = 0
            BEGIN
                -- Insert into DataQuality_Reports
                INSERT INTO DataQuality_Reports (
                    Dataset,
                    Field,
                    Report,
                    OpportunityReport,
                    [Description],
                    ReportCategory
                )
                VALUES (
                    @Dataset,
                    @Field,
                    @ReportName,
                    @OpportunityReportName,
                    @Description,
                    @ReportCategory
                );
            END
 
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            RAISERROR('Error inserting report for Dataset: %s, Field: %s, SegmentField: %s, Value: %s. Error: %s',
                      16, 1, @Dataset, @Field, @SegmentField, @Value, @ErrorMessage);
        END CATCH
 
        FETCH NEXT FROM ConditionCursor INTO @Dataset, @Field, @SegmentField, @Value, @Mandatory;
    END
 
    CLOSE ConditionCursor;
    DEALLOCATE ConditionCursor;
END
GO
/****** Object:  StoredProcedure [dbo].[PopulateDQTableFields_ConditionsBySegment]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PopulateDQTableFields_ConditionsBySegment]
AS
BEGIN
    SET NOCOUNT ON;
 
    -- Variables
    DECLARE @Dataset NVARCHAR(100);
    DECLARE @Field NVARCHAR(100);
    DECLARE @SegmentView NVARCHAR(128);
    DECLARE @SegmentField NVARCHAR(128);
    DECLARE @ConditionField NVARCHAR(128);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @SegmentValue NVARCHAR(256);
    DECLARE @ErrorMessage NVARCHAR(4000);
 
    -- Temporary table to store segment values
    CREATE TABLE #SegmentValues (
        SegmentValue NVARCHAR(256)
    );
 
    -- Cursor to loop over fields with ConditionBySegment = 1
    DECLARE FieldCursor CURSOR FAST_FORWARD FOR
    SELECT Dataset, Field, SegmentView, SegmentField, ConditionField
    FROM DQTableFields
    WHERE ConditionBySegment = 1;
 
    OPEN FieldCursor;
    FETCH NEXT FROM FieldCursor INTO @Dataset, @Field, @SegmentView, @SegmentField, @ConditionField;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            -- Check if SegmentView exists
            IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @SegmentView)
            BEGIN
                RAISERROR('SegmentView %s does not exist.', 16, 1, @SegmentView);
                FETCH NEXT FROM FieldCursor INTO @Dataset, @Field, @SegmentView, @SegmentField, @ConditionField;
                CONTINUE;
            END
 
            -- Clear temporary table
            DELETE FROM #SegmentValues;
 
            -- Build dynamic SQL to insert segment values into temporary table
            SET @SQL = N'
                INSERT INTO #SegmentValues (SegmentValue)
                SELECT DISTINCT [' + @SegmentField + N']
                FROM ' + QUOTENAME(@SegmentView) + N'
                WHERE [' + @SegmentField + N'] IS NOT NULL AND [' + @SegmentField + N'] <> ''''
            ';
 
            EXEC sp_executesql @SQL;
 
            -- Delete existing records for this Dataset and Field in DQTableFields_ConditionsBySegment
            DELETE FROM DQTableFields_ConditionsBySegment
            WHERE Dataset = @Dataset AND Field = @Field and SegmentField=@SegmentField;
 
            -- Insert into DQTableFields_ConditionsBySegment
            INSERT INTO DQTableFields_ConditionsBySegment (Dataset, Field, SegmentField, [Value], Mandatory)
            SELECT DISTINCT
                @Dataset AS Dataset,
                @Field AS Field,
                @SegmentField AS SegmentField,
                SV.SegmentValue AS [Value],
                NULL AS Mandatory  -- You can set this to 0 if you prefer
            FROM #SegmentValues SV;
 
        END TRY
        BEGIN CATCH
            SET @ErrorMessage = ERROR_MESSAGE();
            RAISERROR('An error occurred while processing Dataset: %s, Field: %s. Error: %s',
                      16, 1, @Dataset, @Field, @ErrorMessage);
        END CATCH
 
        FETCH NEXT FROM FieldCursor INTO @Dataset, @Field, @SegmentView, @SegmentField, @ConditionField;
    END
 
    CLOSE FieldCursor;
    DEALLOCATE FieldCursor;
 
    -- Drop temporary table
    DROP TABLE #SegmentValues;
END
GO
/****** Object:  StoredProcedure [dbo].[PopulateDQTableFields_DisplayFields]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateDQTableFields_DisplayFields]
AS
BEGIN
    SET NOCOUNT ON;
 
    DECLARE @Dataset NVARCHAR(100);
    DECLARE @Field NVARCHAR(100);
    DECLARE @Report NVARCHAR(400);
    DECLARE @KeyFields TABLE (
        FieldName NVARCHAR(128),
        [Order] INT
    );
    DECLARE @KeyFieldList NVARCHAR(MAX);
    DECLARE @ExpressionText NVARCHAR(MAX);
    DECLARE @CurrentFieldOrder INT;
    DECLARE @MaxOrder INT;
    DECLARE @Order INT;
    DECLARE @ErrorMessage NVARCHAR(4000);
 
    -- Cursor to loop over reports in DataQuality_Reports
    DECLARE ReportCursor CURSOR FAST_FORWARD FOR
    SELECT DQR.Dataset, DQR.Field, DQR.Report
    FROM DataQuality_Reports DQR
    INNER JOIN DQTableFields DQF ON DQR.Dataset = DQF.Dataset AND DQR.Field = DQF.Field
    WHERE DQF.ConditionBySegment = 1 OR DQF.Mandatory = 1;
	
	OPEN ReportCursor;
    FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @Report;
	
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            -- Clear previous key fields
            DELETE FROM @KeyFields;
 
            -- Get key fields for the dataset
            INSERT INTO @KeyFields (FieldName, [Order])
            SELECT Field, [Order]
            FROM DQTableFields
            WHERE Dataset = @Dataset AND [Key] = 1;
 
            -- If no key fields, skip to next report
            IF (SELECT COUNT(*) FROM @KeyFields) = 0
            BEGIN
                FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @Report;
                CONTINUE;
            END
 
            -- Build the concatenation expression for the composite key
            SELECT @KeyFieldList = STRING_AGG('ISNULL(' + QUOTENAME(FieldName) + ', '''')', ' + ''_'' + ') within group (order by [Order])
            FROM @KeyFields;
 
            SET @ExpressionText = @KeyFieldList;
 
            -- Determine the maximum order value for ordering
            SELECT @MaxOrder = ISNULL(MAX([Order]), 0) FROM @KeyFields;
 
            -- Set Order for SourcesystemID and Key
            SET @Order = 1;
			 
            -- Insert SourcesystemID as Order 1 if not already present
            IF NOT EXISTS (
                SELECT 1 FROM DQTableFields_DisplayFields
                WHERE Dataset = @Dataset AND Field = @Field AND Report = @Report AND DisplayField = 'SourcesystemID'
            )
            BEGIN
                INSERT INTO DQTableFields_DisplayFields (
                    Dataset,
                    Field,
                    Report,
                    [Order],
                    DisplayField,
                    ExpressionText,
                    Alias
                ) VALUES (
                    @Dataset,
                    @Field,
                    @Report,
                    @Order,
                    'SourcesystemID',
                    NULL,
                    NULL
                );
            END
 
            -- Insert Composite Key as Order 2 if not already present
            SET @Order = @Order + 1;
 
            IF NOT EXISTS (
                SELECT 1 FROM DQTableFields_DisplayFields
                WHERE Dataset = @Dataset AND Field = @Field AND Report = @Report AND Alias = 'Key'
            )
            BEGIN
                INSERT INTO DQTableFields_DisplayFields (
                    Dataset,
                    Field,
                    Report,
                    [Order],
                    DisplayField,
                    ExpressionText,
                    Alias
                ) VALUES (
                    @Dataset,
                    @Field,
                    @Report,
                    @Order,
                    NULL,
                    @ExpressionText,
                    'Key'
                );
            END
 
            -- Insert individual key fields starting from Order 3
            SET @Order = @Order + 1;
 
            INSERT INTO DQTableFields_DisplayFields (
                Dataset,
                Field,
                Report,
                [Order],
                DisplayField,
                ExpressionText,
                Alias
            )
            SELECT
                @Dataset AS Dataset,
                @Field AS Field,
                @Report AS Report,
                @Order + [Order] - 1 AS [Order],
                KF.FieldName AS DisplayField,
                NULL AS ExpressionText,
                NULL AS Alias
            FROM @KeyFields KF
            WHERE NOT EXISTS (
                SELECT 1 FROM DQTableFields_DisplayFields DFD
                WHERE DFD.Dataset = @Dataset AND DFD.Field = @Field AND DFD.Report = @Report AND DFD.DisplayField = KF.FieldName
            )
            ORDER BY [Order];
 
            -- Insert the current field if not already present
            SELECT @CurrentFieldOrder = @Order + @MaxOrder;
 
            IF NOT EXISTS (
                SELECT 1 FROM DQTableFields_DisplayFields
                WHERE Dataset = @Dataset AND Field = @Field AND Report = @Report AND DisplayField = @Field
            )
            BEGIN
                INSERT INTO DQTableFields_DisplayFields (
                    Dataset,
                    Field,
                    Report,
                    [Order],
                    DisplayField,
                    ExpressionText,
                    Alias
                ) VALUES (
                    @Dataset,
                    @Field,
                    @Report,
                    @CurrentFieldOrder,
                    @Field,
                    NULL,
                    NULL
                );
            END
 
        END TRY
        BEGIN CATCH
            SET @ErrorMessage = ERROR_MESSAGE();
            RAISERROR('Error processing Dataset: %s, Field: %s, Report: %s. Error: %s',
                      16, 1, @Dataset, @Field, @Report, @ErrorMessage);
        END CATCH
 
        FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @Report;
    END
 
    CLOSE ReportCursor;
    DEALLOCATE ReportCursor;
END
GO
/****** Object:  StoredProcedure [dbo].[web_Matrix_DQReporting_Completeness_Validation_Key_Field]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[web_Matrix_DQReporting_Completeness_Validation_Key_Field] 
	--(@ReportingID nvarchar (150),
	-- @DQReportGrouping nvarchar (150),
 --    @Table nvarchar (150),
 --    @Field nvarchar (150))
AS

  BEGIN

	UPDATE    [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness]  
		SET    [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].[Field Key] = [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Tables_Fields_Completeness].[Key_Field],
			   [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].FieldDescription = [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Tables_Fields_Completeness].[Description]
FROM    [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness]
INNER JOIN [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Tables_Fields_Completeness]
        ON [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].[Table] = [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Tables_Fields_Completeness].[SAP Table Name] and 
			[WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].[Field] = [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Tables_Fields_Completeness].[FIELD]
WHERE
    [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness].[Field Key] is null

  --UPDATE [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness] set [Field Key] = CONCAT([Table],'_',[Field])
  --where ReportingId = @ReportingID and 
		--DQReportGrouping = @DQReportGrouping and
		--[Table] = @Table and
		--[Field] = @Field and
		--[Field Key] is null
END
GO
/****** Object:  StoredProcedure [dbo].[web_Matrix_DQReporting_Validation_Key_Field_Completeness]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[web_Matrix_DQReporting_Validation_Key_Field_Completeness] 
	(@ReportingID nvarchar (150),
	 @DQReportGrouping nvarchar (150),
     @Table nvarchar (150),
     @Field nvarchar (150))
AS

  BEGIN

  UPDATE [WRKDQUtilities].[dbo].[ztMatrix_DQReporting_Completeness] set [Field Key] = 'PEPE'
  where ReportingId = @ReportingID and 
		DQReportGrouping = @DQReportGrouping and
		[Table] = @Table and
		[Field] = @Field and
		[Field Key] is null
END
GO
/****** Object:  StoredProcedure [dbo].[webAvailableTables_DeleteTableColumnRecordsDel]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[webAvailableTables_DeleteTableColumnRecordsDel] @TableId int
as
begin
delete from TableColumns where TableId=@TableId
end
GO
/****** Object:  StoredProcedure [dbo].[webAvailableTables_Getfields]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webAvailableTables_Getfields](@TableID int, @TableName nvarchar(100),@DatabaseName nvarchar(100) )  
AS  
  BEGIN  
      SET NOCOUNT ON;  
  
      -- Truncate the TableColumns table to refresh data (optional)  
      --TRUNCATE TABLE TableColumns;  
  
      --DECLARE @TableID INT=20;  
      --DECLARE @DatabaseName SYSNAME;  
      --DECLARE @TableName SYSNAME;  
      DECLARE @SQL NVARCHAR(MAX);  
      -- Cursor to loop through each table in AvailableTables  
      --DECLARE TableCursor CURSOR FOR  
      --  SELECT TableID,  
      --         DatabaseName,  
      --         TableName  
      --  FROM   AvailableTables  
      --  WHERE  IsActive = 1;  
  
      --OPEN TableCursor;  
  
      --FETCH NEXT FROM TableCursor INTO @TableID, @DatabaseName, @TableName;  
  
      --WHILE @@FETCH_STATUS = 0  
      --  BEGIN  
            -- Use QUOTENAME to safely encapsulate database and table names  
        DECLARE @QuotedDatabaseName NVARCHAR(258) = Quotename(@DatabaseName);  
        DECLARE @QuotedTableName NVARCHAR(258) = Quotename(@TableName, ''''); -- Single quotes for parameter  
  
        -- Create a temporary table to hold column information  
        IF Object_id('tempdb..#Columns') IS NOT NULL  
            DROP TABLE #Columns;  
  
        CREATE TABLE #Columns  
            (  
                ORDINAL_POSITION         INT,  
                COLUMN_NAME              SYSNAME,  
                DATA_TYPE                SYSNAME,  
                CHARACTER_MAXIMUM_LENGTH INT NULL,  
                IS_NULLABLE              VARCHAR(3),  
                IsPrimaryKey             BIT  
            );  
  
        -- Construct dynamic SQL to query column and primary key information  
        SET @SQL = N'             INSERT INTO #Columns (ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, IsPrimaryKey)             SELECT                  C.ORDINAL_POSITION,                 C.COLUMN_NAME,                 C
.DATA_TYPE,                 C.CHARACTER_MAXIMUM_LENGTH,                 C.IS_NULLABLE,                 CASE WHEN PKCols.COLUMN_NAME IS NOT NULL THEN 1 ELSE 0 END AS IsPrimaryKey             FROM '  
                    + @QuotedDatabaseName  
                    + N'.INFORMATION_SCHEMA.COLUMNS C             LEFT JOIN (                 SELECT KCU.COLUMN_NAME                 FROM '  
                    + @QuotedDatabaseName  
                    + N'.INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC                 INNER JOIN '  
                    + @QuotedDatabaseName  
                    + N'.INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE KCU                     ON KCU.CONSTRAINT_NAME = TC.CONSTRAINT_NAME                     AND KCU.TABLE_NAME = TC.TABLE_NAME                 WHERE TC.CONSTRAINT_TYPE = ''PRIMARY KEY''      
               AND KCU.TABLE_NAME = '  
                    + @QuotedTableName  
                    + N'             ) AS PKCols ON PKCols.COLUMN_NAME = C.COLUMN_NAME             WHERE C.TABLE_NAME = '  
                    + @QuotedTableName + N';         ';  
  
        -- Execute the dynamic SQL  
        EXEC sp_executesql  
            @SQL;  
			select * from #Columns
  
        -- Check if any columns were retrieved  
        IF EXISTS (SELECT 1  
                    FROM   #Columns)  
            BEGIN  
                -- Insert column details into TableColumns  
                INSERT INTO TableColumns  
                            (TableID,  
                            ColumnName,  
                            DataType,  
                            Active,  
                            AllowedForJoin,  
                            DisplayName)  
                SELECT @TableID,  
                        COLUMN_NAME,  
                        CASE  
                        WHEN DATA_TYPE IN ( 'varchar', 'nvarchar', 'char', 'nchar' ) THEN DATA_TYPE + '('  
                                                                                            + COALESCE(Cast(CHARACTER_MAXIMUM_LENGTH AS VARCHAR(10)), 'MAX')  
                                                                                            + ')'  
                       ELSE DATA_TYPE  
                        END         AS DataType,  
                        1           AS IsSelectable,-- You can adjust this if needed  
                        IsPrimaryKey,-- Set IsJoinable based on IsPrimaryKey (1 if PK, 0 otherwise)  
                        COLUMN_NAME AS DisplayName  
                FROM   #Columns left outer join TableColumns on COLUMN_NAME=ColumnName and TableId=@TableID where (COLUMN_NAME is null  or COLUMN_NAME!='Not Available')
            END  
        --ELSE if not exists (select 1 from TableColumns where TableID=@TableID)  
        --    BEGIN  
        --        -- Table not found; insert 'Not Available'  
        --        INSERT INTO TableColumns  
        --                    (TableID,  
        --                    ColumnName,  
        --                    DataType,  
        --                    Active,  
        --                    AllowedForJoin,  
        --                    DisplayName)  
        --        VALUES      (@TableID,  
        --                    'Not Available',  
        --                    '',  
        --                    0,  
        --                    0,  
        --                    'Not Available');  
        --    END  
  
        -- Clean up temporary table  
        DROP TABLE #Columns;  
  
          
  END; 
GO
/****** Object:  StoredProcedure [dbo].[webDataquality_Reports_ConditionalCompletenessReportCreate]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDataquality_Reports_ConditionalCompletenessReportCreate](@DataSet nvarchar(100))  
AS  
BEGIN  
    SET NOCOUNT ON;  
   
    -- Variables  
      --declare @DataSet nvarchar(100) ='ttKNB1_DS'
    DECLARE @Field NVARCHAR(100);  
    DECLARE @ReportName NVARCHAR(200);  
    DECLARE @OpportunityReportName NVARCHAR(200);  
    DECLARE @Description NVARCHAR(200);  
    DECLARE @RuleName NVARCHAR(500);  
    DECLARE @Author NVARCHAR(200);  
    DECLARE @ViewType NVARCHAR(100);  
    DECLARE @CreationDate DATE;  
    DECLARE @Header NVARCHAR(MAX);  
    DECLARE @SourceSystem NVARCHAR(100);  
    DECLARE @DisplayFields NVARCHAR(MAX);  
    DECLARE @ExpressionFields NVARCHAR(MAX);  
    DECLARE @FinalSelectFields NVARCHAR(MAX);  
    DECLARE @WhereClause NVARCHAR(MAX);  
    DECLARE @sql NVARCHAR(MAX);  
    DECLARE @sql_drop NVARCHAR(MAX);  
    DECLARE @OpportunityReportNameSource NVARCHAR(200);  
    DECLARE @OpportunitySelects NVARCHAR(MAX);  
   
    -- Temporary table to store active source systems  
    DECLARE @ActiveSources TABLE (  
        SourceSystem NVARCHAR(100)  
    );  
   
    -- Populate @ActiveSources  
    INSERT INTO @ActiveSources (SourceSystem)  
    SELECT [Name]  
    FROM ztSources  
    WHERE Active = 1;  
   
   --PRINT(@ActiveSources)
    -- Cursor to loop over conditional reports  
    DECLARE ReportCursor CURSOR FAST_FORWARD FOR  
    SELECT B.Dataset, B.Field, Report, OpportunityReport, B.Description, isnull(RuleName,''), isnull(Author,''), isnull(ViewType,''), isnull(CreationDate,'')  
    FROM DQTableFields A inner join DataQuality_Reports  B on A.Dataset=B.DataSet and A.Field=B.Field  
    WHERE ReportCategory = 'Conditional Mandatory' and A.Dataset=@Dataset and Publish=1
   
    OPEN ReportCursor;  
    FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @ReportName, @OpportunityReportName, @Description, @RuleName, @Author, @ViewType, @CreationDate;  
   
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
        BEGIN TRY  
            -- Generate Header  
            EXEC dbo.GenerateReportHeader @RuleName, @Author, @ViewType, @CreationDate, @Header OUTPUT;  
   
            -- Retrieve display fields and expressions  
            SELECT   
                @DisplayFields = STRING_AGG(  
                    CASE   
                        WHEN Alias IS NOT NULL AND Alias <> '' THEN QUOTENAME(DisplayField) + ' AS ' + QUOTENAME(Alias)  
                        ELSE QUOTENAME(DisplayField)  
                    END, ', ') WITHIN GROUP (ORDER BY [Order]),  
                @ExpressionFields = STRING_AGG(  
                    CASE   
                        WHEN ExpressionText IS NOT NULL AND ExpressionText <> ''  
                            THEN   
                                CASE  
                                    WHEN Alias IS NOT NULL AND Alias <> ''  
                                        THEN '(' + ExpressionText + ') AS ' + QUOTENAME(Alias)  
                                    ELSE '(' + ExpressionText + ')'  
                                END  
                            ELSE NULL  
                    END, ', ') WITHIN GROUP (ORDER BY [Order])  
            FROM DQTableFields_DisplayFields  
            WHERE Dataset = @Dataset  
              AND Field = @Field  
     and Report=@ReportName;  
   
            -- If no display fields or expressions, use '*'  
            IF @DisplayFields IS NULL OR @DisplayFields = ''  
                SET @DisplayFields = '';  
            IF @ExpressionFields IS NULL  
                SET @ExpressionFields = '';  
   
            -- Combine display fields and expressions  
            IF @DisplayFields <> '' AND @ExpressionFields <> ''  
                SET @FinalSelectFields = @DisplayFields + ', ' + @ExpressionFields;  
            ELSE IF @DisplayFields <> ''  
                SET @FinalSelectFields = @DisplayFields;  
            ELSE IF @ExpressionFields <> ''  
                SET @FinalSelectFields = @ExpressionFields;  
            ELSE  
                SET @FinalSelectFields = '*';  
   
            -- Drop existing views if they exist  
            SET @sql_drop = 'DROP VIEW IF EXISTS ' + QUOTENAME(@OpportunityReportName) + ';' + CHAR(13) +  
   'DROP VIEW IF EXISTS ' + QUOTENAME(@ReportName) + ';';  
			PRINT(@SQL_DROP)
            EXEC sp_executesql @sql_drop;  
   
            -- Initialize variable to collect Opportunity SELECT statements  
            SET @OpportunitySelects = '';  
   
            -- Loop over active source systems  
            DECLARE SourceCursor CURSOR FAST_FORWARD FOR  
            SELECT SourceSystem  
            FROM @ActiveSources;  
   
            OPEN SourceCursor;  
            FETCH NEXT FROM SourceCursor INTO @SourceSystem;  
   
            WHILE @@FETCH_STATUS = 0  
            BEGIN  
                -- Build WHERE clause for the source system and field  
                EXEC dbo.webDataQuality_Summary_GetConditionbySource @SourceSystem, @Dataset, @Field, @ReportName, @sql = @WhereClause OUTPUT;  
   
                IF @WhereClause IS NULL OR @WhereClause = ''  
                BEGIN  
                    -- If no condition is returned, skip this source system  
                    FETCH NEXT FROM SourceCursor INTO @SourceSystem;  
                    CONTINUE;  
                END  
   
                -- Build Opportunity Report Name per Source System  
                SET @OpportunityReportNameSource = @OpportunityReportName + '_' + REPLACE(@SourceSystem, ' ', '_');  
   
                -- Drop existing view if it exists  
                SET @sql_drop = 'DROP VIEW IF EXISTS ' + QUOTENAME(@OpportunityReportNameSource) + ';';  
                PRINT(@SQL_DROP)
				EXEC sp_executesql @sql_drop;  
				
                -- Create Opportunity View per Source System with Header  
                SET @sql = 'CREATE VIEW ' + QUOTENAME(@OpportunityReportNameSource) + ' AS  
' + @Header + '  
SELECT ' + @FinalSelectFields + '   
FROM ' + QUOTENAME(@Dataset) + ' ' + @WhereClause + ';';  
                PRINT(@SQL)
				EXEC sp_executesql @sql;  
				
                -- Append to Opportunity selects  
                SET @OpportunitySelects = @OpportunitySelects + 'SELECT * FROM ' + QUOTENAME(@OpportunityReportNameSource) + ' UNION ALL' + CHAR(13);  
   
                FETCH NEXT FROM SourceCursor INTO @SourceSystem;  
            END  
   
            CLOSE SourceCursor;  
            DEALLOCATE SourceCursor;  
   
            -- Remove the last UNION ALL  
            IF LEN(@OpportunitySelects) >= 11  
                SET @OpportunitySelects = LEFT(@OpportunitySelects, LEN(@OpportunitySelects) - 11);  
            ELSE  
                SET @OpportunitySelects = '';  
   
            -- Create the final Opportunity view if there are any SELECT statements  
            IF @OpportunitySelects <> ''  
            BEGIN  
                -- Create final Opportunity View with Header  
                SET @sql = 'CREATE VIEW ' + QUOTENAME(@OpportunityReportName) + ' AS  
' + @Header + '  
' + @OpportunitySelects + ';'; 
				PRINT(@SQL)
                EXEC sp_executesql @sql;  
				
                -- Create the Missing report view on top of the Opportunity view with Header  
                SET @sql = 'CREATE VIEW ' + QUOTENAME(@ReportName) + ' AS  
' + @Header + '  
SELECT *, ''' + @Description + ''' AS Comment FROM ' +  
                           QUOTENAME(@OpportunityReportName) + ' WHERE  cast('+@Field+' as nvarchar(max)) IS NULL OR  cast('+@Field+' as nvarchar(max)) = ''''';  
                print(@sql)  
    EXEC sp_executesql @sql;  
   
                -- No need to update DataQuality_Reports since it's predefined  
            END  
            ELSE  
            BEGIN  
                -- If no data, you may want to log or handle accordingly  
                PRINT 'No data found for Dataset: ' + @Dataset + ', Field: ' + @Field;  
            END  
   
        END TRY  
        BEGIN CATCH  
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();  
            RAISERROR('An error occurred while processing Dataset: %s, Field: %s. Error: %s', 16, 1, @Dataset, @Field, @ErrorMessage);  
        END CATCH  
   
        FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @ReportName, @OpportunityReportName, @Description, @RuleName, @Author, @ViewType, @CreationDate;  
    END  
   
    CLOSE ReportCursor;  
    DEALLOCATE ReportCursor;  
END
GO
/****** Object:  StoredProcedure [dbo].[webDataQuality_Summary_CompletenessReportCreate01]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDataQuality_Summary_CompletenessReportCreate01]
AS
BEGIN
    SET NOCOUNT ON;
 
    DECLARE @Dataset NVARCHAR(100);
    DECLARE @Field NVARCHAR(100);
    DECLARE @ReportName NVARCHAR(200);
    DECLARE @OpportunityReportName NVARCHAR(200);
    DECLARE @Description NVARCHAR(200);
    DECLARE @DisplayFields NVARCHAR(MAX);
    DECLARE @ExpressionFields NVARCHAR(MAX);
    DECLARE @FinalSelectFields NVARCHAR(MAX);
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @sql_drop NVARCHAR(MAX);
 
    -- Cursor to loop over mandatory reports
    DECLARE ReportCursor CURSOR FAST_FORWARD FOR
    SELECT Dataset, Field, Report, OpportunityReport, Description
    FROM DataQuality_Reports
    WHERE ReportCategory = 'Mandatory Report';
 
    OPEN ReportCursor;
    FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @ReportName, @OpportunityReportName, @Description;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            -- Retrieve display fields and expressions
            SELECT 
                @DisplayFields = STRING_AGG(
                    CASE 
                        WHEN Alias IS NOT NULL AND Alias <> '' THEN QUOTENAME(DisplayField) + ' AS ' + QUOTENAME(Alias)
                        ELSE QUOTENAME(DisplayField)
                    END, ', ') WITHIN GROUP (ORDER BY [Order]),
                @ExpressionFields = STRING_AGG(
                    CASE 
                        WHEN ExpressionText IS NOT NULL AND ExpressionText <> ''
                            THEN 
                                CASE
                                    WHEN Alias IS NOT NULL AND Alias <> ''
                                        THEN '(' + ExpressionText + ') AS ' + QUOTENAME(Alias)
                                    ELSE '(' + ExpressionText + ')'
                                END
                            ELSE NULL
                    END, ', ') WITHIN GROUP (ORDER BY [Order])
            FROM DQTableFields_DisplayFields
            WHERE Dataset = @Dataset
              AND Field = @Field;
 
            -- If no display fields or expressions, use '*'
            IF @DisplayFields IS NULL OR @DisplayFields = ''
                SET @DisplayFields = '';
            IF @ExpressionFields IS NULL
                SET @ExpressionFields = '';
 
            -- Combine display fields and expressions
            IF @DisplayFields <> '' AND @ExpressionFields <> ''
                SET @FinalSelectFields = @DisplayFields + ', ' + @ExpressionFields;
            ELSE IF @DisplayFields <> ''
                SET @FinalSelectFields = @DisplayFields;
            ELSE IF @ExpressionFields <> ''
                SET @FinalSelectFields = @ExpressionFields;
            ELSE
                SET @FinalSelectFields = '*';
 
            -- Drop existing views if they exist
            SET @sql_drop = 'DROP VIEW IF EXISTS ' + QUOTENAME(@OpportunityReportName) + ';' + CHAR(13) +
                            'DROP VIEW IF EXISTS ' + QUOTENAME(@ReportName) + ';';
            EXEC sp_executesql @sql_drop;
 
            -- Create Opportunity View
            SET @sql = 'CREATE VIEW ' + QUOTENAME(@OpportunityReportName) + ' AS SELECT ' + @FinalSelectFields + ' FROM ' + QUOTENAME(@Dataset) + ';';
            EXEC sp_executesql @sql;
 
            -- Create Missing Report View from Opportunity View
            SET @sql = 'CREATE VIEW ' + QUOTENAME(@ReportName) + ' AS SELECT *, ''' + @Description + ''' AS Comment FROM ' +
                       QUOTENAME(@OpportunityReportName) + ' WHERE ' + QUOTENAME(@Field) + ' IS NULL OR ' + QUOTENAME(@Field) + ' = '''';';
            EXEC sp_executesql @sql;
 
            -- Update DataQuality_Summary if needed
            UPDATE DataQuality_Summary
            SET CompletenessReport = 'SELECT * FROM ' + QUOTENAME(@ReportName)
            WHERE Dataset = @Dataset AND Field = @Field;
 
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            RAISERROR('An error occurred while processing Dataset: %s, Field: %s. Error: %s', 16, 1, @Dataset, @Field, @ErrorMessage);
        END CATCH
 
        FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @ReportName, @OpportunityReportName, @Description;
    END
 
    CLOSE ReportCursor;
    DEALLOCATE ReportCursor;
END
GO
/****** Object:  StoredProcedure [dbo].[webDataQuality_Summary_CompletenessScore_AllUpd]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[webDataQuality_Summary_CompletenessScore_AllUpd]
as
begin

declare @Table nvarchar(100)
declare @Field nvarchar(100)
declare @sql nvarchar(max)
declare @Score decimal(8,5) 

declare FieldCursor cursor for 
select Dataset,Field from DataQuality_Summary

open FieldCursor

Fetch Next from FieldCursor into @Table, @Field

While @@FETCH_STATUS=0

begin


EXEC GetCompletenessScore @Table,@Field, @Score OUTPUT


update DataQuality_Summary set Completeness=@Score where [Dataset]=@Table and Field = @Field

Fetch Next from FieldCursor into @Table,@Field

end

close FieldCursor
Deallocate FieldCursor


end
GO
/****** Object:  StoredProcedure [dbo].[webDataQuality_Summary_CompletenessScore_FieldLevelUpd]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[webDataQuality_Summary_CompletenessScore_FieldLevelUpd](@Table nvarchar(100), @field nvarchar(100))
as
begin

--declare @Table nvarchar(100)
--declare @Field nvarchar(100)
declare @sql nvarchar(max)
declare @Score decimal(5,2) 

set @table='MARA'
set @Field='BISMT'
--select @NotNull=count(*) from sdbDPAAS..MARA where isnull(BISMT,'')<>''
--select @TotalRec=count(*) from sdbDPAAS..MARA 

--set @Sql = 'select @Score = cast(sum(iif(isnull('+@Field+','''')<>'''',1,0)) as Decimal(18,2))
--/Count(*) from sdbDPAAS..'+@Table

--print(@sql)
exec sp_executesql @sql
print(@Score)
end
GO
/****** Object:  StoredProcedure [dbo].[webDataset_Master_CleanupDel]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[webDataset_Master_CleanupDel] @DatasetID int
as
begin
declare @Dataset nvarchar(100)
declare @SQL nvarchar(200)
delete  from Dataset_Tables where DatasetId=@DatasetID

delete from Dataset_Joins where datasetid=@DatasetID
delete from Dataset_JoinConditions where datasetid=@DatasetID
delete from Dataset_SelectFields where datasetid=@DatasetID

select @Dataset=DatasetName from Dataset_master where DatasetID=@DatasetID

set @SQL = 'drop view if exists '+@Dataset
exec sp_executesql @SQL

end
GO
/****** Object:  StoredProcedure [dbo].[webDataSet_master_ParseSQL_InsertIntoSelectFieldsIns]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDataSet_master_ParseSQL_InsertIntoSelectFieldsIns]  @DatasetID INT,    @Select_SQL NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
 
    -- Temporary table to hold each field from the SELECT query
    CREATE TABLE #SelectFieldsTemp (
        SequenceNumber INT IDENTITY(1,1) PRIMARY KEY,
        FieldText NVARCHAR(MAX)
    );
 
    -- Replace CRLF and CR with LF for consistent line breaks
	SET @Select_SQL = REPLACE(@Select_SQL,'''','''''');
    SET @Select_SQL = REPLACE(REPLACE(@Select_SQL, CHAR(13) + CHAR(10), CHAR(10)), CHAR(13), CHAR(10));
 
    -- Split the SELECT query into lines (fields)
    DECLARE @FieldText NVARCHAR(MAX);
    DECLARE @Pos INT = 1;
    DECLARE @NextPos INT;
    DECLARE @Len INT = LEN(@Select_SQL);
 
    WHILE @Pos <= @Len
    BEGIN
        SET @NextPos = CHARINDEX(CHAR(10), @Select_SQL, @Pos);
        IF @NextPos = 0
        BEGIN
            SET @FieldText = SUBSTRING(@Select_SQL, @Pos, @Len - @Pos + 1);
            SET @Pos = @Len + 1;
        END
        ELSE
        BEGIN
            SET @FieldText = SUBSTRING(@Select_SQL, @Pos, @NextPos - @Pos);
            SET @Pos = @NextPos + 1;
        END
 
        -- Trim and check if the line is not empty
        SET @FieldText = LTRIM(RTRIM(@FieldText));
        IF @FieldText <> ''
        BEGIN
            INSERT INTO #SelectFieldsTemp (FieldText)
            VALUES (@FieldText);
        END
    END
 
    -- Variables for parsing
    DECLARE @SequenceNumber INT;
    DECLARE @Expression NVARCHAR(MAX);
    DECLARE @Alias NVARCHAR(100);
    DECLARE @ColumnID INT;
    DECLARE @DatasetTableID INT;
    DECLARE @IsExpression BIT;
    DECLARE @CleanExpression NVARCHAR(MAX);
 
    -- Cursor to loop through each field
    DECLARE FieldCursor CURSOR FOR
    SELECT SequenceNumber, FieldText
    FROM #SelectFieldsTemp
    ORDER BY SequenceNumber;
 
    OPEN FieldCursor;
    FETCH NEXT FROM FieldCursor INTO @SequenceNumber, @FieldText;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Trim field text and remove trailing commas
        SET @FieldText = LTRIM(RTRIM(@FieldText));
        IF RIGHT(@FieldText, 1) = ','
            SET @FieldText = LEFT(@FieldText, LEN(@FieldText) - 1);
 
        -- Initialize variables
        SET @Expression = NULL;
        SET @Alias = NULL;
        SET @ColumnID = NULL;
        SET @DatasetTableID = NULL;
        SET @IsExpression = 0;
        SET @CleanExpression = NULL;
 
        -- Check for ' AS ' to identify alias
        IF CHARINDEX(' AS ', UPPER(@FieldText)) > 0
        BEGIN
            SET @Expression = LEFT(@FieldText, CHARINDEX(' AS ', UPPER(@FieldText)) - 1);
            SET @Alias = LTRIM(RTRIM(RIGHT(@FieldText, LEN(@FieldText) - CHARINDEX(' AS ', UPPER(@FieldText)) - 3)));
        END
        ELSE
        BEGIN
            SET @Expression = @FieldText;
            SET @Alias = NULL;
        END
 
        -- Attempt to match the expression to a column in TableColumns
        -- Remove any database and schema prefixes for matching
        SET @CleanExpression = @Expression;
 
        -- Remove any brackets or quotes around identifiers
        SET @CleanExpression = REPLACE(REPLACE(@CleanExpression, '[', ''), ']', '');
        SET @CleanExpression = REPLACE(REPLACE(@CleanExpression, '"', ''), '', '');
 
        -- Extract table alias and column name
        DECLARE @TableAlias NVARCHAR(128) = NULL;
        DECLARE @ColumnName NVARCHAR(128) = NULL;
 
        IF CHARINDEX('.', @CleanExpression) > 0
        BEGIN
            -- Split at the last dot to separate table alias and column name
            SET @TableAlias = LEFT(@CleanExpression, LEN(@CleanExpression) - CHARINDEX('.', REVERSE(@CleanExpression)));
            SET @ColumnName = RIGHT(@CleanExpression, CHARINDEX('.', REVERSE(@CleanExpression)) - 1);
        END
        ELSE
        BEGIN
            SET @ColumnName = @CleanExpression;
        END
 
        -- Clean up identifiers
        SET @TableAlias = LTRIM(RTRIM(@TableAlias));
        SET @ColumnName = LTRIM(RTRIM(@ColumnName));
 
        -- Check if the expression is a complex expression (contains parentheses)
        IF CHARINDEX('(', @Expression) > 0 AND CHARINDEX(')', @Expression) > 0
        BEGIN
            SET @IsExpression = 1;
        END
 
        -- Try to find the DatasetTableID from Dataset_Tables using the table alias
        IF @TableAlias IS NOT NULL
        BEGIN
            SELECT TOP 1 @DatasetTableID = dt.DatasetTableID
            FROM Dataset_Tables dt
            INNER JOIN AvailableTables at ON dt.TableID = at.TableID
            WHERE dt.DatasetID = @DatasetID
              AND (dt.Alias = @TableAlias OR at.TableName = @TableAlias)
        END
 
        -- If DatasetTableID is found, get the corresponding TableID
        DECLARE @TableID INT = NULL;
        IF @DatasetTableID IS NOT NULL
        BEGIN
            SELECT @TableID = dt.TableID
            FROM Dataset_Tables dt
            WHERE dt.DatasetTableID = @DatasetTableID;
        END
 
        -- Try to find ColumnID in TableColumns using TableID and ColumnName
        IF @TableID IS NOT NULL
        BEGIN
            SELECT TOP 1 @ColumnID = tc.ColumnID
            FROM TableColumns tc
            WHERE tc.TableID = @TableID
              AND tc.ColumnName = @ColumnName;
        END
        ELSE
        BEGIN
            -- If no TableID, try to find ColumnID without TableID (less accurate)
            SELECT TOP 1 @ColumnID = tc.ColumnID
            FROM TableColumns tc
            WHERE tc.ColumnName = @ColumnName;
        END
 
        IF @ColumnID IS NOT NULL AND @IsExpression = 0
        BEGIN
            -- Simple column reference
            SET @IsExpression = 0;
        END
        ELSE
        BEGIN
            -- Expression or column not found
            SET @IsExpression = 1;
            SET @ColumnID = NULL;
            SET @DatasetTableID = NULL;
        END
 
        -- Insert into Dataset_SelectFields
        INSERT INTO Dataset_SelectFields (
            DatasetID,
            DatasetTableID,
            ColumnID,
            ExpressionText,
            Alias,
            SequenceNumber,
            IsVisible
        )
        VALUES (
            @DatasetID,
            @DatasetTableID,
            @ColumnID,
            CASE WHEN @IsExpression = 1 THEN @Expression ELSE NULL END,
            @Alias,
            @SequenceNumber,
            1  -- IsVisible
        );
 
        FETCH NEXT FROM FieldCursor INTO @SequenceNumber, @FieldText;
    END
 
    CLOSE FieldCursor;
    DEALLOCATE FieldCursor;
 
    DROP TABLE #SelectFieldsTemp;
END;
GO
/****** Object:  StoredProcedure [dbo].[webDataset_MasterGenerateDynamicQuery]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDataset_MasterGenerateDynamicQuery]
    @DatasetID INT,
    @DatabaseName SYSNAME = NULL  -- Optional: The database where the tables are located
    --@GeneratedQuery NVARCHAR(MAX) OUTPUT  -- Output parameter to return the generated query
AS
BEGIN
    SET NOCOUNT ON;
	--declare @DatasetId int = 5;
	--declare @DataBaseName nvarchar(100)
 
    -- Variable declarations
	DECLARE @GeneratedQuery NVARCHAR(MAX);
    DECLARE @SelectClause NVARCHAR(MAX) = '';
    DECLARE @FromClause NVARCHAR(MAX) = '';
    DECLARE @JoinClauses NVARCHAR(MAX) = '';
    DECLARE @WhereClause NVARCHAR(MAX) = '';  -- Optional: For future use
    DECLARE @OrderByClause NVARCHAR(MAX) = '';  -- Optional: For future use
    DECLARE @CRLF CHAR(2) = CHAR(13) + CHAR(10);  -- Carriage return and line feed for readability
    DECLARE @ViewName SYSNAME;
    DECLARE @DynamicSQL NVARCHAR(MAX);
 
    -- Temporary tables or table variables to hold intermediate data
    DECLARE @Tables TABLE (
        DatasetTableID INT,
        TableID INT,
        DatabaseName SYSNAME,
        SchemaName SYSNAME,
        TableName SYSNAME,
        Alias SYSNAME
    );
 
    DECLARE @SelectFields TABLE (
        SequenceNumber INT,
        SelectExpression NVARCHAR(MAX),
        Alias SYSNAME,
        IsExpression BIT
    );
 
    DECLARE @Joins TABLE (
        DatasetJoinID INT,
        JoinType VARCHAR(20),
        FromTableAlias SYSNAME,
        ToTableAlias SYSNAME,
        ToDatabaseName SYSNAME,
        ToSchemaName SYSNAME,
        ToTableName SYSNAME,
        OnClause NVARCHAR(MAX),
        AdditionalConditions VARCHAR(500),
		JoinOrder INT
    );
 
    -- Step 0: Retrieve the DatasetName from Dataset_Master
    SELECT @ViewName = DatasetName
    FROM Dataset_Master
    WHERE DatasetID = @DatasetID;
 
    IF @ViewName IS NULL
    BEGIN
        RAISERROR('DatasetID %d does not exist in Dataset_Master.', 16, 1, @DatasetID);
        RETURN;
    END
 
    -- Step 1: Retrieve the tables involved in the dataset
    INSERT INTO @Tables (DatasetTableID, TableID, DatabaseName, SchemaName, TableName, Alias)
    SELECT
        dt.DatasetTableID,
        dt.TableID,
        COALESCE(@DatabaseName, at.DatabaseName) AS DatabaseName,  -- Use @DatabaseName if provided
        'dbo' SchemaName,
        at.TableName,
        COALESCE(dt.Alias, at.TableName) AS Alias
    FROM
        Dataset_Tables dt
        INNER JOIN AvailableTables at ON dt.TableID = at.TableID
    WHERE
        dt.DatasetID = @DatasetID;
 --select '1.Tables' as ord , * from @Tables
    -- Step 2: Build the FROM clause
    SELECT TOP 1 @FromClause = 'FROM ' + QUOTENAME(DatabaseName) + '.' + QUOTENAME(SchemaName) + '.' + QUOTENAME(TableName) + ' AS ' + QUOTENAME(Alias)
    FROM @Tables
    ORDER BY DatasetTableID;  -- Assuming the first table is the base table
 --print('2.From Clause: '+@FromClause)
    -- Step 3: Retrieve the select fields
    INSERT INTO @SelectFields (SequenceNumber, SelectExpression, Alias, IsExpression)
    SELECT
        dsf.SequenceNumber,
        CASE
            WHEN dsf.ColumnID IS NOT NULL THEN
                QUOTENAME(t.Alias) + '.' + QUOTENAME(tc.ColumnName)
            ELSE
                dsf.ExpressionText
        END AS SelectExpression,
        COALESCE(dsf.Alias, tc.DisplayName, dsf.ExpressionText) AS Alias,
        CASE WHEN dsf.ColumnID IS NULL THEN 1 ELSE 0 END AS IsExpression
    FROM
        Dataset_SelectFields dsf
        LEFT JOIN TableColumns tc ON dsf.ColumnID = tc.ColumnID
        LEFT JOIN @Tables t ON tc.TableID = t.TableID
    WHERE
        dsf.DatasetID = @DatasetID
    ORDER BY
        dsf.SequenceNumber;
 --select '3. Selectfeilds' as Ord , * from @SelectFields
    -- Step 4: Build the SELECT clause using FOR XML PATH
    SELECT @SelectClause = STUFF((
        SELECT ',' + @CRLF +
            CASE
                WHEN IsExpression = 1 THEN
                    '(' + SelectExpression + ') AS ' + QUOTENAME(Alias)
                ELSE
                    SelectExpression + CASE WHEN Alias IS NOT NULL AND Alias <> SelectExpression THEN ' AS ' + QUOTENAME(Alias) ELSE '' END
            END
        FROM @SelectFields
        ORDER BY SequenceNumber
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, LEN(',' + @CRLF), '');
 
 --print('5.SelectClause '+@SelectClause)
 --select * from Dataset_Joins
    -- Step 5: Retrieve and build the JOIN clauses
    INSERT INTO @Joins (DatasetJoinID, JoinType, FromTableAlias, ToTableAlias, ToDatabaseName, ToSchemaName, ToTableName, OnClause, AdditionalConditions,JoinOrder)
    SELECT
        dj.DatasetJoinID,
        dj.JoinType,
        ft.Alias AS FromTableAlias,
        tt.Alias AS ToTableAlias,
        tt.DatabaseName,
        tt.SchemaName,
        tt.TableName,
        NULL AS OnClause,  -- We'll build this later
        dj.AdditionalConditions,
		dj.JoinOrder
    FROM
        Dataset_Joins dj
        left outer JOIN @Tables ft ON dj.FromTableID = ft.DatasetTableID
        left outer JOIN @Tables tt ON dj.ToTableID = tt.DatasetTableID
    WHERE
        dj.DatasetID = @DatasetID;
 --select  '5.Join ' as ord,* from @Joins
    -- Build the ON clauses by aggregating conditions
    DECLARE @JoinConditions TABLE (
        DatasetJoinID INT,
        Condition NVARCHAR(MAX),
        ConditionOrder INT
    );
 
    INSERT INTO @JoinConditions (DatasetJoinID, Condition, ConditionOrder)
    SELECT
        djc.DatasetJoinID,
        QUOTENAME(ft.Alias) + '.' + QUOTENAME(fc.ColumnName) + ' ' + djc.Operator + ' ' + QUOTENAME(tt.Alias) + '.' + QUOTENAME(tc.ColumnName),
        djc.ConditionOrder
    FROM
        Dataset_JoinConditions djc
        INNER JOIN Dataset_Joins dj ON djc.DatasetJoinID = dj.DatasetJoinID
        INNER JOIN @Tables ft ON dj.FromTableID = ft.DataSetTableID
        INNER JOIN @Tables tt ON dj.ToTableID = tt.DataSetTableID
        INNER JOIN TableColumns fc ON djc.FromColumnID = fc.ColumnID
        INNER JOIN TableColumns tc ON djc.ToColumnID = tc.ColumnID
    WHERE
        dj.DatasetID = @DatasetID;
 --select 'Join COnd'  as ord, * from @JoinConditions
    -- Update @Joins with the aggregated ON clauses
    UPDATE j
    SET OnClause = (
        SELECT STRING_AGG(c.Condition, ' AND ') within group (order by c.ConditionOrder)
        FROM @JoinConditions c
        WHERE c.DatasetJoinID = j.DatasetJoinID
        --ORDER BY c.ConditionOrder
    )
    FROM @Joins j;
 --select '7.' as ord ,* from @Joins
   	-- Build the JOIN clauses
SELECT @JoinClauses = ISNULL(@JoinClauses + @CRLF, '') +
    j.JoinType + ' ' +
    QUOTENAME(j.ToDatabaseName) + '.' + QUOTENAME(j.ToSchemaName) + '.' + QUOTENAME(j.ToTableName) + ' AS ' + QUOTENAME(j.ToTableAlias) +
    ' ON ' + j.OnClause +
    CASE WHEN j.AdditionalConditions IS NOT NULL THEN ' AND ' + j.AdditionalConditions ELSE '' END
FROM @Joins j
ORDER BY j.JoinOrder;
 
    -- Step 6: Assemble the complete query
    SET @GeneratedQuery = 'SELECT' + @CRLF + @SelectClause + @CRLF + @FromClause + @CRLF + @JoinClauses;
 --print(@GeneratedQuery)
    -- Step 7: Create or Alter the View
    SET @DynamicSQL = '
    IF OBJECT_ID(''' + QUOTENAME(@ViewName) + ''', ''V'') IS NOT NULL
    BEGIN
        DROP VIEW ' + QUOTENAME(@ViewName) + ';
    END;
 
    EXEC(''CREATE VIEW ' + QUOTENAME(@ViewName) + ' AS
    ' + REPLACE(@GeneratedQuery, '''', '''''') + ''');
    ';
 
    -- Execute the Dynamic SQL to create the view
    EXEC sp_executesql @DynamicSQL;
 
    -- For debugging purposes, you can print the generated query
    -- PRINT @GeneratedQuery;
    -- PRINT @DynamicSQL;
END;
GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_ConditionsBySegment_InsertConditionsFromSegmentConditions]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDQTableFields_ConditionsBySegment_InsertConditionsFromSegmentConditions](@Dataset nvarchar(100),
                                                                                                    @Field   nvarchar(100))
AS
  BEGIN
      SET NOCOUNT ON;

      --DECLARE @Dataset NVARCHAR(100);
      --DECLARE @Field NVARCHAR(100);
      DECLARE @SegmentField NVARCHAR(128);
      DECLARE @SegmentFieldAlias NVARCHAR(128);
      DECLARE @Value NVARCHAR(256);
      DECLARE @SegmentView NVARCHAR(128);
      DECLARE @ConditionField NVARCHAR(128);
      DECLARE @ConditionFieldInDataSet NVARCHAR(128);
      DECLARE @SourceSystem NVARCHAR(100);
      DECLARE @Condition NVARCHAR(MAX);
      DECLARE @Report NVARCHAR(400);
      DECLARE @CleanSegmentFieldAlias NVARCHAR(128);
      DECLARE @CleanValue NVARCHAR(256);
      DECLARE @ConditionValuesList NVARCHAR(MAX);
      DECLARE @SQL NVARCHAR(MAX);
      DECLARE @Params NVARCHAR(200);
      DECLARE @ErrorMessage NVARCHAR(4000);
      -- Temporary table to store active source systems
      DECLARE @ActiveSources TABLE
        (
           SourceSystem NVARCHAR(100)
        );

      INSERT INTO @ActiveSources
                  (SourceSystem)
      SELECT [Name]
      FROM   ztSources
      WHERE  Active = 1;

      -- Cursor to loop over records where Mandatory = 1 in DQTableFields_ConditionsBySegment
      DECLARE SegmentCursor CURSOR FAST_FORWARD FOR
        SELECT DQCS.Dataset,
               DQCS.Field,
               DQCS.SegmentField,
               DQCS.[Value],
               DQF.SegmentView,
               DQF.ConditionField,
               DQF.SegmentFieldAlias,
               DQF.ConditionFieldInDataSet
        FROM   DQTableFields_ConditionsBySegment DQCS
               INNER JOIN DQTableFields DQF
                       ON DQCS.Dataset = DQF.Dataset
                          AND DQCS.Field = DQF.Field
        WHERE  DQCS.Mandatory = 1
               AND DQF.ConditionBySegment = 1 and DQCS.DataSet=@Dataset and DQCS.Field=@Field;

      OPEN SegmentCursor;

      FETCH NEXT FROM SegmentCursor INTO @Dataset, @Field, @SegmentField, @Value, @SegmentView, @ConditionField, @SegmentFieldAlias, @ConditionFieldInDataSet;

      WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                -- Use SegmentFieldAlias and ConditionFieldAlias if available
                IF @SegmentFieldAlias IS NULL
                    OR @SegmentFieldAlias = ''
                  SET @SegmentFieldAlias = @SegmentField;

                IF @ConditionFieldInDataSet IS NULL
                    OR @ConditionFieldInDataSet = ''
                  SET @ConditionFieldInDataSet = @ConditionField;

                -- Clean SegmentFieldAlias and Value
                SET @CleanSegmentFieldAlias = Replace(Replace(@SegmentFieldAlias, ' ', '_'), '-', '_');
                SET @CleanValue = Replace(Replace(@Value, ' ', '_'), '-', '_');
                -- Construct Report Name (should match what's in DataQuality_Reports)
                SET @Report = 'tv' + @Dataset + '_' + @Field + '_'
                              + @CleanSegmentFieldAlias + '_' + @CleanValue
                              + '_MissingSel';

                -- For each active source system
                DECLARE SourceCursor CURSOR FAST_FORWARD FOR
                  SELECT SourceSystem
                  FROM   @ActiveSources;

                OPEN SourceCursor;

                FETCH NEXT FROM SourceCursor INTO @SourceSystem;

                WHILE @@FETCH_STATUS = 0
                  BEGIN
                      BEGIN TRY
                          -- Initialize @ConditionValuesList
                          SET @ConditionValuesList = NULL;

                          -- Create temp table
                          CREATE TABLE #ConditionValues
                            (
                               ConditionValue NVARCHAR(256)
                            );

                          -- Build dynamic SQL to insert into #ConditionValues
                          SET @SQL = N'INSERT INTO #ConditionValues (ConditionValue)                                  SELECT DISTINCT ['
                                     + @ConditionField
                                     + N']                                  FROM '
                                     + Quotename(@SegmentView)
                                     + N'                                  WHERE ['
                                     + @SegmentField
                                     + N'] = @Value AND [SourceSystemID] = @SourceSystemID                                  AND ['
                                     + @ConditionField + N'] IS NOT NULL AND ['
                                     + @ConditionField + N'] <> ''''';
                          SET @Params = N'@Value NVARCHAR(256), @SourceSystemID NVARCHAR(100)';
						  PRINT(@SQL)
                          EXEC sp_executesql
                            @SQL,
                            @Params,
                            @Value=@Value,
                            @SourceSystemID=@SourceSystem;
							PRINT('OK')
                          -- Build the condition string
                          SELECT @ConditionValuesList = STRING_AGG('''' + Replace(ConditionValue, '''', '''''')
                                                                   + '''', ',')
                          FROM   #ConditionValues;

                          IF @ConditionValuesList IS NOT NULL
                             AND @ConditionValuesList <> ''
                            BEGIN
                                IF (SELECT Count(*)
                                    FROM   #ConditionValues) = 1
                                  BEGIN
                                      SET @Condition = Quotename(@ConditionFieldInDataSet) + ' = '
                                                       + @ConditionValuesList;
                                  END
                                ELSE
                                  BEGIN
                                      SET @Condition = Quotename(@ConditionFieldInDataSet)
                                                       + ' IN (' + @ConditionValuesList + ')';
                                  END

                                -- Insert into DQTableFields_Conditions
                                -- Check if a record already exists
                                IF NOT EXISTS (SELECT 1
                                               FROM   DQTableFields_Conditions
                                               WHERE  Dataset = @Dataset
                                                      AND Field = @Field
                                                      AND SourceSystem = @SourceSystem
                                                      AND [Condition] = @Condition
                                                      AND Report = @Report)
                                  BEGIN
                                      INSERT INTO DQTableFields_Conditions
                                                  (Dataset,
                                                   Field,
                                                   Priority,
                                                   SourceSystem,
                                                   [Mandatory(No Conditions)],
                                                   [Condition],
                                                   Report)
                                      VALUES      ( @Dataset,
                                                    @Field,
                                                    1,
                                                    @SourceSystem,
                                                    0,
                                                    @Condition,
                                                    @Report );
                                  END
                            END

                          -- Drop temp table
						  
                          DROP TABLE #ConditionValues;
                      END TRY

                      BEGIN CATCH
                          SET @ErrorMessage = ERROR_MESSAGE();

                          RAISERROR('Error processing SourceSystem: %s, Dataset: %s, Field: %s. Error: %s',16,1,@SourceSystem,@Dataset,@Field,@ErrorMessage);
                      END CATCH

                      FETCH NEXT FROM SourceCursor INTO @SourceSystem;
                  END

                CLOSE SourceCursor;

                DEALLOCATE SourceCursor;
            END TRY

            BEGIN CATCH
                SET @ErrorMessage = ERROR_MESSAGE();

                RAISERROR('Error processing Dataset: %s, Field: %s, SegmentFieldAlias: %s, Value: %s. Error: %s',16,1,@Dataset,@Field,@SegmentFieldAlias,@Value,@ErrorMessage);
            END CATCH

            FETCH NEXT FROM SegmentCursor INTO @Dataset, @Field, @SegmentField, @Value, @SegmentView, @ConditionField, @SegmentFieldAlias, @ConditionFieldInDataSet;
        END

      CLOSE SegmentCursor;

      DEALLOCATE SegmentCursor;
  END 
GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_ConditionsBySegment_InsertDataQualityReportsFromConditionsIns]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDQTableFields_ConditionsBySegment_InsertDataQualityReportsFromConditionsIns](@Dataset nvarchar(100),@Field nvarchar(100))
AS
  BEGIN
      SET NOCOUNT ON;

      --DECLARE @Dataset NVARCHAR(100);
      --DECLARE @Field NVARCHAR(100);
      DECLARE @SegmentField NVARCHAR(128);
      DECLARE @SegmentFieldAlias NVARCHAR(128);
      DECLARE @Value NVARCHAR(256);
      DECLARE @Mandatory BIT;
      DECLARE @ReportName NVARCHAR(400);
      DECLARE @OpportunityReportName NVARCHAR(400);
      DECLARE @Description NVARCHAR(400);
      DECLARE @ReportCategory NVARCHAR(50);
      DECLARE @Exists INT;
      DECLARE @CleanSegmentFieldAlias NVARCHAR(128);
      DECLARE @CleanValue NVARCHAR(256);
      -- Cursor to loop over records where Mandatory = 1
      DECLARE ConditionCursor CURSOR FAST_FORWARD FOR
        SELECT DQCS.Dataset,
               DQCS.Field,
               DQCS.SegmentField,
               DQCS.[Value],
               DQCS.Mandatory,
               DQF.SegmentFieldAlias
        FROM   DQTableFields_ConditionsBySegment DQCS
               INNER JOIN DQTableFields DQF
                       ON DQCS.Dataset = DQF.Dataset
                          AND DQCS.Field = DQF.Field
        WHERE  DQCS.Mandatory = 1 and DQCS.Dataset=@Dataset  and DQCS.Field=@Field;

      OPEN ConditionCursor;

      FETCH NEXT FROM ConditionCursor INTO @Dataset, @Field, @SegmentField, @Value, @Mandatory, @SegmentFieldAlias;

      WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                -- Use SegmentFieldAlias if available, else default to SegmentField
                IF @SegmentFieldAlias IS NULL
                    OR @SegmentFieldAlias = ''
                  SET @SegmentFieldAlias = @SegmentField;

                -- Clean SegmentFieldAlias and Value
                SET @CleanSegmentFieldAlias = Replace(Replace(@SegmentFieldAlias, ' ', '_'), '-', '_');
                SET @CleanValue = Replace(Replace(@Value, ' ', '_'), '-', '_');
                -- Construct Report Name and Opportunity Report Name
                SET @ReportName = 'tv' + @Dataset + '_' + @Field + '_'
                                  + @CleanSegmentFieldAlias + '_' + @CleanValue
                                  + '_MissingSel';
                SET @OpportunityReportName = 'tv' + @Dataset + '_' + @Field + '_'
                                             + @CleanSegmentFieldAlias + '_' + @CleanValue
                                             + '_OpportunitySel';
                -- Construct Description
                SET @Description = @Field + ' is a Mandatory field for ' + @Value;
                -- Set Report Category
                SET @ReportCategory = 'Conditional Mandatory';

                -- Check if a record with the same Report name already exists
                SELECT @Exists = Count(1)
                FROM   DataQuality_Reports
                WHERE  Report = @ReportName;

                IF @Exists = 0
                  BEGIN
                      -- Insert into DataQuality_Reports
                      INSERT INTO DataQuality_Reports
                                  (Dataset,
                                   Field,
                                   Report,
                                   OpportunityReport,
                                   [Description],
                                   ReportCategory,
                                   Publish)
                      VALUES      ( @Dataset,
                                    @Field,
                                    @ReportName,
                                    @OpportunityReportName,
                                    @Description,
                                    @ReportCategory,
                                    1 );
                  END
            END TRY

            BEGIN CATCH
                DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();

                RAISERROR('Error inserting report for Dataset: %s, Field: %s, SegmentFieldAlias: %s, Value: %s. Error: %s',16,1,@Dataset,@Field,@SegmentFieldAlias,@Value,@ErrorMessage);
            END CATCH

            FETCH NEXT FROM ConditionCursor INTO @Dataset, @Field, @SegmentField, @Value, @Mandatory, @SegmentFieldAlias;
        END

      CLOSE ConditionCursor;

      DEALLOCATE ConditionCursor;
  END 



GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_ConditionsBySegment_PopulateDQTableFields_DisplayFieldsIns]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[webDQTableFields_ConditionsBySegment_PopulateDQTableFields_DisplayFieldsIns]  @Dataset NVARCHAR(100),@Field NVARCHAR(100)
AS  
  BEGIN  
      SET NOCOUNT ON;  
  
      --DECLARE @Dataset NVARCHAR(100);  
      --DECLARE @Field NVARCHAR(100);  
      DECLARE @Report NVARCHAR(400);  
      DECLARE @KeyFields TABLE  
        (  
           FieldName NVARCHAR(128),  
           [Order]   INT  
        );  
      DECLARE @KeyFieldList NVARCHAR(MAX);  
      DECLARE @ExpressionText NVARCHAR(MAX);  
      DECLARE @CurrentFieldOrder INT;  
      DECLARE @MaxOrder INT;  
      DECLARE @Order INT;  
      DECLARE @ErrorMessage NVARCHAR(4000);  
	  Declare @SegmentField_Report nvarchar(100);
      -- Cursor to loop over reports in DataQuality_Reports  

	   SELECT DQR.Dataset,  
               DQR.Field,  
               DQR.Report  
        FROM   DataQuality_Reports DQR  
               INNER JOIN DQTableFields DQF  
                       ON DQR.Dataset = DQF.Dataset  
                          AND DQR.Field = DQF.Field  
        WHERE  (DQF.ConditionBySegment = 1  
                OR DQF.Mandatory = 1) and DQR.Dataset=@Dataset and DQR.Field=@Field;  
	
		
      DECLARE ReportCursor CURSOR FAST_FORWARD FOR  
        SELECT DQR.Dataset,  
               DQR.Field,  
               DQR.Report  
        FROM   DataQuality_Reports DQR  
               INNER JOIN DQTableFields DQF  
                       ON DQR.Dataset = DQF.Dataset  
                          AND DQR.Field = DQF.Field  
        WHERE  (DQF.ConditionBySegment = 1  
                OR DQF.Mandatory = 1) and DQR.Dataset=@Dataset and DQR.Field=@Field;  
  
      OPEN ReportCursor;  
  
      FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @Report;  
  
      WHILE @@FETCH_STATUS = 0  
        BEGIN  
            BEGIN TRY  
                -- Clear previous key fields  
                DELETE FROM @KeyFields;  
				DELETE FROM DQTableFields_DisplayFields WHERE Dataset =@Dataset AND Field=@Field
                -- Get key fields for the dataset  
                INSERT INTO @KeyFields  
                            (FieldName,  
                             [Order])  
                SELECT Field,  
                       [Order]  
                FROM   DQTableFields  
                WHERE  Dataset = @Dataset  
                       AND [Key] = 1;  
  
                -- If no key fields, skip to next report  
                IF (SELECT Count(*)  
                    FROM   @KeyFields) = 0  
                  BEGIN  
                      FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @Report;  
  
                      CONTINUE;  
                  END  
  
                -- Build the concatenation expression for the composite key  
                SELECT @KeyFieldList = STRING_AGG( Quotename(FieldName) , ' + ''_'' + ') within group (order by [Order])  
				FROM   @KeyFields;  

				PRINT(@KeyFieldList)
  
                SET @ExpressionText =   @KeyFieldList;  
  
                -- Determine the maximum order value for ordering  
                SELECT @MaxOrder = ISNULL(Max([Order]), 0)  
                FROM   @KeyFields;  
  
                -- Set Order for SourcesystemID and Key  
                SET @Order = 1;  
  
                -- Insert SourcesystemID as Order 1 if not already present  
                IF NOT EXISTS (SELECT 1  
                               FROM   DQTableFields_DisplayFields  
                               WHERE  Dataset = @Dataset  
                                      AND Field = @Field  
                                      AND Report = @Report  
                                      AND (DisplayField = 'SourcesystemID' or DisplayField = 'zSourcesystemID'))  
                  BEGIN  
                      INSERT INTO DQTableFields_DisplayFields  
                                  (Dataset,  
                                   Field,  
                                   Report,  
                                   [Order],  
                                   DisplayField,  
                                   ExpressionText,  
                                   Alias)  
                      VALUES      ( @Dataset,  
                                    @Field,  
                                    @Report,  
                                    @Order,  
                                    'SourcesystemID',  
                                    NULL,  
                                    NULL );  
                  END  
  
                -- Insert Composite Key as Order 2 if not already present  
                SET @Order = @Order + 1;  
  
                IF NOT EXISTS (SELECT 1  
                               FROM   DQTableFields_DisplayFields  
                               WHERE  Dataset = @Dataset  
                                      AND Field = @Field  
                                      AND Report = @Report  
                                      AND Alias = 'Key')  
                  BEGIN  
                      INSERT INTO DQTableFields_DisplayFields  
                                  (Dataset,  
                                   Field,  
                                   Report,  
                                   [Order],  
                                   DisplayField,  
                                   ExpressionText,  
                                   Alias)  
                      VALUES      ( @Dataset,  
                                    @Field,  
                                    @Report,  
                                    @Order,  
                                    NULL,  
                                    @ExpressionText,  
                                    'Key' );  
                  END  
  
                -- Insert individual key fields starting from Order 3  
                SET @Order = @Order + 1; 
				

				 SELECT @Dataset             AS Dataset,  
                       @Field               AS Field,  
                       @Report              AS Report,  
                       @Order + [Order] - 1 AS [Order],  
                       KF.FieldName         AS DisplayField,  
                       NULL                 AS ExpressionText,  
                       NULL                 AS Alias  
                FROM   @KeyFields KF  
                WHERE  NOT EXISTS (SELECT 1  
                                   FROM   DQTableFields_DisplayFields DFD  
                                   WHERE  DFD.Dataset = @Dataset  
                                          AND DFD.Field = @Field  
                                          AND DFD.Report = @Report  
                                          AND DFD.DisplayField = KF.FieldName)  
                ORDER  BY [Order];  
  
                INSERT INTO DQTableFields_DisplayFields  
                            (Dataset,  
                             Field,  
                             Report,  
                             [Order],  
                             DisplayField,  
                             ExpressionText,  
                             Alias)  
                SELECT @Dataset             AS Dataset,  
                       @Field               AS Field,  
                       @Report              AS Report,  
                       @Order + [Order] - 1 AS [Order],  
                       KF.FieldName         AS DisplayField,  
                       NULL                 AS ExpressionText,  
                       NULL                 AS Alias  
                FROM   @KeyFields KF  
                WHERE  NOT EXISTS (SELECT 1  
                                   FROM   DQTableFields_DisplayFields DFD  
                                   WHERE  DFD.Dataset = @Dataset  
                                          AND DFD.Field = @Field  
                                          AND DFD.Report = @Report  
                                          AND DFD.DisplayField = KF.FieldName)  
                ORDER  BY [Order];  
  
                -- Insert the current field if not already present  
                SELECT @CurrentFieldOrder = @Order + @MaxOrder;  
  
                IF NOT EXISTS (SELECT 1  
                               FROM   DQTableFields_DisplayFields  
                               WHERE  Dataset = @Dataset  
                                      AND Field = @Field  
                                      AND Report = @Report  
                                      AND DisplayField = @Field)  
                  BEGIN  
                      INSERT INTO DQTableFields_DisplayFields  
                                  (Dataset,  
                                   Field,  
                                   Report,  
                                   [Order],  
                                   DisplayField,  
                                   ExpressionText,  
                                   Alias)  
                      VALUES      ( @Dataset,  
                                    @Field,  
                                    @Report,  
                                    @CurrentFieldOrder,  
                                    @Field,  
                                    NULL,  
                                    NULL );  
                  END  



				  -- Insert the Segment  field if not already present  
                SELECT @CurrentFieldOrder = @Order + @MaxOrder;  
				select @SegmentField_Report=ConditionFieldInDataSet from DQTableFields where ConditionBySegment =1 and SegmentView is not null and Dataset=@Dataset and Field=@Field
				--print('Hi - '+@SegmentField_Report)
                IF NOT EXISTS (SELECT 1  
                               FROM   DQTableFields_DisplayFields  
                               WHERE  Dataset = @Dataset  
                                      AND Field = @Field  
                                      AND Report = @Report  
                                      AND DisplayField = @SegmentField_Report)  
                  BEGIN  
                      INSERT INTO DQTableFields_DisplayFields  
                                  (Dataset,  
                                   Field,  
                                   Report,  
                                   [Order],  
                                   DisplayField,  
                                   ExpressionText,  
                                   Alias)  
                      VALUES      ( @Dataset,  
                                    @Field,  
                                    @Report,  
                                    @CurrentFieldOrder,  
                                    @SegmentField_Report,  
                                    NULL,  
                                    NULL );  
                  END  
            END TRY  
  
            BEGIN CATCH  
                SET @ErrorMessage = ERROR_MESSAGE();  
  
                RAISERROR('Error processing Dataset: %s, Field: %s, Report: %s. Error: %s',16,1,@Dataset,@Field,@Report,@ErrorMessage);  
            END CATCH  
  
            FETCH NEXT FROM ReportCursor INTO @Dataset, @Field, @Report;  
        END  
  
      CLOSE ReportCursor;  
  
      DEALLOCATE ReportCursor;  
  END
GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_ConditionsBySegment_UnPublish_NonMandatoryReportsIns]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDQTableFields_ConditionsBySegment_UnPublish_NonMandatoryReportsIns](@Dataset nvarchar(100),
                                                                                                    @Field   nvarchar(100))
AS
  BEGIN
      SET NOCOUNT ON;

      --DECLARE @Dataset NVARCHAR(100);
      --DECLARE @Field NVARCHAR(100);
      DECLARE @SegmentField NVARCHAR(128);
      DECLARE @SegmentFieldAlias NVARCHAR(128);
      DECLARE @Value NVARCHAR(256);
      DECLARE @Mandatory BIT;
      DECLARE @ReportName NVARCHAR(400);
      DECLARE @OpportunityReportName NVARCHAR(400);
      DECLARE @Description NVARCHAR(400);
      DECLARE @ReportCategory NVARCHAR(50);
      DECLARE @Exists INT;
      DECLARE @CleanSegmentFieldAlias NVARCHAR(128);
      DECLARE @CleanValue NVARCHAR(256);
      -- Cursor to loop over records where Mandatory = 1
      DECLARE ConditionCursor CURSOR FAST_FORWARD FOR
        SELECT DQCS.Dataset,
               DQCS.Field,
               DQCS.SegmentField,
               DQCS.[Value],
               DQCS.Mandatory,
               DQF.SegmentFieldAlias
        FROM   DQTableFields_ConditionsBySegment DQCS
               INNER JOIN DQTableFields DQF
                       ON DQCS.Dataset = DQF.Dataset
                          AND DQCS.Field = DQF.Field
        WHERE  isnull(DQCS.Mandatory,0) = 0
               and DQCS.Dataset = @Dataset
               and DQCS.Field = @Field;

      OPEN ConditionCursor;

      FETCH NEXT FROM ConditionCursor INTO @Dataset, @Field, @SegmentField, @Value, @Mandatory, @SegmentFieldAlias;

      WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                -- Use SegmentFieldAlias if available, else default to SegmentField
                IF @SegmentFieldAlias IS NULL
                    OR @SegmentFieldAlias = ''
                  SET @SegmentFieldAlias = @SegmentField;

                -- Clean SegmentFieldAlias and Value
                SET @CleanSegmentFieldAlias = Replace(Replace(@SegmentFieldAlias, ' ', '_'), '-', '_');
                SET @CleanValue = Replace(Replace(@Value, ' ', '_'), '-', '_');
                -- Construct Report Name and Opportunity Report Name
                SET @ReportName = 'tv' + @Dataset + '_' + @Field + '_'
                                  + @CleanSegmentFieldAlias + '_' + @CleanValue
                                  + '_MissingSel';
                
                SELECT @Exists = Count(1)
                FROM   DataQuality_Reports
                WHERE  Report = @ReportName;

                IF @Exists = 1
                  BEGIN
					update DataQuality_Reports set publish=0 where Report=@ReportName and Dataset=@Dataset and Field=@Field
		
                  END
            END TRY

            BEGIN CATCH
                DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();

                RAISERROR('Error updating report for Dataset: %s, Field: %s, SegmentFieldAlias: %s, Value: %s. Error: %s',16,1,@Dataset,@Field,@SegmentFieldAlias,@Value,@ErrorMessage);
            END CATCH

            FETCH NEXT FROM ConditionCursor INTO @Dataset, @Field, @SegmentField, @Value, @Mandatory, @SegmentFieldAlias;
        END

      CLOSE ConditionCursor;

      DEALLOCATE ConditionCursor;
  END 
GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_Description_Update]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[webDQTableFields_Description_Update](@Dataset nvarchar(200))
as
begin
declare @SAPtables nvarchar(200)
declare @table nvarchar(200)
--declare @dataset nvarchar(200)='IV_CSM_201_KNB1_CustomerMaster_CompanyCode'
select @SAPtables=SAPTable from DQtables where Dataset=@Dataset

declare  tableCursor cursor for
select rtrim(ltrim([value])) from string_split(@SAPtables,',')

OPEN tableCursor  
FETCH NEXT FROM tableCursor INTO @table  
WHILE @@FETCH_STATUS = 0
	BEGIN
		update DQTableFields set [Description]=SystemType.FieldDescription 
		from DQTableFields inner join 
		DQTables on DQTableFields.Dataset=DQTables.Dataset inner join 
		webSystemTypeFieldsList SystemType on DQTableFields.Field=SystemType.Field and SystemType.TableName=@table
		where DQTableFields.Dataset = @dataset and DQTableFields.[Description] is null

    FETCH NEXT FROM tableCursor INTO @table 
	END

CLOSE tableCursor
DEALLOCATE tableCursor

update DQTableFields set [Description]=Field where Dataset=@dataset and [Description] is null


END
GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_GenerateDummyValuesResults_FullWordSearchIns]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDQTableFields_GenerateDummyValuesResults_FullWordSearchIns]
    @Dataset NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
 -- declare @dataset nvarchar(100)='IV_CSM_201_KNA1_CustomerMaster'
    DECLARE @RunDate DATETIME = GETDATE();
    DECLARE @Field NVARCHAR(128);
    DECLARE @KeyFields NVARCHAR(MAX);
    DECLARE @DisplayFields NVARCHAR(MAX);
    DECLARE @AllFields NVARCHAR(MAX);
    DECLARE @DatasetTableName NVARCHAR(128);
    DECLARE @ResultTableName NVARCHAR(128);
    DECLARE @InsertColumns NVARCHAR(MAX);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ColumnDefinitions NVARCHAR(MAX);
 
    -- Initialize variables
    SET @DatasetTableName = QUOTENAME(@Dataset);
    SET @ResultTableName = QUOTENAME(@Dataset + '_DummyValues_AttributeLevel');
 
    -- Get Key Fields and Display Fields
    SELECT @KeyFields = STRING_AGG(QUOTENAME(Field), ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND [Key] = 1;
 
    SELECT @DisplayFields = STRING_AGG(QUOTENAME(Field), ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND ReportDisplay = 1;
 
    -- Combine Key Fields and Display Fields, remove duplicates
    SELECT @AllFields = STRING_AGG(QUOTENAME(Field), ', ')
    FROM (
        SELECT DISTINCT Field
        FROM DQTableFields
        WHERE Dataset = @Dataset AND ([Key] = 1 OR ReportDisplay = 1)
    ) AS DistinctFields;
 
    -- Build column definitions with data types
    DECLARE @FieldsTable TABLE
    (
        FieldName        NVARCHAR(128),
        DataType         NVARCHAR(128),
        MaxLength        INT,
        NumericPrecision INT,
        NumericScale     INT
    );
 
    INSERT INTO @FieldsTable
    (FieldName, DataType, MaxLength, NumericPrecision, NumericScale)
    SELECT COLUMN_NAME AS FieldName,
           DATA_TYPE AS DataType,
           CHARACTER_MAXIMUM_LENGTH AS MaxLength,
           NUMERIC_PRECISION AS NumericPrecision,
           NUMERIC_SCALE AS NumericScale
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @Dataset
          AND COLUMN_NAME IN (
              SELECT Field
              FROM DQTableFields
              WHERE Dataset = @Dataset AND ([Key] = 1 OR ReportDisplay = 1)
          );
 
    -- Build column definitions
    SELECT @ColumnDefinitions = STRING_AGG(
        QUOTENAME(FieldName) + ' ' + DataType +
        CASE
            WHEN DataType IN ('varchar', 'nvarchar', 'char', 'nchar') THEN
                '(' + CASE WHEN MaxLength = -1 THEN 'MAX' ELSE CAST(MaxLength AS NVARCHAR(10)) END + ')'
            WHEN DataType IN ('decimal', 'numeric') THEN
                '(' + CAST(NumericPrecision AS NVARCHAR(10)) + ',' + CAST(NumericScale AS NVARCHAR(10)) + ')'
            ELSE ''
        END,
        ', '
    )
    FROM @FieldsTable;
 
    -- Create the result table if it doesn't exist
    SET @SQL = '
    IF OBJECT_ID(''' + @ResultTableName + ''', ''U'') IS NULL
    BEGIN
        CREATE TABLE ' + @ResultTableName + ' (
            RunDate DATETIME,
            ' + @ColumnDefinitions + ',
            Field NVARCHAR(128),
            FieldValue NVARCHAR(MAX),
            DummyValue NVARCHAR(100),
            MatchType NVARCHAR(20)
        );
    END';
    EXEC (@SQL);
 
    -- Truncate the result table
    SET @SQL = 'TRUNCATE TABLE ' + @ResultTableName + ';';
    EXEC (@SQL);
 
    -- Get the fields to check for dummy values
    DECLARE DummyFieldCursor CURSOR FAST_FORWARD FOR
        SELECT Field
        FROM DQTableFields
        WHERE Dataset = @Dataset AND CheckForDummyValues = 1;
 
    OPEN DummyFieldCursor;
    FETCH NEXT FROM DummyFieldCursor INTO @Field;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Create a temporary table for dummy values
        IF OBJECT_ID('tempdb..#DummyValues') IS NOT NULL DROP TABLE #DummyValues;
        CREATE TABLE #DummyValues (
            DummyValue NVARCHAR(100),
            MatchType NVARCHAR(20),
            EscapedDummyValue NVARCHAR(200)
        );
 
        -- Get the list of dummy values into the temporary table
        INSERT INTO #DummyValues (DummyValue, MatchType, EscapedDummyValue)
        SELECT
            DummyValue,
            MatchType,
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(DummyValue, '\', '\\'), -- Escape backslash
                            '%', '\%'),
                        '_', '\_'),
                    '[', '\['),
                ']', '\]'),
            '^', '\^')
        FROM DummyValues
        WHERE Dataset = @Dataset AND Field = @Field;
 
        -- Build the INSERT statement
        SET @InsertColumns = 'RunDate, ' + @AllFields + ', Field, FieldValue, DummyValue, MatchType';
 
        -- Build the dynamic SQL for matching
        SET @SQL = '
        INSERT INTO ' + @ResultTableName + ' (' + @InsertColumns + ')
        SELECT
            ''' + CONVERT(NVARCHAR(20), @RunDate, 120) + ''' AS RunDate,
            ' + @AllFields + ',
            ''' + @Field + ''' AS Field,
            D.' + QUOTENAME(@Field) + ' AS FieldValue,
            DV.DummyValue,
            DV.MatchType
        FROM ' + @DatasetTableName + ' D
        CROSS JOIN #DummyValues DV
        WHERE D.' + QUOTENAME(@Field) + ' IS NOT NULL AND ';
 
        -- Build the matching conditions based on MatchType
        SET @SQL = @SQL + '(
            (DV.MatchType = ''EXACT'' AND D.' + QUOTENAME(@Field) + ' = DV.DummyValue)
            OR
            (DV.MatchType = ''Contains'' AND D.' + QUOTENAME(@Field) + ' LIKE ''%'' + DV.EscapedDummyValue + ''%'' ESCAPE ''\'')
            OR
            (DV.MatchType = ''Starts With'' AND D.' + QUOTENAME(@Field) + ' LIKE DV.EscapedDummyValue + ''%'' ESCAPE ''\'')
            OR
            (DV.MatchType = ''Ends With'' AND D.' + QUOTENAME(@Field) + ' LIKE ''%'' + DV.EscapedDummyValue ESCAPE ''\'')
        );';
 
        -- Execute the dynamic SQL
        print(@sql)
		--EXEC (@SQL);
 
        -- Drop the temporary dummy values table
        DROP TABLE #DummyValues;
 
        FETCH NEXT FROM DummyFieldCursor INTO @Field;
    END
 
    CLOSE DummyFieldCursor;
    DEALLOCATE DummyFieldCursor;
 
    PRINT 'Processed dataset ' + @Dataset + '.';
END

GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_GenerateDummyValueViews_Build]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[webDQTableFields_GenerateDummyValueViews_Build]
    @Dataset NVARCHAR(100), @field nvarchar(200)
AS
BEGIN
    SET NOCOUNT ON;
 
    --DECLARE @Field NVARCHAR(128);
    DECLARE @KeyFields NVARCHAR(MAX);
    DECLARE @DisplayFields NVARCHAR(MAX);
    DECLARE @AllFields NVARCHAR(MAX);
    DECLARE @ResultTableName NVARCHAR(128);
    DECLARE @ReportViewName NVARCHAR(200);
    DECLARE @OpportunityViewName NVARCHAR(200);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @ErrorMessage NVARCHAR(4000);
 
    DECLARE FieldCursor CURSOR FAST_FORWARD FOR
        SELECT Field
        FROM DQTableFields
        WHERE CheckForDummyValues = 1 AND Dataset = @Dataset;
 
    OPEN FieldCursor;
    FETCH NEXT FROM FieldCursor INTO @Field;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            -- Initialize variables
            SET @ResultTableName = QUOTENAME(@Dataset + '_DummyValues');
            SET @ReportViewName = 'tv' + @Dataset + '_' + @Field + '_DummyValue_RptSel';
            SET @OpportunityViewName = 'tv' + @Dataset + '_' + @Field + '_DummyValue_OptSel';
			print (@ResultTableName)
			print (@ReportViewName)
			print (@OpportunityViewName)
 
            -- Get Key Fields and Display Fields
            SELECT @KeyFields = STRING_AGG(QUOTENAME(Field), ', ')
            FROM DQTableFields
            WHERE Dataset = @Dataset AND [Key] = 1;
			print (@KeyFields)

 
            SELECT @DisplayFields = STRING_AGG(QUOTENAME(Field), ', ')
            FROM DQTableFields
            WHERE Dataset = @Dataset AND ReportDisplay = 1;
			print (@DisplayFields)
            -- Combine Key Fields and Display Fields, remove duplicates
            SELECT @AllFields = STRING_AGG('D.' + QUOTENAME(Field), ', ')
            FROM (
                SELECT DISTINCT Field
                FROM DQTableFields
                WHERE Dataset = @Dataset AND ([Key] = 1 OR ReportDisplay = 1)
            ) AS DistinctFields;

			print(@AllFields)

            -- Build join condition based on key fields
            DECLARE @JoinConditions NVARCHAR(MAX);
            SELECT @JoinConditions = STRING_AGG('D.' + QUOTENAME(Field) + ' = DV.' + QUOTENAME(Field), ' AND ')
            FROM DQTableFields
            WHERE Dataset = @Dataset AND [Key] = 1;
			print(@JoinConditions)
            -- Create Report View
            SET @SQL = '
            CREATE OR ALTER VIEW dbo.' + QUOTENAME(@ReportViewName) + ' AS
            SELECT ' + @AllFields + ', DV.Field, DV.FieldValue, DV.DummyValue
            FROM ' + QUOTENAME(@Dataset) + ' D
            INNER JOIN ' + @ResultTableName + ' DV ON ' + @JoinConditions + '
            WHERE DV.Field = ''' + @Field + ''';';
			print(@sql)
            EXEC sp_executesql @SQL;
 
            -- Register Report View in DataQuality_Reports
            IF NOT EXISTS (
                SELECT 1
                FROM DataQuality_Reports
                WHERE Dataset = @Dataset AND Field = @Field AND Report = @ReportViewName
            )
            BEGIN
                INSERT INTO DataQuality_Reports
                (Dataset, Field, Report, Description, ReportCategory, Publish)
                VALUES
                (@Dataset, @Field, @ReportViewName,
                 'Report for dummy values in field ' + @Field + ' of dataset ' + @Dataset,
                 'Dummy Values', 1);
            END
 
            -- Create Opportunity View
            SET @SQL = '
            CREATE OR ALTER VIEW dbo.' + QUOTENAME(@OpportunityViewName) + ' AS
            SELECT ' + @AllFields + '
            FROM ' + QUOTENAME(@Dataset) + ' D;';
			PRINT (@SQL)
            EXEC sp_executesql @SQL;
 
            PRINT 'Views created for Dataset: ' + @Dataset + ', Field: ' + @Field + '.';
        END TRY
        BEGIN CATCH
            SET @ErrorMessage = ERROR_MESSAGE();
            RAISERROR('Error processing Dataset: %s, Field: %s. Error: %s', 16, 1, @Dataset, @Field, @ErrorMessage);
        END CATCH
 
        FETCH NEXT FROM FieldCursor INTO @Field;
    END
 
    CLOSE FieldCursor;
    DEALLOCATE FieldCursor;
END

GO
/****** Object:  StoredProcedure [dbo].[webDQTableFields_Populate_SegmentsIns]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDQTableFields_Populate_SegmentsIns](@Dataset nvarchar(100),
                                                           @Field   nvarchar(100))
AS
  BEGIN
      SET NOCOUNT ON;

      -- Variables
      --DECLARE @Dataset NVARCHAR(100);
      --DECLARE @Field NVARCHAR(100);
      DECLARE @SegmentView NVARCHAR(128);
      DECLARE @SegmentField NVARCHAR(128);
      DECLARE @ConditionField NVARCHAR(128);
      DECLARE @SQL NVARCHAR(MAX);
      DECLARE @SegmentValue NVARCHAR(256);
      DECLARE @ErrorMessage NVARCHAR(4000);

      -- Temporary table to store segment values
      CREATE TABLE #SegmentValues
        (
           SegmentValue NVARCHAR(256)
        );

      -- Cursor to loop over fields with ConditionBySegment = 1
      DECLARE FieldCursor CURSOR FAST_FORWARD FOR
        SELECT Dataset,
               Field,
               SegmentView,
               SegmentField,
               ConditionField
        FROM   DQTableFields
        WHERE  ConditionBySegment = 1 and Dataset=@Dataset and Field=@Field;

      OPEN FieldCursor;

      FETCH NEXT FROM FieldCursor INTO @Dataset, @Field, @SegmentView, @SegmentField, @ConditionField;

      WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                -- Check if SegmentView exists
                IF NOT EXISTS (SELECT 1
                               FROM   INFORMATION_SCHEMA.TABLES
                               WHERE  TABLE_NAME = @SegmentView)
                  BEGIN
                      RAISERROR('SegmentView %s does not exist.',16,1,@SegmentView);

                      FETCH NEXT FROM FieldCursor INTO @Dataset, @Field, @SegmentView, @SegmentField, @ConditionField;

                      CONTINUE;
                  END

                -- Clear temporary table
                DELETE FROM #SegmentValues;

                -- Build dynamic SQL to insert segment values into temporary table
                SET @SQL = N'                 INSERT INTO #SegmentValues (SegmentValue)                 SELECT DISTINCT ['
                           + @SegmentField + N']                 FROM '
                           + Quotename(@SegmentView)
                           + N'                 WHERE [' + @SegmentField
                           + N'] IS NOT NULL AND [' + @SegmentField
                           + N'] <> ''''             ';

                EXEC sp_executesql
                  @SQL;

                select *
                from   #SegmentValues

                ---- Delete existing records for this Dataset and Field in DQTableFields_ConditionsBySegment
                --DELETE FROM DQTableFields_ConditionsBySegment
                --WHERE  Dataset = @Dataset
                --       AND Field = @Field;
                -- Insert into DQTableFields_ConditionsBySegment
                INSERT INTO DQTableFields_ConditionsBySegment
                            (Dataset,
                             Field,
                             SegmentField,
                             [Value],
                             Mandatory)
                SELECT DISTINCT @Dataset        AS Dataset,
                                @Field          AS Field,
                                @SegmentField   AS SegmentField,
                                SV.SegmentValue AS [Value],
                                0               AS Mandatory -- You can set this to 0 if you prefer
                FROM   #SegmentValues SV
                       left outer join DQTableFields_ConditionsBySegment CS
                                    on SV.SegmentValue = CS.[VALUE]
                                       AND Dataset = @Dataset
                                       and Field = @Field
                                       and SegmentField = @SegmentField
                where  CS.[Value] is null
            END TRY

            BEGIN CATCH
                SET @ErrorMessage = ERROR_MESSAGE();

                RAISERROR('An error occurred while processing Dataset: %s, Field: %s. Error: %s',16,1,@Dataset,@Field,@ErrorMessage);
            END CATCH

            FETCH NEXT FROM FieldCursor INTO @Dataset, @Field, @SegmentView, @SegmentField, @ConditionField;
        END

      CLOSE FieldCursor;

      DEALLOCATE FieldCursor;

      -- Drop temporary table
      DROP TABLE #SegmentValues;
  END 
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_CleanupDel]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[webDQTables_CleanupDel] @Dataset nvarchar(100)
as
begin
--declare @Dataset nvarchar(100)
declare @SQL nvarchar(200)
delete  from DQTableFields where Dataset=@Dataset

delete from DQTableFields_ConditionsBySegment where  Dataset=@Dataset
delete from DataQuality_Reports where Dataset=@Dataset
delete from DQTableFields_Conditions where  Dataset=@Dataset
delete from DQTableFields_DisplayFields where  Dataset=@Dataset

set @SQL = 'drop table if exists '+@Dataset+'_Result'
exec sp_executesql @SQL

end
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_DataSet_Completeness_GenerateAttributeLevelReport]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE PROCEDURE [dbo].[webDQTables_DataSet_Completeness_GenerateAttributeLevelReport]  
    @Dataset NVARCHAR(100)  
AS  
BEGIN  
    SET NOCOUNT ON;  
   
    -- Declare variables  
 --declare @Dataset nvarchar(200)='IV_CSM_201_Customer_Address'  
    DECLARE @ResultTable NVARCHAR(128) = QUOTENAME(@Dataset + 'Completeness_RecordLevelResult');  
    DECLARE @SummaryTable NVARCHAR(128) = QUOTENAME(@Dataset + 'Completeness_AttributeLevelResult');  
    DECLARE @KeyFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));  
    DECLARE @ActiveFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));  
    DECLARE @AdditionalFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));  
    DECLARE @KeyFieldList NVARCHAR(MAX);  
    DECLARE @KeyFieldListForSelect NVARCHAR(MAX);  
    DECLARE @KeyFieldListForConcat NVARCHAR(MAX);  
    DECLARE @AdditionalFieldList NVARCHAR(MAX);  
    DECLARE @AdditionalFieldListForSelect NVARCHAR(MAX);  
    DECLARE @SQL NVARCHAR(MAX);  
    DECLARE @FieldValuesList NVARCHAR(MAX);  
    DECLARE @DatasetSafe NVARCHAR(128) = REPLACE(REPLACE(@ResultTable, '[', ''), ']', '');  
    DECLARE @SegmentField NVARCHAR(100);  
	DECLARE @sqlsegment NVARCHAR(MAX)
   
    -- Step 1: Retrieve Key Fields from DQTableFields  
    INSERT INTO @KeyFields (FieldOrder, FieldName)  
    SELECT [Order], Field  
    FROM DQTableFields  
    WHERE Dataset = @Dataset AND [Key] = 1  
    ORDER BY [Order];  
   
    -- Validate presence of key fields  
    IF NOT EXISTS (SELECT 1 FROM @KeyFields)  
    BEGIN  
        RAISERROR('No key fields defined for dataset %s in DQTableFields.', 16, 1, @Dataset);  
        RETURN;  
    END  
   
    -- Step 1b: Retrieve SegmentField from DQTables  
    SELECT @SegmentField = ConditionFieldInDataSet  
    FROM DQTables  
    WHERE Dataset = @Dataset;  
   
    -- Step 2: Retrieve Active Fields (excluding key fields)  
    INSERT INTO @ActiveFields (FieldOrder, FieldName)  
    SELECT [Order], Field  
    FROM DQTableFields  
    WHERE Dataset = @Dataset AND Active = 1 AND ([Key] <> 1 OR [Key] IS NULL)   
 --AND ConditionBySegment = 1  
 AND (ConditionBySegment = 1 or Mandatory=1) --Changed on 20250114 by GK because reports with mandatory marked without conditions for segment were raising an error  
    ORDER BY [Order];  
   
    -- Validate presence of active fields  
    IF NOT EXISTS (SELECT 1 FROM @ActiveFields)  
    BEGIN  
        RAISERROR('No active fields defined for dataset %s in DQTableFields.', 16, 1, @Dataset);  
        RETURN;  
    END  
   
    -- Step 2b: Retrieve Additional Fields to Display (Optional)  
    -- Include SegmentField in additional fields if not already included  
    INSERT INTO @AdditionalFields (FieldOrder, FieldName)  
    SELECT [Order], Field  
    FROM DQTableFields  
    WHERE Dataset = @Dataset AND (Field = @SegmentField or ReportDisplay=1);  
   
    -- Ensure @SegmentField is included in @AdditionalFields  
    IF @SegmentField IS NOT NULL AND NOT EXISTS (SELECT 1 FROM @AdditionalFields WHERE FieldName = @SegmentField)  
    BEGIN  
        INSERT INTO @AdditionalFields (FieldOrder, FieldName)  
        SELECT 9999, @SegmentField;  
    END  
 select 'Additional fields',* from @AdditionalFields  
    -- Build Key Field Lists for SQL  
    SELECT @KeyFieldList = STRING_AGG(QUOTENAME(FieldName) + ' NVARCHAR(100)', ', ') WITHIN GROUP (ORDER BY FieldOrder)  
    FROM @KeyFields;  
   
    SELECT @KeyFieldListForSelect = STRING_AGG('R.' + QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)  
    FROM @KeyFields;  
   
    SELECT @KeyFieldListForConcat = STRING_AGG('R.' + QUOTENAME(FieldName), ' + ''_'' + ') WITHIN GROUP (ORDER BY FieldOrder)  
    FROM @KeyFields;  
   
    -- Build Additional Field Lists for SQL  
    SELECT @AdditionalFieldList = STRING_AGG(QUOTENAME(FieldName) + ' NVARCHAR(100)', ', ') WITHIN GROUP (ORDER BY FieldOrder)  
    FROM @AdditionalFields;  
   
    SELECT @AdditionalFieldListForSelect = STRING_AGG('R.' + QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)  
    FROM @AdditionalFields;  
   
    -- Step 3: Build FieldValuesList for CROSS APPLY  
    SELECT @FieldValuesList = STRING_AGG(  
        '(''' + FieldName + ''', R.' + QUOTENAME(FieldName) + ', R.' + QUOTENAME(FieldName + '_Incomplete') + ')', ', '  
    )  
    FROM @ActiveFields;  
   
    -- Step 4: Create the Summary Table  
    IF OBJECT_ID(@SummaryTable, 'U') IS NOT NULL  
    BEGIN  
        SET @SQL = 'DROP TABLE ' + @SummaryTable + ';';  
        EXEC sp_executesql @SQL;  
    END  
   
    -- Construct the CREATE TABLE statement dynamically  
    SET @SQL = 'CREATE TABLE ' + @SummaryTable + ' (  
        DATASET NVARCHAR(100),  
        [KEY] NVARCHAR(500),  
        ' + @KeyFieldList + ', ';  
   
    IF @AdditionalFieldList IS NOT NULL AND LEN(@AdditionalFieldList) > 0  
    BEGIN  
        SET @SQL = @SQL + @AdditionalFieldList + ', ';  
    END  
   
   /* Segment field is created because the script was giving an error when there was no segment field and only mandatory fields so it was not inserting in the attribute table */
   /* INSERTED THIS SEGMENT ON 20250120 */
	IF @SegmentField IS NULL
	BEGIN
		SET @SQLSEGMENT = 'CASE WHEN FieldValues.IncompleteStatus = ''Yes'' THEN CONCAT(FieldValues.Field, '' is a Mandatory field'') ELSE '''' END AS ZCOMMENT  '
	END

	IF @SegmentField IS NOT NULL
	BEGIN
		SET @SQLSEGMENT = 'CASE WHEN FieldValues.IncompleteStatus = ''Yes'' THEN CONCAT(FieldValues.Field, '' is a Mandatory field for '', R.' + QUOTENAME(ISNULL(@SegmentField, '')) + ') ELSE '''' END AS ZCOMMENT  '
	END
	/* INSERTED THIS SEGMENT ON 20250120 */


    SET @SQL = @SQL + '  
        FIELD NVARCHAR(100),  
        FIELD_VALUE NVARCHAR(MAX),  
        ZERROR BIT,  
        ZCOMMENT NVARCHAR(500)  
    );';  
 print(@SQL)  
   
    EXEC sp_executesql @SQL;  
 print('Keylist ---------'+@AdditionalFieldListForSelect)  
    -- Step 5: Insert Data into the Summary Table  
    SET @SQL = '  
    INSERT INTO ' + @SummaryTable + ' (DATASET, [KEY], ' + @KeyFieldListForSelect +   
        CASE WHEN @AdditionalFieldListForSelect IS NOT NULL AND LEN(@AdditionalFieldListForSelect) > 0 THEN ', ' + @AdditionalFieldListForSelect ELSE '' END + ', FIELD, FIELD_VALUE, ZERROR, ZCOMMENT)  
    SELECT   
        ''' + @Dataset + ''' AS DATASET,  
        ' + @KeyFieldListForConcat + ' AS [KEY],  
        ' + REPLACE(@KeyFieldListForSelect, 'R.', '') +   
        CASE WHEN @AdditionalFieldListForSelect IS NOT NULL AND LEN(@AdditionalFieldListForSelect) > 0 THEN ', ' + REPLACE(@AdditionalFieldListForSelect, 'R.', '') ELSE '' END + ',  
        FieldValues.Field,  
        FieldValues.Field_Value,  
        CASE WHEN FieldValues.IncompleteStatus = ''Yes'' THEN 1 ELSE 0 END AS ZERROR, '
		+ @sqlsegment /*LOOK COMMENT ABOUT SEGMENT FIELD CONDITION ABOVE; CHANGE MADE ON 20250120 */ +' 
        FROM   
        ' + @ResultTable + ' R  
    CROSS APPLY  
    (  
        SELECT   
            v.Field,  
            v.Field_Value,  
            v.IncompleteStatus  
        FROM   
            (VALUES  
                ' + @FieldValuesList + '  
            ) AS v(Field, Field_Value, IncompleteStatus)  
    ) AS FieldValues  
    ;';  
 print(@sql)  
    EXEC sp_executesql @SQL;  
  
 SET @SQL = ' ALTER TABLE ' + @SummaryTable + ' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = ROW)';  
 exec sp_executesql @SQL;  
  
    -- Optional: Provide feedback upon successful completion  
    PRINT 'Attribute-level summary table ' + @SummaryTable + ' has been created successfully.';  
END  
  
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_DataSet_Completeness_GenerateRecordLevelResultTable]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDQTables_DataSet_Completeness_GenerateRecordLevelResultTable] (@Dataset NVARCHAR(200))
AS
BEGIN
	--declare @Dataset nvarchar(200)='IV_CSM_201_KNA1_CustomerMaster'
	DECLARE @mandatory BIT
	DECLARE @conditional BIT

	SELECT @mandatory = max(cast(isnull(mandatory, '') AS INT))
		,@conditional = max(cast(isnull(ConditionBySegment, '') AS INT))
	FROM DQTableFields
	WHERE Dataset = @Dataset
		AND [key] != 1

	PRINT ('man' + cast(isnull(@mandatory, '') AS NVARCHAR))
	PRINT ('com' + cast(isnull(@conditional, '') AS NVARCHAR))

	IF isnull(@Mandatory, 0) = 1
		AND isnull(@Conditional, 0) = 1
	BEGIN
		RAISERROR ('Can be Either Full Mandatory Or full conditionBysegment , There is a mix of both scenarios',16,1,@Dataset);
		RETURN;
	END

	IF isnull(@Mandatory, 0) = 1
		AND isnull(@Conditional, 0) = 0
	BEGIN
		EXEC webDQTables_DataSet_Mandatory_Completeness_GenerateRecordLevelResultTable @Dataset

		PRINT ('Mandatory')
	END

	IF isnull(@Mandatory, 0) = 0
		AND isnull(@Conditional, 0) = 1
	BEGIN
		EXEC webDQTables_DataSet_ConditionalBySegment_Completeness_GenerateRecordLevelResultTable @Dataset

		PRINT ('Conditional')
	END

	IF isnull(@Mandatory, 0) = 0
		AND isnull(@Conditional, 0) = 0
	BEGIN
		RAISERROR ('Please select either mandatory or conditional by segment',16,1,@Dataset);

		RETURN;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_DataSet_Completeness_UpdateResultTableWithSummary]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDQTables_DataSet_Completeness_UpdateResultTableWithSummary] 
    @Dataset NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
 
    -- Declare variables
    DECLARE @ResultTable NVARCHAR(128) = QUOTENAME(@Dataset + 'Completeness_RecordLevelResult');
    DECLARE @KeyFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));
    DECLARE @KeyFieldList NVARCHAR(MAX);
    DECLARE @KeyFieldListForSelect NVARCHAR(MAX);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @IncompleteFieldsList NVARCHAR(MAX) = '';
    DECLARE @CommentFieldsList NVARCHAR(MAX) = '';
    DECLARE @TableName NVARCHAR(128) = REPLACE(REPLACE(@ResultTable, '[', ''), ']', '');
 
    -- Step 1: Retrieve Key Fields from DQTableFields
    INSERT INTO @KeyFields (FieldOrder, FieldName)
    SELECT [Order], Field
    FROM DQTableFields
    WHERE Dataset = @Dataset AND [Key] = 1
    ORDER BY [Order];
 
    -- Validate presence of key fields
    IF NOT EXISTS (SELECT 1 FROM @KeyFields)
    BEGIN
        RAISERROR('No key fields defined for dataset %s in DQTableFields.', 16, 1, @Dataset);
        RETURN;
    END
 
    -- Step 2: Build Key Field List for SELECT Statement
    SELECT @KeyFieldList = STRING_AGG(QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)
    FROM @KeyFields;
 
    SELECT @KeyFieldListForSelect = STRING_AGG('R.' + QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)
    FROM @KeyFields;
 
    -- Step 3: Identify _Incomplete Columns in Result Table
    -- Retrieve all columns that end with '_Incomplete'
    SELECT @IncompleteFieldsList = STRING_AGG('CASE WHEN ' + QUOTENAME(COLUMN_NAME) + ' = ''Yes'' THEN 1 ELSE 0 END', ' + ')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
      AND COLUMN_NAME LIKE '%\_Incomplete' ESCAPE '\';
 
    -- Validate presence of _Incomplete columns
    IF @IncompleteFieldsList IS NULL
    BEGIN
        RAISERROR('No _Incomplete columns found in table %s.', 16, 1, @ResultTable);
        RETURN;
    END
 
    -- Step 4: Identify _Incomplete Columns for Comments
    -- Build a list of CASE statements for CONCAT_WS
    SELECT @CommentFieldsList = STRING_AGG(
        'CASE WHEN ' + QUOTENAME(COLUMN_NAME) + ' = ''Yes'' THEN ''' +
        REPLACE(COLUMN_NAME, '_Incomplete', '') + ''' ELSE NULL END', ', ')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
      AND COLUMN_NAME LIKE '%\_Incomplete' ESCAPE '\';

	print(@CommentFieldsList)
 
    -- Validate presence of _Incomplete columns for comments
    IF @CommentFieldsList IS NULL
    BEGIN
        RAISERROR('No _Incomplete columns found for comment generation in table %s.', 16, 1, @ResultTable);
        RETURN;
    END
 
    -- Step 5: Add Summary Columns to the Result Table if they don't exist
    IF NOT EXISTS (
        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'TotalMissingFields'
    )
    BEGIN
        SET @SQL = 'ALTER TABLE ' + @ResultTable + ' ADD TotalMissingFields INT;';
        EXEC sp_executesql @SQL;
    END
 
    IF NOT EXISTS (
        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'Comment'
    )
    BEGIN
        SET @SQL = 'ALTER TABLE ' + @ResultTable + ' ADD Comment NVARCHAR(MAX);';
        EXEC sp_executesql @SQL;
    END
 
    -- Step 6: Update the Result Table with Summary Data
    SET @SQL = '
    UPDATE R
    SET 
        TotalMissingFields = ' + @IncompleteFieldsList + ',
        Comment = CONCAT_WS('','', ' + @CommentFieldsList + ')
    FROM ' + @ResultTable + ' R;
    ';
 
    EXEC sp_executesql @SQL;
	print (@SQL)
 
    -- Optional: Provide feedback upon successful completion
    PRINT 'Result table ' + @ResultTable + ' has been updated with summary columns.';
END
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_DataSet_ConditionalBySegment_Completeness_GenerateRecordLevelResultTable]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[webDQTables_DataSet_ConditionalBySegment_Completeness_GenerateRecordLevelResultTable]      
      
    @Dataset NVARCHAR(100)      
AS      
      
      
BEGIN      
    SET NOCOUNT ON;      
 --DECLARE @Dataset nvarchar(100)='IV_CSM_201_KNA1_CustomerMaster'      
    DECLARE @DatasetTable NVARCHAR(128) = QUOTENAME(@Dataset);      
    DECLARE @ResultTable NVARCHAR(128) = QUOTENAME(@Dataset + 'Completeness_RecordLevelResult');      
    DECLARE @SegmentView NVARCHAR(200);      
    DECLARE @SegmentField NVARCHAR(100);      
    DECLARE @SegmentFieldAlias NVARCHAR(100);      
 DECLARE @FieldDataType nvarchar(200);      
    DECLARE @ConditionField NVARCHAR(100);      
    DECLARE @ConditionFieldInDataSet NVARCHAR(100);      
    DECLARE @KeyFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));      
    DECLARE @ActiveFields TABLE (FieldOrder int, FieldName NVARCHAR(100),[Key] bit);      
    DECLARE @KeyFieldList NVARCHAR(MAX);      
    DECLARE @KeyFieldListForSelect NVARCHAR(MAX);      
 declare @KeyFieldListForInsert nvarchar(max);      
    DECLARE @MandatoryFields NVARCHAR(MAX);      
    DECLARE @SQL NVARCHAR(MAX);      
    -- Get SegmentView, SegmentField, ConditionField, ConditionFieldInDataSet from DQTables      
    SELECT      
        @SegmentView = SegmentView,      
        @SegmentField = SegmentField,      
        @SegmentFieldAlias = SegmentFieldAlias,      
        @ConditionField = ConditionField,      
        @ConditionFieldInDataSet = ConditionFieldInDataSet      
    FROM DQTables      
    WHERE Dataset = @Dataset;      
       
    IF @SegmentField IS NULL OR @ConditionFieldInDataSet IS NULL      
    BEGIN      
        RAISERROR('SegmentField or ConditionFieldInDataSet is not defined in DQTables for Dataset %s.', 16, 1, @Dataset);      
        RETURN;      
    END      
       
    -- Get Key Fields from DQTableFields      
    INSERT INTO @KeyFields (FieldOrder, FieldName)      
    SELECT [Order], Field      
    FROM DQTableFields      
    WHERE Dataset = @Dataset AND [Key] = 1      
    ORDER BY [Order];      
       
    IF NOT EXISTS (SELECT 1 FROM @KeyFields)      
    BEGIN      
        RAISERROR('No key fields defined for dataset %s.', 16, 1, @Dataset);      
        RETURN;      
    END      
       
    -- Get Active Fields from DQTableFields      
    INSERT INTO @ActiveFields (fieldOrder,FieldName,[Key])      
    SELECT [Order],Field,[Key]      
    FROM DQTableFields      
    WHERE Dataset = @Dataset AND Active = 1      
 order by [Order];      
      
 select * from @ActiveFields      
       
    IF NOT EXISTS (SELECT 1 FROM @ActiveFields)      
    BEGIN      
        RAISERROR('No active fields defined for dataset %s.', 16, 1, @Dataset);      
        RETURN;      
    END      
       
    -- Build key field lists for SQL      
    SELECT @KeyFieldList = STRING_AGG(QUOTENAME(FieldName) + ' NVARCHAR(256)', ', ') WITHIN GROUP (ORDER BY FieldOrder)      
    FROM @KeyFields;      
       
    SELECT @KeyFieldListForSelect = STRING_AGG('D.' + QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)      
    FROM @KeyFields;      
      
 SELECT @KeyFieldListForInsert = STRING_AGG( QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)      
    FROM @KeyFields;      
       
    -- Build list of active fields      
    DECLARE @ActiveFieldList NVARCHAR(MAX) = '';      
    SELECT @ActiveFieldList = STRING_AGG(QUOTENAME(FieldName), ', ')      
    FROM @ActiveFields;      
       
    -- Create the result table with all columns      
    IF OBJECT_ID(@ResultTable, 'U') IS NOT NULL      
    BEGIN      
        SET @SQL = 'DROP TABLE ' + @ResultTable + ';';    
		PRINT(@SQL)
        EXEC sp_executesql @SQL;      
    END      
       
    DECLARE @CompleteColumnList NVARCHAR(MAX) = @KeyFieldList + ', ';      
 declare @field nvarchar(200)      
    DECLARE FieldCursor CURSOR FOR      
    SELECT FieldName      
    FROM @ActiveFields where [key]!=1 order by FieldOrder;      
       
    OPEN FieldCursor;      
    FETCH NEXT FROM FieldCursor INTO @Field;      
       
    WHILE @@FETCH_STATUS = 0      
    BEGIN      
        
  --select @FieldDataType=dbo.webGetDatatypeForTable(@Dataset,@field)      
        
        SET @CompleteColumnList = @CompleteColumnList +       
           --QUOTENAME(@Field) +' '+ @FieldDataType+' , ' +       
   QUOTENAME(@Field) +' nvarchar(256) , ' +      
            QUOTENAME(@Field + '_Incomplete') + ' NVARCHAR(10), ';      
        FETCH NEXT FROM FieldCursor INTO @Field;      
    END      
       
    CLOSE FieldCursor;      
    DEALLOCATE FieldCursor;      
       
    -- Remove trailing comma and space      
    SET @CompleteColumnList = LEFT(@CompleteColumnList, LEN(@CompleteColumnList) - 1);      
       
    -- Create the result table with all columns      
    SET @SQL = ' CREATE TABLE ' + @ResultTable + ' (      
        ' + @CompleteColumnList + '      
    );';      
 print('Create Table -- '+@SQL)      
    EXEC sp_executesql @SQL;      
 set @sql = 'drop table if exists  ConditionalMandatoryFields_'+@Dataset      
 exec sp_executesql @sql      
      
      
    -- Create the pivoted mandatory fields table (non-pivoted approach)      
   exec webDQTables_PivotTable_ConditionBySegment_TableCreate @dataset      
      
       
      
 --cursor for case statements      
 declare @sql_case nvarchar(max)=''      
 DECLARE FieldCursor CURSOR FOR      
    SELECT FieldName      
    FROM @ActiveFields where [key]!=1 order by [FieldOrder] ;      
       
    OPEN FieldCursor;      
    FETCH NEXT FROM FieldCursor INTO @Field;      
       
    WHILE @@FETCH_STATUS = 0      
    BEGIN      
  print('----------------'+@field+'-------------------')      
  if exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='ConditionalMandatoryFields_' + @Dataset+'' and COLUMN_NAME=@field )      
  begin      
  print('Field - '+@field)      
  SELECT @sql_case = @sql_case + 'D.' + QUOTENAME(@Field) + ', ' +       
        'CASE      
            WHEN CM.['+@Field+'] = 1 AND isnull(cast(D.' + QUOTENAME(@Field) + ' as nvarchar),'''')=''''  THEN ''Yes''      
            WHEN CM.['+@Field+'] = 1 AND isnull(cast(D.' + QUOTENAME(@Field) + ' as nvarchar),'''')<>'''' THEN ''No''      
            WHEN CM.['+@Field+'] = 0 THEN ''N/A''      
            ELSE ''N/A''      
        END AS ' + QUOTENAME(@Field + '_Incomplete') + ', '      
  end      
      
  else      
  begin      
  set @sql_case = @sql_case+ 'D.' + QUOTENAME(@Field) + ', ' +'''N/A'' as '  + QUOTENAME(@Field + '_Incomplete') + ', '      
  end      
      
        FETCH NEXT FROM FieldCursor INTO @Field;      
    END      
       
    CLOSE FieldCursor;      
    DEALLOCATE FieldCursor;      
      
 set @sql_case=left(@sql_case,len(@sql_case)-1)      
 --print(@sql_case)      
      
       
     --Insert data with computed Field_Incomplete statuses      
    SET @SQL = 'INSERT INTO ' + @ResultTable + ' (' + @KeyFieldListForInsert + ', ';      
       
    -- Add active fields and their incomplete counterparts to the column list      
    SELECT @SQL = @SQL + QUOTENAME(FieldName) + ', ' + QUOTENAME(FieldName + '_Incomplete') + ', '      
    FROM @ActiveFields where [Key]!=1 order by [FieldOrder];      
       
    -- Remove trailing comma and space, then add closing parenthesis      
    SET @SQL = LEFT(@SQL, LEN(@SQL) - 1) + ')      
       
 SELECT       
        ' + @KeyFieldListForSelect + ', ';      
       
    -- Add active fields and their incomplete statuses      
    SELECT @SQL = @SQL + @sql_case      
/* ABA - Removing SourceSystemID JOIN condition*/       
    -- Remove trailing comma and space      
    --SET @SQL =-- LEFT(@SQL, LEN(@SQL) - 2)      
    -- @SQL+ '      
    --FROM ' + @DatasetTable + ' D left outer join ' +@SegmentView +' MAP on D.SourcesystemId=MAP.SourcesystemId and D.'+@ConditionFieldInDataSet+' = MAP.'+@ConditionField+'      
    --LEFT JOIN ConditionalMandatoryFields_' + @Dataset + ' CM ON       
    --    CM.SegmentValue = MAP.' + QUOTENAME(@SegmentField) + ''     
/* ABA - Removing SourceSystemID JOIN condition */ 
	 SET @SQL =-- LEFT(@SQL, LEN(@SQL) - 2)      
     @SQL+ '      
    FROM ' + @DatasetTable + ' D left outer join ' +@SegmentView +' MAP on  D.'+@ConditionFieldInDataSet+' = MAP.'+@ConditionField+'      
    LEFT JOIN ConditionalMandatoryFields_' + @Dataset + ' CM ON       
        CM.SegmentValue = MAP.' + QUOTENAME(@SegmentField) + '' 
      
 PRINT SUBSTRING(@SQL, 1, 4000)      
      
PRINT SUBSTRING(@SQL, 4001, 4000)      
      
PRINT SUBSTRING(@SQL, 8002, 4000)   
PRINT(@SQL)
EXEC sp_executesql @SQL;      
      
 --declare @sql_test nvarchar(max)      
 --set @sql_test =  'FROM ' + @DatasetTable + ' D left outer join ' +@SegmentView +' MAP on D.SourcesystemId=MAP.SourcesystemId and D.'+@ConditionFieldInDataSet+' = MAP.'+@ConditionField+'      
 --   LEFT JOIN ConditionalMandatoryFields_' + @Dataset + ' CM ON       
 --       CM.SegmentValue = MAP.' + QUOTENAME(@SegmentField) +''; -- Note: Replace @Field appropriately      
 -- print(@Sql_test)      
       
    -- Drop the temporary mandatory fields table      
    SET @SQL = 'DROP TABLE ConditionalMandatoryFields_' + @Dataset + ';';      
    EXEC sp_executesql @SQL;      
       
END
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_DataSet_DummyValueCheck_UpdateResultTableWithSummary]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[webDQTables_DataSet_DummyValueCheck_UpdateResultTableWithSummary] 
    @Dataset NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
 
    -- Declare variables
	--declare @dataset nvarchar(200)='IV_CSM_203_KNA1_CustomerMaster'
    DECLARE @ResultTable NVARCHAR(128) = QUOTENAME(@Dataset+ '_DummyValues_RecordLevel');
    DECLARE @KeyFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));
    DECLARE @KeyFieldList NVARCHAR(MAX);
    DECLARE @KeyFieldListForSelect NVARCHAR(MAX);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @DummyResultFieldsList NVARCHAR(MAX) = '';
    DECLARE @CommentFieldsList NVARCHAR(MAX) = '';
    DECLARE @TableName NVARCHAR(128) = REPLACE(REPLACE(@ResultTable, '[', ''), ']', '');
	DECLARE @NumDummyValues int -- for counting the amount of dummy fields considered in a report
    -- Step 1: Retrieve Key Fields from DQTableFields
    INSERT INTO @KeyFields (FieldOrder, FieldName)
    SELECT [Order], Field
    FROM DQTableFields
    WHERE Dataset = @Dataset AND [Key] = 1
    ORDER BY [Order];
 
    -- Validate presence of key fields
    IF NOT EXISTS (SELECT 1 FROM @KeyFields)
    BEGIN
        RAISERROR('No key fields defined for dataset %s in DQTableFields.', 16, 1, @Dataset);
        RETURN;
    END

	--Fill @NumDummyValues with the amount of dummy fields for creating the correct CONCAT_WS in the last step
	
	SET @NumDummyValues= (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName  AND COLUMN_NAME LIKE '%\ Contains Dummy Value' ESCAPE '\')
 
    -- Step 2: Build Key Field List for SELECT Statement
    SELECT @KeyFieldList = STRING_AGG(QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)
    FROM @KeyFields;
 
    SELECT @KeyFieldListForSelect = STRING_AGG('R.' + QUOTENAME(FieldName), ', ') WITHIN GROUP (ORDER BY FieldOrder)
    FROM @KeyFields;
 
    -- Step 3: Identify Dummy value Columns in Result Table
    -- Retrieve all columns that end with '_Incomplete'
    SELECT @DummyResultFieldsList = STRING_AGG('CASE WHEN ' + QUOTENAME(COLUMN_NAME) + ' = ''Yes'' THEN 1 ELSE 0 END', ' + ')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
      AND COLUMN_NAME LIKE '%\ Contains Dummy Value' ESCAPE '\';
 print(@DummyResultFieldsList)
    -- Validate presence of _Incomplete columns
    IF @DummyResultFieldsList IS NULL
    BEGIN
        RAISERROR('No Dummy Value Result Columns found in table %s.', 16, 1, @ResultTable);
        RETURN;
    END
 
    -- Step 4: Identify _Incomplete Columns for Comments
    -- Build a list of CASE statements for CONCAT_WS
    SELECT @CommentFieldsList = STRING_AGG(
        'CASE WHEN ' + QUOTENAME(COLUMN_NAME) + ' = ''Yes'' THEN ''' +
        REPLACE(COLUMN_NAME, ' Contains Dummy Value', '') + ''' ELSE NULL END', ', ')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
      AND COLUMN_NAME LIKE '%\ Contains Dummy Value' ESCAPE '\';
 
    -- Validate presence of _Incomplete columns for comments
    IF @CommentFieldsList IS NULL
    BEGIN
        RAISERROR('No Dummy Value Result Columns found for comment generation in table %s.', 16, 1, @ResultTable);
        RETURN;
    END
 
    -- Step 5: Add Summary Columns to the Result Table if they don't exist
    IF NOT EXISTS (
        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'TotalDummyValueResultFields'
    )
    BEGIN
        SET @SQL = 'ALTER TABLE ' + @ResultTable + ' ADD TotalDummyValue_ResultFields INT;';
        EXEC sp_executesql @SQL;
		print('1.'+isnull(@sql,''))
    END
 
    IF NOT EXISTS (
        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'Comment'
    )
    BEGIN
        SET @SQL = 'ALTER TABLE ' + @ResultTable + ' ADD Comment NVARCHAR(MAX);';
        EXEC sp_executesql @SQL;
		print(@sql)
    END
 
    -- Step 6: Update the Result Table with Summary Data
	/* This part of the code was added by GK on the 20241128 because reports with only dummy field considered were failing in the UPDATE */
	IF (@NumDummyValues)=1
	BEGIN
		SET @SQL = '
		UPDATE R
		SET 
			TotalDummyValue_ResultFields = ' + @DummyResultFieldsList + ',
			Comment = ' + @CommentFieldsList + '
		FROM ' + @ResultTable + ' R;
		';
 
	    EXEC sp_executesql @SQL;
		print(@sql)
 
		-- Optional: Provide feedback upon successful completion
		PRINT 'Result table ' + @ResultTable + ' has been updated with summary columns.';
	END

	/* This part of the code was added by GK on the 20241128 because reports with only dummy field considered were failing in the UPDATE */

	IF (@NumDummyValues)>1
	BEGIN
		SET @SQL = '
		UPDATE R
		SET 
			TotalDummyValue_ResultFields = ' + @DummyResultFieldsList + ',
			Comment = CONCAT_WS('','', ' + @CommentFieldsList + ')
		FROM ' + @ResultTable + ' R;
		';
 
		EXEC sp_executesql @SQL;
		print(@sql)
 
		-- Optional: Provide feedback upon successful completion
		PRINT 'Result table ' + @ResultTable + ' has been updated with summary columns.';
	END
END
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_DataSet_Mandatory_Completeness_GenerateRecordLevelResultTable]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[webDQTables_DataSet_Mandatory_Completeness_GenerateRecordLevelResultTable]    
    
    @Dataset NVARCHAR(100)    
AS    
    
    
BEGIN    
    
	
--DECLARE @Dataset nvarchar(100)='IV_CCM_214_CSKS_CostCenter'    
    DECLARE @DatasetTable NVARCHAR(128) = QUOTENAME(@Dataset);    
    DECLARE @ResultTable NVARCHAR(128) = QUOTENAME(@Dataset + 'Completeness_RecordLevelResult');    
    DECLARE @SegmentView NVARCHAR(200);    
    DECLARE @SegmentField NVARCHAR(100);    
    DECLARE @SegmentFieldAlias NVARCHAR(100);    
 DECLARE @FieldDataType nvarchar(200);    
    DECLARE @ConditionField NVARCHAR(100);    
    DECLARE @ConditionFieldInDataSet NVARCHAR(100);    
    DECLARE @KeyFields TABLE (FieldOrder INT, FieldName NVARCHAR(100));    
    DECLARE @ActiveFields TABLE (FieldOrder int, FieldName NVARCHAR(100),[Key] bit,Mandatory bit, ReportDisplay bit);    
    DECLARE @KeyFieldList NVARCHAR(MAX);    
    DECLARE @KeyFieldListForSelect NVARCHAR(MAX);    
 declare @KeyFieldListForInsert nvarchar(max);    
    DECLARE @MandatoryFields NVARCHAR(MAX);    
    DECLARE @SQL NVARCHAR(MAX);    

    -- Get Key Fields from DQTableFields    
    INSERT INTO @KeyFields (FieldOrder, FieldName)    
    SELECT [Order], Field    
    FROM DQTableFields    
    WHERE Dataset = @Dataset AND [Key] = 1    
    ORDER BY [Order];    
    
    IF NOT EXISTS (SELECT 1 FROM @KeyFields)    
    BEGIN    
        RAISERROR('No key fields defined for dataset %s.', 16, 1, @Dataset);    
        RETURN;    
    END    
     
    -- Get Active Fields from DQTableFields    
    INSERT INTO @ActiveFields (fieldOrder,FieldName,[Key],[Mandatory],ReportDisplay)    
    SELECT [Order],Field,[Key] ,Mandatory,ReportDisplay
	
    FROM DQTableFields    
    WHERE Dataset = @Dataset AND Active = 1    
 order by [Order];    
    
 --select * from @ActiveFields    
     
    IF NOT EXISTS (SELECT 1 FROM @ActiveFields)    
    BEGIN    
        RAISERROR('No active fields defined for dataset %s.', 16, 1, @Dataset);    
        RETURN;    
    END    
  
    -- Build key field lists for SQL    
    SELECT @KeyFieldList = STRING_AGG(QUOTENAME(ISNULL(FieldName,'')) + ' NVARCHAR(256)', ', ') WITHIN GROUP (ORDER BY FieldOrder)    
    FROM @KeyFields;    
     
    SELECT @KeyFieldListForSelect = STRING_AGG('D.' + QUOTENAME(ISNULL(FieldName,'')), ', ') WITHIN GROUP (ORDER BY FieldOrder)    
    FROM @KeyFields;    
	 
    
 SELECT @KeyFieldListForInsert = STRING_AGG( QUOTENAME(ISNULL(FieldName,'')), ', ') WITHIN GROUP (ORDER BY FieldOrder)    
    FROM @KeyFields;    
     
    -- Build list of active fields    
    DECLARE @DisplayFields NVARCHAR(MAX) = '';
	declare @DisplayFieldsForSelect nvarchar(max)='';
    SELECT @DisplayFieldsForSelect = STRING_AGG(QUOTENAME(ISNULL(FieldName,'')), ', ')   WITHIN GROUP (ORDER BY FieldOrder)   ,
	@DisplayFields=STRING_AGG(QUOTENAME(ISNULL(FieldName,'')) + ' NVARCHAR(256)', ', ') WITHIN GROUP (ORDER BY FieldOrder)
    FROM @ActiveFields where ReportDisplay=1;    
     
	 print(@DisplayFieldsForSelect)
	 print(@DisplayFields)
    -- Create the result table with all columns    
    IF OBJECT_ID(@ResultTable, 'U') IS NOT NULL    
    BEGIN    
        SET @SQL = '
				 DROP TABLE ' + @ResultTable + ';';  
		PRINT(@SQL)
        EXEC sp_executesql @SQL;    
    END    
     
    DECLARE @CompleteColumnList NVARCHAR(MAX) = @KeyFieldList + ', '+@DisplayFields+',';    
 declare @field nvarchar(200)    
    DECLARE FieldCursor CURSOR FOR    
    SELECT FieldName    
    FROM @ActiveFields where [key]!=1 and Mandatory=1 order by FieldOrder;    
     
    OPEN FieldCursor;    
    FETCH NEXT FROM FieldCursor INTO @Field;    
     
    WHILE @@FETCH_STATUS = 0    
    BEGIN    
      
  --select @FieldDataType=dbo.webGetDatatypeForTable(@Dataset,@field)    
      
        SET @CompleteColumnList = @CompleteColumnList +     
           --QUOTENAME(@Field) +' '+ @FieldDataType+' , ' +     
   QUOTENAME(@Field) +' nvarchar(256) , ' +    
            QUOTENAME(@Field + '_Incomplete') + ' NVARCHAR(10), ';    
        FETCH NEXT FROM FieldCursor INTO @Field;    
    END    
     
    CLOSE FieldCursor;    
    DEALLOCATE FieldCursor;    
     
    -- Remove trailing comma and space    
    SET @CompleteColumnList = LEFT(@CompleteColumnList, LEN(@CompleteColumnList) - 1);    
     
    -- Create the result table with all columns    
    SET @SQL = '
				CREATE TABLE ' + @ResultTable + ' (    
        ' + @CompleteColumnList + '    
    );';    
 print('Create Table -- '+@SQL)    
    EXEC sp_executesql @SQL;    

   
 --cursor for case statements    
 declare @sql_case nvarchar(max)=''    
 DECLARE FieldCursor CURSOR FOR    
    SELECT FieldName    
    FROM @ActiveFields where [key]!=1 and Mandatory=1 order by [FieldOrder] ;    
     
    OPEN FieldCursor;    
    FETCH NEXT FROM FieldCursor INTO @Field;    
     
    WHILE @@FETCH_STATUS = 0    
    BEGIN    
  print('----------------'+@field+'-------------------')    
     
  print('Field - '+@field)    
  SELECT @sql_case = @sql_case + 'D.' + QUOTENAME(@Field) + ', ' +     
        'CASE    
            WHEN isnull(cast(D.' + QUOTENAME(@Field) + ' as nvarchar),'''')=''''  THEN ''Yes''    
            ELSE ''No''    
        END AS ' + QUOTENAME(@Field + '_Incomplete') + ', '    
  
    
        FETCH NEXT FROM FieldCursor INTO @Field;    
    END    
     
    CLOSE FieldCursor;    
    DEALLOCATE FieldCursor;    
    
 set @sql_case=left(@sql_case,len(@sql_case)-1)    
 print(@sql_case)    
    
     
     --Insert data with computed Field_Incomplete statuses    
    SET @SQL = 'INSERT INTO ' + @ResultTable + ' (' + @KeyFieldListForInsert + ', '+@DisplayFieldsForSelect+',';    
     
    -- Add active fields and their incomplete counterparts to the column list    
    SELECT @SQL = @SQL + QUOTENAME(FieldName) + ', ' + QUOTENAME(FieldName + '_Incomplete') + ', '    
    FROM @ActiveFields where [Key]!=1 and Mandatory=1 order by [FieldOrder];    
     
    -- Remove trailing comma and space, then add closing parenthesis    
    SET @SQL = LEFT(@SQL, LEN(@SQL) - 1) + ')    
     
 SELECT     
        ' + @KeyFieldListForSelect + ', '+@DisplayFieldsForSelect+',';    
     
    -- Add active fields and their incomplete statuses    
    SELECT @SQL = @SQL + @sql_case    
     
    -- Remove trailing comma and space    
    SET @SQL =-- LEFT(@SQL, LEN(@SQL) - 2)    
     @SQL+ '    
    FROM ' + @DatasetTable + ' D'
    
	PRINT SUBSTRING(@SQL, 1, 4000)    
    
	PRINT SUBSTRING(@SQL, 4001, 4000)    
    
	PRINT SUBSTRING(@SQL, 8002, 4000) 

	EXEC sp_executesql @SQL;    

END
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_GenerateDummyValuesResults_AttributeLevel]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[webDQTables_GenerateDummyValuesResults_AttributeLevel] @Dataset NVARCHAR(200)  
AS  
  BEGIN  
      SET NOCOUNT ON;  
  
      --declare @dataset nvarchar(100)='IV_CSM_203_KNA1_CustomerMaster'    
      DECLARE @RunDate DATETIME = Getdate();  
      DECLARE @Field NVARCHAR(128);  
      DECLARE @KeyFields NVARCHAR(MAX);  
      DECLARE @DisplayFields NVARCHAR(MAX);  
      DECLARE @AllFields NVARCHAR(MAX);  
      DECLARE @DatasetTableName NVARCHAR(128);  
      DECLARE @ResultTableName NVARCHAR(128);  
      DECLARE @InsertColumns NVARCHAR(MAX);  
      DECLARE @SQL NVARCHAR(MAX);  
      DECLARE @ErrorMessage NVARCHAR(4000);  
      DECLARE @ColumnDefinitions NVARCHAR(MAX);  
  
      -- Initialize variables    
      SET @DatasetTableName = Quotename(@Dataset);  
      SET @ResultTableName = Quotename(@Dataset + '_DummyValues_AttributeLevel');  
  
      -- Get Key Fields and Display Fields    
      SELECT @KeyFields = STRING_AGG(Quotename(Field), ', ')  
      FROM   DQTableFields  
      WHERE  Dataset = @Dataset  
             AND [Key] = 1;  
  
      SELECT @DisplayFields = STRING_AGG(Quotename(Field), ', ')  
      FROM   DQTableFields  
      WHERE  Dataset = @Dataset  
             AND ReportDisplay = 1;  
  
      -- Combine Key Fields and Display Fields, remove duplicates    
      SELECT @AllFields = STRING_AGG(Quotename(Field), ', ')  
      FROM   (SELECT DISTINCT Field  
              FROM   DQTableFields  
              WHERE  Dataset = @Dataset  
                     AND ( [Key] = 1  
                            OR ReportDisplay = 1 )) AS DistinctFields;  
  
      -- Build column definitions with data types    
      DECLARE @FieldsTable TABLE  
        (  
           FieldName        NVARCHAR(128),  
           DataType         NVARCHAR(128),  
           MaxLength        INT,  
           NumericPrecision INT,  
           NumericScale     INT  
        );  
  
      INSERT INTO @FieldsTable  
                  (FieldName,  
                   DataType,  
                   MaxLength,  
                   NumericPrecision,  
                   NumericScale)  
      SELECT COLUMN_NAME              AS FieldName,  
             DATA_TYPE                AS DataType,  
             CHARACTER_MAXIMUM_LENGTH AS MaxLength,  
             NUMERIC_PRECISION        AS NumericPrecision,  
             NUMERIC_SCALE            AS NumericScale  
      FROM   INFORMATION_SCHEMA.COLUMNS  
      WHERE  TABLE_NAME = @Dataset  
             AND COLUMN_NAME IN (SELECT Field  
                                 FROM   DQTableFields  
                                 WHERE  Dataset = @Dataset  
                                        AND ( [Key] = 1  
                                               OR ReportDisplay = 1 ));  
  
      -- Build column definitions    
      SELECT @ColumnDefinitions = STRING_AGG(Quotename(FieldName) + ' ' + DataType + CASE WHEN DataType IN ('varchar', 'nvarchar', 'char', 'nchar') THEN '(' + CASE WHEN MaxLength = -1 THEN 'MAX' ELSE Cast(MaxLength AS NVARCHAR(10)) END + ')' WHEN DataType
 IN ('decimal', 'numeric') THEN '(' + Cast(NumericPrecision AS NVARCHAR(10)) + ',' + Cast(NumericScale AS NVARCHAR(10)) + ')' ELSE '' END, ', ')  
      FROM   @FieldsTable;  
  
   --Drop result table if exists  
   SET @SQL = '    
    IF OBJECT_ID(''' + @ResultTableName  
                 + ''', ''U'') IS NOT NULL  
 begin  
  DROP table '+@ResultTableName+  
 'END'  
  
 exec (@SQL)  
  
      -- Create the result table if it doesn't exist    
      SET @SQL = '    
    IF OBJECT_ID(''' + @ResultTableName  
                 + ''', ''U'') IS NULL    
    BEGIN    
        CREATE TABLE ' + @ResultTableName  
                 + ' (    
            RunDate DATETIME,    
            ' + @ColumnDefinitions + ',    
            Field NVARCHAR(128),    
            FieldValue NVARCHAR(MAX),    
            DummyValue NVARCHAR(100),    
            MatchType NVARCHAR(20)    
        );    
    END';  
  
      EXEC (@SQL);  
  
      -- Truncate the result table    
      SET @SQL = 'TRUNCATE TABLE ' + @ResultTableName + ';';  
  
      EXEC (@SQL);  
  
      -- Get the fields to check for dummy values    
      DECLARE DummyFieldCursor CURSOR FAST_FORWARD FOR  
        SELECT Field  
        FROM   DQTableFields  
        WHERE  Dataset = @Dataset  
               AND CheckForDummyValues = 1;  
  
      OPEN DummyFieldCursor;  
  
      FETCH NEXT FROM DummyFieldCursor INTO @Field;  
  
      WHILE @@FETCH_STATUS = 0  
        BEGIN  
            -- Create a temporary table for dummy values    
            IF Object_id('tempdb..#DummyValues') IS NOT NULL  
              DROP TABLE #DummyValues;  
  
            CREATE TABLE #DummyValues  
              (  
                 DummyValue        NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS,  
                 MatchType         NVARCHAR(20)  COLLATE SQL_Latin1_General_CP1_CS_AS,  
                 EscapedDummyValue NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CS_AS  
              );  
  
            -- Get the list of dummy values into the temporary table    
            INSERT INTO #DummyValues  
                        (DummyValue,  
                         MatchType,  
                         EscapedDummyValue)  
            SELECT DummyValue,  
                   MatchType,  
                   Replace(Replace(Replace(Replace(Replace(Replace(DummyValue, '\', '\\'), -- Escape backslash    
                                                   '%', '\%'), '_', '\_'), '[', '\['), ']', '\]'), '^', '\^')  
            FROM   DummyValues  
            WHERE  Dataset = @Dataset  
                   AND Field = @Field;  

			
		
  
            -- Build the INSERT statement    
            SET @InsertColumns = 'RunDate, ' + @AllFields  
                                 + ', Field, FieldValue, DummyValue, MatchType';  
            -- Build the dynamic SQL for matching    
            SET @SQL = '    
        INSERT INTO ' + @ResultTableName  
                       + ' (' + @InsertColumns + ')    
        SELECT    
            '''  
                       + CONVERT(NVARCHAR(20), @RunDate, 120)  
                       + ''' AS RunDate,    
            ' + @AllFields + ',    
            '''  
                       + @Field + ''' AS Field,    
            D.' + Quotename(@Field)  
                       + ' AS FieldValue,    
            DV.DummyValue,    
            DV.MatchType    
        FROM ' + @DatasetTableName  
                       + ' D    
        CROSS JOIN #DummyValues DV    
        WHERE D.' + Quotename(@Field)  
                       + ' IS NOT NULL AND ';  
            -- Build the matching conditions based on MatchType    
            SET @SQL = @SQL  
                       + '(    
            (UPPER(DV.MatchType) = UPPER(''Exact'') AND D.'  
                       + Quotename(@Field)  
                       + 'COLLATE SQL_Latin1_General_CP1_CI_AS = DV.DummyValue)    
            OR    
            (UPPER(DV.MatchType) = UPPER(''Contains'') AND D.'  
                       + Quotename(@Field)  
                       + 'COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ''%'' + DV.EscapedDummyValue + ''%'' ESCAPE ''\'')    
            OR    
            (UPPER(DV.MatchType) = UPPER(''Starts With'') AND D.'  
                       + Quotename(@Field)  
                       + 'COLLATE SQL_Latin1_General_CP1_CI_AS LIKE DV.EscapedDummyValue + ''%'' ESCAPE ''\'')    
            OR    
            (UPPER(DV.MatchType) = UPPER(''Ends With'') AND D.'  
                       + Quotename(@Field) + 'COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ''%'' + DV.EscapedDummyValue ESCAPE ''\'')    
        );';  
  
            -- Execute the dynamic SQL    
            print( @sql )  
  
            EXEC (@SQL);  
  
            -- Drop the temporary dummy values table    
            DROP TABLE #DummyValues;  
  
            FETCH NEXT FROM DummyFieldCursor INTO @Field;  
        END  
  
      CLOSE DummyFieldCursor;  
  
      DEALLOCATE DummyFieldCursor;  
  
      PRINT 'Processed dataset ' + @Dataset + '.';  
  END   
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_PivotDummyValuesResults]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webDQTables_PivotDummyValuesResults]
    @Dataset NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
--declare @Dataset nvarchar(100)='IV_CSM_201_KNA1_CustomerMaster'
    DECLARE @KeyFields NVARCHAR(MAX);
    DECLARE @DisplayFields NVARCHAR(MAX);
    DECLARE @AllFields NVARCHAR(MAX);
    DECLARE @FieldsToCheck NVARCHAR(MAX);
    DECLARE @DatasetTableName NVARCHAR(128) = QUOTENAME(@Dataset);
    DECLARE @ResultTableName NVARCHAR(128) = QUOTENAME(@Dataset + '_DummyValues_RecordLevel');
    DECLARE @AttributeResultTableName NVARCHAR(128) = QUOTENAME(@Dataset + '_DummyValues_AttributeLevel');
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @SelectColumns NVARCHAR(MAX);
    DECLARE @KeyJoinCondition NVARCHAR(MAX);
    DECLARE @PivotAggregationColumns NVARCHAR(MAX); -- Added variable
 
    -- Get Key Fields
    SELECT @KeyFields = STRING_AGG(QUOTENAME(Field), ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND [Key] = 1;
 
    -- Build Key Join Condition
    SELECT @KeyJoinCondition = STRING_AGG('D.' + QUOTENAME(Field) + ' COLLATE SQL_Latin1_General_CP1_CI_AS = PV.' + QUOTENAME(Field), ' COLLATE SQL_Latin1_General_CP1_CI_AS AND ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND [Key] = 1;
 
    -- Get Display Fields
    SELECT @DisplayFields = STRING_AGG('D.' + QUOTENAME(Field), ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND ReportDisplay = 1;
 
    -- Combine Key Fields and Display Fields, remove duplicates
    SELECT @AllFields = STRING_AGG('D.' + QUOTENAME(Field), ', ') within group (order by [Order])
    FROM (
        SELECT DISTINCT [Order],Field
        FROM DQTableFields
        WHERE Dataset = @Dataset AND ([Key] = 1 OR ReportDisplay = 1) and isnull([CheckForDummyValues],0)!=1
    ) AS DistinctFields;
 
    -- Get Fields to Check
    SELECT @FieldsToCheck = STRING_AGG(Field, ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND CheckForDummyValues = 1;
 
    -- Build Select Columns
    SELECT @SelectColumns = @AllFields + ', ' + 
        STRING_AGG('D.'+Field+' , ISNULL(PV.' + QUOTENAME(Field) + ', ''NO'') AS ' + QUOTENAME(Field + ' Contains Dummy Value'), ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND CheckForDummyValues = 1;
 
    -- Build Pivot Aggregation Columns
    SELECT @PivotAggregationColumns = STRING_AGG('MAX(CASE WHEN Field = ''' + Field + ''' THEN ''YES'' END) AS ' + QUOTENAME(Field), ', ')
    FROM DQTableFields
    WHERE Dataset = @Dataset AND CheckForDummyValues = 1;

	  --Drop result table if exists
      SET @SQL = '  
    IF OBJECT_ID(''' + @ResultTableName
                 + ''', ''U'') IS NOT NULL
begin
DROP table ' + @ResultTableName + 'END'

      exec (@SQL)


 
    -- Build the dynamic SQL
    SET @SQL = '
    SELECT ' + @SelectColumns + '
    INTO ' + @ResultTableName + '
    FROM ' + @DatasetTableName + ' D
    LEFT JOIN (
        SELECT ' + @KeyFields + ', ' + @PivotAggregationColumns + '
        FROM ' + @AttributeResultTableName + '
        GROUP BY ' + @KeyFields + '
    ) PV
    ON ' + @KeyJoinCondition + ';';
 
    -- Uncomment the following line to print the SQL for debugging
    PRINT (@SQL);
 
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;
    PRINT 'Pivoted dummy values result table created: ' + @ResultTableName;
END;
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_PivotTable_ConditionBySegment_TableCreate]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[webDQTables_PivotTable_ConditionBySegment_TableCreate] (@dataset nvarchar(400))
as
begin
--declare @dataset nvarchar(200)='IV_CSM_201_KNA1_CustomerMaster'
declare @ConditionalTable nvarchar(200)

DECLARE @columns NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);


set @ConditionalTable='ConditionalMandatoryFields_' + @Dataset 
-- Get the unique values from the 'Value' column to use as dynamic columns
SELECT @columns = STRING_AGG(QUOTENAME(Field), ',')
FROM (SELECT DISTINCT Field FROM DQTableFields_ConditionsBySegment where Dataset=@dataset
) AS ValueList;
print(@columns)

set @sql='drop table if exists '+@ConditionalTable

-- Create the dynamic SQL for the pivot query
SET @sql = '
SELECT
   DataSet,
   [Value] as SegmentValue,
   SegmentField,
   ' + @columns + '
   INTO ' + @ConditionalTable + '
FROM
(
   SELECT
       DataSet,
       Field,
       SegmentField,
       Value,
       CAST(Mandatory AS INT) AS Mandatory -- Cast the BIT column to INT for pivoting
   FROM DQTableFields_ConditionsBySegment  where Dataset='''+@Dataset+'''
) AS SourceTable
PIVOT
(
   MAX(Mandatory)
   FOR Field IN (' + @columns + ')
) AS PivotTable
--ORDER BY DataSet, [Value], SegmentField;
';
print(@sql)
exec sp_executesql @sql

end
GO
/****** Object:  StoredProcedure [dbo].[webDQTables_Populate_FieldSegmentView_Ins]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDQTables_Populate_FieldSegmentView_Ins](@Dataset nvarchar(100))  
AS  
  BEGIN  
      SET NOCOUNT ON;  
  
      -- Variables  
      --DECLARE @Dataset NVARCHAR(100)='ttKNA1_DS';  
      DECLARE @Field NVARCHAR(100);  
      DECLARE @SegmentView NVARCHAR(128);  
      DECLARE @SegmentField NVARCHAR(128);  
	  DECLARE @SegmentFieldAlias NVARCHAR(128);
      DECLARE @ConditionField NVARCHAR(128); 
	  DECLARE @ConditionFieldInDataSet NVARCHAR(128); 
      DECLARE @SQL NVARCHAR(MAX);  
      DECLARE @SegmentValue NVARCHAR(256);  
      DECLARE @ErrorMessage NVARCHAR(4000);  
  
     
		
		select @SegmentView=SegmentView,@SegmentField=SegmentField,@SegmentFieldAlias=SegmentFieldAlias,@ConditionField=ConditionField,@ConditionFieldInDataSet=ConditionFieldInDataSet  from DQTables 
		where SegmentView is not null and dataset=@Dataset
		 SELECT Dataset,  
               Field  
               
        FROM   DQTableFields  
        WHERE  ConditionBySegment = 1 and Dataset=@Dataset and SegmentView is null;  
      -- Cursor to loop over fields with ConditionBySegment = 1  
      DECLARE FieldCursor CURSOR FAST_FORWARD FOR  
        SELECT Dataset,  
               Field  
               
        FROM   DQTableFields  
        WHERE  ConditionBySegment = 1 and Dataset=@Dataset and (SegmentView is null or SegmentField is null);  
  
      OPEN FieldCursor;  
  
      FETCH NEXT FROM FieldCursor INTO @Dataset, @Field
  
      WHILE @@FETCH_STATUS = 0  
        BEGIN  
            Update DQTableFields set SegmentView=@SegmentView,
			SegmentField=@SegmentField , SegmentFieldAlias=@SegmentFieldAlias,ConditionField=@ConditionField,ConditionFieldInDataSet=@ConditionFieldInDataSet
			
			where Dataset=@Dataset and Field=@Field and (SegmentView is null or SegmentField is null)
		    
			FETCH NEXT FROM FieldCursor INTO @Dataset, @Field
        END  
      CLOSE FieldCursor;  
  
      DEALLOCATE FieldCursor;  
  
  END 
GO
/****** Object:  StoredProcedure [dbo].[webDQTablesFields_Dataset_GetFields_InfoSchema_Ins]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[webDQTablesFields_Dataset_GetFields_InfoSchema_Ins]
AS
  BEGIN
      SET NOCOUNT ON;

      DECLARE @Dataset nvarchar(100)
      DECLARE @SQL nvarchar(max)
      DECLARE @TableExists bit
      -- Cursor to loop through datasets in DQTables  
      DECLARE dataset_cursor CURSOR FOR
        SELECT Dataset
        FROM   DQTables
        WHERE  Active = 1

      OPEN dataset_cursor

      FETCH NEXT FROM dataset_cursor INTO @Dataset

      WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Check if table exists  
            SET @TableExists = 0

            IF EXISTS (SELECT 1
                       FROM   INFORMATION_SCHEMA.TABLES
                       WHERE  TABLE_NAME = @Dataset)
              BEGIN
                  SET @TableExists = 1

                  -- Delete existing entries for this dataset  
                  --DELETE FROM DQTableFields
                  --WHERE  Dataset = @Dataset

                  -- Insert column information into DQTableFields  
                  INSERT INTO DQTableFields
                              (Dataset,
                               Field,
                               [Description],
                               [Order],
                               [Key],
                               Active,
                               AddedBy,
                               AddedOn,
                               AddedVia)
                  SELECT @Dataset,
                         COLUMN_NAME,
                         NULL                    as [Description],
                         ORDINAL_POSITION        as [Order],
                         CASE
                           WHEN EXISTS (SELECT 1
                                        FROM   INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                                        WHERE  TABLE_NAME = @Dataset
                                               AND COLUMN_NAME = INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME
                                               AND CONSTRAINT_NAME LIKE 'PK%') THEN 1
                           ELSE 0
                         END                     as [Key],
                         1                       as Active,
                         SYSTEM_USER             as AddedBy,
                         Getdate()               as AddedOn,
                         'PopulateDQTableFields' as AddedVia
                  FROM   INFORMATION_SCHEMA.COLUMNS
                         LEFT outer JOIN DQTableFields df
                                      ON df.Dataset = @Dataset
                                         AND df.Field = COLUMN_NAME
                  WHERE  TABLE_NAME = @Dataset
                         AND df.Field IS NULL
                  ORDER  BY ORDINAL_POSITION;

                  -- Log success  
                  PRINT 'Successfully processed table: ' + @Dataset
              END
            ELSE
              BEGIN
                  -- Log table not found  
                  PRINT 'Table not found: ' + @Dataset
              END

            FETCH NEXT FROM dataset_cursor INTO @Dataset
        END

      CLOSE dataset_cursor

      DEALLOCATE dataset_cursor

      -- Return success  
      RETURN 0
  END 
GO
/****** Object:  StoredProcedure [dbo].[webDQTablesFields_Dataset_GetFields_Ins]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[webDQTablesFields_Dataset_GetFields_Ins](@Dataset nvarchar(100))
as
  begin
      insert into DQTableFields
                  ([Dataset],
                   Field,
                   [Description],
                   [Order],
                   [Key],
                   Active)
      select DatasetName,
             isnull(fields.Alias, col.ColumnName) as Field,
             '',
             SequenceNumber,
             '',
             1
      from   Dataset_SelectFields fields
	  left outer join Dataset_Tables DST on  fields.DataSetTableId=DST.DatasetTableID
             left outer join AvailableTables [Tab]
                          on DST.TableId = tab.TableID
             left outer join TableColumns col
                          on tab.TableID = col.TableID
                             and fields.ColumnID = col.ColumnID
             left outer join Dataset_Master DS
                          on fields.DatasetID = Ds.DatasetID
             left outer join DQTableFields DQTF
                          on DQTF.[Dataset] = DatasetName
                             and DQTF.Field = isnull(fields.Alias, col.ColumnName)
      where  DatasetName = @Dataset
             and DQTF.Field is null
  end 
GO
/****** Object:  StoredProcedure [dbo].[webMaterial_ConfigTables_UpdateDetailsHor]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[webMaterial_ConfigTables_UpdateDetailsHor](@Table nvarchar(30))
as
begin


update material_configtables set TextTable=webSystemTypeTableList.DescriptionTableName from material_configtables inner join webSystemTypeTableList on material_configtables.[Table]=webSystemTypeTableList.[tablename]
where material_configtables.[Table]=@Table
update material_configtables set [Description]=webSystemTypeTableList.TableDescription from  material_configtables inner join webSystemTypeTableList on material_configtables.[Table]=webSystemTypeTableList.TableName
where material_configtables.[Table]=@Table
end
GO
/****** Object:  StoredProcedure [dbo].[webMDQ_MaterialMasterSales_Completeness_Matrix_CommitChange_WarningMessage]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webMDQ_MaterialMasterSales_Completeness_Matrix_CommitChange_WarningMessage] 
AS
BEGIN
		-- Dummy SP to add a pre message for CommitChange button
		-- It informs that changes can not be done in AutoDQ and you need to go to External Lookups to commit changes.
		select * from ztMDQ_MaterialMasterSales_Completeness_Matrix
		
	
END
GO
/****** Object:  StoredProcedure [dbo].[webMDQ_MaterialMasterSales_Completeness_Matrix_Del]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[webMDQ_MaterialMasterSales_Completeness_Matrix_Del]
AS
	TRUNCATE TABLE ztMDQ_MaterialMasterSales_Completeness_Matrix
GO
/****** Object:  StoredProcedure [dbo].[webMDQ_MaterialMasterSales_Completeness_Matrix_Ins]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webMDQ_MaterialMasterSales_Completeness_Matrix_Ins]
AS
	/*INSERT INTO ztMDQ_MaterialMasterSales_Completeness_Matrix ( [DQCheckRequired]
      ,[DQCheckRequiredModified]
      ,[DQReportGrouping]
      ,[DQReportGroupingSubsegment]
      ,[InternalComment]
      ,[Level]
      ,[OrganizationalUnit]
      ,[FunctionalOwner]
      ,[Table]
      ,[Field]
      ,[FieldDescription]
      ,[Checktables]
      ,[UsedAtAZ]
      ,[FinishedProduct]
      ,[FinishedProductModified]
      ,[SemiFinishedGoods]
      ,[SemiFinishedGoodsModified]
      ,[Packaging]
      ,[PackagingModified]
      ,[RawMaterials]
      ,[RawMaterialsModified]
      ,[SpareParts]
      ,[SparePartsModified]
      ,[OperatingSupplies]
      ,[OperatingSuppliesModified]
      ,[NonStockMaterials]
      ,[NonStockMaterialsModified]
      ,[NonValuated]
      ,[NonValuatedModified]
      ,[ManufacturingParts]
      ,[ManufacturingPartsModified]
      ,[MaintenanceAssemblies]
      ,[MaintenanceAssembliesModified]
      ,[WorkInProcess]
      ,[WorkInProcessModified]
      ,[Service]
      ,[ServiceModified]
      ,[CriticalProcessAidMaterial]
      ,[CriticalProcessAidMaterialModified]
      ,[ClinicalFinishedGoods]
      ,[ClinicalFinishedGoodsModified]
      ,[ClinicalPrimaryPack]
      ,[ClinicalPrimaryPackModified]
      ,[ClinicalCommercialPrimaryPack]
      ,[ClinicalCommercialPrimaryPackModified]
      ,[ClinicalComparatorPrimaryPack]
      ,[ClinicalComparatorPrimaryPackModified]
      ,[ClinicalDrugProduct]
      ,[ClinicalDrugProductModified]
      ,[ClinicalDrugSubstance]
      ,[ClinicalDrugSubstanceModified]
      ,[ClinicalLabel]
      ,[ClinicalLabelModified]
      ,[ClinicalSemiFinishedGood]
      ,[ClinicalSemiFinishedGoodModified]
      ,[ClinicalPackagingMaterial]
      ,[ClinicalPackagingMaterialModified]
      ,[ClinicalRawMaterial]
      ,[ClinicalRawMaterialModified]
      ,[ClinicalCellGeneTherapyIMP]
      ,[ClinicalCellGeneTherapyIMPModified]
      ,[AddedBy]
      ,[AddedOn]
      ,[AddedVia]
      ,[ChangedBy]
      ,[ChangedOn]
      ,[ChangedVia]
      ,[boaStatus])
	SELECT
	  [DQCheckRequired]
      ,[DQCheckRequiredModified]
      ,[DQReportGrouping]
      ,[DQReportGroupingSubsegment]
      ,[InternalComment]
      ,[Level]
      ,[OrganizationalUnit]
      ,[FunctionalOwner]
      ,[Table]
      ,[Field]
      ,[FieldDescription]
      ,[Checktables]
      ,[UsedAtAZ]
      ,[FinishedProduct]
      ,[FinishedProductModified]
      ,[SemiFinishedGoods]
      ,[SemiFinishedGoodsModified]
      ,[Packaging]
      ,[PackagingModified]
      ,[RawMaterials]
      ,[RawMaterialsModified]
      ,[SpareParts]
      ,[SparePartsModified]
      ,[OperatingSupplies]
      ,[OperatingSuppliesModified]
      ,[NonStockMaterials]
      ,[NonStockMaterialsModified]
      ,[NonValuated]
      ,[NonValuatedModified]
      ,[ManufacturingParts]
      ,[ManufacturingPartsModified]
      ,[MaintenanceAssemblies]
      ,[MaintenanceAssembliesModified]
      ,[WorkInProcess]
      ,[WorkInProcessModified]
      ,[Service]
      ,[ServiceModified]
      ,[CriticalProcessAidMaterial]
      ,[CriticalProcessAidMaterialModified]
      ,[ClinicalFinishedGoods]
      ,[ClinicalFinishedGoodsModified]
      ,[ClinicalPrimaryPack]
      ,[ClinicalPrimaryPackModified]
      ,[ClinicalCommercialPrimaryPack]
      ,[ClinicalCommercialPrimaryPackModified]
      ,[ClinicalComparatorPrimaryPack]
      ,[ClinicalComparatorPrimaryPackModified]
      ,[ClinicalDrugProduct]
      ,[ClinicalDrugProductModified]
      ,[ClinicalDrugSubstance]
      ,[ClinicalDrugSubstanceModified]
      ,[ClinicalLabel]
      ,[ClinicalLabelModified]
      ,[ClinicalSemiFinishedGood]
      ,[ClinicalSemiFinishedGoodModified]
      ,[ClinicalPackagingMaterial]
      ,[ClinicalPackagingMaterialModified]
      ,[ClinicalRawMaterial]
      ,[ClinicalRawMaterialModified]
      ,[ClinicalCellGeneTherapyIMP]
      ,[ClinicalCellGeneTherapyIMPModified]
      ,[AddedBy]
      ,[AddedOn]
      ,[AddedVia]
      ,[ChangedBy]
      ,[ChangedOn]
      ,[ChangedVia]
      ,[boaStatus]
	FROM
	  DataConstructionServer.dbo.ztMDQ_MaterialMasterSales_Completeness_Matrix
	  */
GO
/****** Object:  StoredProcedure [dbo].[webObjectSummary_Dataset_UpdateDescription_From_DatasetMasterUpd]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure	[dbo].[webObjectSummary_Dataset_UpdateDescription_From_DatasetMasterUpd]
as
begin
update ObjectSummary_Dataset set [Description] = DQTables.[Description] from 
ObjectSummary_Dataset inner join DQTables  on ObjectSummary_Dataset.Dataset=DQTables.Dataset
where DQTables.Active=1 and isnull(ObjectSummary_Dataset.[Description],'')=''
end
GO
/****** Object:  StoredProcedure [dbo].[webObjectSummary_GenerateSummary]    Script Date: 2/12/2026 5:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webObjectSummary_GenerateSummary]    
    
   @ObjectDataset NVARCHAR(100)    
AS    
BEGIN    
   SET NOCOUNT ON;    
   --declare @ObjectDataset nvarchar(200)='IV_MAM_225_MCH1_BatchMaster_ObjectSummary' ;   
   DECLARE @Description NVARCHAR(100);    
   declare @Group nvarchar(100);  
   declare @GroupDatasets nvarchar(max);  
   DECLARE @KeyFields NVARCHAR(MAX);    
   declare @KeyFieldsForSelect nvarchar(max)    
   DECLARE @KeyFieldsList NVARCHAR(MAX);    
   DECLARE @KeyFieldsDataType NVARCHAR(MAX);    
   DECLARE @KeyFieldsJoinCondition NVARCHAR(MAX); 
   DECLARE @Keyfield_WithoutExtension NVARCHAR(MAX);
   declare @DisplayFields nvarchar(max);  
   declare @DisplayFields_insert nvarchar(max);  
   declare @DisplayFields_table nvarchar(max);  
   declare @reporttype nvarchar(max);  
   DECLARE @SQL NVARCHAR(MAX);    
   DECLARE @CalculatedKeyExpression NVARCHAR(MAX);    
   DECLARE @ChildDataset NVARCHAR(200);    
   DECLARE @Dataset NVARCHAR(200);    
   DECLARE @First BIT;   
     
   -- Get the description of the ObjectDataset    
   SELECT @Description = Description    
   FROM ObjectSummary    
   WHERE ObjectDataset = @ObjectDataset AND Active = 1;    
     
   IF @Description IS NULL    
   BEGIN    
       PRINT 'ObjectDataset ' + @ObjectDataset + ' is not active or does not exist.';    
       RETURN;    
   END    
     
   PRINT 'Processing ObjectDataset: ' + @ObjectDataset;    


     
   -- Get Key Fields for the ObjectDataset    
   SELECT     
       @KeyFields = STRING_AGG(QUOTENAME(Field), ', '),    
    @KeyFieldsForSelect = STRING_AGG('O.'+QUOTENAME(Field), ', '),    
       @KeyFieldsList = STRING_AGG(Field, ', '),    
       @KeyFieldsDataType = STRING_AGG(QUOTENAME(Field) + ' NVARCHAR(100)', ', '), 
	   -- ERROR SOLVED: Addition of COLLATE to solve bug when some fields have collation issues
       @KeyFieldsJoinCondition = STRING_AGG('O.' + QUOTENAME(Field) + ' COLLATE SQL_Latin1_General_CP1_CS_AS = ' + 'C.' + QUOTENAME(Field), ' COLLATE SQL_Latin1_General_CP1_CS_AS AND '), 
	   @Keyfield_WithoutExtension = CONCAT('''''',' AS ',STRING_AGG(QUOTENAME(Field), ', '''' AS '))  
   FROM DQTableFields    
   WHERE Dataset = @ObjectDataset AND [Key] = 1;    
     
   -- Build the concatenated key calculation
   -- ERRO SOLVED: Addition of COLLATE to solve bug when some fields have collation issues
   SELECT @CalculatedKeyExpression = STRING_AGG('ISNULL(CAST(O.' + QUOTENAME(Field) + '  COLLATE SQL_Latin1_General_CP1_CS_AS AS NVARCHAR(100)), '''')', ' + ''_'' + ')  WITHIN Group (Order by [Order])  
   FROM DQTableFields    
   WHERE Dataset = @ObjectDataset AND [Key] = 1;    
   print(@CalculatedKeyExpression)  
  
    -- Build the Display fields List  
   SELECT @DisplayFields = STRING_AGG('O.'+QUOTENAME(Field), ', ')  WITHIN Group (Order by [Order]), 
   
   /* This section has been commented by GK on 28/11 because while creating tables the names of the fields were not quoted and leaded to error, the next section is the replacemente

   --@DisplayFields_insert = STRING_AGG(Field, ', ')  WITHIN Group (Order by [Order]),  
   -- @DisplayFields_table = STRING_AGG(Field+ ' nvarchar(256)', ', ')  WITHIN Group (Order by [Order])  
   */

   @DisplayFields_insert = STRING_AGG(QUOTENAME(Field), ', ')  WITHIN Group (Order by [Order]),  
   @DisplayFields_table = STRING_AGG(QUOTENAME(Field)+ ' nvarchar(256)', ', ')  WITHIN Group (Order by [Order])  
   FROM DQTableFields    
   WHERE Dataset = @ObjectDataset AND ReportDisplay = 1;   
   print(@DisplayFields)  
   print(@DisplayFields_insert)  
   print(@DisplayFields_table)  
   -- Get Child Datasets for the ObjectDataset    
   DECLARE @ChildDatasets TABLE (    
       Dataset NVARCHAR(200),    
       ReportType NVARCHAR(40),    
       Extension BIT ,  
    [Group] nvarchar(100)  
   );    
     
   INSERT INTO @ChildDatasets (Dataset, ReportType, Extension,[Group])    
   SELECT Dataset, ReportType, Extension , [Group]   
   FROM ObjectSummary_Dataset    
   WHERE ObjectDataset = @ObjectDataset AND Active = 1;    
     
   -- Create the summary table name    
   DECLARE @SummaryTableName NVARCHAR(128) = @ObjectDataset + '_ObjectLevelSummary';    
     
   -- Drop the summary table if it exists    
   IF OBJECT_ID(@SummaryTableName, 'U') IS NOT NULL    
   BEGIN    
       SET @SQL = 'DROP TABLE ' + QUOTENAME(@SummaryTableName) + ';';    
       EXEC(@SQL);    
   END    
     
   -- Create the summary table    
   SET @SQL = '    
   CREATE TABLE ' + QUOTENAME(@SummaryTableName) + ' (    
       ' + @KeyFieldsDataType + ',    
       CalculatedKey NVARCHAR(500),    
    '+@DisplayFields_table+',  
       Attributes INT,    
       Extensions INT,    
       Records INT,    
       Missing INT,    
       Dummy INT,    
       Total INT    
   );    
   ';    
   print(@sql)  
   EXEC(@SQL);    
     
 DECLARE @AttributesViewName NVARCHAR(128) = QUOTENAME('Attributes_View_' + @ObjectDataset);    
 DECLARE @ExtensionsViewName NVARCHAR(128) = QUOTENAME('Extensions_View_' + @ObjectDataset);    
  DECLARE @RecordsViewName NVARCHAR(128) = QUOTENAME('Records_View_' + @ObjectDataset);    
  DECLARE @MissingViewName NVARCHAR(128) = QUOTENAME('Missing_View_' + @ObjectDataset);    
  DECLARE @DummyViewName NVARCHAR(128) = QUOTENAME('Dummy_View_' + @ObjectDataset);    
  -- Drop the views at the begining    
   SET @SQL = '    
   DROP VIEW if exists ' + @AttributesViewName + ';    
   DROP VIEW if exists ' + @ExtensionsViewName + ';    
   DROP VIEW if exists ' + @RecordsViewName + ';    
   DROP VIEW if exists ' + @MissingViewName + ';    
   DROP VIEW if exists ' + @DummyViewName + ';    
   ';    
   EXEC(@SQL);    
    
   -- Create views for intermediate calculations    
     
   -- 1. Attributes View    
       
   SET @SQL = 'CREATE VIEW ' + @AttributesViewName + ' AS ';    
   DECLARE @AttributesSelect NVARCHAR(MAX) = '';    
   SET @First = 1;    
     
   DECLARE ChildDatasetCursor CURSOR FOR    
   SELECT Dataset,[Group],ReportType    
   FROM @ChildDatasets;    
     
   OPEN ChildDatasetCursor;    
   FETCH NEXT FROM ChildDatasetCursor INTO @Dataset, @Group,@reporttype;    
   WHILE @@FETCH_STATUS = 0    
   BEGIN    
  select * from @ChildDatasets  
  select @GroupDatasets=STRING_AGG(''''+Dataset+'''', ', ') from ObjectSummary_Dataset where [Group]=@Group  
  print('------'+isnull(@GroupDatasets,''))  
  
       DECLARE @NumAttributes INT;    
       SELECT @NumAttributes = COUNT(distinct [Field])     
       FROM DQTableFields     
       WHERE Dataset in  (select Dataset from ObjectSummary_Dataset where [Group]=@Group) AND [Key] = 0;    
    
  
       IF @First = 1    
       BEGIN    
           SET @AttributesSelect = '    
           SELECT DISTINCT ' + @KeyFields + ', '''+@group + ''' as [Group],' + CAST(@NumAttributes AS NVARCHAR(10)) + ' AS Attributes    
           FROM ' + @Dataset + case when @reporttype='Completeness Check' then 'Completeness_RecordLevelResult' when @reporttype='Dummy Value Check' then '_DummyValues_AttributeLevel' else '' end+' C'    
           SET @First = 0;    
       END    
       ELSE    
       BEGIN    
           SET @AttributesSelect += '    
           UNION ALL    
           SELECT DISTINCT ' + @KeyFields + ', '''+@group + ''' as [Group], ' + CAST(@NumAttributes AS NVARCHAR(10)) + ' AS Attributes    
           FROM ' + @Dataset + case when @reporttype='Completeness Check' then 'Completeness_RecordLevelResult' when @reporttype='Dummy Value Check' then '_DummyValues_AttributeLevel' else '' end+' C'     
       END    
     
       FETCH NEXT FROM ChildDatasetCursor INTO @Dataset,@Group,@reporttype;    
   END    
   CLOSE ChildDatasetCursor;    
   DEALLOCATE ChildDatasetCursor;    
     
   SET @SQL += @AttributesSelect + ';';    
   print(@SQL)    
   EXEC(@SQL);    
     
   -- 2. Extensions View : Create view only executed when there's an extension

 
   SET @SQL = 'CREATE VIEW ' + @ExtensionsViewName + ' AS ';    
   DECLARE @ExtensionsSelect NVARCHAR(MAX) = '';    
   SET @First = 1;    
     
   DECLARE ExtensionDatasetCursor CURSOR FOR    
   SELECT Dataset  , ReportType  
   FROM @ChildDatasets    
   WHERE Extension = 1;    
     
   OPEN ExtensionDatasetCursor;    
   FETCH NEXT FROM ExtensionDatasetCursor INTO @Dataset,@reporttype;    
   WHILE @@FETCH_STATUS = 0    
   BEGIN    
       IF @First = 1    
       BEGIN    
           SET @ExtensionsSelect = '    
           SELECT  ' + @KeyFields + ', 1 AS ExtensionsViews ,count(*) as    ExtensionRecords
           FROM ' + @Dataset + case when @reporttype='Completeness Check' then 'Completeness_RecordLevelResult' when @reporttype='Dummy Value Check' then '_DummyValues_AttributeLevel' else '' end+' C
		   group by '+ @KeyFields
		   
           SET @First = 0;    
       END    
       ELSE    
       BEGIN    
           SET @ExtensionsSelect += '    
           UNION ALL    
           SELECT DISTINCT ' + @KeyFields + ', 1 AS ExtensionsViews ,count(*) as    ExtensionRecords    
           FROM ' + @Dataset + case when @reporttype='Completeness Check' then 'Completeness_RecordLevelResult' when @reporttype='Dummy Value Check' then '_DummyValues_AttributeLevel' else '' end+' C
		   group by '+ @KeyFields    
       END    
     
       FETCH NEXT FROM ExtensionDatasetCursor INTO @Dataset,@reporttype;    
   END    
   CLOSE ExtensionDatasetCursor;    
   DEALLOCATE ExtensionDatasetCursor;    
     
   IF @ExtensionsSelect <> ''    
   BEGIN    
       SET @SQL += @ExtensionsSelect + ';';    
       print(@SQL)    
    EXEC(@SQL);    
   END    
   ELSE    
   BEGIN    
       -- Create an empty view if there are no extensions    
     

	Print(@Keyfield_WithoutExtension) 
	SET @SQL = 'CREATE VIEW ' + @ExtensionsViewName + ' AS SELECT ' + @Keyfield_WithoutExtension + ', CAST(0 AS INT) AS ExtensionRecords;';   
    print(@SQL)    
       EXEC(@SQL);    
   END    
    
-- 3. Records View    
      
   SET @SQL = 'CREATE VIEW ' + @RecordsViewName + ' AS ';    
   DECLARE @RecordsSelect NVARCHAR(MAX) = '';    
   SET @First = 1;    
     
   DECLARE RecordsDatasetCursor CURSOR FOR    
   SELECT Dataset  ,reporttype  
   FROM @ChildDatasets;    
     
   OPEN RecordsDatasetCursor;    
   FETCH NEXT FROM RecordsDatasetCursor INTO @Dataset,@reportType;    
   WHILE @@FETCH_STATUS = 0    
   BEGIN    
       IF @First = 1    
       BEGIN    
           SET @RecordsSelect = '    
           SELECT DISTINCT ' + @KeyFields + ', 1 AS Records    
           FROM ' + @Dataset + case when @reporttype='Completeness Check' then 'Completeness_RecordLevelResult' when @reporttype='Dummy Value Check' then '_DummyValues_AttributeLevel' else '' end+' C'    
           SET @First = 0;    
       END    
       ELSE    
       BEGIN    
           SET @RecordsSelect += '    
           UNION ALL    
           SELECT DISTINCT ' + @KeyFields + ', 1 AS Records    
           FROM ' + @Dataset + case when @reporttype='Completeness Check' then 'Completeness_RecordLevelResult' when @reporttype='Dummy Value Check' then '_DummyValues_AttributeLevel' else '' end+' C'    
       END    
     
       FETCH NEXT FROM RecordsDatasetCursor INTO @Dataset,@reportType;    
   END    
   CLOSE RecordsDatasetCursor;    
   DEALLOCATE RecordsDatasetCursor;    
     
   SET @SQL += @RecordsSelect + ';';    
   print(@SQL)    
   EXEC(@SQL);    
     
   -- 4. Missing View    
       
   SET @SQL = 'CREATE VIEW ' + @MissingViewName + ' AS ';    
   DECLARE @MissingSelect NVARCHAR(MAX) = '';    
   SET @First = 1;    
     
   DECLARE MissingDatasetCursor CURSOR FOR    
   SELECT Dataset    
   FROM @ChildDatasets    
   WHERE ReportType = 'Completeness Check';    
     
   OPEN MissingDatasetCursor;    
   FETCH NEXT FROM MissingDatasetCursor INTO @Dataset;    
   WHILE @@FETCH_STATUS = 0    
   BEGIN    
     
       IF OBJECT_ID(QUOTENAME(@Dataset + 'Completeness_RecordLevelResult'), 'U') IS NOT NULL    
       BEGIN    
           IF @First = 1    
           BEGIN    
               SET @MissingSelect = '    
               SELECT DISTINCT ' + @KeyFields + ', ISNULL(CR.TotalMissingFields, 0) AS Missing    
               FROM ' + QUOTENAME(@Dataset + 'Completeness_RecordLevelResult') + ' CR';    
      print(@MissingSelect)    
               SET @First = 0;    
           END    
           ELSE    
           BEGIN    
               SET @MissingSelect += '    
               UNION ALL    
               SELECT DISTINCT ' + @KeyFields + ', ISNULL(CR.TotalMissingFields, 0) AS Missing    
               FROM ' + QUOTENAME(@Dataset + 'Completeness_RecordLevelResult') + ' CR';    
           END    
       END    
     
       FETCH NEXT FROM MissingDatasetCursor INTO @Dataset;    
   END    
   CLOSE MissingDatasetCursor;    
   DEALLOCATE MissingDatasetCursor;    
     
   IF @MissingSelect <> ''    
   BEGIN    
       SET @SQL += @MissingSelect + ';';    
    print(@SQL)    
       EXEC(@SQL);    
   END    
   ELSE    
   BEGIN    
       -- Create an empty view if there are no missing data    
       SET @SQL = 'CREATE VIEW ' + @MissingViewName + ' AS SELECT ' + @KeyFields + ', CAST(0 AS INT) AS Missing WHERE 1=0;';    
       EXEC(@SQL);    
   END    
    
   -- 5. Dummy View    
       
   SET @SQL = 'CREATE VIEW ' + @DummyViewName + ' AS ';    
   DECLARE @DummySelect NVARCHAR(MAX) = '';    
   SET @First = 1;    
     
   DECLARE DummyDatasetCursor CURSOR FOR    
   SELECT Dataset    
   FROM @ChildDatasets    
   WHERE ReportType = 'Dummy Value Check';    
     
   OPEN DummyDatasetCursor;    
   FETCH NEXT FROM DummyDatasetCursor INTO @Dataset;    
   WHILE @@FETCH_STATUS = 0    
   BEGIN    
       IF OBJECT_ID(QUOTENAME(@Dataset + '_DummyValues_RecordLevel'), 'U') IS NOT NULL    
       BEGIN    
           IF @First = 1    
           BEGIN    
               SET @DummySelect = '    
               SELECT DISTINCT ' + @KeyFields + ', ISNULL(DR.TotalDummyValue_ResultFields, 0) AS Dummy    
               FROM ' + QUOTENAME(@Dataset + '_DummyValues_RecordLevel') + ' DR';    
               SET @First = 0;    
           END    
           ELSE    
           BEGIN    
               SET @DummySelect += '    
               UNION ALL    
               SELECT DISTINCT ' + @KeyFields + ', ISNULL(DR.TotalDummyValue_ResultFields, 0) AS Dummy    
               FROM ' + QUOTENAME(@Dataset + '_DummyValues_RecordLevel') + ' DR';    
           END    
       END    
     
       FETCH NEXT FROM DummyDatasetCursor INTO @Dataset;    
   END    
   CLOSE DummyDatasetCursor;    
   DEALLOCATE DummyDatasetCursor;    
     
   IF @DummySelect <> ''    
   BEGIN    
       SET @SQL += @DummySelect + ';';    
    print(@Sql)    
       EXEC(@SQL);    
   END    
   ELSE    
   BEGIN    
       -- Create an empty view if there are no dummy data    
       SET @SQL = 'CREATE VIEW ' + @DummyViewName + ' AS SELECT ' + @KeyFields + ', CAST(0 AS INT) AS Dummy WHERE 1=0;';    
       EXEC(@SQL);    
   END    
 print('Key conditions----'+@KeyFieldsJoinCondition)    
   -- Now, insert into the summary table    
   SET @SQL = '    
   INSERT INTO ' + QUOTENAME(@SummaryTableName) + ' (' + @KeyFieldsList + ', CalculatedKey,'+@DisplayFields_insert+', Attributes, Extensions, Records, Missing, Dummy, Total)    
   SELECT     
       ' + @KeyFieldsForSelect + ',    
       ' + @CalculatedKeyExpression + ' AS CalculatedKey,    
    '+@DisplayFields+',  
       ISNULL(A.TotalAttributes, 0) AS Attributes,    
       ISNULL(E.TotalExtensions, 0) AS Extensions,    
       ISNULL(R.TotalRecords, 0) AS Records,    
       ISNULL(M.TotalMissing, 0) AS Missing,    
       ISNULL(D.TotalDummy, 0) AS Dummy,    
       ISNULL(M.TotalMissing, 0) + ISNULL(D.TotalDummy, 0) AS Total    
   FROM ' + QUOTENAME(@ObjectDataset) + ' O    
   LEFT JOIN (   
 select '+ @KeyFields+', sum(TotalAttributes) as TotalAttributes from (  
       SELECT ' + @KeyFields + ', AVG(Attributes) AS TotalAttributes    
       FROM ' + @AttributesViewName + '    
       GROUP BY ' + @KeyFields + ',[Group] ) a group by '+ @KeyFields+'  
   ) A ON ' + REPLACE(@KeyFieldsJoinCondition, 'C.[', 'A.[') + '    
   LEFT JOIN (    
       SELECT ' + @KeyFields + ', SUM(ExtensionRecords) AS TotalExtensions    
       FROM ' + @ExtensionsViewName + '    
       GROUP BY ' + @KeyFields + '    
   ) E ON ' + REPLACE(@KeyFieldsJoinCondition, 'C.[', 'E.[') + '    
   LEFT JOIN (    
       SELECT ' + @KeyFields + ', AVG(Records) AS TotalRecords    
       FROM ' + @RecordsViewName + '    
       GROUP BY ' + @KeyFields + '    
   ) R ON ' + REPLACE(@KeyFieldsJoinCondition, 'C.[', 'R.[') + '    
   LEFT JOIN (    
       SELECT ' + @KeyFields + ', SUM(Missing) AS TotalMissing    
       FROM ' + @MissingViewName + '    
       GROUP BY ' + @KeyFields + '    
   ) M ON ' + REPLACE(@KeyFieldsJoinCondition, 'C.[', 'M.[') + '    
   LEFT JOIN (    
       SELECT ' + @KeyFields + ', SUM(Dummy) AS TotalDummy    
       FROM ' + @DummyViewName + '    
       GROUP BY ' + @KeyFields + '    
   ) D ON ' + REPLACE(@KeyFieldsJoinCondition, 'C.[', 'D.[') + ';    
   ';    
   print(@sql)    
   EXEC(@SQL);    
     
  --  Drop the views at the end    
   --SET @SQL = '    
   --DROP VIEW if exists ' + @AttributesViewName + ';    
   --DROP VIEW if exists ' + @ExtensionsViewName + ';    
   --DROP VIEW if exists ' + @RecordsViewName + ';    
   --DROP VIEW if exists ' + @MissingViewName + ';    
   --DROP VIEW if exists ' + @DummyViewName + ';    
   --';    
   --EXEC(@SQL);    
     
   PRINT 'Finished processing ObjectDataset: ' + @ObjectDataset;    
END;    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DQ_ConfigLookup"
            Begin Extent = 
               Top = 20
               Left = 529
               Bottom = 154
               Right = 743
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ttLFA1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 332
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 15
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4065
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IV_VEM_001_LFA1_VendorMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IV_VEM_001_LFA1_VendorMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ttLFA1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 322
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 36
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IV_VEM_901_LFA1_VendorMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IV_VEM_901_LFA1_VendorMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DQ_ConfigLookup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'webVendor_AccountGroup_Segment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'webVendor_AccountGroup_Segment'
GO
