/*Таблица приложений*/
IF	object_id('dbo.gbApplications')	IS NOT NULL
	DROP	TABLE	dbo.gbApplications

CREATE	TABLE	dbo.gbApplications
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbApplications_Id			PRIMARY KEY CLUSTERED					,		

	Code				nvarchar(64)		NOT NULL																						,	--код приложения (уникальное)
	Name				nvarchar(240)		NOT NULL																						,	--название приложения
	Description			nvarchar(240)		NOT NULL																						,	--пояснение

	CreatorId			int					NOT NULL	CONSTRAINT	DF_gbApplicationss_CreatorId	DEFAULT(1)								,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbApplications_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	DF_gbApplications_ChangerId		DEFAULT(1)								,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbApplications_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbApplications_Status		DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbApplications_Code
	UNIQUE
	(	
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbApplications            
TO    SDSystem
GO

IF (NOT EXISTS (SELECT 1 FROM dbo.gbApplications WHERE Code='ADMIN'))
	INSERT INTO dbo.gbApplications (Code, Name, Description) VALUES ('ADMIN','Управление системой','Админ панель')
IF (NOT EXISTS (SELECT 1 FROM dbo.gbApplications WHERE Code='SERVICEDESK'))
	INSERT INTO dbo.gbApplications (Code, Name, Description) VALUES ('SERVICEDESK','Сервис деск','Управление заявками')