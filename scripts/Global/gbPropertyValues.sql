/*таблица для хранения доп реквизитов*/
IF	object_id('dbo.gbPropertyValues')	IS NOT NULL
	DROP	TABLE	dbo.gbPropertyValues

CREATE	TABLE	dbo.gbPropertyValues
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbPropertyValues_Id				PRIMARY KEY NONCLUSTERED				,		
	PropertyId			int					NOT NULL	CONSTRAINT	RC_gbPropertyValues_PropertyId		REFERENCES dbo.gbProperties(Id)			,	--ссылка на тип доп реквизита
	OwnerId				int					NOT	NULL																							,	--ид владельца. ид с таблицы той сущности, что указана в типе доп реквизита

	IntVal				int						NULL																							,	--интовое значение (пишем инт, bool)
	MoneyVal			money					NULL																							,	--деньги (double) с делением на int как разрядность, если нужно больше 4 знаков после запятой
	DateTimeVal			datetime				NULL																							,	--дата со временем (datetime)
	StrValue			nvarchar(max)			NULL																							,	--значение строковое до 4000 знаков

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbPropertyValues_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyValues_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbPropertyValues_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbPropertyValues_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbPropertyValues_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_sdPropertyValues_Identity
	UNIQUE		CLUSTERED
	(
		OwnerId		,
		PropertyId		
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbPropertyValues            
TO    SDSystem
GO
