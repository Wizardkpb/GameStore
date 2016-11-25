/*������� ������ ����������*/
IF	object_id('dbo.gbCultures')	IS NOT NULL
	DROP	TABLE	dbo.gbCultures

CREATE	TABLE	dbo.gbCultures
(
	Id					int					IDENTITY																					,
	Culture				nvarchar(2)			NOT NULL	CONSTRAINT	UC_gbCultures_Culture		PRIMARY KEY CLUSTERED					,	--����	
	Name				nvarchar(80)		NOT NULL																					,	--�������� �����
	FDefault			bit					NOT NULL	CONSTRAINT	DF_gbCultures_FDefault		DEFAULT(0)								,	--�������� ���� 0 ���, 1 ��. �������� ���� ����� ���� � ��������, ���� ����� ��������, �� ����� � ��������������


	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbCultures_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbCultures_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbCultures_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbCultures_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbCultures_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbCultures            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbCultures WHERE Culture='RU'))
	INSERT INTO dbo.gbCultures (Culture,Name,CreatorId,ChangerId,FDefault) VALUES ('RU','�������', 1, 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCultures WHERE Culture='UA'))
	INSERT INTO dbo.gbCultures (Culture,Name,CreatorId,ChangerId,FDefault) VALUES ('UA','����������', 1, 1, 0)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCultures WHERE Culture='EN'))
	INSERT INTO dbo.gbCultures (Culture,Name,CreatorId,ChangerId,FDefault) VALUES ('EN','����������', 1, 1, 0)