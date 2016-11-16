/*Таблица возможных ролей пользователя*/
IF	object_id('dbo.gbRoles')	IS NOT NULL
	DROP	TABLE	dbo.gbRoles

CREATE	TABLE	dbo.gbRoles
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbRoles_Id			PRIMARY KEY CLUSTERED					,		
	Code				nvarchar(64)		NOT NULL																				,	--код роли (уникальное)
	Name				nvarchar(240)		NOT NULL																				,	--название роли

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbRoles_CreatorId	REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbRoles_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbRoles_ChangerId	REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbRoles_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbRoles_Status		DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbRoles_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbRoles            
TO    SDSystem
GO
