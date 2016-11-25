/*������� ����� ���������*/
IF	object_id('dbo.gbCommunicationTypes')	IS NOT NULL
	DROP	TABLE	dbo.gbCommunicationTypes

CREATE	TABLE	dbo.gbCommunicationTypes
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbCommTypes_Id				PRIMARY KEY CLUSTERED					,	
	Code				nvarchar(32)		NOT NULL																						,	--��� ���� ��������
	Name				nvarchar(80)		NOT NULL																						,	--�������� ���� �������	


	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbCommTypes_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbCommTypes_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbCommTypes_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbCommTypes_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbCommTypes_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbCommTypes_Code
	UNIQUE
	(			
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbCommunicationTypes            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbCommunicationTypes WHERE Code='MPHONE'))
	INSERT INTO dbo.gbCommunicationTypes (Code, Name, CreatorId, ChangerId ) VALUES ('MPHONE','������� ���������',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCommunicationTypes WHERE Code='PHONE'))
	INSERT INTO dbo.gbCommunicationTypes (Code, Name, CreatorId, ChangerId) VALUES ('PHONE','������� ������������',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCommunicationTypes WHERE Code='MAIL'))
	INSERT INTO dbo.gbCommunicationTypes (Code, Name, CreatorId, ChangerId) VALUES ('MAIL','����������� �������� �����',1,1)