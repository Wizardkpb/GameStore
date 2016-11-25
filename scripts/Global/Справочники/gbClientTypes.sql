/*Таблица типов клиентов*/
IF	object_id('dbo.gbClientTypes')	IS NOT NULL
	DROP	TABLE	dbo.gbClientTypes

CREATE	TABLE	dbo.gbClientTypes
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbClientTypes_Id				PRIMARY KEY CLUSTERED					,
	Code				nvarchar(32)		NOT NULL																						,	--код типа клиента
	Name				nvarchar(80)		NOT NULL																						,	--название типа клиента	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbClientTypes_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbClientTypes_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbClientTypes_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbClientTypes_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbClientTypes_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbClientTypes_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbClientTypes            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='FIZ'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('FIZ','Физические лица', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='JUR'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('JUR','Юридические лица', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='FIZSPD'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('FIZSPD','Субъекты предпринимательской деятельности', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='FIZSELF'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('FIZSELF','Самозанятые физические лица', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='BANK'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('BANK','Банки', 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbClientTypes WHERE Code='STATE'))
	INSERT INTO dbo.gbClientTypes (Code, Name, CreatorId, ChangerId) VALUES ('STATE','Государственные учереждения', 1, 1)