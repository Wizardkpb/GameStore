/*Таблица клиентов для сервис деска*/
IF	object_id('dbo.sdClients')	IS NOT NULL
	DROP	TABLE	dbo.sdClients

CREATE	TABLE	dbo.sdClients
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdClients_Id					PRIMARY KEY CLUSTERED					,
	ClientTypeId		int					NOT NULL	CONSTRAINT	RC_sdClients_ClientTypeId		REFERENCES dbo.gbClientTypes(Id)		,
	FullName			nvarchar(240)		NOT NULL																						,	--название клиента
	StateCode			nvarchar(10)		NOT NULL	CONSTRAINT	DF_sdUserMails_StateCode		DEFAULT('')								,	--ОКПО или ИНН
	Residency			int					NOT NULL	CONSTRAINT	DF_sdUserMails_Residency		DEFAULT(1)								,	--резидент или нет 1 - резидент,  0 -нерезидент
	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdUserMails_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdUserMails_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdUserMails_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdUserMails_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdUserMails_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
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
