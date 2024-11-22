-- 2.1 a
CREATE DATABASE Telecom_Team_9;

GO

-- Custom datatypes from guidelines
CREATE TYPE ALPHA  
FROM VARCHAR(50);

CREATE TYPE MOBILE
FROM CHAR(11);

GO

-- 2.1 b
CREATE PROCEDURE createAllTables
AS
	BEGIN
		CREATE TABLE Customer_profile (
			nationalID INT,
			first_name ALPHA,
			last_name ALPHA,
			email ALPHA,
			address ALPHA,
			date_of_birth DATE,
			PRIMARY KEY(nationalID)
		);

		CREATE TABLE Customer_Account (
			mobileNo MOBILE,
			pass ALPHA,
			balance DECIMAL(10,1),
			account_type ALPHA,
			start_date DATE,
			status ALPHA,
			point INT DEFAULT 0,
			nationalID INT,
			PRIMARY KEY (mobileNo),
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID),
			
			CONSTRAINT Account_Type CHECK (account_type IN ('Post Paid', 'Prepaid', 'Pay_as_you_go')),
			CONSTRAINT Customer_Account_Status_Type CHECK (status IN ('active', 'onhold'))
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

		CREATE TABLE Subscription(
			mobileNo MOBILE,
			planID INT,
			subscription_date DATE,
			status ALPHA,
			PRIMARY KEY (mobileNo,planID),
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID),

			CONSTRAINT Subscription_Status_Type CHECK (status IN ('active', 'onhold'))
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
			PRIMARY KEY (usageID),
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
		);
    
		CREATE TABLE Payment(
			paymentID INT IDENTITY(1,1), 
			amount decimal(10,1),
			date_of_payment DATE,
			payment_method ALPHA,
			status ALPHA,
			mobileNo MOBILE,
			PRIMARY KEY (paymentID),
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),

			CONSTRAINT Payment_Status_type CHECK (status IN ('successful', 'pending', 'rejected')),
			CONSTRAINT Payment_Type CHECK (payment_method IN ('cash', 'credit'))
		);
		
		CREATE TABLE Process_Payment(
			paymentID INT,
			planID INT,
			remaining_balance DECIMAL(10,1),
			extra_amount DECIMAL(10,1),
			PRIMARY KEY(paymentID),
			FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
		);

		CREATE TABLE Wallet (
			walletID INT IDENTITY(1,1),
			current_balance DECIMAL(10,2),
			currency ALPHA,
			last_modified_date DATE,
			nationalID INT,
			mobileNo MOBILE,
			PRIMARY KEY(walletID),
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID)
		);

		CREATE TABLE Transfer_money(
			walletID1 INT,
			walletID2 INT,
			transfer_id INT IDENTITY(1,1),
			amount DECIMAL(10,2),
			transfer_date DATE,
			PRIMARY KEY (walletID1, walletID2, transfer_id),
			FOREIGN KEY (walletID1) REFERENCES Wallet(walletID),
			FOREIGN KEY (walletID2) REFERENCES Wallet(walletID)
		);

		CREATE TABLE Benefits(
			benefitID INT IDENTITY(1,1),
			description ALPHA,
			validity_date DATE,
			status ALPHA,
			mobileNo MOBILE,
			PRIMARY KEY (benefitID),
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),

			CONSTRAINT Benefits_Status_Type CHECK (status IN ('active', 'expired'))
		);

		CREATE TABLE Points_Group (
			pointID INT IDENTITY(1,1),
			benefitID INT, 
			pointsAmount INT,
			PaymentID INT,
			PRIMARY KEY(pointID, benefitID),
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
			FOREIGN KEY (PaymentID) REFERENCES Payment(paymentID)
		);

		CREATE TABLE Exclusive_Offer (		
			offerID INT IDENTITY(1,1),
			benefitID INT,
			internet_offered INT,
			SMS_offered INT,
			minutes_offered INT,
			PRIMARY KEY(offerID, benefitID),
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
		);

		CREATE TABLE Cashback (
			CashbackID INT IDENTITY(1,1),
			benefitID INT,
			walletID INT,
			amount INT,
			credit_date DATE,
			PRIMARY KEY (CashbackID, benefitID),
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
			FOREIGN KEY (walletID) REFERENCES Wallet(walletID)
		);

		CREATE TABLE Plan_Provides_Benefits (
			benefitID INT,
			planID INT,
			PRIMARY KEY (benefitID, planID),
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
		);

		CREATE TABLE Shop(
			shopID INT IDENTITY(1,1),
			name ALPHA,
			category ALPHA,
			PRIMARY KEY (shopID)
		);

		CREATE TABLE Physical_Shop (
			shopID INT,
			address ALPHA,
			working_hours ALPHA,
			PRIMARY KEY (shopID),
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
		);

		CREATE TABLE E_shop (
			shopID INT,
			URL ALPHA,
			rating INT,
			PRIMARY KEY (shopID),
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
		);

		CREATE TABLE Voucher(
			voucherID INT IDENTITY(1,1),
			value INT,
			expiry_date DATE,
			points INT,
			mobileNo MOBILE,
			shopID INT,
			redeem_date DATE,
			PRIMARY KEY (voucherID),
			FOREIGN KEY (shopID) REFERENCES Shop(shopID),
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
		);

		CREATE TABLE Technical_Support_Ticket(
			ticketID INT IDENTITY(1,1),
			mobileNo MOBILE,
			Issue_description ALPHA,
			priority_level INT,
			status ALPHA,
			PRIMARY KEY (ticketID),
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),

			CONSTRAINT TST_Status_Type CHECK (status IN ('Open', 'In Progress', 'Resolved'))
		);
	END

GO

-- 2.1 c
Create Procedure dropAllTables
AS
	-- Update this to drop from sub to parent
	BEGIN
		DROP TABLE Physical_Shop;

		DROP TABLE E_shop;

		DROP TABLE Voucher;

		DROP TABLE Shop;

		DROP TABLE Technical_Support_Ticket;

		DROP TABLE Plan_Provides_Benefits;
		
		DROP TABLE Cashback;

		DROP TABLE Points_Group;

		DROP TABLE Exclusive_Offer;

		DROP TABLE Benefits;

		DROP TABLE Transfer_money;

		DROP TABLE Wallet;

		DROP TABLE Process_Payment;

		DROP TABLE Payment;

		DROP TABLE Plan_Usage;

		DROP TABLE Subscription;

		DROP TABLE Service_Plan;

		DROP TABLE Customer_Account;

		DROP TABLE Customer_profile;

	END

GO

-- 2.1 d
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

GO

-- 2.1 e
Create Procedure clearAllTables
AS
	BEGIN
		DELETE FROM Physical_Shop;

		DELETE FROM E_shop;

		DELETE FROM Voucher;

		DELETE FROM Shop;

		DELETE FROM Technical_Support_Ticket;

		DELETE FROM Plan_Provides_Benefits;

		DELETE FROM Cashback;

		DELETE FROM Points_Group;

		DELETE FROM Exclusive_Offer;

		DELETE FROM Benefits;

		DELETE FROM Transfer_money;

		DELETE FROM Wallet;

		DELETE FROM Process_Payment;

		DELETE FROM Payment;

		DELETE FROM Plan_Usage;

		DELETE FROM Subscription;

		DELETE FROM Service_Plan;

		DELETE FROM Customer_Account;

		DELETE FROM Customer_profile;
	END

GO

-- 2.2 a
Create View allCustomerAccounts AS
	SELECT p.first_name, p.last_name, p.email, p.address, p.date_of_birth, a.*
	FROM Customer_profile p INNER JOIN Customer_Account a 
	ON p.nationalID = a.nationalID
	WHERE a.status = 'active';

GO

-- 2.2 b
Create View allServicePlans AS
	SELECT *
	FROM Service_Plan;

GO

-- 2.2 c
Create View allBenefits AS
	SELECT * 
	FROM Benefits B
	WHERE B.status = 'active'

GO

-- 2.2 d
Create View AccountPayments AS
	SELECT P.paymentID, P.amount, P.date_of_payment, P.payment_method, P.status AS 'Payment status', C.*
	FROM Payment P INNER JOIN Customer_Account C ON (P.mobileNo = C.mobileNo)
GO

-- 2.2 e
CREATE VIEW allShops AS
	SELECT s.*
	FROM Shop S

GO

-- 2.2 f
CREATE VIEW allResolvedTickets AS
	SELECT *
	FROM Technical_Support_Ticket
	WHERE status = 'resolved';

GO

-- 2.2 g
CREATE VIEW CustomerWallet AS
	SELECT w.*, c.first_name, c.last_name
	FROM Wallet w
	INNER JOIN Customer_profile c ON (w.nationalID = c.nationalID);

GO

-- 2.2 h
CREATE VIEW E_shopVouchers AS
	SELECT s.*, e.URL, e.rating, v.voucherID, v.value
	FROM Shop s
	INNER JOIN E_shop e ON (s.shopID = e.shopID)
	LEFT OUTER JOIN Voucher v ON(e.shopID = v.shopID);

GO

-- 2.2 i
CREATE VIEW PhysicalStoreVouchers AS
	SELECT s.*, ps.address, ps.working_hours, v.voucherID, v.value
	FROM Shop s
	INNER JOIN Physical_Shop ps ON (s.shopID = ps.shopID)
	INNER JOIN Voucher v ON (ps.shopID = v.shopID)
	WHERE v.redeem_date IS NOT NULL;

GO

-- 2.2 j
CREATE VIEW Num_of_cashback AS
	SELECT c.walletID, COUNT(c.CashbackID)
	FROM Cashback c
	GROUP BY c.walletID;

GO

-- 2.3 a
CREATE PROCEDURE Account_Plan
AS
	BEGIN
		SELECT C.*, P.*
		FROM Customer_Account C, Subscription S, Service_Plan P
		WHERE C.mobileNo = S.mobileNo AND S.planID = P.planID
	END
GO

-- 2.3 b
CREATE FUNCTION Account_Plan_date (@Subscription_Date date, @Plan_id int)
RETURNS TABLE 
AS
	RETURN (
		SELECT C.*
		FROM Customer_Account C, Subscription S
		WHERE C.mobileNo = S.mobileNo AND S.planID = @Plan_id AND S.subscription_date = @Subscription_Date
	)

GO

-- 2.3 c
CREATE FUNCTION Account_Usage_Plan (@MobileNo MOBILE, @from_date date)
RETURNS TABLE
AS
	RETURN (
		SELECT P.planID, SUM(P.data_consumption) total_data_consumed, SUM(P.minutes_used) total_minutes_used, SUM(P.SMS_sent) total_SMS
		FROM Plan_Usage P
		WHERE P.mobileNO = @MobileNo AND P.start_date >= @from_date
		GROUP BY P.planID
	)

GO

-- 2.3 d
CREATE PROCEDURE Benefits_Account
@MobileNo MOBILE,
@planID INT
AS
	BEGIN
		DELETE PG FROM Points_Group PG
		INNER JOIN Benefits B ON (B.benefitID = PG.benefitID)
		INNER JOIN Subscription S ON (B.mobileNo = S.mobileNo)
		WHERE S.planID = @planID AND B.mobileNo = @MobileNo

		DELETE C FROM Cashback C
		INNER JOIN Benefits B ON (B.benefitID = C.benefitID)
		INNER JOIN Subscription S ON (B.mobileNo = S.mobileNo)
		WHERE S.planID = @planID AND B.mobileNo = @MobileNo

		DELETE EO FROM Exclusive_Offer EO
		INNER JOIN Benefits B ON (B.benefitID = EO.benefitID)
		INNER JOIN Subscription S ON (B.mobileNo = S.mobileNo)
		WHERE S.planID = @planID AND B.mobileNo = @MobileNo

		DELETE PPB FROM Plan_Provides_Benefits PPB
		INNER JOIN Benefits B ON (B.benefitID = PPB.benefitID)
		INNER JOIN Subscription S ON (B.mobileNo = S.mobileNo)
		WHERE S.planID = @planID AND B.mobileNo = @MobileNo

		DELETE B FROM Benefits B
		INNER JOIN Subscription S ON (B.mobileNo = S.mobileNo)
		WHERE S.planID = @planID AND B.mobileNo = @MobileNo

		SELECT B.*
		FROM Benefits B
		WHERE B.mobileNo = @MobileNo
	END

GO

-- 2.3 e
CREATE FUNCTION Account_SMS_Offers (@MobileNo MOBILE)
RETURNS TABLE
AS
	RETURN
	(
		SELECT eo.*
		FROM Exclusive_Offer eo
		INNER JOIN Benefits b ON eo.benefitID = b.benefitID
		WHERE b.mobileNo = @MobileNo AND eo.SMS_offered > 0
	);

GO

-- 2.3 f
CREATE PROCEDURE Account_Payment_Points
@MobileNo MOBILE,
@TotalTransactions INT OUTPUT,
@TotalPoints DECIMAL(10,2) OUTPUT

AS
	BEGIN
		SELECT @TotalTransactions = COUNT(P.PaymentID) , @TotalPoints = SUM(ISNULL(PG.pointsAmount,0))
		FROM Payment P
		LEFT JOIN Points_Group PG ON P.PaymentID = PG.PaymentID
		-- # check the validity of the comparison betweeen DATETIME and DATE data types.
		WHERE P.mobileNo = @MobileNo AND P.date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP) AND P.status = 'successful';
	END

	-- Testing
	/*DECLARE @MobileNo MOBILE = '12345678901', @TotalTransactions INT, @TotalPoints DECIMAL(10,2);
	EXEC Account_Payment_Points @MobileNo, @TotalTransactions OUTPUT, @TotalPoints OUTPUT;
	PRINT 'Total number of transactions: ' + STR(@TotalTransactions, 10, 0); 
	PRINT 'Total amount of points: ' + STR(@TotalPoints, 10, 2);*/

GO

-- 2.3 g
CREATE FUNCTION Wallet_Cashback_Amount (@WalletId INT, @planId INT)
RETURNS INT
AS
	BEGIN
		DECLARE @cashback INT
		SELECT @cashback = c.amount
		FROM Cashback c
		INNER JOIN Plan_Provides_Benefits ppb ON (ppb.benefitID = c.benefitID)
		WHERE ppb.planID = @planId AND c.walletID = @WalletId;

		RETURN @cashback
	END

GO

-- 2.3 h
CREATE FUNCTION Wallet_Transfer_Amount (@Wallet_id INT, @start_date DATE, @end_date DATE)
RETURNS DECIMAL(10,2)
AS
	BEGIN
		DECLARE @TransactionAmountAverage DECIMAL(10,2)
		
		SELECT @TransactionAmountAverage = AVG(t.amount)
		FROM Transfer_money t
		WHERE t.walletID1 = @Wallet_id AND (t.transfer_date BETWEEN @start_date AND @end_date)

		RETURN @TransactionAmountAverage
	END

GO

-- 2.3 i
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

GO

-- 2.3 j
CREATE PROCEDURE Total_Points_Account
@MobileNo MOBILE,
@newPoints INT OUTPUT

AS
	BEGIN
		SELECT @newPoints = SUM(pointsAmount)
		FROM Point_Group pg INNER JOIN Benefit b
		ON (pg.benefitID = b.benefitID)
		-- Checking for validity of points group, and considering it not used.
		WHERE b.mobileNo = @MobileNo AND b.validity_date >= CURRENT_TIMESTAMP;

		UPDATE Customer_Account
		SET point = @newPoints
		WHERE mobileNo = @MobileNo;
	END

GO

-- 2.4 a
CREATE FUNCTION AccountLoginValidation (@MobileNo MOBILE, @password ALPHA)
RETURNS BIT
AS
	BEGIN
	DECLARE @OUT_BIT BIT
	IF EXISTS(
			SELECT *
			FROM Customer_Account
			WHERE pass = @password AND mobileNo = @MobileNo
		)
		SET @OUT_BIT = 1;
	ELSE
		SET @OUT_BIT = 0;
	RETURN @OUT_BIT
	END
GO

-- 2.4 b
CREATE FUNCTION Consumption (@Plan_name ALPHA, @start_date date, @end_date date)
RETURNS TABLE
AS
	RETURN (
		SELECT SUM(O.data_consumption) AS 'Data consumption', SUM(O.minutes_used) AS 'Minutes used', SUM(O.SMS_sent) AS 'SMS sent'
		FROM (
			(
				SELECT U.data_consumption, U.minutes_used, U.SMS_sent
				FROM Plan_Usage U, Service_Plan P
				WHERE P.name = @Plan_name AND P.planID = U.planID AND U.start_date >= @start_date
			)
			EXCEPT
			(
				SELECT U.data_consumption, U.minutes_used, U.SMS_sent
				FROM Plan_Usage U, Service_Plan P
				WHERE P.name = @Plan_name AND P.planID = U.planID AND U.end_date <= @end_date
			)
		) AS O
	)
GO

-- 2.4 c
CREATE PROCEDURE Unsubscribed_Plans
@MobileNo MOBILE
AS
	BEGIN
		(
			SELECT P.*
			FROM Service_Plan P
		)
		EXCEPT
		(
			SELECT P.*
			FROM Service_Plan P, Subscription S
			WHERE P.PlanID = S.PlanID AND S.mobileNo = @MobileNo
		)
	END

GO

-- 2.4 d
CREATE FUNCTION Usage_Plan_CurrentMonth(@MobileNo MOBILE)
RETURNS TABLE
AS
	RETURN	(
				SELECT P.*
				FROM Plan_Usage P INNER JOIN Subscription S ON (P.planID = S.planID)
				-- plan usage records the usasge of a plan periodically not overall, with ~one-month period.
				WHERE S.mobileNo = @MobileNo AND S.status = 'active' AND MONTH(CURRENT_TIMESTAMP) = MONTH(P.start_date)
			)

GO

-- 2.4 e
CREATE FUNCTION Cashback_Wallet_Customer (@NationalID int)
RETURNS TABLE
AS
	RETURN	(
				SELECT C.*
				FROM Cashback C INNER JOIN Wallet W ON (W.walletID = C.walletID)
				WHERE W.nationalID = @NationalID
			)

GO

-- 2.4 f
CREATE PROCEDURE Ticket_Account_Customer
@NationalID INT,
@unresolved INT OUTPUT
AS
	BEGIN
		SELECT @unresolved = COUNT(*) 
		FROM Technical_Support_Ticket T INNER JOIN Customer_Account C ON (T.mobileNo = C.mobileNo)
		WHERE T.status <> 'Resolved' AND C.nationalID = @NationalID
		GROUP BY C.mobileNo
	END

GO

-- 2.4 g
CREATE PROCEDURE Account_Highest_Voucher
@MobileNo MOBILE,
@Voucher_id INT OUTPUT

AS
	BEGIN
		SELECT TOP 1 @Voucher_id = V.voucherID
		FROM Voucher V
		WHERE V.mobileNo = @MobileNo
		ORDER BY V.value DESC
	END;

	-- Testing
	/*DECLARE @MobileNo MOBILE = '12345678901', @Voucher_id INT;
	EXEC Account_Highest_Voucher @MobileNo, @Voucher_id OUTPUT;
	PRINT 'The voucher with the highest value is: ' + STR(@Voucher_id,10,0);*/

GO

-- 2.4 h
CREATE FUNCTION Remaining_plan_amount (@MobileNo MOBILE, @plan_name ALPHA)
RETURNS DECIMAL (10,1)
AS
	BEGIN
		DECLARE @price INT;
		DECLARE @payment_amount DECIMAL(10,1);
		DECLARE @Remaining_amount DECIMAL(10,1);

		SELECT @price = ISNULL(sp.price,0), @payment_amount = ISNULL(p.amount,0)
		FROM Payment p
		LEFT JOIN Process_Payment pp ON p.paymentID = pp.paymentID
		LEFT JOIN Service_Plan sp ON pp.planID = sp.planID
		WHERE p.mobileNo = @MobileNo AND sp.name = @plan_name;

		IF @payment_amount < @price
			SET @Remaining_amount = @price - @payment_amount;
		ELSE
			SET @Remaining_amount = 0;

		RETURN @Remaining_amount;
	END

GO

-- 2.4 i
CREATE FUNCTION Extra_plan_amount(@MobileNo MOBILE, @plan_name ALPHA)
RETURNS DECIMAL(10,1)
AS
	BEGIN
		DECLARE @price INT;
		DECLARE @payment_amount DECIMAL(10,1);
		DECLARE @Extra_amount DECIMAL(10,1);

		SELECT @price = ISNULL(sp.price,0), @payment_amount = ISNULL(p.amount,0)
		FROM Payment p
		LEFT JOIN Process_Payment pp ON p.paymentID = pp.paymentID
		LEFT JOIN Service_Plan sp ON pp.planID = sp.planID
		WHERE p.mobileNo = @MobileNo AND sp.name = @plan_name;

		IF @payment_amount > @price
			SET @Extra_amount = @payment_amount - @price;
		ELSE
			SET @Extra_amount = 0;
		

		RETURN @Extra_amount;
	END

GO

-- 2.4 j
CREATE PROCEDURE Subscribed_plans_5_Months
@MobileNo MOBILE
AS
	BEGIN
		SELECT TOP 10 P.*
		FROM Payment P
		WHERE mobileNo = @MobileNo AND status = 'successful'
		ORDER BY P.amount DESC;
	END

GO

-- 2.4 k
CREATE FUNCTION Subscribed_plans_5_Months (@MobileNo MOBILE)
RETURNS TABLE
AS
	RETURN (
			SELECT SP.*
			FROM Service_Plan SP
			INNER JOIN Subscription S ON (SP.planID = S.planID)
			WHERE S.mobileNo = @MobileNo AND subscription_date >= DATEADD(MONTH, -5, CURRENT_TIMESTAMP)
		)

GO

-- 2.4 l
CREATE PROCEDURE Initiate_plan_payment
@MobileNo MOBILE,
@amount DECIMAL(10,1),
@payment_method ALPHA,
@plan_id INT
AS
	BEGIN
		INSERT INTO Payment
		VALUES (@amount, CAST(CURRENT_TIMESTAMP AS DATE), @payment_method, 'successful', @MobileNo);

		UPDATE Subscription
		SET status = 'active'
		WHERE mobileNo = @MobileNo AND planID = @plan_id;
	END

GO

-- 2.4 m
CREATE PROCEDURE Payment_wallet_cashback
@MobileNo MOBILE,
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

GO

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

GO

-- 2.4 o
CREATE PROCEDURE Redeem_voucher_points
@MobileNo MOBILE,
@voucher_id INT

AS
	BEGIN
		DECLARE @has_voucher BIT
		DECLARE @current_points INT
		DECLARE @points INT
		DECLARE @expiry_date DATE

		-- Checking whether the user has the voucher in question
		IF EXISTS (
			SELECT voucherID, mobileNo
			FROM Voucher
			WHERE voucherID = @voucher_id AND mobileNo = @MobileNo
		)
		BEGIN
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
			-- # possible printing error message
			-- $ sure
		END
		-- # possible printing error message
	END

GO

-- Extra: Roles

CREATE ROLE Admin;
CREATE ROLE Customer;

-- Extra: Granting execution of admin functions and procedures to role Admin
GRANT EXECUTE ON dbo.Account_Plan TO Admin;
GRANT EXECUTE ON dbo.Account_Plan_date TO Admin;
GRANT EXECUTE ON dbo.Account_Usage_Plan TO Admin;
GRANT EXECUTE ON dbo.Benefits_Account TO Admin;
GRANT EXECUTE ON dbo.Account_SMS_Offers TO Admin;
GRANT EXECUTE ON dbo.Account_Payment_Points TO Admin;
GRANT EXECUTE ON dbo.Wallet_Cashback_Amount TO Admin;
GRANT EXECUTE ON dbo.Wallet_Transfer_Amount TO Admin;
GRANT EXECUTE ON dbo.Wallet_MobileNo TO Admin;
GRANT EXECUTE ON dbo.Total_Points_Account TO Admin;

-- Extra: Granting execution of customer functions and procdure to the role Customer
GRANT EXECUTE ON dbo.AccountLoginValidation TO Customer;
GRANT EXECUTE ON dbo.Consumption TO Customer;
GRANT EXECUTE ON dbo.Unsubscribed_Plans TO Customer;
GRANT EXECUTE ON dbo.Usage_Plan_CurrentMonth TO Customer;
GRANT EXECUTE ON dbo.Cashback_Wallet_Customer TO Customer;
GRANT EXECUTE ON dbo.Ticket_Account_Customer TO Customer;
GRANT EXECUTE ON dbo.Account_Highest_Voucher TO Customer;
GRANT EXECUTE ON dbo.Remaining_plan_amount TO Customer;
GRANT EXECUTE ON dbo.Extra_plan_amount TO Customer;
GRANT EXECUTE ON dbo.Top_Successful_Payments TO Customer;
GRANT EXECUTE ON dbo.Subscribed_plans_5_Months TO Customer;
GRANT EXECUTE ON dbo.Initiate_plan_payment TO Customer;
GRANT EXECUTE ON dbo.Payment_wallet_cashback TO Customer;
GRANT EXECUTE ON dbo.Initiate_balance_payment TO Customer;
GRANT EXECUTE ON dbo.Redeem_voucher_points TO Customer;

/*
	This ia a line to make the project 1010 loc (Shoutout Ahmed Hamdy)
*/