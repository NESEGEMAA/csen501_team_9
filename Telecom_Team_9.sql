CREATE DATABASE Telecom_Team_9;

GO;
CREATE VIEW AllShops AS
SELECT *
FROM Shop S LEFT JOIN Physical_Shop PS ON S.shopID = PS.shopID LEFT JOIN E_shop ON S.shopID = ES.shopID;

GO;
CREATE VIEW allResolvedTickets AS
SELECT *
FROM Technical_Support_Ticket
WHERE status = 'resolved';