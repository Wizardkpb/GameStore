/*������� ������ ��������� �� ������� ����� ������ ������ �����*/
IF	object_id('dbo.gbBusinessProcesses')	IS NOT NULL
	DROP	TABLE	dbo.gbBusinessProcesses

CREATE	TABLE	dbo.gbBusinessProcesses
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbBProcesses_Id				PRIMARY KEY CLUSTERED						,		
	ApplicationId		int					NOT NULL	CONSTRAINT	RC_gbBProcesses_ApplicationId	REFERENCES dbo.gbApplications(Id)			,
	EntityId			int					NOT NULL	CONSTRAINT	RC_gbBProcesses_EntityId		REFERENCES dbo.gbEntites(Id)				,
	Code				nvarchar(64)		NOT NULL																							,	--��� ������-�������� (����������)
	Name				nvarchar(240)		NOT NULL																							,	--�������� ������-��������
	Description			nvarchar(240)			NULL																							,	--���������
	ProcessTypeId		int					NOT NULL	CONSTRAINT	RC_gbBProcesses_ProcessTypeId	REFERENCES dbo.gbTypeBusinessProcesses(Id)	,	--��� ������ ��������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbBProcesses_CreatorId		REFERENCES dbo.gbUsers(Id)					,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbBProcesses_Created			DEFAULT(getdate())							,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbBProcesses_ChangerId		REFERENCES dbo.gbUsers(Id)					,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbBProcesses_Changed			DEFAULT(getdate())							,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbBProcesses_Status			DEFAULT(1)									,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbBProcesses_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbBusinessProcesses            
TO    SDSystem
GO
