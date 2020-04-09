create function fn_battery_charging(@charging decimal)
return table
as
return (select * from dbo.battery where charging >= @charging)
create function fn_battery_wireless(@wirelessCharging bit)
return table
as
return (select * from dbo.battery where @wirelesscharging = wirelessCharging)
create function fn_battery_size(@size int)
return table
as
return (select * from dbo.battery where size >= @size)
create function fn_sim(@size nvarchar(50))
returns table
as
return (select * from dbo.sim where size = @size)
create function fn_speedmin(@speedmin)
returns table
as
return (select * from dbo.network where speedmin >= @speedmin)
create function fn_network_speedmax(@speedmax decimal(10,2))
returns table
as
return (select * from dbo.network where speedmax >= @speedmax)
create function fn_find_by_network(@speedmin decimal = 0,@speedmax decimal = null)
returns @table table(id bigint, "2gband" bit, "3gband" bit, "4gband" bit, "5gband" bit, speedmin decimal, speedmax decimal)
as
begin
declare @table1 table(id bigint, "2gband" bit, "3gband" bit, "4gband" bit, "5gband" bit, speedmin decimal,speedmax decimal)
declare @table2 table(id bigint, "2gband" bit, "3gband" bit, "4gband" bit, "5gband" bit, speedmin decimal, speedmax decimal)
insert into @table1 select * from dbo.fn_network_speedmin(@speedmin)
if @speedmax != null
insert into @table2 select * from dbo.fn_network_speedmax(@speedmax)
else
insert into @table2 select * from @table1
insert into @table
select distinct a.id, a."2gband", a."3gband", a."4gband", a."5gband", a.speedmin, a.speedmax from
@table1 a inner join @table2 b on a.id = b.id
return
end
create function fn_find_by_battery(@charging decimal=0, @wirelessCharging bit=null, @size int = 0)
returns @table table(id bigint, charging decimal, wirelessCharging bit, size int)
as
begin
declare @table1 table(id bigint, charging decimal, wirelessCharging bit, size int)
declare @table2 table(id bigint, charging decimal, wirelessCharging bit, size int)
declare @table3 table(id bigint, charging decimal, wirelessCharging bit, size int)
declare @table4 table(id bigint, charging decimal, wirelessCharging bit, size int)
insert into @table1 select * from dbo.fn_battery_charging(@charging)
if @wirelesscharging = null
insert into @table2 select * from @table1
else
insert into @table2 select * from dbo.fn_battery_wireless(@wirelessCharging)
insert into @table3 select * from dbo.fn_battery_size(@size)
insert into @table4
select distinct a.id, a.charging, a.wirelessCharging, a.size from
@table1 a inner join @table2 b on a.id = b.id
insert into @table
select distinct a.id, a.charging, a.wirelessCharging, a.size from
@table4 a inner join @table3 b on a.id = b.id
return
end
