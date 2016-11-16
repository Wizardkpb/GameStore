/*проекты сервис деска*/

IF	object_id('dbo.sdProjects')	IS NOT NULL
	DROP	TABLE	dbo.sdProjects

CREATE	TABLE	dbo.sdProjects
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdProjects_Id			PRIMARY KEY CLUSTERED					,	
	Code				nvarchar(64)		NOT NULL																					,	--код проекта, уникальное
	Name				nvarchar(240)		NOT NULL																					,	--название проекта
	FileImage			nvarchar(240)			NULL																					,	--путь к файлу картинки

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdProjects_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdProjects_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdProjects_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdProjects_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdProjects_Status		DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdProjects_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdProjects            
TO    SDSystem
GO
