/*���������� ��������� ��������� �����*/

IF	object_id('dbo.sdStatusTask')	IS NOT NULL
	DROP	TABLE	dbo.sdStatusTask

CREATE	TABLE	dbo.sdStatusTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdStatusTask_Id				PRIMARY KEY CLUSTERED					,			

	Code				nvarchar(64)		NOT NULL																						,	--��� ���������	
	Name				nvarchar(240)		NOT NULL																						,	--�������� ���������	
	Comment				nvarchar(1024)			NULL																						,	--�����������	
	FileImage			nvarchar(240)			NULL																						,	--���� � ����� ��������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdStatusTask_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdStatusTask_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdStatusTask_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdStatusTask_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdStatusTask_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdStatusTask_Code
	UNIQUE
	(	
		Code		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdStatusTask            
TO    SDSystem
GO
