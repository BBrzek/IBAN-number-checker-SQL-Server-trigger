--Trigger for db in SQL Server
create trigger iban_validation
on bank_number
for insert
as
begin
	declare @acc_number varchar(max) = (select acc_number from inserted) -- inserted value of account number
	declare @nr1 varchar(max)
	declare @nr2 varchar(max)
	declare @nr3 varchar(max)
	declare @nr4 varchar(max)
	declare @nr5 varchar(max)
	declare @mod1 varchar(max)
	declare @mod1nr2 varchar(max)
	declare @mod2 varchar(max)
	declare @mod2nr3 varchar(max)
	declare @mod3 varchar(max)
	declare @mod3nr4 varchar(max)
end