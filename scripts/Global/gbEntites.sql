/*таблица для определения сущности с которой будет работать доп реквизиты*/
IF	object_id('dbo.gbEntites')	IS NOT NULL
	DROP	TABLE	dbo.gbEntites

CREATE	TABLE	dbo.gbEntites
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbEntites_Id			PRIMARY KEY	CLUSTERED					,		
	Code				nvarchar(64)		NOT NULL																				,	--код сущности (уникальное)
	Name				nvarchar(240)		NOT NULL																				,	--название сущности

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbEntites_CreatorId	REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbEntites_Created	DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbEntites_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbEntites_Changed	DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbEntites_Status		DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdEntites_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbEntites            
TO    SDSystem
GO
