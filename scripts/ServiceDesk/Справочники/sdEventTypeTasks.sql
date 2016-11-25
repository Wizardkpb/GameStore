/*���� ������� �� ������ �����*/
IF	object_id('dbo.sdEventTypeTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdEventTypeTasks

CREATE	TABLE	dbo.sdEventTypeTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdEventTypeTasks_Id				PRIMARY KEY CLUSTERED					,	

	Code				nvarchar(64)		NOT NULL																							,	--��� �������
	Name				nvarchar(240)		NOT NULL																							,	--�������� �������
	Comment				nvarchar(1024)			NULL																							,	--�����������	
	FileImage			nvarchar(240)			NULL																							,	--���� � ����� ��������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdEventTypeTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdEventTypeTasks_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdEventTypeTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdEventTypeTasks_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdEventTypeTasks_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������

	CONSTRAINT	UC_sdEventTypeTasks_Code
	UNIQUE
	(	
		Code		
	)
)
GO



GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdEventTypeTasks            
TO    SDSystem
GO
