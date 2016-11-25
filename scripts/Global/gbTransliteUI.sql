/*Таблица транслитирации всех спраочных ресурсов отличных от культуры по умолчанию*/
IF	object_id('dbo.gbTransliteUI')	IS NOT NULL
	DROP	TABLE	dbo.gbTransliteUI

CREATE	TABLE	dbo.gbTransliteUI
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbTransliteUI_Id				PRIMARY KEY NONCLUSTERED				,	
	TableCode			nvarchar(64)		NOT NULL																						,	--код таблицы (название таблицы)	
	Code				nvarchar(64)		NOT NULL																						,	--уникальный код в таблице
	CultureUI			nvarchar(2)			NOT NULL	CONSTRAINT	RC_gbTransliteUI_CultureUI		REFERENCES dbo.gbCultures(Culture)		,	--язык
	Name				nvarchar(240)		NOT NULL																						,	--наименование на указанном языке


	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbTransliteUI_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbTransliteUI_Created		DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbTransliteUI_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbTransliteUI_Changed		DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbTransliteUI_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbTransliteUI_Identity
	UNIQUE CLUSTERED
	(			
		TableCode,		
		Code,
		CultureUI
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbTransliteUI            
TO    SDSystem
GO
