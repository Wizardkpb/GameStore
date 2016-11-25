/*“аблица бизнес процессов на которые можно давать доступ рол€м*/
IF	object_id('dbo.gbBusinessProcesses')	IS NOT NULL
	DROP	TABLE	dbo.gbBusinessProcesses

CREATE	TABLE	dbo.gbBusinessProcesses
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbBProcesses_Id				PRIMARY KEY CLUSTERED						,		
	ApplicationId		int					NOT NULL	CONSTRAINT	RC_gbBProcesses_ApplicationId	REFERENCES dbo.gbApplications(Id)			,
	EntityId			int					NOT NULL	CONSTRAINT	RC_gbBProcesses_EntityId		REFERENCES dbo.gbEntites(Id)				,
	Code				nvarchar(64)		NOT NULL																							,	--код бизнес-процесса (уникальное)
	Name				nvarchar(240)		NOT NULL																							,	--название бизнес-процесса
	Description			nvarchar(240)			NULL																							,	--по€снение
	ProcessTypeId		int					NOT NULL	CONSTRAINT	RC_gbBProcesses_ProcessTypeId	REFERENCES dbo.gbTypeBusinessProcesses(Id)	,	--тип бизнес процесса

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbBProcesses_CreatorId		REFERENCES dbo.gbUsers(Id)					,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbBProcesses_Created			DEFAULT(getdate())							,	--дата создани€
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbBProcesses_ChangerId		REFERENCES dbo.gbUsers(Id)					,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbBProcesses_Changed			DEFAULT(getdate())							,	--дата изменени€
	Status				int					NOT	NULL	CONSTRAINT	DF_gbBProcesses_Status			DEFAULT(1)									,	--состо€ние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbBProcesses_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbBusinessProcesses            
TO    SDSystem
GO
