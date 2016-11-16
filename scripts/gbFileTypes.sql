/*������� ����������� ����� ������, ������� ����� ��������� ��� �������� ���������*/
IF	object_id('dbo.gbFileTypes')	IS NOT NULL
	DROP	TABLE	dbo.gbFileTypes

CREATE	TABLE	dbo.gbFileTypes
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbFileTypes_Id				PRIMARY KEY CLUSTERED			,			
	EntityId			int					NOT NULL	CONSTRAINT	RC_gbFileTypes_EntityId			REFERENCES dbo.gbEntites(Id)	,	--������ �� ��������
	Name				nvarchar(240)		NOT	NULL	CONSTRAINT	DF_gbFileTypes_Name				DEFAULT('')						,	--��������	
	MaxSize				int					NOT NULL	CONSTRAINT	DF_gbFileTypes_MaxSize			DEFAULT(0)						,	--������������ ������ � ������
	ExtFilter			nvarchar(240)		NOT NULL	CONSTRAINT	DF_gbFileTypes_ExtFilter		DEFAULT('*.*')					,	--���������� ������, ������� ����� ���������� ����������� ";"

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbFileTypes_CreatorId		REFERENCES dbo.gbUsers(Id)		,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbFileTypes_Created			DEFAULT(getdate())				,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbFileTypes_ChangerId		REFERENCES dbo.gbUsers(Id)		,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbFileTypes_Changed			DEFAULT(getdate())				,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbFileTypes_Status			DEFAULT(1)						,	--��������� 0 - ����������, 1 - ��������	
	
	CONSTRAINT	UC_sdFileTypes_Identity
	UNIQUE
	(		
		EntityId,
		Name
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbFileTypes            
TO    SDSystem
GO

