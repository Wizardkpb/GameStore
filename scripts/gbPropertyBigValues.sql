/*������� ��� �������� ��� ���������� ������� ������� - �����, XML ������, ��������*/
IF	object_id('dbo.gbPropertyBigValues')	IS NOT NULL
	DROP	TABLE	dbo.gbPropertyBigValues

CREATE	TABLE	dbo.gbPropertyBigValues
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbPropertyBigValues_Id				PRIMARY KEY CLUSTERED					,		
	PropertyId			int					NOT NULL	CONSTRAINT	RC_gbPropertyBigValues_PropertyId		REFERENCES dbo.gbProperties(Id)			,	--������ �� ��� ��� ���������
	OwnerId				int					NOT	NULL																								,	--�� ���������. �� � ������� ��� ��������, ��� ������� � ���� ��� ���������

	TextValue			NTEXT					NULL																								,	--�����
	ImageValue			IMAGE					NULL																								,	--��������
	XMLValue			XML						NULL																								,	--���� ������ ��� ������ XML
		
	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbPropertyBigValues_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyBigValues_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbPropertyBigValues_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyBigValues_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbPropertyBigValues_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	/*����� ���������� ������, �.�. ���������� ������� ������ � ���� ������ ������� ��� �����. ����� ������� ����� �������� ������� ������ �����������*/
	CONSTRAINT	UC_gbPropertyBigValues_Identity
	UNIQUE
	(
		OwnerId		,
		PropertyId		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbPropertyBigValues  
TO    SDSystem
GO
