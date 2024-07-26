CREATE DATABASE WINcarRental;
USE WINcarRental;

--creating the customer table
CREATE TABLE Customer (
    CustomerId    INTEGER NOT NULL,
    LastName      VARCHAR(35) NOT NULL,
    FirstName     VARCHAR(15) NOT NULL,
    Addresses     VARCHAR(255) NOT NULL,
    PostCode      INTEGER(4) NOT NULL,
    State         VARCHAR(10) NOT NULL,
    Phone         BIGINT NOT NULL,
    MemberDate    DATE NOT NULL,
    PRIMARY KEY (CustomerId)
);

--creating the insurance table
CREATE TABLE Insurance (
    InsuranceId     CHAR(1) NOT NULL,
    InsuranceType   VARCHAR(25) NOT NULL,
    Price           FLOAT NOT NULL,
    PRIMARY KEY (InsuranceId)
);

--creating the rental charge table
CREATE TABLE RentalCharge (
    RentalId     INTEGER NOT NULL,
    Rent         FLOAT NOT NULL,
    PRIMARY KEY (RentalId)
);

--creating the paytype table
CREATE TABLE PayType (
    PaymentId     INTEGER NOT NULL,
    Pay_Type      VARCHAR(25) NOT NULL,
    PRIMARY KEY (PaymentId)
);

--creating the vehicle type table
CREATE TABLE Vehicle_Type (
    VehicleTypeId     INTEGER NOT NULL,
    VehicleType       VARCHAR(25) NOT NULL,
    Charge            FLOAT NOT NULL,
    PRIMARY KEY (VehicleTypeId)
);

--creating the cehicle table
CREATE TABLE Vehicle (
    Rego            VARCHAR(8) NOT NULL,
    Descrript       VARCHAR(255) NOT NULL,
    Make            VARCHAR(25) NOT NULL,
    Model           VARCHAR(30) NOT NULL,
    CarYear         INTEGER NOT NULL,
    Val             FLOAT NOT NULL,
    EngineCapacity  FLOAT NOT NULL,
    Odometer        INTEGER NOT NULL,
    PurchaseDate    DATE NOT NULL,
    VehicleTypeId   INTEGER NOT NULL,
    PRIMARY KEY (Rego),
    FOREIGN KEY (VehicleTypeId) REFERENCES Vehicle_Type(VehicleTypeId)
);

--creating the rental table
CREATE TABLE Rental (
    RentalId     INTEGER NOT NULL,
    BookingDate  DATE NOT NULL,
    BookingMethod VARCHAR(25) NOT NULL,
    Checkout     DATE NOT NULL,
    RentDays     INTEGER NOT NULL,
    Checkin      DATE,
    DueDate      DATE NOT NULL,
    Odometer     INTEGER NOT NULL,
    Damage       VARCHAR(255),
    PaymentId    INTEGER NOT NULL,
    Rego         VARCHAR(8) NOT NULL,
    CustomerId   INTEGER NOT NULL,
    InsuranceId  CHAR(1) NOT NULL,
    PRIMARY KEY (RentalId),
    FOREIGN KEY (PaymentId) REFERENCES PayType(PaymentId),
    FOREIGN KEY (Rego) REFERENCES Vehicle (Rego),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
    FOREIGN KEY (InsuranceId) REFERENCES Insurance(InsuranceId)
);

-- Inserting values into Vehicle
INSERT INTO Vehicle VALUES('123WIN', 'Blue, Semi Auto, Central Locking, Leather Int', 'Toyota', 'Camry', 2020, 27990, 4, 28902, '2020-10-02', 1);
INSERT INTO Vehicle VALUES('345WIN', 'Navy, Manual, Cruise, Central Locking, A/C, 6 CD', 'Nissan', 'Pathfinder', 2017, 75000, 4, 27429, '2017-09-05', 3);
INSERT INTO Vehicle VALUES('456WIN', 'Red, Cruise, Auto, 6 CD, Central Locking', 'Toyota', 'Astra', 2021, 24990, 1.8, 16904, '2021-11-06', 2);
INSERT INTO Vehicle VALUES('789WIN', 'Green, Auto, Leather Int, 6 CD, Wood Feature, Cruise', 'Ford', 'Falcon', 2015, 87545, 4, 2600, '2015-12-15', 1);
INSERT INTO Vehicle VALUES('123LSK', 'Golden, Semi Auto, Cruise, CD, A/C, Central Locking', 'Mitsubishi', 'Lancer', 2015, 25300, 3.8, 1800, '2015-02-14', 1);
INSERT INTO Vehicle VALUES('567LSK', 'White, Auto, Cruise, 7 Seater, CD', 'Toyota', 'Tarago', 2019, 35900, 2.4, 7500, '2019-01-12', 5);
INSERT INTO Vehicle VALUES('234LSK', 'White, Auto, Cruise, 6 CD, Central Locking', 'Ford', 'Falcon Forte', 2021, 29799, 4, 5910, '2021-02-15', 1);

-- Inserting values into Vehicle_Type
INSERT INTO Vehicle_Type VALUES(1, 'Sedan', 75);
INSERT INTO Vehicle_Type VALUES(2, 'Hatchback', 50);
INSERT INTO Vehicle_Type VALUES(3, '4 Wheel Drive', 110);
INSERT INTO Vehicle_Type VALUES(4, 'Station Wagon', 60);
INSERT INTO Vehicle_Type VALUES(5, 'People Mover', 110);
INSERT INTO Vehicle_Type VALUES(6, 'Coupe', 70);

-- Inserting values into Insurance
INSERT INTO Insurance VALUES('N', 'No Cover', 0);
INSERT INTO Insurance VALUES('P', 'Partial Cover', 20.99);
INSERT INTO Insurance VALUES('F', 'Full Cover', 35.5);

-- Inserting values into PayType
INSERT INTO PayType VALUES(1, 'Credit Card');
INSERT INTO PayType VALUES(2, 'Cash');
INSERT INTO PayType VALUES(3, 'Cheque');
INSERT INTO PayType VALUES(4, 'Eftpos');

--inserting the values into the customer
INSERT INTO Customer (CustomerId, LastName, FirstName, Addresses, PostCode, State, Phone, MemberDate) VALUES
(1, 'Thapa', 'Kanchan', '123 John st, Ashfield',2131, 'NSW', 1234567890, '2002-03-14'),
(2, 'Shrestha', 'Riya', '456 Web St, Rockdale', 2216, 'NSW', 2345678901, '2005-02-20'),
(3, 'Tuladhar', 'Ayush', '789 Albert St, Parrmata', 2116, 'NSW', 3456789012, '2003-03-10'),
(4, 'Khadka', 'Dharmendra', '321 Alt St, Barangaroo', 2000, 'NSW', 4567890123, '2004-04-05'),
(5, 'Singh', 'Pramod', '654 Winston St, Asquith', 2077, 'NSW', 5678901234, '1981-05-22');

--inserting the value into the rental
INSERT INTO Rental (RentalId, BookingDate, BookingMethod, Checkout, RentDays, Checkin, DueDate, Odometer, Damage, PaymentId, Rego, CustomerId, InsuranceId) VALUES
(1, '2023-06-01', 'Online', '2023-06-05', 7, NULL, '2023-06-12', 30000, 'None', 1, '123WIN', 1, 'F'),
(2, '2023-07-15', 'Phone', '2023-07-20', 3, '2023-07-23', '2023-07-26', 31500, 'Scratch on mirror', 2, '345WIN', 2, 'P'),
(3, '2023-08-10', 'In-Person', '2023-08-12', 5, '2023-08-17', '2023-08-19', 32500, 'None', 3, '456WIN', 3, 'N');
