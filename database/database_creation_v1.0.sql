-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema group32_V1.0
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `group32_V1.0` ;

-- -----------------------------------------------------
-- Schema group32_V1.0
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group32_V1.0` DEFAULT CHARACTER SET utf8mb3 ;
-- SHOW WARNINGS;
USE `group32_V1.0` ;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`admin` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`admin` (
  `Admin_id` INT NOT NULL AUTO_INCREMENT,
  `Admin_name` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Admin_id`),
  UNIQUE INDEX `Admin_name_UNIQUE` (`Admin_name` ASC) VISIBLE,
  UNIQUE INDEX `Password_UNIQUE` (`Password` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`variant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`variant` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`variant` (
  `variant_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`variant_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -- -----------------------------------------------------
-- -- Table `group32_V1.0`.`attribute`
-- -- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`attribute` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`attribute` (
  `Attribute_id` INT NOT NULL AUTO_INCREMENT,
  `Variant_id` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Attribute_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Attributes_variants1_idx` (`Variant_id` ASC) VISIBLE,
  CONSTRAINT `fk_attribute_variant`
    FOREIGN KEY (`Variant_id`)
    REFERENCES `group32_V1.0`.`variant` (`Variant_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`attribute`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `group32_V1.0`.`attribute` ;

-- -- SHOW WARNINGS;
-- CREATE TABLE IF NOT EXISTS `group32_V1.0`.`attribute` (
--   `Attribute_id` INT NOT NULL, -- changed by Yapa
--   `variant_id` INT NOT NULL,
--   `Name` VARCHAR(50) NOT NULL,
--   PRIMARY KEY (`Attribute_id`, `variant_id`), -- changed by Yapa
--   UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
--   INDEX `fk_Attributes_variants1_idx` (`variant_id` ASC) VISIBLE,
--   CONSTRAINT `fk_attribute_variant`
--     FOREIGN KEY (`variant_id`)
--     REFERENCES `group32_V1.0`.`variant` (`variant_id`)
--     ON UPDATE CASCADE)
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`customer` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`customer` (
  `Customer_id` INT NOT NULL AUTO_INCREMENT,
  `Password` VARCHAR(50) NULL,
  `First_name` VARCHAR(50) NOT NULL,
  `Last_name` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Phone_number` CHAR(10) NOT NULL,
  `Address_line1` VARCHAR(50) NOT NULL,
  `Address_line2` VARCHAR(50) NULL DEFAULT NULL,
  `City` VARCHAR(50) NOT NULL,
  `Province` VARCHAR(50) NOT NULL,
  `Zipcode` CHAR(5) NOT NULL,
  `Is_registered` TINYINT NOT NULL,
  PRIMARY KEY (`Customer_id`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`card_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`card_detail` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`card_detail` (
  `Customer_id` INT NOT NULL,
  `Name_on_card` VARCHAR(50) NOT NULL,
  `Card_number` CHAR(16) NOT NULL CHECK (LENGTH(`Card_number`) = 16),
  `Expiry_date` CHAR(5) NOT NULL,
  PRIMARY KEY (`Customer_id`),
  UNIQUE INDEX `Card_number_UNIQUE` (`Card_number` ASC) VISIBLE,
  INDEX `fk_Card_details_Customer_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Card_details_Customer`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `group32_V1.0`.`customer` (`Customer_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`cart` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`cart` (
  `Cart_id` INT NOT NULL AUTO_INCREMENT,
  `Customer_id` INT NOT NULL,
  PRIMARY KEY (`Cart_id`),
  INDEX `fk_Carts_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_customer`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `group32_V1.0`.`customer` (`Customer_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`product` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`product` (
  `Product_id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) NOT NULL,
  `SKU` VARCHAR(50) NOT NULL,
  `Weight` DECIMAL(6,3) NOT NULL,
  `Description` TEXT NULL DEFAULT NULL,
  `Image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Product_id`),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE,
  UNIQUE INDEX `SKU_UNIQUE` (`SKU` ASC) VISIBLE)
ENGINE = InnoDB
-- AUTO_INCREMENT = 89
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`item` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`item` (
  `Item_id` INT NOT NULL AUTO_INCREMENT,
  `Product_id` INT NOT NULL,
  `Price` DECIMAL(9,2) NOT NULL CHECK (`Price` >= 0),
  `Quantity` INT NOT NULL DEFAULT '0' CHECK (`Quantity` >= 0),
  `Image` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`Item_id`),
  INDEX `fk_Unique_products_Product1_idx` (`Product_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `group32_V1.0`.`product` (`Product_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`cart_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`cart_item` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`cart_item` (
  `Cart_id` INT NOT NULL,
  `Item_id` INT NOT NULL,
  `Quantity` INT NOT NULL  CHECK (`Quantity` >= 0),
  PRIMARY KEY (`Cart_id`, `Item_id`),
  INDEX `fk_Cart_items_Carts1_idx` (`Cart_id` ASC) VISIBLE,
  INDEX `fk_Cart_items_Unique_products1_idx` (`Item_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_item_cart`
    FOREIGN KEY (`Cart_id`)
    REFERENCES `group32_V1.0`.`cart` (`Cart_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_item_item`
    FOREIGN KEY (`Item_id`)
    REFERENCES `group32_V1.0`.`item` (`Item_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`delivery_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`delivery_type` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`delivery_type` (
  `Delivery_id` INT NOT NULL AUTO_INCREMENT,
  `Delivery_type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Delivery_id`),
  UNIQUE INDEX `Delivery_type_UNIQUE` (`Delivery_type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`category` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`category` (
  `Category_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `Parent_Category_id` INT NULL,
  PRIMARY KEY (`Category_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_category_category1_idx` (`Parent_Category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_parent_category`
    FOREIGN KEY (`Parent_Category_id`)
    REFERENCES `group32_V1.0`.`category` (`Category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`payment_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`payment_type` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`payment_type` (
  `Payment_id` INT NOT NULL AUTO_INCREMENT,
  `Payment_type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Payment_id`),
  UNIQUE INDEX `Payment_type_UNIQUE` (`Payment_type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`shop_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`shop_order` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`shop_order` (
  `Order_id` INT NOT NULL AUTO_INCREMENT,
  `Cart_id` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `Payment_id` INT NOT NULL,
  `Delivery_id` INT NOT NULL,
  `Address_line1` VARCHAR(50) NOT NULL,
  `Address_line2` VARCHAR(50) NOT NULL,
  `City` VARCHAR(50) NOT NULL,
  `Province` VARCHAR(50) NOT NULL,
  `Zipcode` CHAR(5) NOT NULL,
  PRIMARY KEY (`Order_id`),
  INDEX `fk_Orders_Carts1_idx` (`Cart_id` ASC) VISIBLE,
  INDEX `fk_Orders_Payments1_idx` (`Payment_id` ASC) VISIBLE,
  INDEX `fk_Orders_Delivery_types1_idx` (`Delivery_id` ASC) VISIBLE,
  CONSTRAINT `fk_shop_order_cart`
    FOREIGN KEY (`Cart_id`)
    REFERENCES `group32_V1.0`.`cart` (`Cart_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_shop_order_delivery_type`
    FOREIGN KEY (`Delivery_id`)
    REFERENCES `group32_V1.0`.`delivery_type` (`Delivery_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_shop_order_payment_type`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `group32_V1.0`.`payment_type` (`Payment_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`order_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`order_item` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`order_item` (
  `Order_id` INT NOT NULL,
  `Item_id` INT NOT NULL,
  `Quantity` INT NOT NULL CHECK (`Quantity` >= 0),
  `Unit_price` DECIMAL(9,2) NOT NULL CHECK (`Unit_price` >= 0),
  PRIMARY KEY (`Order_id`, `Item_id`),
  INDEX `fk_Order_Items_Orders1_idx` (`Order_id` ASC) VISIBLE,
  INDEX `fk_Order_Items_Unique_products1_idx` (`Item_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_item_shop_order`
    FOREIGN KEY (`Order_id`)
    REFERENCES `group32_V1.0`.`shop_order` (`Order_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_item_item`
    FOREIGN KEY (`Item_id`)
    REFERENCES `group32_V1.0`.`item` (`Item_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`product_category` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`product_category` (
  `Product_id` INT NOT NULL,
  `Category_id` INT NOT NULL,
  INDEX `fk_Product_sub_categories_Product1_idx` (`Product_id` ASC) VISIBLE,
  PRIMARY KEY (`Product_id`, `Category_id`),
  INDEX `fk_product_sub_category_category1_idx` (`Category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category_product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `group32_V1.0`.`product` (`Product_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_category_category`
    FOREIGN KEY (`Category_id`)
    REFERENCES `group32_V1.0`.`category` (`Category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group32_V1.0`.`item_configuration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group32_V1.0`.`item_configuration` ;

-- SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group32_V1.0`.`item_configuration` (
  `Item_id` INT NOT NULL,
  `Attribute_id` INT NOT NULL,
  PRIMARY KEY (`Item_id`, `Attribute_id`),
  INDEX `fk_Unique_product_attributes_Attributes1_idx` (`Attribute_id` ASC) VISIBLE,
  INDEX `fk_Unique_product_attributes_Unique_products1_idx` (`Item_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_configuration_attribute`
    FOREIGN KEY (`Attribute_id`)
    REFERENCES `group32_V1.0`.`attribute` (`Attribute_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_configuration_item`
    FOREIGN KEY (`Item_id`)
    REFERENCES `group32_V1.0`.`item` (`Item_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
