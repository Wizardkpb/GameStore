/*комментариии журнал работ по задаче*/
IF	object_id('dbo.sdJobLogTasks')	IS NOT NULL
	DROP	TABLE	dbo.sdJobLogTasks

CREATE	TABLE	dbo.sdJobLogTasks
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdJobLogTasks_Id				PRIMARY KEY CLUSTERED					,	

	TaskId				int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_TaskId			REFERENCES dbo.sdTasks(Id)				,	--задача
	ElTime				nvarchar(32)		NOT NULL																						,	--время введенное пользователем 1d, 1h, 1m, 1w
	ElTimeMinute		int					NOT NULL																						,	--время в минутах 
	DateFrom			datetime			NOT NULL																						,	--дата начала
	Comment				nvarchar(max)			NULL																						,	--комментарий

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdJobLogTasks_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdJobLogTasks_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdJobLogTasks_Status			DEFAULT(1)									--состояние 0 - неактивное, 1 - активное, 2 - измененное
)
GO

CREATE INDEX Ix_sdJobLogTasks_TaskId	ON dbo.sdJobLogTasks( TaskId )
INCLUDE	(CreatorId)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdCommentTasks            
TO    SDSystem
GO
