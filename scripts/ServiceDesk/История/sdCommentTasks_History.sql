/*История изменения.комментариии по сервис деску*/
IF	object_id('dbo.sdCommentTasks_History')	IS NOT NULL
	DROP	TABLE	dbo.sdCommentTasks_History

CREATE	TABLE	dbo.sdCommentTasks_History
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdCommentTasks_H_Id				PRIMARY KEY CLUSTERED					,	
	ObjectId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_H_ObjectId		REFERENCES dbo.sdCommentTasks(Id)		,	--ссылка на журнал
	Operation			int					NOT NULL																							,	--операция 0- вставка, 1 изменение, 2 -удаление (сохраняется после операции)

	TaskId				int					NOT NULL	/*CONSTRAINT	RC_sdCommentTasks_H_TaskId			REFERENCES dbo.sdTasks(Id)*/		,	--задача
	Comment				nvarchar(max)		NOT	NULL																							,	--комментарий	

	
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdCommentTasks_H_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdCommentTasks_H_Changed			DEFAULT(getdate())						,	--дата изменения

	Status				int					NOT	NULL	CONSTRAINT	DF_sdCommentTasks_H_Status			DEFAULT(1)									--состояние 0 - неактивное, 1 - активное, 2 - измененное
)
GO

CREATE INDEX Ix_sdCommentTasks_History_ObjectId	ON dbo.sdCommentTasks_History( ObjectId )
INCLUDE (Changed, Operation)


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdCommentTasks_History            
TO    SDSystem
GO
