-- Create the function to check date validity
DELIMITER $$

    CREATE FUNCTION IsDateValid(dateToCheck DATE)
    RETURNS BOOLEAN
    DETERMINISTIC
    BEGIN
        RETURN dateToCheck <= CURRENT_DATE;
    END $$

DELIMITER ;

-- Trigger for Customer table
DELIMITER $$

    CREATE TRIGGER trg_customer_insert
    BEFORE INSERT ON Customer
    FOR EACH ROW
    BEGIN
        IF NOT IsDateValid(NEW.MemberDate) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'MemberDate must be before or equal to the current date';
        END IF;
    END $$

DELIMITER ;

-- Trigger for Vehicle table
DELIMITER $$

    CREATE TRIGGER trg_vehicle_insert
    BEFORE INSERT ON Vehicle
    FOR EACH ROW
    BEGIN
        IF NOT IsDateValid(NEW.PurchaseDate) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PurchaseDate must be before or equal to the current date';
        END IF;
    END $$

DELIMITER ;

-- Trigger for Rental table
DELIMITER $$

    CREATE TRIGGER trg_rental_insert
    BEFORE INSERT ON Rental
    FOR EACH ROW
    BEGIN
        IF NEW.BookingDate < CURRENT_DATE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BookingDate must be after or equal to the current date';
        END IF;
        IF NEW.Checkout < CURRENT_DATE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkout must be after or equal to the current date';
        END IF;
        IF NEW.DueDate <= NEW.Checkout THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'DueDate must be after Checkout';
        END IF;
        IF NEW.Checkin IS NOT NULL AND NEW.Checkin <= NEW.Checkout THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkin must be after Checkout';
        END IF;
    END $$

DELIMITER ;

-- Trigger for Rental update
DELIMITER $$

    CREATE TRIGGER trg_rental_update
    BEFORE UPDATE ON Rental
    FOR EACH ROW
    BEGIN
        IF NEW.BookingDate < CURRENT_DATE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BookingDate must be after or equal to the current date';
        END IF;
        IF NEW.Checkout < CURRENT_DATE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkout must be after or equal to the current date';
        END IF;
        IF NEW.DueDate <= NEW.Checkout THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'DueDate must be after Checkout';
        END IF;
        IF NEW.Checkin IS NOT NULL AND NEW.Checkin <= NEW.Checkout THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkin must be after Checkout';
        END IF;
    END $$

DELIMITER ;