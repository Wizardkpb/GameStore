/* ������ ��� �������� ��� ������ �����*/

IF	object_id('dbo.sdTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdTasks

CREATE	TABLE	dbo.sdTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdTasks_Id				PRIMARY KEY CLUSTERED					,	

	ProjectId			int					NOT NULL	CONSTRAINT	RC_sdTasks_ProjectId		REFERENCES dbo.sdProjects(Id)			,	--������
	TypeTaskId			int					NOT NULL	CONSTRAINT	RC_sdTasks_TypeTaskId		REFERENCES dbo.sdTypeTask(Id)			,	--��� ������
	SubTaskId			int						NULL	CONSTRAINT	RC_sdTasks_SubTaskId		REFERENCES dbo.sdTasks(Id)				,	--������ �� ��������� ������, ���� ��� ���������
	AccessLevelsId		int					NOT NULL	CONSTRAINT	RC_sdTasks_AccessLevelsId	REFERENCES dbo.sdAccessLevelsTask(Id)	,	--������� ������� � ���� ������

	Subject				nvarchar(1024)		NOT NULL	CONSTRAINT	DF_sdTasks_Subject			DEFAULT('')								,	--����
	PriorityId			int					NOT NULL	CONSTRAINT	RC_sdTasks_PriorityId		REFERENCES dbo.sdPriorityTask(Id)		,	--��������� ������
	Description			nvarchar(max)		NOT NULL	CONSTRAINT	DF_sdTasks_Description		DEFAULT('')								,	--��������
	Comment				nvarchar(max)			NULL																					,	--�����������

	ExecutorId			int					NOT	NULL	CONSTRAINT	RC_sdTasks_ExecutorId		REFERENCES dbo.gbUsers(Id)				,	--�����������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdTasks_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdTasks_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	RC_sdTasks_Status			REFERENCES dbo.sdStatusTask(Id)				--���������	
)
GO

CREATE INDEX Ix_sdTasks_CreatorCreated	ON dbo.sdTasks( CreatorId, Created )
GO

CREATE INDEX Ix_sdTasks_ExecutorCreated	ON dbo.sdTasks( ExecutorId, Created )
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdTasks            
TO    SDSystem
GO
