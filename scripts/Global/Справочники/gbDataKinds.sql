/*таблица определения типов данных для доп реквизитов*/
IF	object_id('dbo.gbDataKinds')	IS NOT NULL
	DROP	TABLE	dbo.gbDataKinds

CREATE	TABLE	dbo.gbDataKinds
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbDataKinds_Id				PRIMARY KEY	CLUSTERED					,			
	Code				nvarchar(64)		NOT	NULL	CONSTRAINT	DF_gbDataKinds_Code				DEFAULT('')								,	--код
	Name				nvarchar(240)		NOT	NULL	CONSTRAINT	DF_gbDataKinds_Name				DEFAULT('')								,	--название
	NETType				nvarchar(512)		NOT NULL	CONSTRAINT	DF_gbDataKinds_NETType			DEFAULT('')								,	--NET тип
	FormControl			nvarchar(512)		NOT NULL	CONSTRAINT	DF_gbDataKinds_FormControl		DEFAULT('')								,	--контроллер который будет использоваться для отображения (еще не знаю как использовать в MVC, а для WebForm это пользовательсткий компонент, который отобразит данные)
	Comment				nvarchar(512)			NULL																						,	--пояснение где храниться

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbDataKinds_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbDataKinds_Created			DEFAULT(getdate())						,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbDataKinds_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbDataKinds_Changed			DEFAULT(getdate())						,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbDataKinds_Status			DEFAULT(1)								,	--состояние 0 - неактивное, 1 - активное

	
	CONSTRAINT	UC_gbDataKinds_Code
	UNIQUE
	(		
		Code
	)
)
GO


GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbDataKinds            
TO    SDSystem
GO


/*инициализация*/
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Int'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Int','Целое число','System.Int32','','Храниться в IntVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Double'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Double','Дробное число','System.Double','','Храниться в MoneyVal gbPropertyValues, а в IntVal храниться умножение',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='DateTime'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('DateTime','Дата/Время','System.DateTime','','Храниться в DateTimeVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Logic'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Logic','Логическое','System.Boolean','','Храниться в IntVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='String'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('String','Строка','System.String','','Храниться в StrVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Text'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Text','Текст','System.String','','Храниться в NText gbPropertyBigValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Image'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Image','Изображение','System.Drawing.Image','','Храниться в Image gbPropertyBigValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='File'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('File','Файл','System.Byte[]','','Храниться в Image gbPropertyBigValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Xml'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Xml','Xml объект','System.String','','Храниться в Xml gbPropertyBigValues',1,1)

--SELECT * FROM dbo.sdDataKinds