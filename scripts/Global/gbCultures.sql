/*Таблица языков интерфейса*/
IF	object_id('dbo.gbCultures')	IS NOT NULL
	DROP	TABLE	dbo.gbCultures

CREATE	TABLE	dbo.gbCultures
(
	Id					int					IDENTITY																					,
	Culture				nvarchar(2)			NOT NULL	CONSTRAINT	UC_gbCultures_Culture		PRIMARY KEY CLUSTERED					,	--язык	
	Name				nvarchar(80)		NOT NULL																					,	--название языка
	FDefault			bit					NOT NULL	CONSTRAINT	DF_gbCultures_FDefault		DEFAULT(0)								,	--основной язык 0 нет, 1 да. Основной язык берем прям с названий, если будет отличный, то бурем с транслитирации


	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbCultures_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbCultures_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbCultures_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbCultures_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbCultures_Status		DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbCultures            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbCultures WHERE Culture='RU'))
	INSERT INTO dbo.gbCultures (Culture,Name,CreatorId,ChangerId,FDefault) VALUES ('RU','Русский', 1, 1, 1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCultures WHERE Culture='UA'))
	INSERT INTO dbo.gbCultures (Culture,Name,CreatorId,ChangerId,FDefault) VALUES ('UA','Украинский', 1, 1, 0)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbCultures WHERE Culture='EN'))
	INSERT INTO dbo.gbCultures (Culture,Name,CreatorId,ChangerId,FDefault) VALUES ('EN','Английский', 1, 1, 0)