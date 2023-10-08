DELIMITER $$

DROP PROCEDURE IF EXISTS insert_variant_if_not_exists$$

CREATE PROCEDURE insert_variant_if_not_exists 
(
	variant_name VARCHAR(50)
)
BEGIN
	IF (variant_name NOT IN (SELECT name FROM variant)) THEN
		INSERT INTO variant (name) VALUES (variant_name);
	END IF;
END$$

DROP PROCEDURE IF EXISTS insert_attribute_if_not_exists$$

CREATE PROCEDURE insert_attribute_if_not_exists
(
	attribute_name VARCHAR(50),
    variant_name VARCHAR(50)
)
BEGIN
	DECLARE variant_id INT DEFAULT 0;
    SELECT v.variant_id INTO variant_id FROM variant v WHERE name = variant_name;
    
	IF (attribute_name NOT IN (SELECT name FROM attribute a WHERE a.variant_id = variant_id)) THEN
		INSERT INTO attribute (variant_id, name) VALUES (variant_id, attribute_name);
	END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_item_with_configuration`(
	SKU VARCHAR(50), -- Product SKU to get the product id
    Price DECIMAL(9,2), 
    Quantity INT,
    Image VARCHAR(255), -- image path
    No_of_variants INT,
    Variant_types VARCHAR(255), -- comma separated list of variant names
    Attributes VARCHAR(255) -- comma separated list of attribute names
)
BEGIN
	DECLARE NewItemID INT;
    DECLARE Product_id INT;
    DECLARE Curr_variant_id INT;
    DECLARE Curr_attribute_id INT;

	SELECT p.Product_id INTO Product_id FROM product p WHERE SKU = p.SKU;

    -- Add the item to the item table
    INSERT INTO item (Product_id, Price, Quantity, Image) VALUES (Product_id, Price, Quantity, Image);
    SET NewItemID = LAST_INSERT_ID();
    
    WHILE No_of_variants > 0 DO
		SELECT variant_id INTO Curr_variant_id FROM variant WHERE name = TRIM(SUBSTRING_INDEX(TRIM(Variant_types), ',', 1));  -- Extract the first variant_id
        SELECT attribute_id INTO Curr_attribute_id FROM attribute WHERE name = TRIM(SUBSTRING_INDEX(TRIM(Attributes), ',', 1)) AND variant_id = Curr_variant_id;  -- Extract the first attribute_id
        INSERT INTO item_configuration VALUES (NewItemID, Curr_attribute_id);
        SET Variant_types = SUBSTRING(TRIM(Variant_types), LENGTH(SUBSTRING_INDEX(Variant_types, ',', 1)) + 2);  -- Remove the inserted Variant name and comma
        SET Attributes = SUBSTRING(TRIM(Attributes), LENGTH(SUBSTRING_INDEX(Attributes, ',', 1)) + 2);  -- Remove the inserted Attribute name and comma
		SET No_of_variants = No_of_variants - 1;
    END WHILE;
END$$

DELIMITER ;