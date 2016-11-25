/*������� �������������� ���� ��������� �������� �������� �� �������� �� ���������*/
IF	object_id('dbo.gbTransliteUI')	IS NOT NULL
	DROP	TABLE	dbo.gbTransliteUI

CREATE	TABLE	dbo.gbTransliteUI
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbTransliteUI_Id				PRIMARY KEY NONCLUSTERED				,	
	TableCode			nvarchar(64)		NOT NULL																						,	--��� ������� (�������� �������)	
	Code				nvarchar(64)		NOT NULL																						,	--���������� ��� � �������
	CultureUI			nvarchar(2)			NOT NULL	CONSTRAINT	RC_gbTransliteUI_CultureUI		REFERENCES dbo.gbCultures(Culture)		,	--����
	Name				nvarchar(240)		NOT NULL																						,	--������������ �� ��������� �����


	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbTransliteUI_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbTransliteUI_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbTransliteUI_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbTransliteUI_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbTransliteUI_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbTransliteUI_Identity
	UNIQUE CLUSTERED
	(			
		TableCode,		
		Code,
		CultureUI
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbTransliteUI            
TO    SDSystem
GO
