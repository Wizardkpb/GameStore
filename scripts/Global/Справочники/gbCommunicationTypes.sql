/*“аблица типов контактов*/
IF	object_id('dbo.gbCommunicationTypes')	IS NOT NULL
	DROP	TABLE	dbo.gbCommunicationTypes

CREATE	TABLE	dbo.gbCommunicationTypes
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbCommTypes_Id				PRIMARY KEY CLUSTERED					,	
	Code				nvarchar(32)		NOT NULL																						,	--код типа контакта
	Name				nvarchar(80)		NOT NULL																						,	--название типа клиента	


	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbCommTypes_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbCommTypes_Created			DEFAULT(getdate())						,	--дата создани€
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbCommTypes_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbCommTypes_Changed			DEFAULT(getdate())						,	--дата изменени€
	Status				int					NOT	NULL	CONSTRAINT	DF_gbCommTypes_Status			DEFAULT(1)								,	--состо€ние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbCommTypes_Code
	UNIQUE
	(			
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbCommunicationTypes            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbCommunicationTypes WHERE Code='MPHONE'))
	INSERT INTO dbo.gbCommunicationTypes (Code, Name, CreatorId, ChangerId ) VALUES ('MPHONE','“елефон мобильный',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCommunicationTypes WHERE Code='PHONE'))
	INSERT INTO dbo.gbCommunicationTypes (Code, Name, CreatorId, ChangerId) VALUES ('PHONE','“елефон стационарный',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCommunicationTypes WHERE Code='MAIL'))
	INSERT INTO dbo.gbCommunicationTypes (Code, Name, CreatorId, ChangerId) VALUES ('MAIL','Ёлектронный почтовый адрес',1,1)