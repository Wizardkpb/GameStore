/*типы событий по сервис деску*/
IF	object_id('dbo.sdEventTypeTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdEventTypeTasks

CREATE	TABLE	dbo.sdEventTypeTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdEventTypeTasks_Id				PRIMARY KEY CLUSTERED					,	

	Code				nvarchar(64)		NOT NULL																							,	--код события
	Name				nvarchar(240)		NOT NULL																							,	--название события
	Comment				nvarchar(1024)			NULL																							,	--комментарий	
	FileImage			nvarchar(240)			NULL																							,	--путь к файлу картинки	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdEventTypeTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdEventTypeTasks_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdEventTypeTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdEventTypeTasks_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdEventTypeTasks_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное

	CONSTRAINT	UC_sdEventTypeTasks_Code
	UNIQUE
	(	
		Code		
	)
)
GO



GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdEventTypeTasks            
TO    SDSystem
GO
