
-- view
CREATE  or ALTER VIEW [dbo].[ViewFood]
AS
SELECT dbo.Categorys.Name, dbo.Categorys.CategoryId, dbo.Foods.FoodId, dbo.Foods.FoodName, dbo.Foods.Price, dbo.Foods.Quantity, dbo.Foods.CreatedDate, dbo.Foods.CreatedBy, dbo.Foods.ModifiedDate, dbo.Foods.ModifiedBy, 
                  dbo.Foods.FoodDesc, dbo.Foods.FoodDiscount, dbo.Foods.FoodStar, dbo.Foods.FoodType, dbo.Foods.FoodStatus, dbo.Foods.FoodVote
FROM     dbo.Categorys INNER JOIN
                  dbo.Foods ON dbo.Categorys.CategoryId = dbo.Foods.CategoryId

CREATE or ALTER VIEW [dbo].[ViewCategory]
AS
SELECT dbo.Categorys.*
FROM     dbo.Categorys

CREATE or ALTER VIEW [dbo].[ViewBill]
AS
SELECT dbo.Bills.CreatedDate, dbo.Bills.Total, dbo.Bills.Status, dbo.Bills.UserId, dbo.Bills.BillId, dbo.Users.Username, dbo.Users.Address, dbo.Users.Avatar, dbo.Users.FullName, dbo.Users.PhoneNumber
FROM     dbo.Bills INNER JOIN
                  dbo.Users ON dbo.Bills.UserId = dbo.Users.UserId



CREATE or ALTER VIEW [dbo].[ViewRole]
AS
SELECT dbo.Roles.*
FROM     dbo.Roles

CREATE or ALTER VIEW [dbo].[ViewUser]
AS
SELECT dbo.Users.*
FROM     dbo.Users



-- PROCEDURE


-- CRUD bill

CREATE or ALTER PROCEDURE GetBills
    @Id uniqueidentifier
AS
BEGIN
   SELECT b.BillId,b.Paid,b.Status,b.CreatedDate,b.Total,u.Address, u.PhoneNumber  
	FROM Bills b inner join Users u on u.UserId= b.UserId
	WHERE b.UserId = @Id
END

CREATE or ALTER PROCEDURE GetBillDetails
    @Id uniqueidentifier
AS
BEGIN
   SELECT f.FoodId,f.FoodDesc, fi.Url, f.FoodName, bd.Quantity
   from BillDetails bd 
	 inner join Foods f on f.FoodId = bd.FoodId
	 left join FoodImages fi on fi.FoodId = f.FoodId
	WHERE bd.BillId = @Id
END

CREATE or ALTER PROCEDURE GetBillStatus
    @Id uniqueidentifier
AS
BEGIN
   SELECT b.BillId, b.Discount,b.Delivery,b.Total
   from Bills b
	WHERE b.BillId = @Id
END


CREATE or alter PROCEDURE AddBill
	@BillId uniqueidentifier,
    @UserId uniqueidentifier,
    @Paid NVARCHAR(50) = null,
	@Status int,
	@Total int,
	@Method NVARCHAR(50) = null,
	@Discount int = null,
	@Delivery int = null,
	@CreatedDate datetime2(7),
	@CreatedBy nvarchar(max),
	@ModifiedDate datetime2(7),
	@ModifiedBy  nvarchar(max)
AS
BEGIN
    
INSERT INTO [dbo].[Bills] ([BillId],[UserId],[Status],[Total],[CreatedDate],[CreatedBy],[ModifiedDate],[ModifiedBy],[Delivery],[Discount],[Method],[Paid])
     VALUES
           (@BillId,@userId,@status,@total,GETDATE() ,'NTKIEN',null,null,@delivery,@discount,@method,@Paid)
END



CREATE or ALTER PROCEDURE UpdateBill
    @BillId uniqueidentifier,
    @UserId uniqueidentifier,
    @Paid NVARCHAR(50) = null,
	@Status int,
	@Total int,
	@Method NVARCHAR(50) = null,
	@Discount int = null,
	@Delivery int = null,
	@CreatedDate datetime2(7),
	@CreatedBy nvarchar(max),
	@ModifiedDate datetime2(7),
	@ModifiedBy  nvarchar(max)
AS
BEGIN
    UPDATE Bills
    SET
        UserId = @UserId,
        Paid = @Paid,
		Status = @Status,
		Total = @Total,
		Method = @Method,
		Discount = @Discount,
		Delivery = @Delivery,
		ModifiedDate = GETDATE(),
		ModifiedBy = 'NTKIEN'
    WHERE
        BillId = @BillId;
END;


-- CRUD Category
CREATE or alter PROCEDURE AddCategory
	@CategoryId uniqueidentifier,
    @Name NVARCHAR(max),
	@CreatedDate datetime2(7),
	@CreatedBy nvarchar(max),
	@ModifiedDate datetime2(7),
	@ModifiedBy  nvarchar(max)
AS
BEGIN
INSERT INTO Categorys(CategoryId,Name,CreatedDate,CreatedBy,ModifiedDate,ModifiedBy)
     VALUES
           (@CategoryId,@Name, GETDATE(),'NTKIEN',null,null)
END

-- update
CREATE or ALTER PROCEDURE UpdateCategory
	@CategoryId uniqueidentifier,
    @Name NVARCHAR(max),
	@CreatedDate datetime2(7),
	@CreatedBy nvarchar(max),
	@ModifiedDate datetime2(7),
	@ModifiedBy  nvarchar(max)
AS
BEGIN
    UPDATE Categorys
    SET
        Name = @Name,
		ModifiedDate = GETDATE(),
		ModifiedBy = 'NTKIEN'
    WHERE
        CategoryId = @CategoryId;
END;

-- get by id
CREATE or ALTER PROCEDURE GetCategorys
    @Id uniqueidentifier
AS
BEGIN
   SELECT *  
	FROM Categorys c
	WHERE c.CategoryId = @Id
END



-- CRUD role
CREATE or alter PROCEDURE AddRole
	@RoleId uniqueidentifier,
    @RoleName NVARCHAR(max),
	@CreatedDate datetime2(7),
	@CreatedBy nvarchar(max),
	@ModifiedDate datetime2(7),
	@ModifiedBy  nvarchar(max)
AS
BEGIN
INSERT INTO Roles(RoleId,RoleName,CreatedDate,CreatedBy,ModifiedDate,ModifiedBy)
     VALUES
           (@RoleId,@RoleName, GETDATE(),'NTKIEN',null,null)
END

-- update
CREATE or ALTER PROCEDURE UpdateRole
	@RoleId uniqueidentifier,
    @RoleName NVARCHAR(max),
	@CreatedDate datetime2(7),
	@CreatedBy nvarchar(max),
	@ModifiedDate datetime2(7),
	@ModifiedBy  nvarchar(max)
AS
BEGIN
    UPDATE Roles
    SET
        RoleName = @RoleName,
		ModifiedDate = GETDATE(),
		ModifiedBy = 'NTKIEN'
    WHERE
        RoleId = @RoleId;
END;

-- get by id
CREATE or ALTER PROCEDURE GetRoles
    @Id uniqueidentifier
AS
BEGIN
   SELECT *  
	FROM Roles r
	WHERE r.RoleId = @Id
END