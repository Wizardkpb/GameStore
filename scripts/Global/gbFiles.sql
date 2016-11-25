/*таблица для хранения закачиваемых данных (файлы или картинки)*/
IF	object_id('dbo.gbFiles')	IS NOT NULL
	DROP	TABLE	dbo.gbFiles

CREATE	TABLE	dbo.gbFiles
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbFiles_Id				PRIMARY KEY CLUSTERED					,		
	EntityId			int					NOT NULL	CONSTRAINT	RC_gbFiles_EntityId			REFERENCES dbo.gbEntites(Id)			,	--ссылка на сущность
	OwnerId				int					NOT	NULL																					,	--ид владельца. ид с таблицы той сущности, что указана в типе доп реквизита	

	FileTypesId			int					NOT NULL	CONSTRAINT	RC_gbFiless_FileTypesId		REFERENCES dbo.gbFileTypes(Id)			,	--ссылка на тип файла
	NameFile			nvarchar(240)		NOT	NULL																					,	--название файла
	VersionFile			int					NOT NULL	CONSTRAINT	DF_gbFiles_VersionFile		DEFAULT(1)								,	--верия файла - это счетчик, если имя пересекается для этой сущности, то добавляем номер версии следующий
	
	TextValue			NTEXT					NULL																					,	--текст
	ImageValue			IMAGE					NULL																					,	--картинка	
	FileStrimValue		VARBINARY(MAX)			NULL																					,	--если выбрали сохранение как тип данных FILESTREAM (http://sqlmag.com/sql-server-2008/using-sql-server-2008s-filestream-data-type)	
	
	Size				int						NULL																					,	--размер в байтах 
	Ext					nvarchar(32)			NULL																					,	--разширение файла
	Mime				nvarchar(240)			NULL																					,	--как его отдавать 
	Comment				nvarchar(512)			NULL																					,	--пояснение к файлу

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbFiles_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbFiles_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbFiles_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbFiles_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbFiles_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbFiles_Identity
	UNIQUE	
	(	
		EntityId	,
		OwnerId		,		
		NameFile	,
		VersionFile			
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbFiles            
TO    SDSystem
GO
