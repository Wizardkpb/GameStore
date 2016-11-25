/*Таблица данных о контактах клиента */
IF	object_id('dbo.sdClientCommunication')	IS NOT NULL
	DROP	TABLE	dbo.sdClientCommunication

CREATE	TABLE	dbo.sdClientCommunication
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdClientCom_Id				PRIMARY KEY CLUSTERED					,		
	ClientId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_ClientId			REFERENCES dbo.sdClients(Id)			,
	ComTypeId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_ComTypeId		REFERENCES dbo.gbCommunicationTypes(Id)	,	--тип комуникации пользователя
	Value				nvarchar(240)		NOT NULL																						,	--значение	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdClientCom_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdClientCom_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdClientCom_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdClientCom_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
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

