/*таблица определения типов файлов, которые можно загружать для указаных сущностей*/
IF	object_id('dbo.gbFileTypes')	IS NOT NULL
	DROP	TABLE	dbo.gbFileTypes

CREATE	TABLE	dbo.gbFileTypes
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbFileTypes_Id				PRIMARY KEY CLUSTERED			,			
	EntityId			int					NOT NULL	CONSTRAINT	RC_gbFileTypes_EntityId			REFERENCES dbo.gbEntites(Id)	,	--ссылка на сущность
	Name				nvarchar(240)		NOT	NULL	CONSTRAINT	DF_gbFileTypes_Name				DEFAULT('')						,	--название	
	MaxSize				int					NOT NULL	CONSTRAINT	DF_gbFileTypes_MaxSize			DEFAULT(0)						,	--максимальный размер в байтах
	ExtFilter			nvarchar(240)		NOT NULL	CONSTRAINT	DF_gbFileTypes_ExtFilter		DEFAULT('*.*')					,	--расширения файлов, который можно закачивать разделитель ";"

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbFileTypes_CreatorId		REFERENCES dbo.gbUsers(Id)		,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbFileTypes_Created			DEFAULT(getdate())				,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbFileTypes_ChangerId		REFERENCES dbo.gbUsers(Id)		,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbFileTypes_Changed			DEFAULT(getdate())				,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbFileTypes_Status			DEFAULT(1)						,	--состояние 0 - неактивное, 1 - активное	
	
	CONSTRAINT	UC_sdFileTypes_Identity
	UNIQUE
	(		
		EntityId,
		Name
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbFileTypes            
TO    SDSystem
GO

