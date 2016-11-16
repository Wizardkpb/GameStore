/*������� ������ �����*/

IF	object_id('dbo.sdProjects')	IS NOT NULL
	DROP	TABLE	dbo.sdProjects

CREATE	TABLE	dbo.sdProjects
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdProjects_Id			PRIMARY KEY CLUSTERED					,	
	Code				nvarchar(64)		NOT NULL																					,	--��� �������, ����������
	Name				nvarchar(240)		NOT NULL																					,	--�������� �������
	FileImage			nvarchar(240)			NULL																					,	--���� � ����� ��������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdProjects_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdProjects_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdProjects_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdProjects_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdProjects_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdProjects_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdProjects            
TO    SDSystem
GO
