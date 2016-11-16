/*������� ��� �������� ������������ ������ (����� ��� ��������)*/
IF	object_id('dbo.gbFiles')	IS NOT NULL
	DROP	TABLE	dbo.gbFiles

CREATE	TABLE	dbo.gbFiles
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbFiles_Id				PRIMARY KEY CLUSTERED					,		
	EntityId			int					NOT NULL	CONSTRAINT	RC_gbFiles_EntityId			REFERENCES dbo.gbEntites(Id)			,	--������ �� ��������
	OwnerId				int					NOT	NULL																					,	--�� ���������. �� � ������� ��� ��������, ��� ������� � ���� ��� ���������	

	FileTypesId			int					NOT NULL	CONSTRAINT	RC_gbFiless_FileTypesId		REFERENCES dbo.gbFileTypes(Id)			,	--������ �� ��� �����
	NameFile			nvarchar(240)		NOT	NULL																					,	--�������� �����
	VersionFile			int					NOT NULL	CONSTRAINT	DF_gbFiles_VersionFile		DEFAULT(1)								,	--����� ����� - ��� �������, ���� ��� ������������ ��� ���� ��������, �� ��������� ����� ������ ���������
	
	TextValue			NTEXT					NULL																					,	--�����
	ImageValue			IMAGE					NULL																					,	--��������	
	FileStrimValue		VARBINARY(MAX)			NULL																					,	--���� ������� ���������� ��� ��� ������ FILESTREAM (http://sqlmag.com/sql-server-2008/using-sql-server-2008s-filestream-data-type)	
	
	Size				int						NULL																					,	--������ � ������ 
	Ext					nvarchar(32)			NULL																					,	--���������� �����
	Mime				nvarchar(240)			NULL																					,	--��� ��� �������� 
	Comment				nvarchar(512)			NULL																					,	--��������� � �����

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbFiles_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbFiles_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbFiles_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbFiles_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbFiles_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbFiles_Identity
	UNIQUE	
	(	
		EntityId	,
		OwnerId		,		
		NameFile	,
		VersionFile			
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbFiles            
TO    SDSystem
GO
