USE [WRKDQUtilities]
GO
/****** Object:  Table [dbo].[AccountGroup_DQ_Mapping]    Script Date: 2/12/2026 4:59:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountGroup_DQ_Mapping](
	[SourcesystemID] [nvarchar](20) NOT NULL,
	[KTOKD] [nvarchar](10) NOT NULL,
	[AccountGroupDescription] [nvarchar](100) NULL,
	[KTOKD_Target] [nvarchar](100) NULL,
	[TargetAccountGroupDescription] [nvarchar](100) NULL,
 CONSTRAINT [PK_AccountGroup_DQ_Mapping] PRIMARY KEY CLUSTERED 
(
	[SourcesystemID] ASC,
	[KTOKD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountGroup_VendorCustomer_Config]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountGroup_VendorCustomer_Config](
	[Category] [varchar](8) NOT NULL,
	[SourcesystemID] [nvarchar](6) NOT NULL,
	[AccountGroup] [nvarchar](4) NOT NULL,
	[TXT30] [nvarchar](30) NULL,
	[Account Group - Type] [nvarchar](100) NULL,
	[Account Group - Group] [nvarchar](100) NULL,
	[DPAAS Group] [nvarchar](100) NULL,
	[S/4 Obsolete Scope] [nvarchar](100) NULL,
	[Obsolete Account Group] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[ActiveForMatch] [bit] NULL,
	[MatchScenario] [nvarchar](100) NULL,
	[Comments] [nvarchar](max) NULL,
	[MDG Scope] [nvarchar](100) NULL,
	[Missing in Source] [bit] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_AccountGroup_VendorCustomer_Config] PRIMARY KEY CLUSTERED 
(
	[Category] ASC,
	[SourcesystemID] ASC,
	[AccountGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AvailableTables]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailableTables](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [nvarchar](100) NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Availabl__7D5F018E0733B009] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Availabl__733652EEDDD2099C] UNIQUE NONCLUSTERED 
(
	[TableName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Config_MaterialTypeMapping]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config_MaterialTypeMapping](
	[SourceSystemID] [nvarchar](20) NOT NULL,
	[Legacy Material Type] [nvarchar](10) NOT NULL,
	[LegacyMaterialTypeDescription] [nvarchar](100) NULL,
	[TargetMaterialType] [nvarchar](10) NULL,
	[TargetMaterialTypeDesc] [nvarchar](100) NULL,
 CONSTRAINT [PK_Config_MaterialTypeMapping] PRIMARY KEY CLUSTERED 
(
	[SourceSystemID] ASC,
	[Legacy Material Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataQuality_Reports]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataQuality_Reports](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DataSet] [nvarchar](50) NULL,
	[Field] [nvarchar](100) NULL,
	[Report] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[ReportCategory] [nvarchar](50) NULL,
	[OpportunityReport] [nvarchar](200) NULL,
	[Publish] [int] NULL,
	[RuleName] [nvarchar](max) NULL,
	[Author] [nvarchar](50) NULL,
	[ViewType] [nvarchar](30) NULL,
	[CreationDate] [nvarchar](20) NULL,
 CONSTRAINT [PK_DataQuality_Reports] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataQuality_Summary]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataQuality_Summary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Dataset] [nvarchar](100) NOT NULL,
	[Tables] [nvarchar](400) NULL,
	[Order] [int] NULL,
	[Field] [nvarchar](100) NULL,
	[Completeness] [decimal](18, 5) NULL,
	[CompletenessReport] [nvarchar](100) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_DataQuality_Summary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dataset_JoinConditions]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dataset_JoinConditions](
	[DatasetJoinConditionID] [int] IDENTITY(1,1) NOT NULL,
	[DatasetJoinID] [int] NOT NULL,
	[DataSetID] [int] NULL,
	[FromColumnID] [int] NOT NULL,
	[ToColumnID] [int] NOT NULL,
	[Operator] [varchar](10) NOT NULL,
	[ConditionOrder] [int] NOT NULL,
 CONSTRAINT [PK__Dataset___C815722C18C28EA3] PRIMARY KEY CLUSTERED 
(
	[DatasetJoinConditionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dataset_Joins]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dataset_Joins](
	[DatasetJoinID] [int] IDENTITY(1,1) NOT NULL,
	[DatasetID] [int] NOT NULL,
	[FromTableID] [int] NOT NULL,
	[ToTableID] [int] NOT NULL,
	[JoinType] [varchar](20) NOT NULL,
	[AdditionalConditions] [varchar](500) NULL,
	[JoinOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DatasetJoinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dataset_Master]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dataset_Master](
	[DatasetID] [int] IDENTITY(1,1) NOT NULL,
	[DatasetName] [varchar](100) NOT NULL,
	[Description] [varchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[Select_SQL] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[DatasetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DatasetName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DatasetName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DatasetName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dataset_SelectFields]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dataset_SelectFields](
	[DatasetSelectFieldID] [int] IDENTITY(1,1) NOT NULL,
	[DatasetID] [int] NOT NULL,
	[DataSetTableId] [int] NULL,
	[SequenceNumber] [int] NOT NULL,
	[ColumnID] [int] NULL,
	[ExpressionText] [varchar](max) NULL,
	[Alias] [varchar](100) NULL,
	[IsVisible] [bit] NOT NULL,
	[LookUpTable] [nvarchar](100) NULL,
	[TargetSystemTable] [nvarchar](100) NULL,
	[TargetSystemTableFieldName] [nvarchar](100) NULL,
 CONSTRAINT [PK__Dataset___73C29603BF948667] PRIMARY KEY CLUSTERED 
(
	[DatasetSelectFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dataset_Tables]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dataset_Tables](
	[DatasetTableID] [int] IDENTITY(1,1) NOT NULL,
	[DatasetID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[Alias] [varchar](50) NULL,
	[TargetSystemTableName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[DatasetTableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQ_ConfigLookup]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQ_ConfigLookup](
	[LookupType] [nvarchar](50) NULL,
	[System] [nvarchar](20) NULL,
	[SystemID] [nvarchar](6) NOT NULL,
	[LookUpName] [nvarchar](40) NOT NULL,
	[LookupDescription] [nchar](200) NULL,
	[SourceTable] [nvarchar](50) NOT NULL,
	[SourceField] [nvarchar](50) NULL,
	[SourceValue] [nvarchar](50) NOT NULL,
	[LanguageKey] [nvarchar](5) NULL,
	[SourceValueDescription] [nvarchar](150) NULL,
	[TargetValue] [nvarchar](150) NULL,
	[TargetValueDescription] [nvarchar](150) NULL,
	[DQActive] [nvarchar](40) NULL,
	[ProjectRule] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_DQ_ConfigLookup] PRIMARY KEY CLUSTERED 
(
	[SystemID] ASC,
	[LookUpName] ASC,
	[SourceTable] ASC,
	[SourceValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQ_ConfigLookup#Audit]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQ_ConfigLookup#Audit](
	[boaAuditID] [int] IDENTITY(1,1) NOT NULL,
	[boaAuditProcessToken] [uniqueidentifier] NULL,
	[boaAuditDateCreated] [datetime2](0) NOT NULL,
	[boaAuditUserID] [nvarchar](50) NULL,
	[boaAuditPageID] [uniqueidentifier] NULL,
	[boaAuditEvent] [nvarchar](50) NULL,
	[boaAuditSignatureToken] [nvarchar](64) NULL,
	[boaAuditSignatureComment] [nvarchar](200) NULL,
	[SystemID] [nvarchar](6) NOT NULL,
	[LookUpName] [nvarchar](40) NOT NULL,
	[SourceTable] [nvarchar](50) NOT NULL,
	[SourceValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DQ_ConfigLookup#Audit] PRIMARY KEY NONCLUSTERED 
(
	[boaAuditID] ASC,
	[SystemID] ASC,
	[LookUpName] ASC,
	[SourceTable] ASC,
	[SourceValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQ_ConfigLookup#AuditColumn]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQ_ConfigLookup#AuditColumn](
	[boaAuditID] [int] NOT NULL,
	[boaAuditSequence] [int] IDENTITY(1,1) NOT NULL,
	[boaAuditChange] [bit] NOT NULL,
	[System] [nvarchar](20) NULL,
	[SystemID] [nvarchar](6) NULL,
	[LookUpName] [nvarchar](40) NULL,
	[LookupDescription] [nchar](200) NULL,
	[SourceTable] [nvarchar](50) NULL,
	[SourceField] [nvarchar](50) NULL,
	[SourceValue] [nvarchar](50) NULL,
	[LanguageKey] [nvarchar](5) NULL,
	[SourceValueDescription] [nvarchar](100) NULL,
	[TargetValue] [nvarchar](100) NULL,
	[TargetValueDescription] [nvarchar](100) NULL,
	[DQActive] [nvarchar](40) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_DQ_ConfigLookup#AuditColumn] PRIMARY KEY NONCLUSTERED 
(
	[boaAuditID] ASC,
	[boaAuditSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQ_ConfigLookup#AuditProcedure]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQ_ConfigLookup#AuditProcedure](
	[boaAuditID] [int] NOT NULL,
	[boaAuditSequence] [int] IDENTITY(1,1) NOT NULL,
	[boaAuditProcedureCounter] [int] NULL,
	[boaAuditProcedureType] [nvarchar](50) NULL,
	[boaAuditProcedureName] [nvarchar](128) NULL,
 CONSTRAINT [PK_DQ_ConfigLookup#AuditProcedure] PRIMARY KEY NONCLUSTERED 
(
	[boaAuditID] ASC,
	[boaAuditSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQ_ConfigLookup_Backup]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQ_ConfigLookup_Backup](
	[LookupType] [nvarchar](50) NULL,
	[System] [nvarchar](20) NULL,
	[SystemID] [nvarchar](6) NOT NULL,
	[LookUpName] [nvarchar](40) NOT NULL,
	[LookupDescription] [nchar](200) NULL,
	[SourceTable] [nvarchar](50) NOT NULL,
	[SourceField] [nvarchar](50) NULL,
	[SourceValue] [nvarchar](50) NOT NULL,
	[LanguageKey] [nvarchar](5) NULL,
	[SourceValueDescription] [nvarchar](100) NULL,
	[TargetValue] [nvarchar](100) NULL,
	[TargetValueDescription] [nvarchar](100) NULL,
	[DQActive] [nvarchar](40) NULL,
	[ProjectRule] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQ_ProjectRuleValues]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQ_ProjectRuleValues](
	[Value] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DQ_ProjectRuleValues] PRIMARY KEY CLUSTERED 
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQTableFields]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQTableFields](
	[Dataset] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Order] [int] NULL,
	[Key] [bit] NULL,
	[Active] [bit] NULL,
	[ReportDisplay] [bit] NULL,
	[Mandatory] [bit] NULL,
	[Conditional_Manual] [bit] NULL,
	[ConditionBySegment] [bit] NULL,
	[CheckForDummyValues] [bit] NULL,
	[SegmentView] [nvarchar](200) NULL,
	[SegmentField] [nvarchar](100) NULL,
	[SegmentFieldAlias] [nvarchar](100) NULL,
	[ConditionField] [nvarchar](100) NULL,
	[ConditionFieldInDataSet] [nvarchar](100) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_DQTableFields] PRIMARY KEY CLUSTERED 
(
	[Dataset] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQTableFields_Conditions]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQTableFields_Conditions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Dataset] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Priority] [int] NULL,
	[ConditionalGroup] [int] NULL,
	[Sourcesystem] [nvarchar](100) NULL,
	[Mandatory(No Conditions)] [bit] NULL,
	[ConditionalField] [nvarchar](50) NULL,
	[Condition] [nvarchar](max) NULL,
	[ManualCondition] [nvarchar](100) NULL,
	[NextConditionalOperator] [nvarchar](20) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[Report] [nvarchar](200) NULL,
 CONSTRAINT [PK_DQTableFields_Conditions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQTableFields_ConditionsBySegment]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQTableFields_ConditionsBySegment](
	[DataSet] [nvarchar](200) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[SegmentField] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](50) NOT NULL,
	[Mandatory] [bit] NULL,
 CONSTRAINT [PK_DQTableFields_ConditionsBySegment] PRIMARY KEY CLUSTERED 
(
	[DataSet] ASC,
	[SegmentField] ASC,
	[Field] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQTableFields_ConditionsBySegment_Load]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQTableFields_ConditionsBySegment_Load](
	[DataSet] [nvarchar](50) NOT NULL,
	[Field] [nvarchar](50) NOT NULL,
	[FieldDescription] [nvarchar](200) NULL,
	[CheckTable] [nvarchar](50) NULL,
	[Group01] [nvarchar](50) NULL,
	[Group02] [nvarchar](50) NULL,
	[Group03] [nvarchar](50) NULL,
	[Group04] [nvarchar](50) NULL,
	[Group05] [nvarchar](50) NULL,
	[Group06] [nvarchar](50) NULL,
	[Group07] [nvarchar](50) NULL,
	[Group08] [nvarchar](50) NULL,
	[Group09] [nvarchar](50) NULL,
	[Group10] [nvarchar](50) NULL,
	[Group11] [nvarchar](50) NULL,
	[Group12] [nvarchar](50) NULL,
	[Group13] [nvarchar](50) NULL,
	[Group14] [nvarchar](50) NULL,
	[Group15] [nvarchar](50) NULL,
 CONSTRAINT [PK_DQTableFields_ConditionsBySegment_Load2] PRIMARY KEY CLUSTERED 
(
	[DataSet] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQTableFields_DisplayFields]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQTableFields_DisplayFields](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Dataset] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Report] [nvarchar](200) NOT NULL,
	[Order] [int] NULL,
	[DisplayField] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[ExpressionText] [nvarchar](max) NULL,
	[Alias] [nvarchar](128) NULL,
 CONSTRAINT [PK_DQTableFields_DisplayFields] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DQTables]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DQTables](
	[Dataset] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[ReportType] [nvarchar](40) NULL,
	[SAPTable] [nvarchar](100) NULL,
	[SegmentView] [nvarchar](200) NULL,
	[SegmentField] [nvarchar](100) NULL,
	[SegmentFieldAlias] [nvarchar](100) NULL,
	[ConditionField] [nvarchar](100) NULL,
	[ConditionFieldInDataSet] [nvarchar](100) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_DQTables] PRIMARY KEY CLUSTERED 
(
	[Dataset] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DummyValues]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DummyValues](
	[DummyValueID] [int] IDENTITY(1,1) NOT NULL,
	[Dataset] [nvarchar](100) NULL,
	[Field] [nvarchar](128) NULL,
	[MatchType] [nvarchar](30) NULL,
	[DummyValue] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__DummyVal__5CE0B86124052274] PRIMARY KEY CLUSTERED 
(
	[DummyValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DummyValueSynonyms]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DummyValueSynonyms](
	[SynonymID] [int] IDENTITY(1,1) NOT NULL,
	[DummyValueID] [int] NOT NULL,
	[Synonym] [nvarchar](100) NOT NULL,
	[Language] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SynonymID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Material_ConfigTables]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material_ConfigTables](
	[Table] [nvarchar](40) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[TextTable] [nvarchar](40) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_Material_ConfigTables] PRIMARY KEY CLUSTERED 
(
	[Table] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ObjectSummary]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObjectSummary](
	[ObjectDataset] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_ObjectSummary] PRIMARY KEY CLUSTERED 
(
	[ObjectDataset] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ObjectSummary_Dataset]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObjectSummary_Dataset](
	[ObjectDataset] [nvarchar](100) NOT NULL,
	[Dataset] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[ReportType] [nvarchar](40) NULL,
	[Active] [bit] NULL,
	[Extension] [bit] NULL,
	[Group] [nvarchar](100) NULL,
 CONSTRAINT [PK_ObjectSummary_Dataset] PRIMARY KEY CLUSTERED 
(
	[ObjectDataset] ASC,
	[Dataset] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prueba]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prueba](
	[DummyValue] [nvarchar](100) NOT NULL,
	[MatchType] [nvarchar](30) NULL,
	[las] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableColumns]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableColumns](
	[ColumnID] [int] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[ColumnName] [varchar](50) NOT NULL,
	[DataType] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
	[AllowedForJoin] [bit] NULL,
	[DisplayName] [varchar](100) NULL,
	[isExpression] [bit] NULL,
 CONSTRAINT [PK__TableCol__1AA1422FF5DC8465] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor_AccountGroup_DQ_Mapping]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor_AccountGroup_DQ_Mapping](
	[SourcesystemID] [nvarchar](20) NOT NULL,
	[KTOKK] [nvarchar](10) NOT NULL,
	[AccountGroupDescription] [nvarchar](100) NULL,
	[KTOKK_Target] [nvarchar](100) NULL,
	[TargetAccountGroupDescription] [nvarchar](100) NULL,
 CONSTRAINT [PK_Vendor_AccountGroup_DQ_Mapping] PRIMARY KEY CLUSTERED 
(
	[SourcesystemID] ASC,
	[KTOKK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztFieldUsage]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztFieldUsage](
	[UsedInID] [int] IDENTITY(1,1) NOT NULL,
	[FieldID] [int] NULL,
	[UsedIn] [varchar](255) NOT NULL,
 CONSTRAINT [PK__ztFieldU__5D5F4ECBBF893187] PRIMARY KEY CLUSTERED 
(
	[UsedInID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztMatrix_DQReporting_Completeness]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztMatrix_DQReporting_Completeness](
	[ReportingID] [nvarchar](105) NOT NULL,
	[DQReportGrouping] [nvarchar](105) NOT NULL,
	[Field Key] [nvarchar](105) NULL,
	[Table] [nvarchar](105) NOT NULL,
	[Field] [nvarchar](105) NOT NULL,
	[Active] [bit] NULL,
	[FieldDescription] [nvarchar](105) NULL,
 CONSTRAINT [PK_ztMatrix_DQReporting_Completeness] PRIMARY KEY CLUSTERED 
(
	[ReportingID] ASC,
	[DQReportGrouping] ASC,
	[Table] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztMDQ_MaterialMasterSales_Completeness_Matrix]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztMDQ_MaterialMasterSales_Completeness_Matrix](
	[DQCheckRequired] [nvarchar](25) NULL,
	[DQCheckRequiredModified] [nvarchar](25) NULL,
	[DQReportGrouping] [nvarchar](100) NULL,
	[DQReportGroupingSubsegment] [nvarchar](100) NULL,
	[InternalComment] [nvarchar](500) NULL,
	[Level] [nvarchar](50) NOT NULL,
	[OrganizationalUnit] [nvarchar](50) NULL,
	[FunctionalOwner] [nvarchar](50) NULL,
	[Table] [nvarchar](10) NOT NULL,
	[Field] [nvarchar](20) NOT NULL,
	[FieldDescription] [nvarchar](200) NULL,
	[Checktables] [nvarchar](50) NULL,
	[UsedAtAZ] [char](1) NULL,
	[FinishedProduct] [bit] NULL,
	[FinishedProductModified] [bit] NULL,
	[SemiFinishedGoods] [bit] NULL,
	[SemiFinishedGoodsModified] [bit] NULL,
	[Packaging] [bit] NULL,
	[PackagingModified] [bit] NULL,
	[RawMaterials] [bit] NULL,
	[RawMaterialsModified] [bit] NULL,
	[SpareParts] [bit] NULL,
	[SparePartsModified] [bit] NULL,
	[OperatingSupplies] [bit] NULL,
	[OperatingSuppliesModified] [bit] NULL,
	[NonStockMaterials] [bit] NULL,
	[NonStockMaterialsModified] [bit] NULL,
	[NonValuated] [bit] NULL,
	[NonValuatedModified] [bit] NULL,
	[ManufacturingParts] [bit] NULL,
	[ManufacturingPartsModified] [bit] NULL,
	[MaintenanceAssemblies] [bit] NULL,
	[MaintenanceAssembliesModified] [bit] NULL,
	[WorkInProcess] [bit] NULL,
	[WorkInProcessModified] [bit] NULL,
	[Service] [bit] NULL,
	[ServiceModified] [bit] NULL,
	[CriticalProcessAidMaterial] [bit] NULL,
	[CriticalProcessAidMaterialModified] [bit] NULL,
	[ClinicalFinishedGoods] [bit] NULL,
	[ClinicalFinishedGoodsModified] [bit] NULL,
	[ClinicalPrimaryPack] [bit] NULL,
	[ClinicalPrimaryPackModified] [bit] NULL,
	[ClinicalCommercialPrimaryPack] [bit] NULL,
	[ClinicalCommercialPrimaryPackModified] [bit] NULL,
	[ClinicalComparatorPrimaryPack] [bit] NULL,
	[ClinicalComparatorPrimaryPackModified] [bit] NULL,
	[ClinicalDrugProduct] [bit] NULL,
	[ClinicalDrugProductModified] [bit] NULL,
	[ClinicalDrugSubstance] [bit] NULL,
	[ClinicalDrugSubstanceModified] [bit] NULL,
	[ClinicalLabel] [bit] NULL,
	[ClinicalLabelModified] [bit] NULL,
	[ClinicalSemiFinishedGood] [bit] NULL,
	[ClinicalSemiFinishedGoodModified] [bit] NULL,
	[ClinicalPackagingMaterial] [bit] NULL,
	[ClinicalPackagingMaterialModified] [bit] NULL,
	[ClinicalRawMaterial] [bit] NULL,
	[ClinicalRawMaterialModified] [bit] NULL,
	[ClinicalCellGeneTherapyIMP] [bit] NULL,
	[ClinicalCellGeneTherapyIMPModified] [bit] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ztMDQ_MaterialMasterSales_Completeness_Matrix] PRIMARY KEY CLUSTERED 
(
	[Level] ASC,
	[Table] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztPrecalculatedFieldsRegistry]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztPrecalculatedFieldsRegistry](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[ViewName] [nvarchar](255) NULL,
	[SourceTable] [nvarchar](255) NULL,
	[SourceField] [nvarchar](255) NULL,
	[TimeDimension] [nvarchar](255) NULL,
	[TimeDimensionValue] [nvarchar](255) NULL,
 CONSTRAINT [PK__ztPrecal__C8B6FF27D6A531EB] PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztSources]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztSources](
	[Name] [nvarchar](100) NOT NULL,
	[Database] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[APO_LOGSYS] [nvarchar](40) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[Platform] [nvarchar](40) NULL,
 CONSTRAINT [PK_ztSources] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztStatusType]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztStatusType](
	[StatusType] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ztStatusType] PRIMARY KEY CLUSTERED 
(
	[StatusType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztSystemType]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztSystemType](
	[SystemTypeID] [uniqueidentifier] NOT NULL,
	[SystemType] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](512) NULL,
	[Vendor] [nvarchar](50) NULL,
	[VendorWebsite] [nvarchar](512) NULL,
	[Comments] [nvarchar](max) NULL,
	[CranSoftSupplied] [bit] NOT NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[boaStatus] [int] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[Version] [nvarchar](50) NULL,
	[ENTOTACloudReady] [bit] NULL,
	[ExternalReference] [nvarchar](max) NULL,
 CONSTRAINT [PK_ztSystemType] PRIMARY KEY CLUSTERED 
(
	[SystemTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztSystemTypeTable]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztSystemTypeTable](
	[SystemTypeTableID] [uniqueidentifier] NOT NULL,
	[SystemTypeID] [uniqueidentifier] NULL,
	[TableName] [nvarchar](128) NULL,
	[Description] [nvarchar](128) NULL,
	[CranSoftSupplied] [bit] NOT NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[boaStatus] [int] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[SingleThreadDataExtract] [bit] NOT NULL,
	[CopyToTableName] [nvarchar](128) NULL,
	[CopyToSystemTypeTableID] [uniqueidentifier] NULL,
	[LookupTableType] [nvarchar](128) NULL,
	[LookupTableFieldID1] [uniqueidentifier] NULL,
	[LookupTableFieldID2] [uniqueidentifier] NULL,
	[LookupTableFieldID3] [uniqueidentifier] NULL,
	[LookupTableFieldID4] [uniqueidentifier] NULL,
	[LookupTableFieldID5] [uniqueidentifier] NULL,
	[LookupTableClientFieldID] [uniqueidentifier] NULL,
	[LookupTableLanguageFieldID] [uniqueidentifier] NULL,
	[LookupTableFieldValueID] [uniqueidentifier] NULL,
	[LookupTableWhereClause] [nvarchar](max) NULL,
	[DescriptionTableID] [uniqueidentifier] NULL,
	[DescriptionTableFieldID] [uniqueidentifier] NULL,
	[DescriptionTableKeyFieldID] [uniqueidentifier] NULL,
	[DescriptionTableClientFieldID] [uniqueidentifier] NULL,
	[DescriptionTableLanguageFieldID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ztSystemTypeTable] PRIMARY KEY CLUSTERED 
(
	[SystemTypeTableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztSystemTypeTableField]    Script Date: 2/12/2026 4:59:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztSystemTypeTableField](
	[SystemTypeTableFieldID] [uniqueidentifier] NOT NULL,
	[SystemTypeTableID] [uniqueidentifier] NOT NULL,
	[Field] [nvarchar](128) NULL,
	[FieldOrder] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[HelpText] [nvarchar](max) NULL,
	[DataType] [nvarchar](50) NULL,
	[Length] [int] NULL,
	[Decimals] [int] NULL,
	[CranSoftSupplied] [bit] NOT NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[boaStatus] [int] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[KeyField] [bit] NULL,
	[ActiveForMappingDefault] [bit] NOT NULL,
	[RuleField] [bit] NULL,
	[FieldFormat] [nvarchar](50) NULL,
	[ApplicationScreen] [nvarchar](256) NULL,
	[Comment] [nvarchar](max) NULL,
	[Instructions] [nvarchar](max) NULL,
	[LookupTableSystemTypeTableID] [uniqueidentifier] NULL,
	[OriginalDataType] [nvarchar](50) NULL,
	[OriginalLength] [int] NULL,
	[OriginalDecimals] [int] NULL,
 CONSTRAINT [PK_ztSystemTypeTableField] PRIMARY KEY CLUSTERED 
(
	[SystemTypeTableFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dataset_Joins] ADD  DEFAULT ((1)) FOR [JoinOrder]
GO
ALTER TABLE [dbo].[Dataset_Master] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Dataset_SelectFields] ADD  CONSTRAINT [DF__Dataset_S__IsVis__0A096455]  DEFAULT ((1)) FOR [IsVisible]
GO
ALTER TABLE [dbo].[TableColumns] ADD  CONSTRAINT [DF__TableColu__IsSel__750E476F]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[TableColumns] ADD  CONSTRAINT [DF__TableColu__IsJoi__76026BA8]  DEFAULT ((0)) FOR [AllowedForJoin]
GO
ALTER TABLE [dbo].[ztPrecalculatedFieldsRegistry] ADD  CONSTRAINT [DF__ztPrecalc__TimeD__24E777C3]  DEFAULT ((0)) FOR [TimeDimension]
GO
ALTER TABLE [dbo].[DummyValueSynonyms]  WITH CHECK ADD  CONSTRAINT [FK__DummyValu__Dummy__02932B16] FOREIGN KEY([DummyValueID])
REFERENCES [dbo].[DummyValues] ([DummyValueID])
GO
ALTER TABLE [dbo].[DummyValueSynonyms] CHECK CONSTRAINT [FK__DummyValu__Dummy__02932B16]
GO
ALTER TABLE [dbo].[ztFieldUsage]  WITH CHECK ADD  CONSTRAINT [FK__ztFieldUs__Field__2B947552] FOREIGN KEY([FieldID])
REFERENCES [dbo].[ztPrecalculatedFieldsRegistry] ([FieldID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ztFieldUsage] CHECK CONSTRAINT [FK__ztFieldUs__Field__2B947552]
GO


INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'Address', 9, 0, 1, 1, NULL, NULL, 1, NULL, N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:53:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'International location number (Part 2)', 10, 0, 1, 1, NULL, NULL, 1, NULL, N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:53:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'ID for mainly non-military use', 14, 0, 1, 1, NULL, NULL, 1, NULL, N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:56:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'Date on which the Record Was Created', 11, 0, 1, 1, NULL, NULL, 1, NULL, N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:53:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KTOKD', N'Customer Account Group', 4, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'Customer classification', 12, 0, 1, 1, NULL, NULL, 1, NULL, N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:56:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUNNR', N'Customer Number', 2, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T11:17:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'MANDT', NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'NAME1', N'Name 1', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'SourceValue', N'SourceValue', 5, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'SourceValueDescription', N'SourceValueDescription', 8, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'VAT Registration Number', 13, 0, 1, 1, NULL, NULL, 1, NULL, N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:56:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'TargetValue', N'TargetValue', 6, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'TargetValueDescription', N'TargetValueDescription', 7, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T09:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'ADRNR', N'Address', 4, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T10:03:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'KTOKD', N'Customer Account Group', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T10:03:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'KUNNR', N'Customer Number', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T10:03:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'MCOD1', N'Search term for matchcode search', 6, 0, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T10:03:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'NAME1', N'Name 1', 2, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T10:03:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'TELF1', N'First telephone number', 5, 0, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-04T10:03:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'Old material number', 9, 0, 1, 1, NULL, NULL, 1, NULL, N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:20:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'Weight Unit', 10, 0, 1, 1, NULL, NULL, 1, NULL, N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:20:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MANDT', N'Client', 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:22:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'Material Group', 8, 0, 1, 1, NULL, NULL, 1, NULL, N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:19:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATNR', N'Material Number', 2, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:22:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MTART', N'Material Type', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:16:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'Product hierarchy', 13, 0, 1, 1, NULL, NULL, 1, NULL, N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:20:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SourceValue', N'SourceValue', 4, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:16:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SourceValueDescription', N'SourceValueDescription', 7, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:16:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'Division', 12, 0, 1, 1, NULL, NULL, 1, NULL, N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:20:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'TargetValue', N'TargetValue', 5, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:16:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'TargetValueDescription', N'TargetValueDescription', 6, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:16:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'Volume unit', 11, 0, 1, 1, NULL, NULL, 1, NULL, N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'MigrateAdmin', CAST(N'2026-02-05T06:12:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:20:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'BRGEW', N'Gross Weight', 5, 0, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T15:08:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'MANDT', N'Client', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T14:12:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'MATKL', N'Material Group', 4, 0, 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T15:54:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'MATNR', N'Material Number', 2, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T14:12:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'MSTDE', N'Date from which the cross-plant material status is valid', 8, 0, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T15:12:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'MTART', N'Material Type', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'christian.stratford@syniti.com', CAST(N'2026-02-05T14:12:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'NTGEW', N'Net Weight', 6, 0, 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T15:08:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'VOLUM', N'Volume', 7, 0, 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:11:00' AS SmallDateTime), N'PopulateDQTableFields', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T15:08:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ADRNR', N'Address', 13, 0, 1, 1, NULL, NULL, 1, NULL, N'webVendor_AccountGroup_Segment', N'KTOKK', NULL, N'KTOKK', N'KTOKK', N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:25:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BBSNR', N'International location number (Part 2)', 14, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:54:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BEGRU', N'Authorization Group', 12, 0, 1, 1, NULL, NULL, 1, NULL, N'webVendor_AccountGroup_Segment', N'KTOKK', NULL, N'KTOKK', N'KTOKK', N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:26:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ERDAT', N'Date on which the Record Was Created', 15, 0, 1, 1, NULL, NULL, 1, NULL, N'webVendor_AccountGroup_Segment', N'KTOKK', NULL, N'KTOKK', N'KTOKK', N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:25:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KTOKK', N'Supplier Account Group', 6, 0, 1, 1, NULL, NULL, 1, NULL, N'webVendor_AccountGroup_Segment', N'KTOKK', NULL, N'KTOKK', N'KTOKK', N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:25:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KUNNR', N'Customer Number', 2, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'LAND1', N'Country Key', 4, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'LIFNR', N'Account Number of Vendor or Creditor', 5, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T11:24:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'LOEVM', N'Central Deletion Flag for Master Record', 7, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'MANDT', N'Client', 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T11:24:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'NAME1', N'Name 1', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ORT01', N'City', 10, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:51:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'PSTLZ', N'Postal Code', 9, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:51:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'SourceValue', N'SourceValue', 17, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:54:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'SourceValueDescription', N'SourceValueDescription', 20, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:54:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCD1', N'Tax Number 1', 8, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:50:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCEG', N'VAT Registration Number', 16, 0, 1, 1, NULL, NULL, 1, NULL, N'webVendor_AccountGroup_Segment', N'KTOKK', NULL, N'KTOKK', N'KTOKK', N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:25:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STRAS', N'House number and street', 11, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:51:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'TargetValue', N'TargetValue', 18, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:54:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'TargetValueDescription', N'TargetValueDescription', 19, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:49:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:54:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'ADRNR', N'Address', 12, 0, 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T15:03:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'BBSNR', N'International location number (Part 2)', 13, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'BEGRU', N'Authorization Group', 11, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'ERDAT', N'Date on which the Record Was Created', 14, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'KTOKK', N'Supplier Account Group', 5, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'LAND1', N'Country Key', 4, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'LIFNR', N'Account Number of Vendor or Creditor', 2, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'LOEVM', N'Central Deletion Flag for Master Record', 6, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'MANDT', N'Client', 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'NAME1', N'Name 1', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'ORT01', N'City', 9, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'PSTLZ', N'Postal Code', 8, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'STCD1', N'Tax Number 1', 7, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:18:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'STCEG', N'VAT Registration Number', 15, 0, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:21:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'STRAS', N'House number and street', 10, 0, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T09:14:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T15:02:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'TELF1', N'First telephone number', 16, 0, 1, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:24:00' AS SmallDateTime), N'UserInterface', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:24:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'ADRNR', N'Address', 13, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:42:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'BBSNR', N'International location number (Part 2)', 14, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:42:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'BEGRU', N'Authorization Group', 12, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:43:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'ERDAT', N'Date on which the Record Was Created', 15, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:43:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'KTOKK', N'Supplier Account Group', 6, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:43:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'KUNNR', N'Customer Number', 2, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:43:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'LAND1', N'Country Key', 4, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:43:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'LIFNR', N'Account Number of Vendor or Creditor', 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:44:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'LOEVM', N'Central Deletion Flag for Master Record', 7, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'MANDT', N'Client', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:44:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'NAME1', N'Name 1', 3, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:44:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'ORT01', N'City', 10, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:44:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'PSTLZ', N'Postal Code', 9, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:44:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'SourceValue', N'SourceValue', 17, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:44:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'SourceValueDescription', N'SourceValueDescription', 20, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'STCD1', N'Tax Number 1', 8, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'STCEG', N'VAT Registration Number', 16, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'STRAS', N'House number and street', 11, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'TargetValue', N'TargetValue', 18, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields] ([Dataset], [Field], [Description], [Order], [Key], [Active], [ReportDisplay], [Mandatory], [Conditional_Manual], [ConditionBySegment], [CheckForDummyValues], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VM_001_LFA1_VendorMaster', N'TargetValueDescription', N'TargetValueDescription', 19, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MigrateAdmin', CAST(N'2026-02-05T05:34:00' AS SmallDateTime), N'PopulateDQTableFields', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T10:45:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0001', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0002', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0003', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0006', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0007', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ADRNR', N'KTOKD', N'0009', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0001', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0002', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0003', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0004', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0005', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0006', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'BBSNR', N'KTOKD', N'0009', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0001', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0003', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0006', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0008', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'CIVVE', N'KTOKD', N'0009', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0001', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0003', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0004', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0005', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0006', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'ERDAT', N'KTOKD', N'0009', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0001', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0002', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0003', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0004', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0006', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0007', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'KUKLA', N'KTOKD', N'0009', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0001', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0002', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0003', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0006', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0007', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'STCEG', N'KTOKD', N'0009', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'DIEN', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'FERT', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'FHMI', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'HALB', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'HAWA', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'HERS', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'NLAG', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'PROC', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'BISMT', N'MTART', N'ROH', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'DIEN', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'FERT', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'FHMI', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'HALB', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'HAWA', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'HERS', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'NLAG', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'PROC', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'GEWEI', N'MTART', N'ROH', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'DIEN', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'FERT', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'FHMI', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'HALB', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'HAWA', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'HERS', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'NLAG', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'PROC', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'MATKL', N'MTART', N'ROH', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'DIEN', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'FERT', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'FHMI', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'HALB', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'HAWA', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'HERS', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'NLAG', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'PROC', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'PRDHA', N'MTART', N'ROH', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'DIEN', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'FERT', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'FHMI', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'HALB', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'HAWA', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'HERS', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'NLAG', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'PROC', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'SPART', N'MTART', N'ROH', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'DIEN', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'FERT', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'FHMI', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'HALB', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'HAWA', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'HERS', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'NLAG', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'PROC', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'VOLEH', N'MTART', N'ROH', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ADRNR', N'KTOKK', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ADRNR', N'KTOKK', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ADRNR', N'KTOKK', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ADRNR', N'KTOKK', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ADRNR', N'KTOKK', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BEGRU', N'KTOKK', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BEGRU', N'KTOKK', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BEGRU', N'KTOKK', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BEGRU', N'KTOKK', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'BEGRU', N'KTOKK', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ERDAT', N'KTOKK', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ERDAT', N'KTOKK', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ERDAT', N'KTOKK', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ERDAT', N'KTOKK', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'ERDAT', N'KTOKK', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KTOKK', N'KTOKK', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KTOKK', N'KTOKK', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KTOKK', N'KTOKK', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KTOKK', N'KTOKK', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'KTOKK', N'KTOKK', N'0008', 0)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCEG', N'KTOKK', N'0002', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCEG', N'KTOKK', N'0004', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCEG', N'KTOKK', N'0005', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCEG', N'KTOKK', N'0007', 1)
GO
INSERT [dbo].[DQTableFields_ConditionsBySegment] ([DataSet], [Field], [SegmentField], [Value], [Mandatory]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'STCEG', N'KTOKK', N'0008', 0)
GO
INSERT [dbo].[DQTables] ([Dataset], [Description], [Active], [ReportType], [SAPTable], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_002_KNA1_CustomerMaster', N'Customer Master', 1, N'Completeness Check', N'KNA1', N'webCustomer_AccountGroup_Segment', N'KTOKD', NULL, N'KTOKD', N'KTOKD', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T14:49:00' AS SmallDateTime), N'UserInterface', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T11:19:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTables] ([Dataset], [Description], [Active], [ReportType], [SAPTable], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_CSM_902_KNA1_CustomerMaster', N'Customer Master', 1, N'Dummy Value Check', N'KNA1', NULL, NULL, NULL, NULL, NULL, N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:03:00' AS SmallDateTime), N'UserInterface', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-04T15:05:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTables] ([Dataset], [Description], [Active], [ReportType], [SAPTable], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_003_MARA_MaterialMaster', N'Material Master', 1, N'Completeness Check', N'MARA', N'webMaterial_MaterialType_Segment', N'MTART', NULL, N'MTART', N'MTART', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:11:00' AS SmallDateTime), N'UserInterface', N'christian.stratford@syniti.com', CAST(N'2026-02-05T11:53:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTables] ([Dataset], [Description], [Active], [ReportType], [SAPTable], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_MAM_903_MARA_MaterialMaster', N'Material Master', 1, N'Dummy Value Check', N'MARA', NULL, NULL, NULL, NULL, NULL, N'christian.stratford@syniti.com', CAST(N'2026-02-05T14:10:00' AS SmallDateTime), N'UserInterface', N'gaurav.kalwani@syniti.com', CAST(N'2026-02-05T15:55:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTables] ([Dataset], [Description], [Active], [ReportType], [SAPTable], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_001_LFA1_VendorMaster', N'Vendor Master', 1, N'Completeness Check', N'LFA1', N'webVendor_AccountGroup_Segment', N'KTOKK', NULL, N'KTOKK', N'KTOKK', N'anna.pascal@Syniti.com', CAST(N'2026-02-04T17:48:00' AS SmallDateTime), N'UserInterface', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:27:00' AS SmallDateTime), N'UserInterface', 4)
GO
INSERT [dbo].[DQTables] ([Dataset], [Description], [Active], [ReportType], [SAPTable], [SegmentView], [SegmentField], [SegmentFieldAlias], [ConditionField], [ConditionFieldInDataSet], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (N'IV_VEM_901_LFA1_VendorMaster', N'Vendor Master', 1, N'Dummy Value Check', N'LFA1', NULL, NULL, NULL, NULL, NULL, N'anna.pascal@Syniti.com', CAST(N'2026-02-05T14:13:00' AS SmallDateTime), N'UserInterface', N'anna.pascal@Syniti.com', CAST(N'2026-02-05T16:28:00' AS SmallDateTime), N'UserInterface', 4)
GO
SET IDENTITY_INSERT [dbo].[DummyValues] ON 
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (4, NULL, NULL, NULL, N'N/A')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (5, NULL, NULL, NULL, N'DUMMY')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (6, NULL, NULL, NULL, N'BLOCKED')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (7, NULL, NULL, NULL, N'DO NOT USE')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (8, NULL, NULL, NULL, N'OBSOLETE')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (9, NULL, NULL, NULL, N'DUPLICATE')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (10, NULL, NULL, NULL, N'INACTIVE')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (11, NULL, NULL, NULL, N'ERROR')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (12, NULL, NULL, NULL, N'INCAPACITY')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (13, N'IV_CSM_901_KNB1_CustomerMaster', N'SORTL', N'EXACT', N'TEST')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (14, N'IV_CSM_901_KNB1_CustomerMaster', N'PSTLZ', N'EXACT', N'TEST')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (15, N'IV_CSM_901_KNB1_CustomerMaster', N'PSTLZ', N'Starts With', N'.')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (16, N'IV_CSM_901_KNB1_CustomerMaster', N'PSTLZ', N'Ends With', N'.')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (17, N'IV_CSM_901_KNB1_CustomerMaster', N'STCD1', N'EXACT', N'TEST')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (18, N'IV_CSM_901_KNB1_CustomerMaster', N'STCD1', N'Starts With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (19, N'IV_CSM_901_KNB1_CustomerMaster', N'STCD1', N'Ends With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (20, N'IV_CSM_901_KNB1_CustomerMaster', N'STCD2', N'EXACT', N'TEST')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (21, N'IV_CSM_901_KNB1_CustomerMaster', N'STCD2', N'Starts With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (22, N'IV_CSM_901_KNB1_CustomerMaster', N'STCD2', N'Ends With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (23, N'IV_CSM_902_KNA1_CustomerMaster', N'TELF1', N'Starts With', N'1234')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (24, N'IV_CSM_902_KNA1_CustomerMaster', N'TELF1', N'Starts With', N'0000')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (25, N'IV_CSM_902_KNA1_CustomerMaster', N'MCOD1', N'Contains', N'TEST')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (26, N'IV_CSM_902_KNA1_CustomerMaster', N'MCOD1', N'Starts With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (27, N'IV_CSM_902_KNA1_CustomerMaster', N'MCOD1', N'Ends With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (31, N'IV_MAM_903_MARA_MaterialMaster', N'NTGEW', N'Starts With', N'9.99')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (32, N'IV_MAM_903_MARA_MaterialMaster', N'VOLUM', N'EXACT', N'999.9')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (34, N'IV_VEM_901_LFA1_VendorMaster', N'TELF1', N'Starts With', N'0000')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (35, N'IV_VEM_901_LFA1_VendorMaster', N'TELF1', N'Starts With', N'1234')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (36, N'IV_VEM_901_LFA1_VendorMaster', N'STCEG', NULL, N'= LEFT(STCEG, 2) NOT LIKE ''%[0-9]%''   AND LEFT(STCEG, 2) NOT LIKE ''%[^A-Za-z]%''')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (37, N'IV_VEM_901_LFA1_VendorMaster', N'STCEG', N'Contains', N'TEST')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (38, N'IV_VEM_901_LFA1_VendorMaster', N'STCEG', N'Contains', N'DUMMY')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (39, N'IV_VEM_901_LFA1_VendorMaster', N'STCEG', N'Contains', N'N/A')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (40, N'IV_VEM_901_LFA1_VendorMaster', N'STCEG', NULL, N'LIKE ''%[^A-Za-z0-9 ]%''')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (45, N'IV_VEM_901_LFA1_VendorMaster', N'STRAS', N'Contains', N'DUMMY')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (46, N'IV_VEM_901_LFA1_VendorMaster', N'STRAS', N'Contains', N'NULL')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (47, N'IV_VEM_901_LFA1_VendorMaster', N'STRAS', N'Contains', N'N/A')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (48, N'IV_MAM_903_MARA_MaterialMaster', N'BRGEW', N'Starts With', N'-')
GO
INSERT [dbo].[DummyValues] ([DummyValueID], [Dataset], [Field], [MatchType], [DummyValue]) VALUES (49, N'IV_MAM_903_MARA_MaterialMaster', N'MSTDE', N'Starts With', N'00000000')
GO
SET IDENTITY_INSERT [dbo].[DummyValues] OFF
GO

