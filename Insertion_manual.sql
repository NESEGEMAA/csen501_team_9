-- Dummy Data for Customer_Profile
INSERT INTO Customer_profile (nationalID, first_name, last_name, email, address, date_of_birth) 
VALUES 
(30407260102211, 'Noureldin', 'Abdelrahman', 'nour.abdelrahman@example.com', '48 Mohamed Kamel Albendary St', '2004-07-26'),
(30407260102212, 'Bala7a', 'Goat', 'bala7a.goat@example.com', '123 Tahya Masr', '1954-11-09'),
(30407260102213, 'Jane', 'Smith', 'jane.smith@example.com', '456 Oak St', '2001-09-11'),
(30407260102214, 'John', 'Doe', 'john.doe@example.com', '456 Whatever St', '1990-07-18');

-- Dummy Data for Customer_Account
INSERT INTO Customer_Account (mobileNo, pass, balance, account_type, start_date, status, point, nationalID) 
VALUES 
(01551664726, 'pass123', 100.0, 'Pay_as_you_go', '2023-01-01', 'active', 10, 30407260102211),
(01030828989, 'pass456', 75.2, 'Post Paid', '2022-05-01', 'onhold', 0, 30407260102212),
(01200513663, 'pass789', 50.5, 'Prepaid', '2023-06-01', 'active', 5, 30407260102213),
(01200512119, 'pass987', 12.7, 'Post Paid', '2020-07-12', 'active', 0, 30407260102214);

-- Dummy Data for Service_Plan
INSERT INTO Service_Plan (SMS_offered, minutes_offered, data_offered, name, price, description) 
VALUES 
(100, 200, 2, 'Basic', 10, 'Basic Plan'),
(200, 500, 5, 'Premium', 20, 'Premium Plan'),
(500, 1000, 10, 'Deluxe', 100, 'Deluxe Plan');

-- Dummy Data for Subscription
INSERT INTO Subscription (mobileNo, planID, subscription_date, status) 
VALUES 
(01551664726, 1, '2019-07-01', 'active'),
(01030828989, 2, '2020-05-12', 'onhold'),
(01200513663, 3, '2020-06-30', 'active'),
(01200512119, 2, '2019-07-01', 'active');

-- Dummy Data for Plan_Usage
INSERT INTO Plan_Usage (start_date, end_date, data_consumption, minutes_used, SMS_sent, mobileNo, planID) 
VALUES 
('2007-11-01', '2020-12-01', 1, 50, 20, 01551664726, 1),
('2007-11-01', '2020-12-01', 2, 100, 20, 01030828989, 2),
('2007-07-01', '2020-08-01', 3, 200, 50, 01200513663, 3),
('2007-08-01', '2020-09-01', 5, 200, 50, 01200512119, 2),
('2022-11-01', '2022-12-01', 1, 20, 20, 01551664726, 1),
('2022-11-01', '2022-12-01', 2, 200, 20, 01030828989, 2),
('2022-07-01', '2022-08-01', 3, 100, 50, 01200513663, 3),
('2022-08-01', '2022-09-01', 4, 100, 50, 01200512119, 2),
('2024-11-01', '2024-12-01', 1, 50, 20, 01551664726, 1),
('2024-11-01', '2024-12-01', 2, 50, 20, 01030828989, 2),
('2024-07-01', '2024-08-01', 3, 100, 50, 01200513663, 3),
('2024-08-01', '2024-09-01', 6, 100, 50, 01200512119, 2);

-- Dummy Data for Payment
INSERT INTO Payment (amount, date_of_payment, payment_method, status, mobileNo) 
VALUES 
(10.0, '2024-11-22', 'cash', 'successful', 01551664726),
(20.5, '2023-07-15', 'credit', 'pending', 01030828989),
(100.0, '2024-10-15', 'cash', 'successful', 01200513663),
(50.5, '2023-11-15', 'credit', 'successful', 01030828989),
(70.0, '2024-11-23', 'cash', 'successful', 01200513663),
(30.5, '2024-11-22', 'credit', 'pending', 01200512119),
(100.0, '2024-11-22', 'cash', 'pending', 01200513663),
(250.5, '2024-11-15', 'credit', 'successful', 01200512119);

-- Dummy Data for Process_Payment
INSERT INTO Process_Payment (paymentID, planID, remaining_balance, extra_amount) 
VALUES
(1, 1, NULL, NULL),
(4, 2, 0, 30.5),
(3, 3, 0, 0),
(4, 2, NULL, NULL),
(5, 3, NULL, NULL);

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