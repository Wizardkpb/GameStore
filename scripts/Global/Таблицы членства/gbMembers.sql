/*������� �������� ������������ � �������� �������*/
IF	object_id('dbo.gbMembers')	IS NOT NULL
	DROP	TABLE	dbo.gbMembers

CREATE	TABLE	dbo.gbMembers
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbMembers_Id			PRIMARY KEY CLUSTERED					,		

	UserId				int					NOT NULL	CONSTRAINT	RC_gbMembers_UserId		REFERENCES dbo.gbUsers(Id)				,	--�� ������������
	RoleId				int					NOT NULL	CONSTRAINT	RC_gbMembers_RoleId		REFERENCES dbo.gbRoles(Id)				,	--�� ���� � ������� �� �������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbMembers_CreatorId	REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbMembers_Created	DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbMembers_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbMembers_Changed	DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbMembers_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbMembers_Identity
	UNIQUE
	(	
		UserId,
		RoleId
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbMembers            
TO    SDSystem
GO
