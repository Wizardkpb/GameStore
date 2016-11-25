/*История изменения. комментариии журнал работ по задаче*/
IF	object_id('dbo.sdJobLogTasks_History')	IS NOT NULL
	DROP	TABLE	dbo.sdJobLogTasks_History

CREATE	TABLE	dbo.sdJobLogTasks_History
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdJobLogTasks_H_Id			PRIMARY KEY CLUSTERED					,	
	ObjectId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_H_ObjectId		REFERENCES dbo.sdJobLogTasks(Id)		,	--ссылка на журнал
	Operation			int					NOT NULL																						,	--операция 0- вставка, 1 изменение, 2 -удаление (сохраняется после операции)

	TaskId				int					NOT NULL	/*CONSTRAINT	RC_sdJobLogTasks_H_TaskId			REFERENCES dbo.sdTasks(Id)*/	,	--задача
	ElTime				nvarchar(32)		NOT NULL																						,	--время введенное пользователем 1d, 1h, 1m, 1w
	ElTimeMinute		int					NOT NULL																						,	--время в минутах 
	DateFrom			datetime			NOT NULL																						,	--дата начала
	Flag				int					NOT NULL																						,	--тип действия 0- уменьшить время автоматически, 1- установить время в ручную
	SetTime				int					NOT NULL																						,	--оставшеся время в минутах
	Comment				nvarchar(max)			NULL																						,	--комментарий
	
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdJobLogTasks_H_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdJobLogTasks_H_Changed		DEFAULT(getdate())						,	--дата изменения

	Status				int					NOT	NULL																							--состояние 0 - неактивное, 1 - активное, 2 - измененное
)
GO

CREATE INDEX Ix_sdJobLogTasks_H_ObjectId	ON dbo.sdJobLogTasks_History( ObjectId )
INCLUDE (Changed, Operation)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdJobLogTasks_History            
TO    SDSystem
GO
