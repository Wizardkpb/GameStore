/*���������� ��������� ����������� ������*/

IF	object_id('dbo.sdPriorityTask')	IS NOT NULL
	DROP	TABLE	dbo.sdPriorityTask

CREATE	TABLE	dbo.sdPriorityTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdPriorityTask_Id				PRIMARY KEY CLUSTERED					,			
	Name				nvarchar(240)		NOT NULL																							,	--�������� ����������	
	FileImage			nvarchar(240)			NULL																							,	--���� � ����� ��������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdPriorityTask_CreatorId			REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdPriorityTask_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdPriorityTask_ChangerId			REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdPriorityTask_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdPriorityTask_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdPriorityTask_Name
	UNIQUE
	(	
		Name		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdPriorityTask            
TO    SDSystem
GO
