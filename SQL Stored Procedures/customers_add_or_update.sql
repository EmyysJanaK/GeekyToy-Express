CREATE DEFINER=`root`@`localhost` PROCEDURE `customers_add_or_update`(
	IN _customer_id INT,
    IN _password VARCHAR(50),
    IN _first_name VARCHAR(50),
    IN _last_name VARCHAR(50),
    IN _email VARCHAR(255),
    IN _phone_number CHAR(10),
    IN _address_line1 VARCHAR(50),
    IN _address_line2 VARCHAR(50),
    IN _city VARCHAR(50),
    IN _province VARCHAR(50),
    IN _zipcode CHAR(5),
    IN _is_registered TINYINT
)
BEGIN
	
    IF _customer_id = 0 THEN
		INSERT INTO customers(customer_id,password,first_name,last_name,email,phone_number,address_line1,address_line2,city,province,zipcode,is_registered)
        VALUES (_customer_id,_password,_first_name,_last_name,_email,_phone_number,_address_line1,_address_line2,_city,_province,_zipcode,_is_registered);
	ELSE 
		UPDATE customers 
        SET
            password = _password,
            first_name = _first_name,
            last_name = _last_name,
            email = _email,
            phone_number = _phone_number,
            address_line1 = _address_line1,
            address_line2 = _address_line2,
            city = _city,
            province = _province,
            zipcode = _zipcode,
            is_registered = _is_registered
		WHERE 
			customer_id = _customer_id;
	END IF;
    
    SELECT ROW_COUNT() AS 'affectedRows';    
END