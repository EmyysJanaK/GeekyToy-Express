CREATE DEFINER=`root`@`localhost` PROCEDURE `orders_add_or_update`(
	IN _order_id INT,
    IN _cart_id INT,
    IN _date DATETIME,
    IN _payment_id INT,
    IN _delivery_id INT,
    IN _address_line1 VARCHAR(50),
    IN _address_line2 VARCHAR(50),
    IN _city VARCHAR(50),
    IN _province VARCHAR(50),
    IN _zipcode CHAR(5)
)
BEGIN
	
    IF _order_id = 0 THEN
		INSERT INTO orders(order_id,cart_id,date,payment_id,delivery_id,address_line1,address_line2,city,province,zipcode)
        VALUES (_order_id,_cart_id,_date,_payment_id,_delivery_id,_address_line1,_address_line2,_city,_province,_zipcode);
	ELSE 
		UPDATE orders 
        SET
            cart_id = _cart_id,
            date = _date,
            payment_id = _payment_id,
            delivery_id = _delivery_id,
            address_line1 = _address_line1,
            address_line2 = _address_line2,
            city = _city,
            province = _province,
            zipcode = _zipcode
		WHERE 
			order_id = _order_id;
	END IF;
    
    SELECT ROW_COUNT() AS 'affectedRows';    
END