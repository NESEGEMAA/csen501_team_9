CREATE DATABASE Telecom_Team_9;

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

		DELETE FROM E_shop;

		DELETE FROM	Voucher;

		DELETE FROM Technical_Support_Ticket;

	END

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

		DROP TABLE E_shop;

		DROP TABLE	Voucher;

		DROP TABLE Technical_Support_Ticket;

	END

GO;

Create Procedure dropAllProceduresFunctionsViews

AS

	BEGIN
			DROP PROCEDURE
				dropAllTables,
				clearAllTables,
				createAllTables;
	END
