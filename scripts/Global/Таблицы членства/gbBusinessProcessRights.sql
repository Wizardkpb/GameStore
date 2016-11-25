/*Таблица связи ролей с бизнес процессами. Права ролей. Членство бизнес процессов в ролях*/
IF	object_id('dbo.gbBusinessProcessRights')	IS NOT NULL
	DROP	TABLE	dbo.gbBusinessProcessRights

CREATE	TABLE	dbo.gbBusinessProcessRights
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbBProcessesRights_Id			PRIMARY KEY NONCLUSTERED					,		

	RoleId				int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_RoleId		REFERENCES dbo.gbRoles(Id)					,	--ид роли
	BusinessProcessId	int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_BusProcId		REFERENCES dbo.gbBusinessProcesses(Id)		,	--ид бизнес-процесса

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_CreatorId		REFERENCES dbo.gbUsers(Id)					,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbBProcessesRights_Created		DEFAULT(getdate())							,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbBProcessesRights_ChangerId		REFERENCES dbo.gbUsers(Id)					,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbBProcessesRights_Changed		DEFAULT(getdate())							,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbBProcessesRights_Status		DEFAULT(1)									,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbBProcessesRights_Identity
	UNIQUE		CLUSTERED
	(	
			RoleId				,
			BusinessProcessId
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbBusinessProcessRights            
TO    SDSystem
GO
