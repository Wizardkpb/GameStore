/*������� ������ � ��������� ������� */
IF	object_id('dbo.sdClientCommunication')	IS NOT NULL
	DROP	TABLE	dbo.sdClientCommunication

CREATE	TABLE	dbo.sdClientCommunication
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdClientCom_Id				PRIMARY KEY CLUSTERED					,		
	ClientId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_ClientId			REFERENCES dbo.sdClients(Id)			,
	ComTypeId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_ComTypeId		REFERENCES dbo.gbCommunicationTypes(Id)	,	--��� ����������� ������������
	Value				nvarchar(240)		NOT NULL																						,	--��������	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdClientCom_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdClientCom_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_sdClientCom_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������
	
	CONSTRAINT	UC_sdClientCom_Identity
	UNIQUE
	(	
		ClientId,
		ComTypeId,
		Value
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdClientCommunication            
TO    SDSystem
GO

