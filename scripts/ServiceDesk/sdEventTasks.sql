/*события по сервис деску*/
IF	object_id('dbo.sdEventTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdEventTasks

CREATE	TABLE	dbo.sdEventTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdEventTasks_Id				PRIMARY KEY CLUSTERED					,	

	TaskId				int					NOT NULL	CONSTRAINT	RC_sdEventTaskss_TaskId			REFERENCES dbo.sdTasks(Id)				,	--проект
	EventTypeId			int					NOT NULL	CONSTRAINT	RC_sdEventTaskss_EventTypeId	REFERENCES dbo.sdEventTypeTasks(Id)		,	--ид типа события
	TimeExecut			datetime			NOT NULL																						,	--дата исполнения
	Comment				nvarchar(max)		NOT	NULL																						,	--комментарий	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdEventTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdEventTasks_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdEventTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdEventTasks_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdEventTasks_Status			DEFAULT(1)									--состояние 0 - неактивное, 1 - активное, 2 - выполненое
)
GO

--найти все события по указанной задаче
CREATE INDEX Ix_sdEventTasks_TaskId	ON dbo.sdEventTasks( TaskId )
INCLUDE	(Status, CreatorId)

--найти все указанные типы событий
CREATE INDEX Ix_sdEventTasks_EventTypeId	ON dbo.sdEventTasks( EventTypeId )
INCLUDE	(Status)


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdEventTasks            
TO    SDSystem
GO
