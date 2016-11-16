/*������� ��������� ����� ������������*/
IF	object_id('dbo.gbRoles')	IS NOT NULL
	DROP	TABLE	dbo.gbRoles

CREATE	TABLE	dbo.gbRoles
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbRoles_Id			PRIMARY KEY CLUSTERED					,		
	Code				nvarchar(64)		NOT NULL																				,	--��� ���� (����������)
	Name				nvarchar(240)		NOT NULL																				,	--�������� ����

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbRoles_CreatorId	REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbRoles_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbRoles_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbRoles_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbRoles_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbRoles_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbRoles            
TO    SDSystem
GO
