/*������� ��� ����������� �������� � ������� ����� �������� ��� ���������*/
IF	object_id('dbo.gbEntites')	IS NOT NULL
	DROP	TABLE	dbo.gbEntites

CREATE	TABLE	dbo.gbEntites
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbEntites_Id			PRIMARY KEY	CLUSTERED					,		
	Code				nvarchar(64)		NOT NULL																				,	--��� �������� (����������)
	Name				nvarchar(240)		NOT NULL																				,	--�������� ��������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbEntites_CreatorId	REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbEntites_Created	DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbEntites_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbEntites_Changed	DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbEntites_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdEntites_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbEntites            
TO    SDSystem
GO
