/*���������� ������ ������������� �����*/
IF	object_id('dbo.sdAccessLevelsTask')	IS NOT NULL
	DROP	TABLE	dbo.sdAccessLevelsTask

CREATE	TABLE	dbo.sdAccessLevelsTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdAccessLevelsTask_Id		PRIMARY KEY CLUSTERED					,	
			
	Name				nvarchar(80)		NOT NULL																						,	--�������� ������� ������������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdAccessLevelsTask_CreatorId		REFERENCES dbo.gbUsers(Id)			,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdAccessLevelsTask_Created		DEFAULT(getdate())					,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdAccessLevelsTask_ChangerId		REFERENCES dbo.gbUsers(Id)			,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdAccessLevelsTask_Changed		DEFAULT(getdate())					,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdAccessLevelsTask_Status		DEFAULT(1)							,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdAccessLevelsTask_Name
	UNIQUE
	(	
		Name		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdAccessLevelsTask            
TO    SDSystem
GO
