/*������� �������� ��������� ������������*/
IF	object_id('dbo.gbDataReferences')	IS NOT NULL
	DROP	TABLE	dbo.gbDataReferences

CREATE	TABLE	dbo.gbDataReferences
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbDataRef_Id				PRIMARY KEY CLUSTERED					,		
	
	Code				nvarchar(64)		NOT NULL	CONSTRAINT	DF_gbDataRef_Code			DEFAULT('')								,	--��� �����������
	Name				nvarchar(240)		NOT NULL	CONSTRAINT	DF_gbDataRef_Name			DEFAULT('')								,	--�������� �����������
	Kind				int					NOT NULL	CONSTRAINT	RC_gbDataRef_Kind			REFERENCES dbo.gbDataKinds(Id)			,	--��� ��������
	AutoImport			int					NOT NULL	CONSTRAINT	DF_gbDataRef_AutoImport   	DEFAULT(0)								,	--�������������� ������� �������� ����������� 0- �� ������������, 1- ������������
	LastLoad			datetime				NULL																					,	--���� ��������� ������� ����������� �� ���

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbDataRef_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbDataRef_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbDataRef_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbDataRef_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbDataRef_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbDataRef_Code
	UNIQUE
	(
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbDataReferences            
TO    SDSystem
GO
