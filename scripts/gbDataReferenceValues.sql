/*������� �� ���������� �����������*/
IF	object_id('dbo.gbDataReferenceValues')	IS NOT NULL
	DROP	TABLE	dbo.gbDataReferenceValues
GO

CREATE	TABLE	dbo.gbDataReferenceValues
(
	Id					int				IDENTITY	CONSTRAINT	UC_gbDtRefVal_Id			PRIMARY KEY CLUSTERED					,
	DataReferenceId		int				NOT NULL	CONSTRAINT	RC_gbDtRefVal_DtRefId		REFERENCES dbo.gbDataReferences(Id)		,	
	
	Value				nvarchar(240)	NOT NULL	CONSTRAINT	DF_gbDtRefVal_Value			DEFAULT('')								,	--��������
	Description			nvarchar(1024)	NOT NULL	CONSTRAINT	DF_gbDtRefVal_Description	DEFAULT('')								,	--���������
	DateFrom			int				NOT NULL	CONSTRAINT	DF_gbDtRefVal_DateFrom		DEFAULT(0)								,	--���� ������ �������� � ����
	DateInto			int					NULL																					,	--���� ��������� �������� � ����

	CreatorId			int				NOT	NULL	CONSTRAINT	DF_gbDtRefVal_CreatorId		DEFAULT(0)								,	--���������
	Created				datetime		NOT NULL	CONSTRAINT	DF_gbDtRefVal_Created		DEFAULT(getdate())						,	--���� ��������
	ChangerId			int				NOT NULL	CONSTRAINT	DF_gbDtRefVal_ChangerId		DEFAULT(0)								,	--��� �������
	Changed				datetime		NOT NULL	CONSTRAINT	DF_gbDtRefVal_Changed		DEFAULT(getdate())						,	--���� ���������
	Status				int				NOT	NULL	CONSTRAINT	DF_gbDtRefVal_Status		DEFAULT(1)								,	--��������� 0 - ����������, 1 - ��������																						,
	
	CONSTRAINT	UC_wbDtRefVals
		UNIQUE
		(
			DataReferenceId	,
			Value			,
			DateFrom
		)
)
GO

GRANT INSERT,UPDATE,DELETE,SELECT
ON    dbo.gbDataReferenceValues            
TO    SDSystem
GO
