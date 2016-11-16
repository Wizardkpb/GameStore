/*������� ����������� ����� ������ ��� ��� ����������*/
IF	object_id('dbo.gbDataKinds')	IS NOT NULL
	DROP	TABLE	dbo.gbDataKinds

CREATE	TABLE	dbo.gbDataKinds
(
	Id					int					IDENTITY	CONSTRAINT	UC_gbDataKinds_Id				PRIMARY KEY	CLUSTERED					,			
	Code				nvarchar(64)		NOT	NULL	CONSTRAINT	DF_gbDataKinds_Code				DEFAULT('')								,	--���
	Name				nvarchar(240)		NOT	NULL	CONSTRAINT	DF_gbDataKinds_Name				DEFAULT('')								,	--��������
	NETType				nvarchar(512)		NOT NULL	CONSTRAINT	DF_gbDataKinds_NETType			DEFAULT('')								,	--NET ���
	FormControl			nvarchar(512)		NOT NULL	CONSTRAINT	DF_gbDataKinds_FormControl		DEFAULT('')								,	--���������� ������� ����� �������������� ��� ����������� (��� �� ���� ��� ������������ � MVC, � ��� WebForm ��� ����������������� ���������, ������� ��������� ������)
	Comment				nvarchar(512)			NULL																						,	--��������� ��� ���������

	CreatorId			int					NOT NULL	CONSTRAINT	RC_gbDataKinds_CreatorId		REFERENCES dbo.gbUsers(Id)				,	--���������
	Created				datetime			NOT NULL	CONSTRAINT	DF_gbDataKinds_Created			DEFAULT(getdate())						,	--���� ��������
	ChangerId			int					NOT NULL	CONSTRAINT	RC_gbDataKinds_ChangerId		REFERENCES dbo.gbUsers(Id)				,	--��� �������
	Changed				datetime			NOT NULL	CONSTRAINT	DF_gbDataKinds_Changed			DEFAULT(getdate())						,	--���� ���������
	Status				int					NOT	NULL	CONSTRAINT	DF_gbDataKinds_Status			DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������

	
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


/*�������������*/
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Int'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Int','����� �����','System.Int32','','��������� � IntVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Double'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Double','������� �����','System.Double','','��������� � MoneyVal gbPropertyValues, � � IntVal ��������� ���������',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='DateTime'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('DateTime','����/�����','System.DateTime','','��������� � DateTimeVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Logic'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Logic','����������','System.Boolean','','��������� � IntVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='String'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('String','������','System.String','','��������� � StrVal gbPropertyValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Text'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Text','�����','System.String','','��������� � NText gbPropertyBigValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Image'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Image','�����������','System.Drawing.Image','','��������� � Image gbPropertyBigValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='File'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('File','����','System.Byte[]','','��������� � Image gbPropertyBigValues',1,1)
IF (NOT EXISTS (SELECT 1 FROM dbo.gbDataKinds WHERE Code='Xml'))
	INSERT INTO dbo.gbDataKinds (Code, Name, NETType, FormControl, Comment, CreatorId, ChangerId) VALUES ('Xml','Xml ������','System.String','','��������� � Xml gbPropertyBigValues',1,1)

--SELECT * FROM dbo.sdDataKinds