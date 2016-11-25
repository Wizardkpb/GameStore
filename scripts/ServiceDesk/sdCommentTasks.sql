/*комментариии по сервис деску*/
IF	object_id('dbo.sdCommentTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdCommentTasks

CREATE	TABLE	dbo.sdCommentTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdCommentTasks_Id				PRIMARY KEY CLUSTERED					,	

	TaskId				int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_TaskId			REFERENCES dbo.sdTasks(Id)				,	--задача
	Comment				nvarchar(max)		NOT	NULL																							,	--комментарий	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_CreatorId			REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdCommentTasks_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_ChangerId			REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdCommentTasks_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdCommentTasks_Status			DEFAULT(1)									--состояние 0 - неактивное, 1 - активное, 2 - измененное
)
GO

CREATE INDEX Ix_sdCommentTasks_TaskId	ON dbo.sdCommentTasks( TaskId )
INCLUDE	(CreatorId)


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdCommentTasks            
TO    SDSystem
GO
