/* История изменения. Задачи или подзадач для сервис деска*/
/*убрал все сслыки специаль, что бы в случае каких-то изменний ид все равно остались, хотя это перебр поидее, но зато база немного проще будет*/

IF	object_id('dbo.sdTasks_History')	IS NOT NULL
	DROP	TABLE	dbo.sdTasks_History

CREATE	TABLE	dbo.sdTasks_History
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdTasks_H_Id					PRIMARY KEY CLUSTERED						,	
	ObjectId			int					NOT NULL	CONSTRAINT	RC_sdTasks_H_ObjectId			REFERENCES dbo.sdTasks(Id)					,	--задача
	Operation			int					NOT NULL																							,	--операция 0- вставка, 1 изменение, 2 -удаление (сохраняется после операции)

	ProjectId			int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_ProjectId			REFERENCES dbo.sdProjects(Id)*/			,	--проект
	TypeTaskId			int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_TypeTaskId			REFERENCES dbo.sdTypeTask(Id)*/			,	--тип задачи
	SubTaskId			int						NULL	/*CONSTRAINT	RC_sdTasks_H_SubTaskId			REFERENCES dbo.sdTasks(Id)	*/			,	--ссылка на владельца задачи, если это подзадача
	AccessLevelsId		int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_AccessLevelsId		REFERENCES dbo.sdAccessLevelsTask(Id)*/	,	--уровень доступа к этой задаче

	Subject				nvarchar(1024)		NOT NULL																							,	--тема
	PriorityId			int					NOT NULL	/*CONSTRAINT	RC_sdTasks_H_PriorityId			REFERENCES dbo.sdPriorityTask(Id)*/		,	--приоритет задачи
	Description			nvarchar(max)		NOT	NULL																							,	--описание
	Comment				nvarchar(max)			NULL																							,	--комментарий
	
	ExecutorId			int					NOT	NULL	/*CONSTRAINT	RC_sdTasks_H_ExecutorId			REFERENCES dbo.gbUsers(Id)*/			,	--исполнитель	
	
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdTasks_H_ChangerId			REFERENCES dbo.gbUsers(Id)					,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdTasks_H_Changed			DEFAULT(getdate())							,	--дата изменения

	Status				int					NOT	NULL	/*CONSTRAINT	RC_sdTasks_H_Status				REFERENCES dbo.sdStatusTask(Id)	*/			--состояние	
)
GO

CREATE INDEX Ix_sdTasks_H_ObjectId	ON dbo.sdTasks_History( ObjectId )
INCLUDE (Changed, Operation)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdTasks_History            
TO    SDSystem
GO
