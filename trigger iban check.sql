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

	declare @mod_iban varchar(max)
	declare @nr_test varchar(max)

	if (LEN(@acc_number) <> 26)
	begin
		print 'Lenght of value inserted in column acc_number is not correct'
		rollback
	end

	if (ISNUMERIC(@acc_number) = 0)
	begin
		print 'Inserted value is not a number'
		rollback
	end

	set @nr1 = LEFT(@acc_number,2)
	set @nr_test = CONCAT(SUBSTRING(@acc_number,3,24),'2521',@nr1)

	set @nr2 = SUBSTRING(@nr_test,1,9)
	set @nr3 = SUBSTRING(@nr_test,10,7)
	set @nr4 = SUBSTRING(@nr_test,17,7)
	set @nr5 = SUBSTRING(@nr_test,24,7)

	set @mod1 = @nr2 % 97
	set @mod1nr2 = CONCAT(@mod1,@nr3)

	set @mod2 = @mod1nr2 % 97
	set @mod2nr3 = CONCAT(@mod2,@nr4)

	set @mod3 = @mod2nr3 % 97
	set @mod3nr4 = CONCAT(@mod3,@nr5)

	set @mod_iban = @mod3nr4 % 97


	if (@mod_iban = 1)
	begin
		print 'IBAN is correct!'
	end
	else
	begin
		print 'IBAN is NOT correct!'
		rollback
	end
end