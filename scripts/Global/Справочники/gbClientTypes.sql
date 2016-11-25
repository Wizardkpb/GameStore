/*������� ����� ��������*/
IF	object_id('dbo.gbClientTypes')	IS NOT NULL
	DROP	TABLE	dbo.gbClientTypes

CREATE	TABLE	dbo.gbClientTypes
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbClientTypes_Id				PRIMARY KEY CLUSTERED					,
	Code				nvarchar(32)		NOT NULL																						,	--��� ���� �������
	Name				nvarchar(80)		NOT NULL																						,	--�������� ���� �������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbClientTypes_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbClientTypes_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbClientTypes_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbClientTypes_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbClientTypes_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbClientTypes_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbClientTypes            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='FIZ'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('FIZ','���������� ����', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='JUR'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('JUR','����������� ����', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='FIZSPD'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('FIZSPD','�������� ������������������� ������������', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='FIZSELF'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('FIZSELF','����������� ���������� ����', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='BANK'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('BANK','�����', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='STATE'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('STATE','��������������� �����������', 1, 1)