/*������� �������� ��� ������ �����*/
IF	object_id('dbo.sdClients')	IS NOT NULL
	DROP	TABLE	dbo.sdClients

CREATE	TABLE	dbo.sdClients
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdClients_Id					PRIMARY KEY CLUSTERED					,
	ClientTypeId		int					NOT NULL	CONSTRAINT	RC_sdClients_ClientTypeId		REFERENCES dbo.gbClientTypes(Id)		,
	FullName			nvarchar(240)		NOT NULL																						,	--�������� �������
	StateCode			nvarchar(10)		NOT NULL	CONSTRAINT	DF_sdUserMails_StateCode		DEFAULT('')								,	--���� ��� ���
	Residency			int					NOT NULL	CONSTRAINT	DF_sdUserMails_Residency		DEFAULT(1)								,	--�������� ��� ��� 1 - ��������,  0 -����������
	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdUserMails_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdUserMails_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdUserMails_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdUserMails_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdUserMails_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdClients_Identity
	UNIQUE
	(	
		StateCode,
		FullName,
		ClientTypeId,
		Residency
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdClients            
TO    SDSystem
GO
