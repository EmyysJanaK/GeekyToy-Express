CREATE DEFINER=`root`@`localhost` PROCEDURE `carts_add_or_update`(
	IN _cart_id INT,
    IN _customer_id INT,
    IN _total_value DECIMAL(9,2)
)
BEGIN
	
    IF _cart_id = 0 THEN
		INSERT INTO carts(cart_id,customer_id,total_value)
        VALUES (_cart_id,_customer_id,_total_value);
	ELSE 
		UPDATE carts 
        SET
            customer_id = _customer_id,
            total_value = _total_value
		WHERE 
			cart_id = _cart_id;
	END IF;
    
    SELECT ROW_COUNT() AS 'affectedRows';    
END