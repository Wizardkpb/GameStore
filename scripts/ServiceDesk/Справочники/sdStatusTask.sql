/*справочник возможных состояний задач*/

IF	object_id('dbo.sdStatusTask')	IS NOT NULL
	DROP	TABLE	dbo.sdStatusTask

CREATE	TABLE	dbo.sdStatusTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdStatusTask_Id				PRIMARY KEY CLUSTERED					,			

	Code				nvarchar(64)		NOT NULL																						,	--код состояния	
	Name				nvarchar(240)		NOT NULL																						,	--название состояния	
	Comment				nvarchar(1024)			NULL																						,	--комментарий	
	FileImage			nvarchar(240)			NULL																						,	--путь к файлу картинки	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdStatusTask_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdStatusTask_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdStatusTask_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdStatusTask_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdStatusTask_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdStatusTask_Code
	UNIQUE
	(	
		Code		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdStatusTask            
TO    SDSystem
GO
