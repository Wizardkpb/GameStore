/*таблица описания доступных справочников*/
IF	object_id('dbo.gbDataReferences')	IS NOT NULL
	DROP	TABLE	dbo.gbDataReferences

CREATE	TABLE	dbo.gbDataReferences
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbDataRef_Id				PRIMARY KEY CLUSTERED					,		
	
	Code				nvarchar(64)		NOT NULL	CONSTRAINT	DF_gbDataRef_Code			DEFAULT('')								,	--код справочника
	Name				nvarchar(240)		NOT NULL	CONSTRAINT	DF_gbDataRef_Name			DEFAULT('')								,	--название справочника
	Kind				int					NOT NULL	CONSTRAINT	RC_gbDataRef_Kind			REFERENCES dbo.gbDataKinds(Id)			,	--тип значения
	AutoImport			int					NOT NULL	CONSTRAINT	DF_gbDataRef_AutoImport   	DEFAULT(0)								,	--автоматическая закачка значений справочника 0- не закачивается, 1- закачивается
	LastLoad			datetime				NULL																					,	--дата последней закачки справочника из вне

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbDataRef_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbDataRef_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbDataRef_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbDataRef_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbDataRef_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbDataRef_Code
	UNIQUE
	(
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbDataReferences            
TO    SDSystem
GO
