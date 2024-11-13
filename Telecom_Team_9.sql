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

GO;

-- 2.1 b
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
			point INT,
			PRIMARY KEY (mobileNo) ,
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID)
			ON DELETE CASCADE
			ON UPDATE  CASCADE
		);

		CREATE TABLE Service_Plan(
			planID int ,
			SMS_offered int,
			minutes_offered int,
			data_offered int,
			name VARCHAR(10),
			price int,
			description ALPHA,
			PRIMARY KEY(planID)
		);

		CREATE TABLE Subscribtion(
			mobileNo char(11) ,
			planID int,
			subscribtion_date date,
			status ALPHA,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (mobileNo,planID)
		);

		CREATE TABLE Plan_Usage(
			usageID int,
			start_date date,
			end_date date,
			consumption int,
			minutes_used int,
			SMS_sent int ,
			mobileNo MOBILE,
			planID int , 
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (usageID)
		);
    
		CREATE TABLE Payment(
			paymentID int , 
			amount decimal(10,1),
			date_of_payment date,
			payment_method ALPHA ,
			status STATUS,
			mobileNo MOBILE,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (paymentID)
		)
		
		CREATE TABLE Process_Payment(
			paymentID int ,
			planID int ,
			remaining_balance decimal(10,1),
			extra_amount decimal(10,1),
			FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,

		);
		CREATE TABLE Wallet (
			walletID int ,
			current_balance decimal(10,2),
			currency ALPHA,
			last_modified_date date ,
			nationalID int ,
			mobileNo  MOBILE ,
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY(walltID)
		);

		CREATE TABLE Transfer_Money(
			walletID1 int ,
			walletID2 int ,
			transfer_id int,
			amount decimal(10,2),
			transfer_date date,
			FOREIGN KEY (walletID1) REFERENCES Wallet(walletID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (walletID2) REFERENCES Wallet(walletID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (walletID1 , walletID2 , transfer_id)
		);
		CREATE TABLE Benifits(
			benefitID int ,
			description ALPHA ,
			vaidity_date date,
			status STATUS ,
			mobileNo MOBILE,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (benefitID)
		);

		CREATE TABLE Point_Group (
			pointID int ,
			benefitID int , 
			pointsAmount int ,
			PaymentID int ,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (PaymentID) REFERENCES Payment(paymentID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY(pointsID , benefitID)
		);

		CREATE TABLE Exclusive_Offer(		
			offerID int ,
			benefitID int ,
			internet_offered int ,
			SMS_offered int ,
			minutes_offered int ,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY(offerID , benefitID)
		);

		CREATE TABLE Cashback (
			CashbackID int ,
			benefitID int ,
			walletID int ,
			amount int ,
			credit_date date ,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (walletID) REFERENCES Wallet(walletID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (CashbackID , benefitID , walletID)
		);

		CREATE TABLE Plan_Provides_Benefits (
			benefitID int ,
			planID int ,
			FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (benefitID , planID)
		);

		CREATE TABLE Shop(
			shopID int ,
			name ALPHA ,
			category ALPHA ,
			PRIMARY KEY (shopID)
		);

		CREATE TABLE Physical_Shop (
			shopID int ,
			address ALPHA ,
			working_hours ALPHA,
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (shopID),
		)
		CREATE TABLE E_Shop (
			shopID int ,
			URL ALPHA ,
			rating ALPHA,
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (shopID),
		);

		CREATE TABLE VOUCHER(
			voucherID int ,
			value int ,
			expiry_date date ,
			points int ,
			mobileNo MOBILE ,
			shopID int,
			redeem_date date ,
			FOREIGN KEY (shopID) REFERENCES Shop(shopID)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (voucherID)
		)

		CREATE TABLE Technical_Support_Ticket(
			ticketID int ,
			mobileNo MOBILE ,
			issue_description ALPHA ,
			priority_level int ,
			status STATUS ,
			FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
				ON DELETE CASCADE
				ON UPDATE  CASCADE,
			PRIMARY KEY (ticketID)
		)
	END

GO;

-- 2.1 c
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

		DROP TABLE E_shop;

		DROP TABLE	Voucher;

		DROP TABLE Technical_Support_Ticket;

	END

GO;

-- 2.1 d
Create Procedure dropAllProceduresFunctionsViews

AS

	BEGIN
			DROP PROCEDURE
				dropAllTables,
				clearAllTables,
				createAllTables;
	END

GO;

-- 2.1 e
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

		DELETE FROM E_shop;

		DELETE FROM	Voucher;

		DELETE FROM Technical_Support_Ticket;

	END

GO;

-- 2.2 a
Create View allCustomerAccounts AS
	SELECT *
	FROM Customer_profile p INNER JOIN Customer_Account a 
	ON p.nationalID = a.nationalID;

GO;

-- 2.2 b
Create View allServicePlans AS
	SELECT *
	FROM Service_Plan

-- 2.2 c

-- 2.2 d
GO;

-- 2.2 e
CREATE VIEW AllShops AS
SELECT *
FROM Shop S LEFT JOIN Physical_Shop PS ON S.shopID = PS.shopID LEFT JOIN E_shop ON S.shopID = ES.shopID;

GO;

-- 2.2 f
CREATE VIEW allResolvedTickets AS
SELECT *
FROM Technical_Support_Ticket
WHERE status = 'resolved';

GO;

-- 2.2 g

-- 2.2 h
GO;

-- 2.2 i
CREATE VIEW PhysicalStoreVouchers AS
	SELECT ps.shopID, ps.name, v.voucherID, v.value
	FROM Physical_Shop INNER JOIN Voucher v
	ON (ps.shopID = v.shopID)
GO;

-- 2.2 j
CREATE VIEW Num_of_cashback AS
	SELECT c.walletID, COUNT(c.CashbackID)
	FROM Cashback c
	GROUP BY c.walletID

GO;

-- 2.3 a

-- 2.3 b

-- 2.3 c

-- 2.3 d

-- 2.3 e
GO;

-- 2.3 f
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

GO;

-- 2.3 g

-- 2.3 h

-- 2.3 i

-- 2.3 j

-- 2.4 a

-- 2.4 b

-- 2.4 c

-- 2.4 d

-- 2.4 e

-- 2.4 f
GO;

-- 2.4 g
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

GO;

-- 2.4 h

-- 2.4 i

-- 2.4 j

-- 2.4 k

-- 2.4 l

-- 2.4 m

-- 2.4 n

-- 2.4 o
