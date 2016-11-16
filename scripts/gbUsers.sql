/*������� ������������� - ���������� ������� �� �������� �� ������*/
IF	object_id('dbo.gbUsers')	IS NOT NULL
	DROP	TABLE	dbo.gbUsers

CREATE	TABLE	dbo.gbUsers
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbUsers_Id			PRIMARY KEY CLUSTERED						,	
	[Login]				nvarchar(64)		NOT NULL																					,	--�����
	[Password]			nvarchar(240)		NOT NULL																					,	--������ MD5
	Surname				nvarchar(64)		NOT NULL																					,	--�������
	Name				nvarchar(64)		NOT NULL																					,	--���
	Patronymic			nvarchar(64)			NULL																					,	--��������
	EMail				nvarchar(240)			NULL																					,	--�����
	Phone				nvarchar(32)			NULL																					,	--�������
	Culture				nvarchar(2)			NOT NULL	CONSTRAINT	DF_gbUsers_Culture		DEFAULT('RU')								,	--��������
	PasswordExpired		datetime				NULL																					,	--���� ��������� ������
	Photo				image					NULL																					,	--���� ������������

	CreaterId			int					NOT NULL	CONSTRAINT	DF_gbUsers_CreaterId	DEFAULT(0)									,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbUsers_Created		DEFAULT(getdate())							,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	DF_gbUsers_ChangerId	DEFAULT(0)									,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbUsers_Changed		DEFAULT(getdate())							,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbUsers_Status		DEFAULT(1)									,	--��������� 0 - ����������/���������, 1 - ��������, 2 - ������������
	
	CONSTRAINT	UC_gbProjects_Login
	UNIQUE
	(	
		[Login]
	)
)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbUsers            
TO    SDSystem
GO


IF (NOT EXISTS (SELECT 1 FROM dbo.gbUsers WHERE Login='Admin'))
	INSERT INTO dbo.gbUsers ([Login],[Password],Surname,Name) VALUES ('Admin','1','Admin','')
--SELECT * FROM dbo.sdUsers