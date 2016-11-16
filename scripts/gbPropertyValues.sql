/*������� ��� �������� ��� ����������*/
IF	object_id('dbo.gbPropertyValues')	IS NOT NULL
	DROP	TABLE	dbo.gbPropertyValues

CREATE	TABLE	dbo.gbPropertyValues
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbPropertyValues_Id				PRIMARY KEY NONCLUSTERED				,		
	PropertyId			int					NOT NULL	CONSTRAINT	RC_gbPropertyValues_PropertyId		REFERENCES dbo.gbProperties(Id)			,	--������ �� ��� ��� ���������
	OwnerId				int					NOT	NULL																							,	--�� ���������. �� � ������� ��� ��������, ��� ������� � ���� ��� ���������

	IntVal				int						NULL																							,	--������� �������� (����� ���, bool)
	MoneyVal			money					NULL																							,	--������ (double) � �������� �� int ��� �����������, ���� ����� ������ 4 ������ ����� �������
	DateTimeVal			datetime				NULL																							,	--���� �� �������� (datetime)
	StrValue			nvarchar(max)			NULL																							,	--�������� ��������� �� 4000 ������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbPropertyValues_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyValues_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbPropertyValues_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyValues_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbPropertyValues_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdPropertyValues_Identity
	UNIQUE		CLUSTERED
	(
		OwnerId		,
		PropertyId		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbPropertyValues            
TO    SDSystem
GO
