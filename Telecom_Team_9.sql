-- 2.1 a
CREATE DATABASE Telecom_Team_9;

GO;

-- Custome datatypes from guidelines
CREATE TYPE ALPHA  
FROM varchar(50);

CREATE TYPE STATUS  
FROM varchar(50);

CREATE TYPE MOBILE  
FROM char(11);

-- 2.1 b
GO;
CREATE PROCEDURE createAllTables
AS
	BEGIN
		CREATE TABLE Customer_Profile (
			nationalID INT,
			first_name ALPHA,
			last_name ALPHA,
			email ALPHA,
			address ALPHA,
			date_of_birth DATE,
			PRIMARY KEY(nationalID)
		);

		CREATE TABLE Customer_Account (
			mobileNo VARCHAR(11),
			pass ALPHA,
			balance decimal(10,1),
			account_type ALPHA,
			start_date DATE,
			status ALPHA,
			point INT DEFAULT 0,
			nationalID INT,
			PRIMARY KEY (mobileNo) ,
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID)
			ON DELETE CASCADE
			ON UPDATE CASCADE
		);

		CREATE TABLE Service_Plan(
			planID INT IDENTITY(1,1),
			SMS_offered INT,
			minutes_offered INT,
			data_offered INT,
			name VARCHAR(10),
			price INT,
			description ALPHA,
			PRIMARY KEY(planID)
		);

		CREATE TABLE Subscribtion(
			mobileNo char(11),
			planID INT,
			subscribtion_date DATE,
			status ALPHA,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (mobileNo,planID)
		);

		CREATE TABLE Plan_Usage(
			usageID INT IDENTITY(1,1),
			start_date DATE,
			end_date DATE,
			data_consumption INT,
			minutes_used INT,
			SMS_sent INT,
			mobileNo MOBILE,
			planID INT, 
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (usageID)
		);
    
		CREATE TABLE Payment(
			paymentID INT IDENTITY(1,1), 
			amount decimal(10,1),
			date_of_payment date,
			payment_method ALPHA,
			status STATUS,
			mobileNo MOBILE,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (paymentID)
		)
		
		CREATE TABLE Process_Payment(
			paymentID INT,
			planID INT,
			remaining_balance decimal(10,1),
			extra_amount decimal(10,1),
			FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,

		);
		CREATE TABLE Wallet (
			walletID INT IDENTITY(1,1),
			current_balance decimal(10,2),
			currency ALPHA,
			last_modified_date DATE,
			nationalID INT,
			mobileNo  MOBILE ,
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY(walletID)
		);

		CREATE TABLE Transfer_Money(
			walletID1 INT,
			walletID2 INT,
			transfer_id INT IDENTITY(1,1),
			amount decimal(10,2),
			transfer_date DATE,
			FOREIGN KEY (walletID1) REFERENCES Wallet(walletID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (walletID2) REFERENCES Wallet(walletID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (walletID1 , walletID2 , transfer_id)
		);
		CREATE TABLE Benefits(
			benefitID INT IDENTITY(1,1),
			description ALPHA,
			vaidity_date DATE,
			status STATUS,
			mobileNo MOBILE,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (benefitID)
		);

		CREATE TABLE Points_Group (
			pointID INT IDENTITY(1,1),
			benefitID INT, 
			pointsAmount INT,
			PaymentID INT,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (PaymentID) REFERENCES Payment(paymentID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY(pointsID , benefitID)
		);

		CREATE TABLE Exclusive_Offer(		
			offerID INT IDENTITY(1,1),
			benefitID INT,
			internet_offered INT,
			SMS_offered INT,
			minutes_offered INT,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY(offerID , benefitID)
		);

		CREATE TABLE Cashback (
			CashbackID INT IDENTITY(1,1),
			benefitID INT,
			walletID INT,
			amount INT,
			credit_date DATE,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (walletID) REFERENCES Wallet(walletID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (CashbackID , benefitID , walletID)
		);

		CREATE TABLE Plan_Provides_Benefits (
			benefitID INT,
			planID INT,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (benefitID , planID)
		);

		CREATE TABLE Shop(
			shopID INT IDENTITY(1,1),
			name ALPHA ,
			category ALPHA ,
			PRIMARY KEY (shopID)
		);

		CREATE TABLE Physical_Shop (
			shopID INT,
			address ALPHA,
			working_hours ALPHA,
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (shopID),
		)
		CREATE TABLE E_Shop (
			shopID INT,
			URL ALPHA,
			rating INT,
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (shopID),
		);

		CREATE TABLE Voucher(
			voucherID INT IDENTITY(1,1),
			value INT,
			expiry_date DATE,
			points INT,
			mobileNo MOBILE,
			shopID INT,
			redeem_date DATE,
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (voucherID)
		)

		CREATE TABLE Technical_Support_Ticket(
			ticketID INT IDENTITY(1,1),
			mobileNo MOBILE,
			issue_description ALPHA,
			priority_level INT,
			status STATUS,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			PRIMARY KEY (ticketID)
		)
	END



-- 2.1 c
GO;
Create Procedure dropAllTables
AS

	BEGIN

		DROP TABLE Customer_Profile;

		DROP TABLE Customer_Account;

		DROP TABLE Service_Plan;

		DROP TABLE Subscription;

		DROP TABLE Plan_Usage;

		DROP TABLE Payment;

		DROP TABLE Process_Payment;

		DROP TABLE Wallet;

		DROP TABLE Transfer_money;

		DROP TABLE Benefits;

		DROP TABLE Points_Group;

		DROP TABLE Exclusive_Offer;

		DROP TABLE Cashback;

		DROP TABLE Plan_Provides_Benefits;

		DROP TABLE Shop;

		DROP TABLE Physical_Shop;

		DROP TABLE E_shop;

		DROP TABLE Voucher;

		DROP TABLE Technical_Support_Ticket;

	END



-- 2.1 d
GO;
Create Procedure dropAllProceduresFunctionsViews

AS

	BEGIN
			DROP PROCEDURE
				createAllTables,
				dropAllTables,
				clearAllTables,
				Account_Plan,
				Benefits_Account,
				Total_Points_Account,
				Unsubscribed_Plans,
				Ticket_Account_Customer,
				Account_Highest_Voucher,
				Top_Successful_Payments,
				Initiate_plan_payment,
				Payment_wallet_cashback,
				Initiate_balance_payment,
				Redeem_voucher_points;




			DROP FUNCTION
				Account_Plan_date,
				Account_Usage_Plan,
				Account_SMS_Offers,
				Account_Payment_Points,
				Wallet_Cashback_Amount,
				Wallet_Transfer_Amount,
				Wallet_MobileNo,
				AccountLoginValidation,
				Consumption,
				Usage_Plan_CurrentMonth,
				Cashback_Wallet_Customer,
				Remaining_plan_amount,
				Extra_plan_amount,
				Subscribed_plans_5_Months;



			DROP VIEW
				allCustomerAccounts,
				allServicePlans,
				allBenefits,
				AccountPayments,
				allShops,
				allResolvedTickets,
				CustomerWallet,
				E_shopVouchers,
				PhysicalStoreVouchers,
				Num_of_cashback;
	END



-- 2.1 e
GO;
Create Procedure clearAllTables
AS

	BEGIN

		DELETE FROM Customer_Profile;

		DELETE FROM Customer_Account;

		DELETE FROM Service_Plan;

		DELETE FROM Subscription;

		DELETE FROM Plan_Usage;

		DELETE FROM Payment;

		DELETE FROM Process_Payment;

		DELETE FROM Wallet;

		DELETE FROM Transfer_money;

		DELETE FROM Benefits;

		DELETE FROM Points_Group;

		DELETE FROM Exclusive_Offer;

		DELETE FROM Cashback;

		DELETE FROM Plan_Provides_Benefits;

		DELETE FROM Shop;

		DELETE FROM Physical_Shop;

		DELETE FROM E_shop;

		DELETE FROM	Voucher;

		DELETE FROM Technical_Support_Ticket;

	END



-- 2.2 a
GO;
Create View allCustomerAccounts AS
	SELECT *
	FROM Customer_profile p INNER JOIN Customer_Account a 
	ON p.nationalID = a.nationalID;



-- 2.2 b
GO;
Create View allServicePlans AS
	SELECT *
	FROM Service_Plan

-- 2.2 c

-- 2.2 d


-- 2.2 e
GO;
CREATE VIEW AllShops AS
SELECT *
FROM Shop S LEFT JOIN Physical_Shop PS ON S.shopID = PS.shopID LEFT JOIN E_shop ON S.shopID = ES.shopID;



-- 2.2 f
GO;
CREATE VIEW allResolvedTickets AS
SELECT *
FROM Technical_Support_Ticket
WHERE status = 'resolved';



-- 2.2 g

-- 2.2 h


-- 2.2 i
GO;
CREATE VIEW PhysicalStoreVouchers AS
	SELECT ps.shopID, ps.name, v.voucherID, v.value
	FROM Physical_Shop INNER JOIN Voucher v
	ON (ps.shopID = v.shopID)


-- 2.2 j
GO;
CREATE VIEW Num_of_cashback AS
	SELECT c.walletID, COUNT(c.CashbackID)
	FROM Cashback c
	GROUP BY c.walletID



-- 2.3 a

-- 2.3 b

-- 2.3 c

-- 2.3 d

-- 2.3 e
GO;
CREATE FUNCTION Account_SMS_Offers (@MobileNo char(11))
RETURNS TABLE
AS
RETURN
(
	SELECT eo.offerID, b.description, eo.SMS_offered, eo.internet_offered, eo.minutes_offered, b.validity_date 
	FROM Exclusive_Offer eo
	INNER JOIN Benefits b ON eo.benefitID = b.benefitID
	WHERE b.mobileNo = @MobileNo AND eo.SMS_offered > 0

)

-- 2.3 f
GO;
CREATE PROCEDURE Account_Payment_Points
@MobileNo char(11),
@TotalTransactions int OUTPUT,
@TotalPoints decimal(10,2) OUTPUT

AS
	BEGIN
		SELECT @TotalTransactions = COUNT(P.PaymentID) , @TotalPoints = SUM(ISNULL(PG.pointsAmount,0))
		FROM Payment P
		LEFT JOIN Points_Group PG ON P.PaymentID = PG.PaymentID
		WHERE P.mobileNo = @MobileNo AND P.date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP) AND P.status = 'accepted';

		
	END;
	DECLARE @MobileNo char(11) = '12345678901', @TotalTransactions INT, @TotalPoints DECIMAL(10,2);
	EXEC Account_Payment_Points @MobileNo, @TotalTransactions OUTPUT, @TotalPoints OUTPUT;
	PRINT 'Total number of transactions: ' + STR(@TotalTransactions, 10, 0); 
	PRINT 'Total amount of points: ' + STR(@TotalPoints, 10, 2);



-- 2.3 g

-- 2.3 h


-- 2.3 i
GO;
CREATE FUNCTION Wallet_MobileNo (@MobileNo MOBILE)
RETURNS BIT
AS
	BEGIN
		DECLARE @result BIT;
		IF EXISTS (
				SELECT mobileNo
				FROM Wallet
				WHERE mobileNo = @MobileNo
			)
			SET @result = 1;
		ELSE
			SET @result = 0;

		RETURN @result;
	END



-- 2.3 j
GO;
CREATE PROCEDURE Total_Points_Account
@MobileNo MOBILE,
@newPoints INT OUTPUT

AS
	BEGIN
		SELECT @newPoints = SUM(pointsAmount)
		FROM Point_Group pg INNER JOIN Benefit b
		ON (pg.benefitID = b.benefitID)
		WHERE mobileNo = @MobileNo;

		UPDATE Customer_Account
		SET point = @newPoints
		WHERE mobileNo = @MobileNo
	END

GO;
-- 2.4 a

-- 2.4 b

-- 2.4 c

-- 2.4 d

-- 2.4 e

-- 2.4 f


-- 2.4 g
GO;
CREATE PROCEDURE Account_Highest_Voucher
@MobileNo char(11),
@Voucher_id INT OUTPUT

AS
	BEGIN
		SELECT TOP 1 @Voucher_id = V.voucherID
		FROM Voucher V
		WHERE V.mobileNo = @MobileNo
		ORDER BY V.value DESC
	END;

	DECLARE @MobileNo char(11) = '12345678901', @Voucher_id INT;
	EXEC Account_Highest_Voucher @MobileNo, @Voucher_id OUTPUT;
	PRINT ' The voucher with the highest value is: ' + STR(@Voucher_id,10,0);



-- 2.4 h
GO;
CREATE FUNCTION Remaining_plan_amount (@MobileNo char(11), @plan_name varchar(50))
RETURNS  DECIMAL (10,1)
AS
BEGIN
	DECLARE @price INT;
	DECLARE @payment_amount DECIMAL(10,1);
	DECLARE @Remaining_amount DECIMAL(10,1);

	SELECT @price = ISNULL(sp.price,0), @payment_amount = SUM(ISNULL(p.amount,0))
	FROM Payment p
	LEFT JOIN Process_Payment pp ON p.paymentID = pp.paymentID
	LEFT JOIN Service_Plan sp ON pp.planID = sp.planID
	WHERE p.mobileNo = @MobileNo AND sp.plan_name = @plan_name;

	IF @payment_amount < @price
		SET @Remaining_amount = @price - @payment_amount;
	ELSE
		SET @Remaining_amount = 0;

	RETURN @Remaining_amount;

	END;

-- 2.4 i
GO;
CREATE FUNCTION Extra_plan_amount(@MobileNo char(11), @plan_name varchar(50))
RETURNS DECIMAL(10,1)
AS
BEGIN
	DECLARE @price INT;
	DECLARE @payment_amount DECIMAL(10,1);
	DECLARE @Extra_amount DECIMAL(10,1);

	SELECT @price = ISNULL(sp.price,0), @payment_amount = SUM(ISNULL(p.amount,0))
	FROM Payment p
	LEFT JOIN Process_Payment pp ON p.paymentID = pp.paymentID
	LEFT JOIN Service_Plan sp ON pp.planID = sp.planID
	WHERE p.mobileNo = @MobileNo AND sp.plan_name = @plan_name;

	IF @payment_amount > @price
		SET @Extra_amount = @payment_amount - @price;
	ELSE
		SET @Extra_amount = 0;
		

	RETURN @Extra_amount;

END;
-- 2.4 j

-- 2.4 k

-- 2.4 l

-- 2.4 m
GO;
CREATE PROCEDURE Payment_wallet_cashback
@MobileNo char(11),
@payment_id INT,
@benefit_id INT

AS
	BEGIN
		DECLARE @paymentAmount decimal(10,1)
		DECLARE @walletID INT
		DECLARE @cashback INT

		SELECT @paymentAmount = amount, @walletID = walletID
		FROM Payment INNER JOIN Wallet
		ON (Payment.mobileNo = Wallet.mobileNo)
		WHERE paymentID = @payment_id

		SET @cashback = 0.1 * @paymentAmount

		INSERT INTO Cashback
		VALUES(@benefit_id, @walletId, @cashback, CAST(CURRENT_TIMESTAMP AS DATE))
	END

GO;

-- 2.4 n
CREATE PROCEDURE Initiate_balance_payment
@MobileNo MOBILE,
@amount decimal(10,1),
@payment_method ALPHA

AS
	BEGIN
		INSERT INTO Payment
			VALUES (@amount, CAST(CURRENT_TIMESTAMP AS DATE), @payment_method, 'successful', @MobileNo);

		UPDATE Customer_Account
		SET balance = balance + @amount
		WHERE mobileNo = @MobileNo;
	END
GO;

-- 2.4 o
CREATE PROCEDURE Redeem_voucher_points
@MobileNo MOBILE,
@voucher_id INT

AS
	BEGIN
		DECLARE @current_points INT
		DECLARE @points INT
		DECLARE @expiry_date DATE

		-- Check expiry date of the voucher
		SELECT @expiry_date = expiry_date
		FROM Voucher
		WHERE voucherID = @voucher_id

		-- If voucher not expired, then continue
		IF @expiry_date > CAST(CURRENT_TIMESTAMP AS DATE)
		BEGIN
			-- Getting the user's current points
			SELECT @current_points = point
			FROM Customer_Account
			WHERE mobileNo = @MobileNO;

			-- Getting the amount of points needed to redeem the voucher in question
			SELECT @points = points
			FROM Voucher
			WHERE voucherID = @voucher_id
			
			-- Checking whether the points the user has are enough to redeem the voucher, if so continue
			IF @current_points >= @points
			BEGIN
				-- Deducting the points needed to redeem the voucher from the user points
				UPDATE Customer_Account
				SET point = @current_points - @points
				WHERE mobileNo = @MobileNO;

				-- Update the redemption date of the voucher in question to the date of the execution of the code
				UPDATE Voucher
				SET redeem_date = CAST(CURRENT_TIMESTAMP AS DATE)
			END
		END
	END

GO;