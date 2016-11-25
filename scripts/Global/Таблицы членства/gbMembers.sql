/*Таблица членства пользователя в указнных группах*/
IF	object_id('dbo.gbMembers')	IS NOT NULL
	DROP	TABLE	dbo.gbMembers

CREATE	TABLE	dbo.gbMembers
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbMembers_Id			PRIMARY KEY CLUSTERED					,		

	UserId				int					NOT NULL	CONSTRAINT	RC_gbMembers_UserId		REFERENCES dbo.gbUsers(Id)				,	--ид пользователя
	RoleId				int					NOT NULL	CONSTRAINT	RC_gbMembers_RoleId		REFERENCES dbo.gbRoles(Id)				,	--ид роли в которую он включен

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbMembers_CreatorId	REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbMembers_Created	DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbMembers_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbMembers_Changed	DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbMembers_Status		DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbMembers_Identity
	UNIQUE
	(	
		UserId,
		RoleId
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbMembers            
TO    SDSystem
GO
