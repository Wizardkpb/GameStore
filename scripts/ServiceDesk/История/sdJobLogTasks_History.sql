/*������� ���������. ������������ ������ ����� �� ������*/
IF	object_id('dbo.sdJobLogTasks_History')	IS NOT NULL
	DROP	TABLE	dbo.sdJobLogTasks_History

CREATE	TABLE	dbo.sdJobLogTasks_History
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdJobLogTasks_H_Id			PRIMARY KEY CLUSTERED					,	
	ObjectId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_H_ObjectId		REFERENCES dbo.sdJobLogTasks(Id)		,	--������ �� ������
	Operation			int					NOT NULL																						,	--�������� 0- �������, 1 ���������, 2 -�������� (����������� ����� ��������)

	TaskId				int					NOT NULL	/*CONSTRAINT	RC_sdJobLogTasks_H_TaskId			REFERENCES dbo.sdTasks(Id)*/	,	--������
	ElTime				nvarchar(32)		NOT NULL																						,	--����� ��������� ������������� 1d, 1h, 1m, 1w
	ElTimeMinute		int					NOT NULL																						,	--����� � ������� 
	DateFrom			datetime			NOT NULL																						,	--���� ������
	Flag				int					NOT NULL																						,	--��� �������� 0- ��������� ����� �������������, 1- ���������� ����� � ������
	SetTime				int					NOT NULL																						,	--��������� ����� � �������
	Comment				nvarchar(max)			NULL																						,	--�����������
	
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_H_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdJobLogTasks_H_Changed		DEFAULT(getdate())						,	--���� ���������

	Status				int					NOT	NULL																							--��������� 0 - ����������, 1 - ��������, 2 - ����������
)
GO

CREATE INDEX Ix_sdJobLogTasks_H_ObjectId	ON dbo.sdJobLogTasks_History( ObjectId )
INCLUDE (Changed, Operation)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdJobLogTasks_History            
TO    SDSystem
GO
