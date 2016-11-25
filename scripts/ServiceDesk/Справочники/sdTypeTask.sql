/*справочник типов задач или подзадач дл€ сервси деска*/

IF	object_id('dbo.sdTypeTask')	IS NOT NULL
	DROP	TABLE	dbo.sdTypeTask

CREATE	TABLE	dbo.sdTypeTask
(	
	Id					int					IDENTITY	CONSTRAINT	UC_sdTypeTask_Id			PRIMARY KEY CLUSTERED					,	
		
	Name				nvarchar(80)		NOT NULL																					,	--название типа запроса
	SubTask				int					NOT NULL	CONSTRAINT	DF_sdTypeTask_SubTask		DEFAULT(0)								,	--подзадача или нет 0 - задача, 1 - подзадача. ≈сли что-то большее, то нужно делать справочник
	FileImage			nvarchar(240)			NULL																					,	--путь к файлу картинки	

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdTypeTask_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdTypeTask_Created		DEFAULT(getdate())						,	--дата создани€
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdTypeTask_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdTypeTask_Changed		DEFAULT(getdate())						,	--дата изменени€
	Status				int					NOT	NULL	CONSTRAINT	DF_sdTypeTask_Status		DEFAULT(1)								,	--состо€ние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdTypeTask_Identity
	UNIQUE
	(	
		Name,
		SubTask
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.sdTypeTask            
TO    SDSystem
GO
