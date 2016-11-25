/*Таблица типов бизнес процессов*/
IF	object_id('dbo.gbTypeBusinessProcesses')	IS NOT NULL
	DROP	TABLE	dbo.gbTypeBusinessProcesses

CREATE	TABLE	dbo.gbTypeBusinessProcesses
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbTypeBProcesses_Id				PRIMARY KEY CLUSTERED				,		
		
	Code				nvarchar(64)		NOT NULL																						,	--код типа бизнес процесса (уникальное) (ACT, REP, FIELD, PAGE...)
	Name				nvarchar(240)		NOT NULL																						,	--название бизнес-процесса
	Description			nvarchar(240)			NULL																						,	--пояснение
	
	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbTypeBProcesses_CreatorId		REFERENCES dbo.gbUsers(Id)			,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbTypeBProcesses_Created			DEFAULT(getdate())					,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbTypeBProcesses_ChangerId		REFERENCES dbo.gbUsers(Id)			,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbTypeBProcesses_Changed			DEFAULT(getdate())					,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbTypeBProcesses_Status			DEFAULT(1)							,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbTypeBProcesses_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbTypeBusinessProcesses            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='ACT'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('ACT','Действия','Бизнес-процесы относящиеся к действиям пользователя',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='REP'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('REP','Отчеты','Бизнес-процесы относящиеся к построению отчетов',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='FIELD'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('FIELD','Поле','Бизнес-процесы относящиеся к доступу конкретного поля',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbTypeBusinessProcesses WHERE Code='PAGE'))
	INSERT INTO dbo.gbTypeBusinessProcesses (Code, Name, Description, CreatorId, ChangerId) VALUES ('PAGE','Страница','Бизнес-процесы относящиеся к доступу на целую страницу',1,1)