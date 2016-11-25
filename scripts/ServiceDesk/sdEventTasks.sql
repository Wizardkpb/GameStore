/*������� �� ������ �����*/
IF	object_id('dbo.sdEventTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdEventTasks

CREATE	TABLE	dbo.sdEventTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdEventTasks_Id				PRIMARY KEY CLUSTERED					,	

	TaskId				int					NOT NULL	CONSTRAINT	RC_sdEventTaskss_TaskId			REFERENCES dbo.sdTasks(Id)				,	--������
	EventTypeId			int					NOT NULL	CONSTRAINT	RC_sdEventTaskss_EventTypeId	REFERENCES dbo.sdEventTypeTasks(Id)		,	--�� ���� �������
	TimeExecut			datetime			NOT NULL																						,	--���� ����������
	Comment				nvarchar(max)		NOT	NULL																						,	--�����������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdEventTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdEventTasks_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdEventTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdEventTasks_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdEventTasks_Status			DEFAULT(1)									--��������� 0 - ����������, 1 - ��������, 2 - ����������
)
GO

--����� ��� ������� �� ��������� ������
CREATE INDEX Ix_sdEventTasks_TaskId	ON dbo.sdEventTasks( TaskId )
INCLUDE	(Status, CreatorId)

--����� ��� ��������� ���� �������
CREATE INDEX Ix_sdEventTasks_EventTypeId	ON dbo.sdEventTasks( EventTypeId )
INCLUDE	(Status)


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdEventTasks            
TO    SDSystem
GO
