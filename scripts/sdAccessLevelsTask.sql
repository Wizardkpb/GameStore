/*справочник уровня безопастности задач*/
IF	object_id('dbo.sdAccessLevelsTask')	IS NOT NULL
	DROP	TABLE	dbo.sdAccessLevelsTask

CREATE	TABLE	dbo.sdAccessLevelsTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdAccessLevelsTask_Id		PRIMARY KEY CLUSTERED					,	
			
	Name				nvarchar(80)		NOT NULL																						,	--название Уровеня безопасности

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdAccessLevelsTask_CreatorId		REFERENCES dbo.gbUsers(Id)			,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdAccessLevelsTask_Created		DEFAULT(getdate())					,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdAccessLevelsTask_ChangerId		REFERENCES dbo.gbUsers(Id)			,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdAccessLevelsTask_Changed		DEFAULT(getdate())					,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdAccessLevelsTask_Status		DEFAULT(1)							,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdAccessLevelsTask_Name
	UNIQUE
	(	
		Name		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdAccessLevelsTask            
TO    SDSystem
GO
