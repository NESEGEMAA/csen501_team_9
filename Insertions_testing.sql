-- Dummy Data for Customer_Profile
INSERT INTO Customer_profile (nationalID, first_name, last_name, email, address, date_of_birth) 
VALUES 
(1001, 'John', 'Doe', 'john.doe@example.com', '123 Main St', '1985-05-12'),
(1002, 'Jane', 'Smith', 'jane.smith@example.com', '456 Oak St', '1990-07-18');

-- Dummy Data for Customer_Account
INSERT INTO Customer_Account (mobileNo, pass, balance, account_type, start_date, status, point, nationalID) 
VALUES 
(1234567890, 'pass123', 100.0, 'Prepaid', '2023-01-01', 'active', 10, 1001),
(9876543210, 'pass456', 50.5, 'Post Paid', '2023-06-01', 'onhold', 5, 1002);

-- Dummy Data for Service_Plan
INSERT INTO Service_Plan (SMS_offered, minutes_offered, data_offered, name, price, description) 
VALUES 
(100, 200, 2, 'Basic', 10, 'Basic Plan'),
(200, 500, 5, 'Premium', 20, 'Premium Plan');

-- Dummy Data for Subscription
INSERT INTO Subscription (mobileNo, planID, subscription_date, status) 
VALUES 
(1234567890, 1, '2024-07-01', 'active'),
(9876543210, 2, '2023-07-01', 'onhold');

-- Dummy Data for Plan_Usage
INSERT INTO Plan_Usage (start_date, end_date, data_consumption, minutes_used, SMS_sent, mobileNo, planID) 
VALUES 
('2007-11-01', '2027-11-01', 1, 50, 20, 1234567890, 1),
('2024-11-01', '2024-12-01', 1, 50, 20, 1234567890, 1),
('2023-07-01', '2023-08-01', 3, 100, 50, 9876543210, 2),
('2023-08-01', '2023-09-01', 3, 100, 50, 9876543210, 2);

-- Dummy Data for Payment
INSERT INTO Payment (amount, date_of_payment, payment_method, status, mobileNo) 
VALUES 
(10.0, '2024-11-22', 'cash', 'successful', 1234567890),
(20.5, '2023-07-15', 'credit', 'pending', 9876543210);

-- Dummy Data for Process_Payment
INSERT INTO Process_Payment (paymentID, planID, remaining_balance, extra_amount) 
VALUES 
(1, 1, 90.0, 0.0),
(2, 2, 30.0, 10.5);

-- Dummy Data for Wallet
INSERT INTO Wallet (current_balance, currency, last_modified_date, nationalID, mobileNo) 
VALUES 
(50.0, 'USD', '2023-02-20', 1001, 1234567890),
(100.0, 'USD', '2023-07-20', 1002, 9876543210);

-- Dummy Data for Transfer_money
INSERT INTO Transfer_money (walletID1, walletID2, amount, transfer_date) 
VALUES 
(1, 2, 10.0, '2023-02-25'),
(2, 1, 15.0, '2023-07-25');

-- Dummy Data for Benefits
INSERT INTO Benefits (description, validity_date, status, mobileNo) 
VALUES
('Points', '2027-11-22', 'active', 1234567890),
('Free Data', '2027-11-22', 'active', 1234567890),
('Discount on calls', '2027-11-22', 'expired', 9876543210),
('Ha5a', '2027-01-16', 'active', 9876543210);

-- Dummy Data for Points_Group
INSERT INTO Points_Group (benefitID, pointsAmount, PaymentID) 
VALUES 
(1, 100, 1),
(2, 200, 2),
(4, 200, 1);

-- Dummy Data for Exclusive_Offer
INSERT INTO Exclusive_Offer (benefitID, internet_offered, SMS_offered, minutes_offered) 
VALUES 
(1, 5, 50, 100),
(2, 10, 100, 200);

-- Dummy Data for Cashback
INSERT INTO Cashback (benefitID, walletID, amount, credit_date) 
VALUES 
(1, 1, 10.0, '2023-02-28'),
(2, 2, 15.0, '2023-07-28');

-- Dummy Data for Plan_Provides_Benefits
INSERT INTO Plan_Provides_Benefits (benefitID, planID) 
VALUES 
(1, 1),
(2, 2);

-- Dummy Data for Shop
INSERT INTO Shop (name, category) 
VALUES 
('Tech Store', 'Electronics'),
('Book Haven', 'Books'),
('Hamada Tech', 'Ha5atronics');

-- Dummy Data for Physical_Shop
INSERT INTO Physical_Shop (shopID, address, working_hours) 
VALUES 
(1, '789 Tech Ave', '9 AM - 9 PM'),
(2, '321 Book St', '10 AM - 8 PM');

-- Dummy Data for E_shop
INSERT INTO E_shop (shopID, URL, rating) 
VALUES 
(1, 'www.techstore.com', 4),
(2, 'www.bookhaven.com', 5),
(3, 'www.hamadatech.com', 5);

-- Dummy Data for Voucher
INSERT INTO Voucher (value, expiry_date, points, mobileNo, shopID, redeem_date) 
VALUES 
(10, '2027-12-31', 10, 1234567890, 1, NULL),
(10, '2023-12-31', 10, 1234567890, 1, '2023-11-01'),
(10, '2024-01-31', 20, 9876543210, 2, '2024-01-01');

-- Dummy Data for Technical_Support_Ticket
INSERT INTO Technical_Support_Ticket (mobileNo, Issue_description, priority_level, status) 
VALUES 
(1234567890, 'Network issue', 1, 'Open'),
(1234567890, 'skill issue', 1, 'Open'),
(9876543210, 'ha5a issue', 1, 'Resolved'),
(9876543210, 'Billing error', 2, 'In Progress');

-- SELECT statements for tables
SELECT * FROM Physical_Shop;
SELECT * FROM E_shop;
SELECT * FROM Voucher;
SELECT * FROM Shop;
SELECT * FROM Technical_Support_Ticket;
SELECT * FROM Plan_Provides_Benefits;
SELECT * FROM Cashback;
SELECT * FROM Points_Group;
SELECT * FROM Exclusive_Offer;
SELECT * FROM Benefits;
SELECT * FROM Transfer_money;
SELECT * FROM Wallet;
SELECT * FROM Process_Payment;
SELECT * FROM Payment;
SELECT * FROM Plan_Usage;
SELECT * FROM Subscription;
SELECT * FROM Service_Plan;
SELECT * FROM Customer_Account;
SELECT * FROM Customer_profile;

-- Testing views functionality:
SELECT * FROM allCustomerAccounts
SELECT * FROM allServicePlans
SELECT * FROM allBenefits
SELECT * FROM AccountPayments
SELECT * FROM allShops
SELECT * FROM allResolvedTickets
SELECT * FROM CustomerWallet
SELECT * FROM E_shopVouchers
SELECT * FROM PhysicalStoreVouchers
SELECT * FROM Num_of_cashback

-- Testing procedures/functions functionality
EXEC Account_Plan;
SELECT * FROM dbo.Account_Plan_date('2023-02-01', 1);
SELECT * FROM dbo.Account_Usage_Plan(1234567890, '2023-02-01');
DECLARE @mobile MOBILE;
SET @mobile = 1234567890;
DECLARE @plan_id INT;
SET @plan_id = 1;
EXEC Benefits_Account @mobile, @plan_id;
SELECT * FROM dbo.Account_SMS_Offers(9876543210);

DECLARE @MobileNo MOBILE, @TotalTransactions INT, @TotalPoints DECIMAL(10,2);
SET @MobileNo = '1234567890';
EXEC Account_Payment_Points @MobileNo, @TotalTransactions OUTPUT, @TotalPoints OUTPUT;
PRINT 'Total number of transactions: ' + STR(@TotalTransactions); 
PRINT 'Total amount of points: ' + STR(@TotalPoints);

SELECT dbo.Wallet_Cashback_Amount(1,1);
SELECT dbo.Wallet_Transfer_Amount(1,'2023-01-25', '2024-02-25');
SELECT dbo.Wallet_MobileNo(01551664726);

DECLARE @Points INT;
EXEC Total_Points_Account 
    @MobileNo = '1234567890', 
    @newPoints = @Points OUTPUT;


DROP PROCEDURE Total_Points_Account;

SELECT * FROM Customer_Account;

EXEC dropAllTables;
EXEC createAllTables;
		
SELECT dbo.AccountLoginValidation(1234567890,'pass123');
SELECT * FROM dbo.Consumption('Premium', '2023-07-01', '2023-09-01');

DROP FUNCTION Consumption;

DECLARE @MobileNo MOBILE;
SET @MobileNo = 1234567890;
EXEC Unsubscribed_Plans @MobileNo;

SELECT * FROM dbo.Usage_Plan_CurrentMonth(1234567890);
SELECT * FROM dbo.Cashback_Wallet_Customer(1001);

DECLARE @NationalID INT, @unresolved INT;
SET @NationalID = 1002;
EXEC Ticket_Account_Customer @NationalID, @unresolved OUTPUT;
PRINT 'Number of unresolved tickets: ' + STR(@unresolved);

DECLARE @MobileNo MOBILE = '1234567890', @Voucher_id INT;
EXEC Account_Highest_Voucher @MobileNo, @Voucher_id OUTPUT;
PRINT 'The voucher with the highest value is: ' + STR(@Voucher_id)

SELECT dbo.Remaining_plan_amount(1234567890,'Basic');
SELECT dbo.Remaining_plan_amount(9876543210,'Premium');
SELECT dbo.Extra_plan_amount(1234567890,'Basic');
SELECT dbo.Extra_plan_amount(9876543210,'Premium');


DECLARE @MobileNo MOBILE;
SET @MobileNo = 1234567890;
EXEC Top_Successful_Payments @MobileNo;

SELECT * FROM dbo.Subscribed_plans_5_Months(1234567890);

DECLARE @MobileNo MOBILE, @amount DECIMAL(10,1), @payment_method ALPHA, @plan_id INT;
SET @MobileNo = 9876543210
SET @amount = 10.0
SET @payment_method = 'cash'
SET @plan_id = 2
EXEC Initiate_plan_payment @MobileNo, @amount, @payment_method, @plan_id;

SELECT * FROM Payment

SELECT * FROM Subscription;

DECLARE @MobileNo MOBILE, @payment_id INT, @benefit_id INT;
SET @MobileNo = 1234567890;
SET @payment_id = 1;
SET @benefit_id = 1;
EXEC Payment_wallet_cashback @MobileNo, @payment_id, @benefit_id;

SELECT * FROM Cashback;


DECLARE @MobileNo MOBILE, @amount decimal(10,1), @payment_method ALPHA
SET @MobileNo = 9876543210
SET @amount = 10.0
SET @payment_method = 'cash'
EXEC Initiate_balance_payment @MobileNo, @amount, @payment_method;

SELECT * FROM Payment;
SELECT * FROM Customer_Account;

DECLARE @MobileNo MOBILE, @voucher_id INT
SET @MobileNo = 1234567890;
SET @voucher_id = 5;
EXEC Redeem_voucher_points @MobileNo, @voucher_id;

SELECT * FROM Customer_Account;
SELECT * FROM Voucher;

DROP PROCEDURE Wallet_Cashback_Amount;
DROP DATABASE Telecom_Team_9;
EXEC createAllTables;

SELECT dbo.Wallet_Cashback_Amount(1,1);