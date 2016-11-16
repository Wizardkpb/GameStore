/*���������� ����� ����� ��� �������� ��� ������ �����*/

IF	object_id('dbo.sdTypeTask')	IS NOT NULL
	DROP	TABLE	dbo.sdTypeTask

CREATE	TABLE	dbo.sdTypeTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdTypeTask_Id			PRIMARY KEY CLUSTERED					,	
		
	Name				nvarchar(80)		NOT NULL																					,	--�������� ���� �������
	SubTask				int					NOT NULL	CONSTRAINT	DF_sdTypeTask_SubTask		DEFAULT(0)								,	--��������� ��� ��� 0 - ������, 1 - ���������. ���� ���-�� �������, �� ����� ������ ����������
	FileImage			nvarchar(240)			NULL																					,	--���� � ����� ��������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdTypeTask_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdTypeTask_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdTypeTask_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdTypeTask_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdTypeTask_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdTypeTask_Identity
	UNIQUE
	(	
		Name,
		SubTask
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdTypeTask            
TO    SDSystem
GO
