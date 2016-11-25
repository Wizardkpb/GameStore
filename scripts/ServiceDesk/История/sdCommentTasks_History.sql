/*������� ���������.������������ �� ������ �����*/
IF	object_id('dbo.sdCommentTasks_History')	IS NOT NULL
	DROP	TABLE	dbo.sdCommentTasks_History

CREATE	TABLE	dbo.sdCommentTasks_History
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdCommentTasks_H_Id				PRIMARY KEY CLUSTERED					,	
	ObjectId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_H_ObjectId		REFERENCES dbo.sdCommentTasks(Id)		,	--������ �� ������
	Operation			int					NOT NULL																							,	--�������� 0- �������, 1 ���������, 2 -�������� (����������� ����� ��������)

	TaskId				int					NOT NULL	/*CONSTRAINT	RC_sdCommentTasks_H_TaskId			REFERENCES dbo.sdTasks(Id)*/		,	--������
	Comment				nvarchar(max)		NOT	NULL																							,	--�����������	

	
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_H_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdCommentTasks_H_Changed			DEFAULT(getdate())						,	--���� ���������

	Status				int					NOT	NULL	CONSTRAINT	DF_sdCommentTasks_H_Status			DEFAULT(1)									--��������� 0 - ����������, 1 - ��������, 2 - ����������
)
GO

CREATE INDEX Ix_sdCommentTasks_History_ObjectId	ON dbo.sdCommentTasks_History( ObjectId )
INCLUDE (Changed, Operation)


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdCommentTasks_History            
TO    SDSystem
GO
