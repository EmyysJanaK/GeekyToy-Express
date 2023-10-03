CREATE DEFINER=`root`@`localhost` PROCEDURE `products_add_or_update`(
	IN _product_id INT,
    IN _title VARCHAR(255),
    IN _sku VARCHAR(50),
    IN _weight DECIMAL(6,3),
    IN _description TEXT
)
BEGIN
	
    IF _product_id = 0 THEN
		INSERT INTO products(product_id,title,sku,weight,description)
        VALUES (_product_id,_title,_sku,_weight,_description);
	ELSE 
		UPDATE products 
        SET
            title = _title,
            sku = _sku,
            weight = _weight,
            description = _description
		WHERE 
			product_id = _product_id;
	END IF;
    
    SELECT ROW_COUNT() AS 'affectedRows';    
END