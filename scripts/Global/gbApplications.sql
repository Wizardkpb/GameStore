/*������� ����������*/
IF	object_id('dbo.gbApplications')	IS NOT NULL
	DROP	TABLE	dbo.gbApplications

CREATE	TABLE	dbo.gbApplications
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbApplications_Id			PRIMARY KEY CLUSTERED					,		

	Code				nvarchar(64)		NOT NULL																						,	--��� ���������� (����������)
	Name				nvarchar(240)		NOT NULL																						,	--�������� ����������
	Description			nvarchar(240)		NOT NULL																						,	--���������

	CreatorId			int					NOT NULL	CONSTRAINT	DF_gbApplicationss_CreatorId	DEFAULT(1)								,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbApplications_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	DF_gbApplications_ChangerId		DEFAULT(1)								,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbApplications_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbApplications_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_gbApplications_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbApplications            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbApplications WHERE Code='ADMIN'))
	INSERT INTO dbo.gbApplications (Code, Name, Description) VALUES ('ADMIN','���������� ��������','����� ������')
IF (NOT EXISTS (SELECT 1 FROM dbo.gbApplications WHERE Code='SERVICEDESK'))
	INSERT INTO dbo.gbApplications (Code, Name, Description) VALUES ('SERVICEDESK','������ ����','���������� ��������')