/* Задачи или подзадач для сервис деска*/

IF	object_id('dbo.sdTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdTasks

CREATE	TABLE	dbo.sdTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdTasks_Id				PRIMARY KEY CLUSTERED					,	

	ProjectId			int					NOT NULL	CONSTRAINT	RC_sdTasks_ProjectId		REFERENCES dbo.sdProjects(Id)			,	--проект
	TypeTaskId			int					NOT NULL	CONSTRAINT	RC_sdTasks_TypeTaskId		REFERENCES dbo.sdTypeTask(Id)			,	--тип задачи
	SubTaskId			int						NULL	CONSTRAINT	RC_sdTasks_SubTaskId		REFERENCES dbo.sdTasks(Id)				,	--ссылка на владельца задачи, если это подзадача
	AccessLevelsId		int					NOT NULL	CONSTRAINT	RC_sdTasks_AccessLevelsId	REFERENCES dbo.sdAccessLevelsTask(Id)	,	--уровень доступа к этой задаче

	Subject				nvarchar(1024)		NOT NULL	CONSTRAINT	DF_sdTasks_Subject			DEFAULT('')								,	--тема
	PriorityId			int					NOT NULL	CONSTRAINT	RC_sdTasks_PriorityId		REFERENCES dbo.sdPriorityTask(Id)		,	--приоритет задачи
	Description			nvarchar(max)		NOT NULL	CONSTRAINT	DF_sdTasks_Description		DEFAULT('')								,	--описание
	Comment				nvarchar(max)			NULL																					,	--комментарий

	ExecutorId			int					NOT	NULL	CONSTRAINT	RC_sdTasks_ExecutorId		REFERENCES dbo.gbUsers(Id)				,	--исполнитель	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdTasks_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdTasks_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	RC_sdTasks_Status			REFERENCES dbo.sdStatusTask(Id)				--состояние	
)
GO

CREATE INDEX Ix_sdTasks_CreatorCreated	ON dbo.sdTasks( CreatorId, Created )
GO

CREATE INDEX Ix_sdTasks_ExecutorCreated	ON dbo.sdTasks( ExecutorId, Created )
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdTasks            
TO    SDSystem
GO
