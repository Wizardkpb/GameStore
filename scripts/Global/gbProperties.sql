/*таблица для определения дополнительных реквизитов к любой сущности*/
IF	object_id('dbo.gbProperties')	IS NOT NULL
	DROP	TABLE	dbo.gbProperties

CREATE	TABLE	dbo.gbProperties
(
	Id					int					IDENTITY	CONSTRAINT	UC_sdProperties_Id				PRIMARY KEY CLUSTERED					,		
	EntityId			int					NOT NULL	CONSTRAINT	RC_sdProperties_EntityId		REFERENCES dbo.gbEntites(Id)			,	--ссылка на сущность	
	Code				nvarchar(64)		NOT	NULL																						,	--код доп реквизита
	Name				nvarchar(240)		NOT	NULL																						,	--название реквизита
	Description			nvarchar(512)			NULL																						,	--пояснение, если необходимо

	Kind				int					NOT NULL	CONSTRAINT	RC_sdProperties_Kind			REFERENCES dbo.gbDataKinds(Id)			,	--ссылка на тип доп реквизита
	Mask				nvarchar(240)		NOT NULL	CONSTRAINT	DF_sdProperties_Mask			DEFAULT('')								,	--маска отображения	
	Flag				int					NOT NULL	CONSTRAINT	DF_sdProperties_Flag			DEFAULT(0)								,	--флаг - пока как зарезервированное. 
																																				--0 - обычный
																																				--1 - архивный реквизит!
																																				--Будет использоваться как маска 1,2,4,8,16,32 и т.д.
	DataReferenceId		int						NULL	CONSTRAINT RC_wbPropertiesDataReferenceId	REFERENCES dbo.gbDataReferences(Id)		,	--ссылка на справочник, если значения берутся со справочника																																					

	CreatorId			int					NOT NULL	CONSTRAINT	RC_sdProperties_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_sdProperties_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_sdProperties_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_sdProperties_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_sdProperties_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное
	
	CONSTRAINT	UC_gbProperties_Identity
	UNIQUE
	(
		EntityId	,
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbProperties            
TO    SDSystem
GO
