/*������� ����� ������ ���������*/
IF	object_id('dbo.gbTypeBusinessProcesses')	IS NOT NULL
	DROP	TABLE	dbo.gbTypeBusinessProcesses

CREATE	TABLE	dbo.gbTypeBusinessProcesses
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbTypeBProcesses_Id				PRIMARY KEY CLUSTERED				,		
		
	Code				nvarchar(64)		NOT NULL																						,	--��� ���� ������ �������� (����������) (ACT, REP, FIELD, PAGE...)
	Name				nvarchar(240)		NOT NULL																						,	--�������� ������-��������
	Description			nvarchar(240)			NULL																						,	--���������
	
	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbTypeBProcesses_CreatorId		REFERENCES dbo.gbUsers(Id)			,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbTypeBProcesses_Created			DEFAULT(getdate())					,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbTypeBProcesses_ChangerId		REFERENCES dbo.gbUsers(Id)			,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbTypeBProcesses_Changed			DEFAULT(getdate())					,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbTypeBProcesses_Status			DEFAULT(1)							,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbTypeBProcesses_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbTypeBusinessProcesses            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='ACT'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('ACT','��������','������-������� ����������� � ��������� ������������',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='REP'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('REP','������','������-������� ����������� � ���������� �������',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='FIELD'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('FIELD','����','������-������� ����������� � ������� ����������� ����',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='PAGE'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('PAGE','��������','������-������� ����������� � ������� �� ����� ��������',1,1)