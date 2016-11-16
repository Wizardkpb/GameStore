/*������������ �� ������ �����*/
IF	object_id('dbo.sdCommentTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdCommentTasks

CREATE	TABLE	dbo.sdCommentTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdCommentTasks_Id				PRIMARY KEY CLUSTERED					,	

	TaskId				int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_TaskId			REFERENCES dbo.sdTasks(Id)				,	--������
	Comment				nvarchar(max)		NOT	NULL																							,	--�����������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_CreatorId			REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdCommentTasks_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_ChangerId			REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdCommentTasks_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdCommentTasks_Status			DEFAULT(1)									--��������� 0 - ����������, 1 - ��������, 2 - ����������
)
GO

CREATE INDEX Ix_sdCommentTasks_TaskId	ON dbo.sdCommentTasks( TaskId )
INCLUDE	(CreatorId)


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdCommentTasks            
TO    SDSystem
GO
