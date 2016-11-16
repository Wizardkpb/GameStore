/*таблица для хранения доп реквизитов большой емкости - файлы, XML данные, картинки*/
IF	object_id('dbo.gbPropertyBigValues')	IS NOT NULL
	DROP	TABLE	dbo.gbPropertyBigValues

CREATE	TABLE	dbo.gbPropertyBigValues
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbPropertyBigValues_Id				PRIMARY KEY CLUSTERED					,		
	PropertyId			int					NOT NULL	CONSTRAINT	RC_gbPropertyBigValues_PropertyId		REFERENCES dbo.gbProperties(Id)			,	--ссылка на тип доп реквизита
	OwnerId				int					NOT	NULL																								,	--ид владельца. ид с таблицы той сущности, что указана в типе доп реквизита

	TextValue			NTEXT					NULL																								,	--текст
	ImageValue			IMAGE					NULL																								,	--картинка
	XMLValue			XML						NULL																								,	--Если данные это объект XML
		
	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbPropertyBigValues_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyBigValues_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbPropertyBigValues_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyBigValues_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbPropertyBigValues_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	/*убрал класнерный индекс, т.к. количество больших данных в разы меньше обычных доп реков. Таким образом будет скорость вставки быстей выполняться*/
	CONSTRAINT	UC_gbPropertyBigValues_Identity
	UNIQUE
	(
		OwnerId		,
		PropertyId		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbPropertyBigValues  
TO    SDSystem
GO
