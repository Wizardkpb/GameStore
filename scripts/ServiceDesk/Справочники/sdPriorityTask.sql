/*справочник возможных приоритетов задачи*/

IF	object_id('dbo.sdPriorityTask')	IS NOT NULL
	DROP	TABLE	dbo.sdPriorityTask

CREATE	TABLE	dbo.sdPriorityTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdPriorityTask_Id				PRIMARY KEY CLUSTERED					,			
	Name				nvarchar(240)		NOT NULL																							,	--название приоритета	
	FileImage			nvarchar(240)			NULL																							,	--путь к файлу картинки	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdPriorityTask_CreatorId			REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdPriorityTask_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdPriorityTask_ChangerId			REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdPriorityTask_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdPriorityTask_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdPriorityTask_Name
	UNIQUE
	(	
		Name		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdPriorityTask            
TO    SDSystem
GO
