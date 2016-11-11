select	*
from	Games

insert	into Games
select 'Vladik', 'descVladik', 'third', 99999 union all
select 'TITANFALL4', 'descTITANFALL', 'second', 2299 union all
select 'Battlefield 44', 'descBattlefield 4', 'second', 899.4

update Games
set Price = 999
where GameId = 13

select * from dbo.__MigrationHistory
/*
MigrationId                                                                                                                                            ContextKey                                                                                                                                                                                                                                                       Model                                                                                                                                                                                                                                                            ProductVersion
------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------------------
201610301101522_InitialCreate                                                                                                                          GameStore.Domain.Concrete.EFDbContext                                                                                                                                                                                                                            0x1F8B0800000000000400CD57DB8EDB36107D2FD07F20F8D4021B732F2FDB859C606BAF03A3B1D7883679A7A5B1972845AA24B5B0BF2D0FFDA4FE4287BA5BF22D9BA62DFC229333672E9C3943FEF5E5CFE0DD2691E4058C155A0DE9D5E0921250918E855A0F69E6566F6EE9BBB73FFE103CC4C9867CAEE46EBC1C6A2A3BA4CF 6.1.3-40302

(1 row(s) affected)
*/

delete from dbo.__MigrationHistory

ALTER TABLE Games 
	ADD
		ImageData		VARBINARY(MAX)	NULL,
		ImageMimeType	VARCHAR(50)		NULL