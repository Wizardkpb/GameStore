/* ������� ���������. ������ ��� �������� ��� ������ �����*/
/*����� ��� ������ ��������, ��� �� � ������ �����-�� �������� �� ��� ����� ��������, ���� ��� ������ ������, �� ���� ���� ������� ����� �����*/

IF	object_id('dbo.sdTasks_History')	IS NOT NULL
	DROP	TABLE	dbo.sdTasks_History

CREATE	TABLE	dbo.sdTasks_History
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdTasks_H_Id					PRIMARY KEY CLUSTERED						,	
	ObjectId			int					NOT NULL	CONSTRAINT	RC_sdTasks_H_ObjectId			REFERENCES dbo.sdTasks(Id)					,	--������
	Operation			int					NOT NULL																							,	--�������� 0- �������, 1 ���������, 2 -�������� (����������� ����� ��������)

	ProjectId			int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_ProjectId			REFERENCES dbo.sdProjects(Id)*/			,	--������
	TypeTaskId			int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_TypeTaskId			REFERENCES dbo.sdTypeTask(Id)*/			,	--��� ������
	SubTaskId			int						NULL	/*CONSTRAINT	RC_sdTasks_H_SubTaskId			REFERENCES dbo.sdTasks(Id)	*/			,	--������ �� ��������� ������, ���� ��� ���������
	AccessLevelsId		int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_AccessLevelsId		REFERENCES dbo.sdAccessLevelsTask(Id)*/	,	--������� ������� � ���� ������

	Subject				nvarchar(1024)		NOT NULL																							,	--����
	PriorityId			int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_PriorityId			REFERENCES dbo.sdPriorityTask(Id)*/		,	--��������� ������
	Description			nvarchar(max)		NOT	NULL																							,	--��������
	Comment				nvarchar(max)			NULL																							,	--�����������
	
	ExecutorId			int					NOT	NULL	/*CONSTRAINT	RC_sdTasks_H_ExecutorId			REFERENCES dbo.gbUsers(Id)*/			,	--�����������	
	
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdTasks_H_ChangerId			REFERENCES dbo.gbUsers(Id)					,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdTasks_H_Changed			DEFAULT(getdate())							,	--���� ���������

	Status				int					NOT	NULL	/*CONSTRAINT	RC_sdTasks_H_Status				REFERENCES dbo.sdStatusTask(Id)	*/			--���������	
)
GO

CREATE INDEX Ix_sdTasks_H_ObjectId	ON dbo.sdTasks_History( ObjectId )
INCLUDE (Changed, Operation)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdTasks_History            
TO    SDSystem
GO
