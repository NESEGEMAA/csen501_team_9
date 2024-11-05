CREATE DATABASE Telecom_Team_9;

GO;

CREATE TYPE ALPHA  
FROM varchar(50);

CREATE TYPE STATUS  
FROM varchar(50);

CREATE TYPE MOBILE  
FROM char(11);

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