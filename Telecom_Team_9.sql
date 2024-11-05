CREATE DATABASE Telecom_Team_9;
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
		INNER JOIN Points_Group ON P.PaymentID = PG.PaymentID
		WHERE P.mobileNo = @MobileNo AND P.date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP) AND p.status = 'accepted';

		
	END;
	DECLARE @MobileNo char(11), @TotalTransactions INT, @TotalPoints DECIMAL(10,2);
	EXEC Account_Payment_Points @MobileNo, @TotalTransactions OUTPUT, @TotalPoints OUTPUT;
	PRINT 'Total number of transactions: ' + STR(@TotalTransactions, 10, 0); 
	PRINT 'Total amount of points: ' + STR(@TotalPoints, 10, 2);
