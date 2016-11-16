/*������� ��� ����������� �������������� ���������� � ����� ��������*/
IF	object_id('dbo.gbProperties')	IS NOT NULL
	DROP	TABLE	dbo.gbProperties

CREATE	TABLE	dbo.gbProperties
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdProperties_Id				PRIMARY KEY CLUSTERED					,		
	EntityId			int					NOT NULL	CONSTRAINT	RC_sdProperties_EntityId		REFERENCES dbo.gbEntites(Id)			,	--������ �� ��������	
	Code				nvarchar(64)		NOT	NULL																						,	--��� ��� ���������
	Name				nvarchar(240)		NOT	NULL																						,	--�������� ���������
	Description			nvarchar(512)			NULL																						,	--���������, ���� ����������

	Kind				int					NOT NULL	CONSTRAINT	RC_sdProperties_Kind			REFERENCES dbo.gbDataKinds(Id)			,	--������ �� ��� ��� ���������
	Mask				nvarchar(240)		NOT NULL	CONSTRAINT	DF_sdProperties_Mask			DEFAULT('')								,	--����� �����������	
	Flag				int					NOT NULL	CONSTRAINT	DF_sdProperties_Flag			DEFAULT(0)								,	--���� - ���� ��� �����������������. 
																																				--0 - �������
																																				--1 - �������� ��������!
																																				--����� �������������� ��� ����� 1,2,4,8,16,32 � �.�.
	DataReferenceId		int						NULL	CONSTRAINT RC_wbPropertiesDataReferenceId	REFERENCES dbo.gbDataReferences(Id)		,	--������ �� ����������, ���� �������� ������� �� �����������																																					

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdProperties_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdProperties_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdProperties_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdProperties_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdProperties_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbProperties_Identity
	UNIQUE
	(
		EntityId	,
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbProperties            
TO    SDSystem
GO
