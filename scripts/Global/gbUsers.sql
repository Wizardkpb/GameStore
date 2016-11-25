/*Таблица пользователей - глобальная таблица не зависимо от модуля*/
IF	object_id('dbo.gbUsers')	IS NOT NULL
	DROP	TABLE	dbo.gbUsers

CREATE	TABLE	dbo.gbUsers
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbUsers_Id			PRIMARY KEY CLUSTERED						,	
	[Login]				nvarchar(64)		NOT NULL																					,	--логин
	[Password]			nvarchar(240)		NOT NULL																					,	--пароль MD5
	Surname				nvarchar(64)		NOT NULL																					,	--фамилия
	Name				nvarchar(64)		NOT NULL																					,	--имя
	Patronymic			nvarchar(64)			NULL																					,	--отчество
	EMail				nvarchar(240)			NULL																					,	--почта
	Phone				nvarchar(32)			NULL																					,	--телефон
	Culture				nvarchar(2)			NOT NULL	CONSTRAINT	DF_gbUsers_Culture		DEFAULT('RU')								,	--культура
	PasswordExpired		datetime				NULL																					,	--дата истечения пароля
	Photo				image					NULL																					,	--фото пользователя

	CreaterId			int					NOT NULL	CONSTRAINT	DF_gbUsers_CreaterId	DEFAULT(0)									,	--создатель
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbUsers_Created		DEFAULT(getdate())							,	--дата создания
	ChangerId			int					NOT NULL	CONSTRAINT	DF_gbUsers_ChangerId	DEFAULT(0)									,	--кто изменил
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbUsers_Changed		DEFAULT(getdate())							,	--дата изменения
	Status				int					NOT	NULL	CONSTRAINT	DF_gbUsers_Status		DEFAULT(1)									,	--состояние 0 - неактивное/удаленный, 1 - активное, 2 - заблокирован
	
	CONSTRAINT	UC_gbProjects_Login
	UNIQUE
	(	
		[Login]
	)
)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbUsers            
TO    SDSystem
GO


IF (NOT EXISTS (SELECT 1 FROM dbo.gbUsers WHERE Login='Admin'))
	INSERT INTO dbo.gbUsers ([Login],[Password],Surname,Name) VALUES ('Admin','1','Admin','')
--SELECT * FROM dbo.sdUsers