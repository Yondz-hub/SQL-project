CREATE DATABASE LimpopoMicroLoans;
USE LimpopoMicroLoans;

CREATE TABLE Client (
ClientID INT AUTO_INCREMENT PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
Contact VARCHAR(15),
Email VARCHAR(100),
Address VARCHAR(200),
JoinDate DATE 
);

CREATE TABLE LoanType (
LoanTypeID INT AUTO_INCREMENT PRIMARY KEY,
TypeName VARCHAR(50) NOT NULL,
InterestRate DECIMAL(5,2),
Description VARCHAR (255)
);

CREATE TABLE Staff (
StaffID INT AUTO_INCREMENT PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
Role VARCHAR(50),
Email VARCHAR(100),
Phone VARCHAR(15),
HireDate DATE 
);

CREATE TABLE Loan (
LoanID INT AUTO_INCREMENT PRIMARY KEY,
ClientID  INT,
LoanTypeID INT,
StaffID INT,
Amount DECIMAL(10,2),
StartDate DATE,
DueDate Date,
Status VARCHAR(20),
FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
FOREIGN KEY (LoanTypeID) REFERENCES LoanType(LoanTypeID),
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Repayment (
RepaymentID INT AUTO_INCREMENT PRIMARY KEY,
LoanID INT,
PaymentDate DATE,
AmountPaid DECIMAL(10,2),
FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);

INSERT INTO Client (FullName, Contact, Email, Address, JoinDate) VALUES
('Kanele Noyo', '+27831234567', 'kanele.n@limpopoloans.co.za', '45 Oak St, Polokwane', '2025-01-12'),
('Tiro Ndlovu', '+27837654321', 'tiro.n@limpopoloans.co.za', '22 Palm Rd, Tzaneen', '2025-02-10'),
('Naledi Xobo', '+27835551212', 'naledi.x@limpopoloans.co.za', '18 Acacia Ave, Giyani', '2025-03-05');

INSERT INTO LoanType (TypeName, InterestRate, Description) VALUES
('Personal Loan', 11.50, 'Short-term unsecured loan'),
('Business Loan', 15.20, 'Small business funding'),
('Education Loan', 13.00, 'Loan for education costs');

INSERT INTO Staff (FullName, Role, Email, Phone, HireDate) VALUES
('Nomsa Dlamini', 'Loan Officer', 'nomsa.d@limpopoloans.co.za', '+27830001234', '2024-05-01'),
('Peter Brown', 'Collections Manager', 'peter.b@limpopoloans.co.za', '+27831110000', '2023-08-15');

INSERT INTO Loan (ClientID, LoanTypeID, StaffID, Amount, StartDate, DueDate, Status) VALUES
(1, 1, 1, 15500.00, '2025-01-15', '2025-06-15', 'Active'),
(2, 2, 1, 45030.00, '2025-02-20', '2025-08-20', 'Active'),
(3, 3, 2, 20000.00, '2025-03-10', '2025-09-10', 'Paid');

INSERT INTO Repayment (LoanID, PaymentDate, AmountPaid) VALUES
(1, '2025-02-15', 3300.00),
(1, '2025-03-15', 3500.00),
(2, '2025-03-01', 7000.00),
(3, '2025-04-01', 20000.00);

INSERT INTO Penalty (LoanID, Description, Amount, DateIssued, Status) VALUES
(1, 'Late payment fee', 200.00, '2025-03-20', 'Unpaid'),
(2, 'Missed installment', 400.00, '2025-04-10', 'Paid');

SHOW TABLES; 

SELECT * FROM Loan WHERE ClientID = 1;

SELECT c.FullName, p.Description, p.Amount, p.Status
FROM Client c
JOIN Loan l ON c.ClientID = l.ClientID
JOIN Penalty p ON l.LoanID = p.LoanID
WHERE p.Status = 'Unpaid';

UPDATE Loan
SET Status = 'Paid'
WHERE LoanID = 1;

DELETE FROM Penalty
WHERE PenaltyID = 2;

SELECT c.FullName, SUM(r.AmountPaid) AS TotalRepayments
FROM Client c
JOIN Loan l ON c.ClientID = l.ClientID
JOIN Repayment r ON l.LoanID = r.LoanID
GROUP BY c.FullName;

SELECT LoanID, Status FROM Loan WHERE LoanID = 1;

SELECT * FROM Penalty WHERE PenaltyID = 2;

SELECT * FROM Penalty;