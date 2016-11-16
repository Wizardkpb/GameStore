/*������������ ������ ����� �� ������*/
IF	object_id('dbo.sdJobLogTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdJobLogTasks

CREATE	TABLE	dbo.sdJobLogTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdJobLogTasks_Id				PRIMARY KEY CLUSTERED					,	

	TaskId				int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_TaskId			REFERENCES dbo.sdTasks(Id)				,	--������
	ElTime				nvarchar(32)		NOT NULL																						,	--����� ��������� ������������� 1d, 1h, 1m, 1w
	ElTimeMinute		int					NOT NULL																						,	--����� � ������� 
	DateFrom			datetime			NOT NULL																						,	--���� ������
	Comment				nvarchar(max)			NULL																						,	--�����������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdJobLogTasks_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdJobLogTasks_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdJobLogTasks_Status			DEFAULT(1)									--��������� 0 - ����������, 1 - ��������, 2 - ����������
)
GO

CREATE INDEX Ix_sdJobLogTasks_TaskId	ON dbo.sdJobLogTasks( TaskId )
INCLUDE	(CreatorId)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdCommentTasks            
TO    SDSystem
GO
