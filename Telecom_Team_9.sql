CREATE DATABASE Telecom_Team_9;

GO;

CREATE TYPE ALPHA  
FROM varchar(50);

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
			PRIMARY KEY (mobileNo),
			FOREIGN KEY (nationalID) REFERENCES Customer_Profile(nationalID)
		);

	END