/*������� ����� ����� � ������ ����������. ����� �����. �������� ������ ��������� � �����*/
IF	object_id('dbo.gbBusinessProcessRights')	IS NOT NULL
	DROP	TABLE	dbo.gbBusinessProcessRights

CREATE	TABLE	dbo.gbBusinessProcessRights
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbBProcessesRights_Id			PRIMARY KEY NONCLUSTERED					,		

	RoleId				int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_RoleId		REFERENCES dbo.gbRoles(Id)					,	--�� ����
	BusinessProcessId	int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_BusProcId		REFERENCES dbo.gbBusinessProcesses(Id)		,	--�� ������-��������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_CreatorId		REFERENCES dbo.gbUsers(Id)					,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbBProcessesRights_Created		DEFAULT(getdate())							,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_ChangerId		REFERENCES dbo.gbUsers(Id)					,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbBProcessesRights_Changed		DEFAULT(getdate())							,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbBProcessesRights_Status		DEFAULT(1)									,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbBProcessesRights_Identity
	UNIQUE		CLUSTERED
	(	
			RoleId				,
			BusinessProcessId
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbBusinessProcessRights            
TO    SDSystem
GO
