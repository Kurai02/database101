--running the query for the detail of customer who hasn't rent any car yet
SELECT 
    Customer.CustomerId, 
    Customer.LastName, 
    Customer.FirstName, 
    Customer.Addresses, 
    Customer.PostCode, 
    Customer.State, 
    Customer.Phone, 
    Customer.MemberDate
FROM 
    Customer
LEFT JOIN 
    Rental ON Customer.CustomerId = Rental.CustomerId 
WHERE 
    Rental.CustomerId IS NULL;


--running the query for the car that are still in rent 
SELECT 
-- listing the information from the vechile table to make the data more insightfull
    Vehicle.Rego, 
    Vehicle.Descrript, 
    Vehicle.Make, 
    Vehicle.Model, 
    Vehicle.CarYear, 
    Vehicle.Val, 
    Vehicle.EngineCapacity, 
    Vehicle.Odometer, 
    Vehicle.PurchaseDate, 
    Vehicle.VehicleTypeId
FROM 
    Vehicle
JOIN 
    Rental ON Vehicle.Rego = Rental.Rego
WHERE 
    Rental.Checkout <= CURRENT_DATE 
    AND (Rental.Checkin > CURRENT_DATE OR Rental.Checkin IS NULL); --determining if the car hasn.t check in or is beyound rent terms
