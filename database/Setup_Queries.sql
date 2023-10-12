-- Used to add some sample data to the database

USE `group32_v1.0`;

-- Inserting a main category
-- [Electronics, Toys]
INSERT INTO `category` VALUES
(
    DEFAULT,
	'Electronics', -- Enter Main category name HERE
	NULL
);
INSERT INTO `category` VALUES
(
    DEFAULT,
	'Toys', -- Enter Main category name HERE
	NULL
);

-- Inserting a sub category using parent category name
-- [Smartphones, Smart Watches, Wearables, Board Games]
INSERT INTO `category` VALUES
(
    DEFAULT,
	'Smartphones', -- Enter Sub category name HERE
	(SELECT `Category_id` FROM (SELECT `Category_id` FROM `category` WHERE `Name` = 'Electronics') AS id)
);
INSERT INTO `category` VALUES
(
    DEFAULT,
	'Smart Watches', -- Enter Sub category name HERE
	(SELECT `Category_id` FROM (SELECT `Category_id` FROM `category` WHERE `Name` = 'Electronics') AS id)
);
INSERT INTO `category` VALUES
(
    DEFAULT,
	'Wearables', -- Enter Sub category name HERE
	(SELECT `Category_id` FROM (SELECT `Category_id` FROM `category` WHERE `Name` = 'Electronics') AS id)
);
INSERT INTO `category` VALUES
(
    DEFAULT,
	'Board Games', -- Enter Sub category name HERE
	(SELECT `Category_id` FROM (SELECT `Category_id` FROM `category` WHERE `Name` = 'Toys') AS id)
);


-- Set up delivery types
-- [Delivery, Pickup]
INSERT INTO delivery_type VALUES
	(DEFAULT, 'Delivery'),
    (DEFAULT, 'Pickup');

-- Set up payment types
-- [Cash on Delivery, Card]
INSERT INTO payment_type VALUES
	(DEFAULT, 'Cash on Delivery'),
    (DEFAULT, 'Card');

-- Set up variants
-- [Color, Size, Storage]
INSERT INTO variant VALUES
	(DEFAULT, 'Color'),
    (DEFAULT, 'Size'),
    (DEFAULT, 'Storage');

-- Set up attributes
-- [[Black, Blue], [Small, Medium, Large], [64GB, 128GB]]
INSERT INTO attribute VALUES
	(1, (SELECT variant_id FROM variant WHERE `Name` = 'Color'), 'Blue'),
	(2, (SELECT variant_id FROM variant WHERE `Name` = 'Color'), 'Black');

INSERT INTO attribute VALUES
	(1, (SELECT variant_id FROM variant WHERE `Name` = 'Size'), 'Small'),
	(2, (SELECT variant_id FROM variant WHERE `Name` = 'Size'), 'Medium'),
	(3, (SELECT variant_id FROM variant WHERE `Name` = 'Size'), 'Large');

INSERT INTO attribute VALUES
	(1, (SELECT variant_id FROM variant WHERE `Name` = 'Storage'), '64GB'),
	(2, (SELECT variant_id FROM variant WHERE `Name` = 'Storage'), '128GB');


-- Add Product Procedure
USE `group32_v1.0`;
DROP procedure IF EXISTS `add_product`;

DELIMITER $$
USE `group32_v1.0`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product`(
    IN product_title VARCHAR(255),
    IN category_list VARCHAR(255),
    IN product_description TEXT,
    IN product_weight DECIMAL(6,3),
    IN product_SKU VARCHAR(50),
    IN product_image VARCHAR(255)
)
BEGIN
    DECLARE product_id INT;
    
    START TRANSACTION;
    
    -- Insert new product into product table
    INSERT INTO product (`Product_id`, `Title`, `Description`, `Weight`, `SKU`, `Image`)
    VALUES (DEFAULT, product_title, product_description, product_weight, product_SKU, product_image);
    
    -- Get ID of new product
    SET product_id = LAST_INSERT_ID();
    
    -- Split category_list into individual categories
    BEGIN
		DECLARE category_name VARCHAR(255);
		WHILE LENGTH(category_list) > 0 DO
			SET category_name = TRIM(SUBSTRING_INDEX(TRIM(category_list), ',', 1));
			SET category_list = SUBSTRING(TRIM(category_list), LENGTH(category_name)+2);
			
			-- Insert new category into product_category table
			INSERT INTO product_category (`Product_id`, `Category_id`)
			VALUES (product_id, (SELECT `Category_id` FROM `category` WHERE `Name` = category_name));
		END WHILE;
    END;
    COMMIT;
END$$

DELIMITER ;

-- Adding variants to products

-- STILL NEEEEEDS WORK

DELIMITER $$
USE `group32_v1.0`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_variants`(
    IN product_id INT,
    IN product_variant VARCHAR(50),
    IN attribute_list VARCHAR(255)
)
BEGIN
    START TRANSACTION;
    
    IF(
		product_variant NOT IN (SELECT `Name` FROM `variant`),
        INSERT INTO variant VALUES (DEFAULT, product_variant),
        (NULL)
    ); -- CONTINUE FROM HERE
    
    INSERT INTO item
    VALUES (DEFAULT, product_id, 0, 0, NULL);
    
    -- Split category_list into individual categories
    BEGIN
		DECLARE attribute_value VARCHAR(255);
		WHILE LENGTH(attribute_list) > 0 DO
			SET attribute_value = TRIM(SUBSTRING_INDEX(TRIM(attribute_list), ',', 1));
			SET attribute_list = SUBSTRING(TRIM(attribute_list), LENGTH(attribute_value)+2);
			
			-- Insert new category into product_category table
			INSERT INTO product_category (`Product_id`, `Category_id`)
			VALUES (product_id, (SELECT `Category_id` FROM `category` WHERE `Name` = category_name));
		END WHILE;
    END;
    COMMIT;
END$$

DELIMITER ;

-- Get the minimum price of a product given the product_id
CREATE FUNCTION GetMinPrice(product_id INT)
RETURNS DECIMAL(9,2)
BEGIN
    DECLARE min_price DECIMAL(9,2);
    SELECT MIN(price) INTO min_price
    FROM item
    WHERE product_id = product_id;
    RETURN min_price;
END;
