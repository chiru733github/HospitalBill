create table HospitalBill
(
Bill_No int primary key not null,
Bill_Date date not null,
Patient_Name nvarchar(150),
Gender varchar(10) not null,
DOB date not null,
Address nvarchar(max) not null,
Email_Id varchar(50),
Mobile_No varchar(10)
)

create table Investigation
(
Investigation_Id int primary key identity(1,1),
Investigation_Name nvarchar(200),
Fee decimal(6,2)
)
insert into Investigation (Investigation_Name) values('')
insert into Investigation (Investigation_Name,Fee) values('X-ray',700),('Blood Test',300),('Headache',200),('Acidity',250),('City Scan',2000),('diabitics',350);

delete from Grid_Table where Investigation_Id=1;
select * from Investigation
create table Grid_Table
(
Id int primary key identity(1,1),
Bill_No int foreign key references HospitalBill(Bill_No),
Investigation_Id int foreign key references Investigation(Investigation_Id),
CreatedAt date 
)

select * from HospitalBill
create or alter proc usp_InsertBill
(
@Bill_No int,
@Bill_Date datetime,
@PatientName nvarchar(150),
@Gender varchar(50),
@DOB datetime,
@Address nvarchar(max),
@Email_Id varchar(100),
@Mobile_No varchar(10)
)
as
begin
  SET NOCOUNT ON;
    BEGIN TRY
        IF @Bill_No IS NULL OR @Bill_Date IS NULL OR @PatientName IS NULL OR 
           @Gender IS NULL OR (@Gender != 'Male' AND @Gender != 'Female') OR 
           @DOB IS NULL OR @Mobile_No IS NULL OR 
           (@Mobile_No NOT LIKE '[6-9]%' OR LEN(@Mobile_No) != 10)
        BEGIN
            RAISERROR ('All required fields must be provided and constraints must be satisfied.', 16, 1);
            RETURN;
        END

        INSERT INTO HospitalBill (Bill_No, Bill_Date, Patient_Name, Gender, DOB, Address, Email_Id, Mobile_No)
        VALUES (@Bill_No, @Bill_Date, @PatientName, @Gender, @DOB, @Address, @Email_Id, @Mobile_No);

        PRINT 'Bill inserted successfully';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END


CREATE OR ALTER PROCEDURE usp_UpdateBill
(
    @Bill_No INT,
    @Bill_Date DATETIME,
    @Patient_Name NVARCHAR(150),
    @Gender VARCHAR(50),
    @DOB DATETIME,
    @Address NVARCHAR(MAX),
    @EmailId NVARCHAR(150),
    @Mobile_Number NVARCHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Check for NULL values and other constraints in all fields at once
        IF @Bill_No IS NULL OR @Bill_Date IS NULL OR @Patient_Name IS NULL OR 
           @Gender IS NULL OR (@Gender != 'Male' AND @Gender != 'Female') OR 
           @DOB IS NULL OR @Mobile_Number IS NULL OR 
           (@Mobile_Number NOT LIKE '[6-9]%' OR LEN(@Mobile_Number) != 10)
        BEGIN
            RAISERROR ('All required fields must be provided and constraints must be satisfied.', 16, 1);
            RETURN;
        END

        -- Update Hospital_Bill table
        UPDATE HospitalBill
        SET 
            Bill_Date = @Bill_Date,
            Patient_Name = @Patient_Name,
            Gender = @Gender,
            DOB = @DOB,
            Address = @Address,
            Email_Id = @EmailId,
            Mobile_No = @Mobile_Number
        WHERE Bill_No = @Bill_No;

        -- Check if the update was successful
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR ('No bill found with the specified Bill_No.', 16, 1);
            RETURN;
        END

        PRINT 'Bill updated successfully';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

select * from Grid_Table
select * from Investigation
exec usp_Inserting_Into_Grid 1,'Blood Test',300


create or alter proc usp_Inserting_Into_Grid
(
@Bill_No int,
@Investigation_Id int
)
as
begin
  SET NOCOUNT ON;
    BEGIN TRY
        IF (@Bill_No IS NULL OR @Investigation_Id IS NULL)
        BEGIN
            RAISERROR ('All required fields must be provided', 16, 1);
            RETURN;
        END
		else
		begin
		insert into Grid_Table (Bill_No,Investigation_Id,CreatedAt) values(@Bill_No,@Investigation_Id,getdate())
		end

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
exec usp_ShowGrid 1

select * from Grid_Table

update Grid_Table set Investigation_Id=1 where id=2
create or alter proc usp_ShowGrid
(
@Bill_No int
)
as
begin
  SET NOCOUNT ON;
    BEGIN TRY
	
        IF (@Bill_No IS NULL)
        BEGIN
            RAISERROR ('Bill No required field must be provided', 16, 1);
            RETURN;
        END
		else
		begin
		select inv.Investigation_Name, inv.Fee,gt.CreatedAt from Investigation inv join Grid_Table gt
		on inv.Investigation_Id=gt.Investigation_Id
		where gt.Bill_No=@Bill_No
		end

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

		