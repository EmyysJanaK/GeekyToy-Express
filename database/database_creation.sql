-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO';

DROP SCHEMA IF EXISTS `Group32` ;

CREATE SCHEMA IF NOT EXISTS `Group32` DEFAULT CHARACTER SET utf8 ;
USE `Group32` ;

-- -----------------------------------------------------
-- Table `Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customers` ;

CREATE TABLE IF NOT EXISTS `Customers` (
  `Customer_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Password` VARCHAR(50) NOT NULL,
  `First_name` VARCHAR(50) NOT NULL,
  `Last_name` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Phone_number` CHAR(10) NULL,
  `Address_line1` VARCHAR(50) NOT NULL,
  `Address_line2` VARCHAR(50) NULL,
  `City` VARCHAR(50) NOT NULL,
  `Province` VARCHAR(50) NOT NULL,
  `Zipcode` CHAR(5) NOT NULL,
  `Is_registered` TINYINT NOT NULL,
  PRIMARY KEY (`Customer_id`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Carts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Carts` ;

CREATE TABLE IF NOT EXISTS `Carts` (
  `Cart_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Customer_id` INT(5) NOT NULL,
  `Total_value` DECIMAL(9,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Cart_id`),
  INDEX `fk_Carts_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Carts_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `Customers` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Payments` ;

CREATE TABLE IF NOT EXISTS `Payments` (
  `Payment_id` INT(2) NOT NULL AUTO_INCREMENT,
  `Payment_type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Payment_id`),
  UNIQUE INDEX `Payment_type_UNIQUE` (`Payment_type` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Delivery_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_types` ;

CREATE TABLE IF NOT EXISTS `Delivery_types` (
  `Delivery_id` INT(2) NOT NULL AUTO_INCREMENT,
  `Delivery_type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Delivery_id`),
  UNIQUE INDEX `Delivery_type_UNIQUE` (`Delivery_type` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Orders` ;

CREATE TABLE IF NOT EXISTS `Orders` (
  `Order_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Cart_id` INT(5) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Payment_id` INT(2) NOT NULL,
  `Delivery_id` INT(2) NOT NULL,
  `Address_line1` VARCHAR(50) NOT NULL,
  `Address_line2` VARCHAR(50) NOT NULL,
  `City` VARCHAR(50) NOT NULL,
  `Province` VARCHAR(50) NOT NULL,
  `Zipcode` CHAR(5) NOT NULL,
  PRIMARY KEY (`Order_id`),
  INDEX `fk_Orders_Carts1_idx` (`Cart_id` ASC) VISIBLE,
  INDEX `fk_Orders_Payments1_idx` (`Payment_id` ASC) VISIBLE,
  INDEX `fk_Orders_Delivery_types1_idx` (`Delivery_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Carts1`
    FOREIGN KEY (`Cart_id`)
    REFERENCES `Carts` (`Cart_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_Payments1`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `Payments` (`Payment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_Delivery_types1`
    FOREIGN KEY (`Delivery_id`)
    REFERENCES `Delivery_types` (`Delivery_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Products` ;

CREATE TABLE IF NOT EXISTS `Products` (
  `Product_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) NOT NULL,
  `SKU` VARCHAR(50) NOT NULL,
  `Weight` DECIMAL(6,3) NOT NULL,
  `Description` TEXT,
  PRIMARY KEY (`Product_id`),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE,
  UNIQUE INDEX `SKU_UNIQUE` (`SKU` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Unique_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Unique_products` ;

CREATE TABLE IF NOT EXISTS `Unique_products` (
  `Unique_product_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Product_id` INT(5) NOT NULL,
  `Price` DECIMAL(9,2) NOT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  `Image` VARCHAR(255) NULL,
  PRIMARY KEY (`Unique_product_id`),
  INDEX `fk_Unique_products_Product1_idx` (`Product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Unique_products_Product1`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Products` (`Product_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Order_Items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Order_Items` ;

CREATE TABLE IF NOT EXISTS `Order_Items` (
  `Order_id` INT(5) NOT NULL,
  `Unique_product_id` INT(5) NOT NULL,
  `Quantity` INT NOT NULL,
  `Unit_price` DECIMAL(9,2) NOT NULL,
  INDEX `fk_Order_Items_Orders1_idx` (`Order_id` ASC) VISIBLE,
  INDEX `fk_Order_Items_Unique_products1_idx` (`Unique_product_id` ASC) VISIBLE,
  PRIMARY KEY (`Order_id`, `Unique_product_id`),
  CONSTRAINT `fk_Order_Items_Orders1`
    FOREIGN KEY (`Order_id`)
    REFERENCES `Orders` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_Items_Unique_products1`
    FOREIGN KEY (`Unique_product_id`)
    REFERENCES `Unique_products` (`Unique_product_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Card_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Card_details` ;

CREATE TABLE IF NOT EXISTS `Card_details` (
  `Customer_id` INT(5) NOT NULL,
  `Name_on_card` VARCHAR(50) NOT NULL,
  `Card_number` CHAR(16) NOT NULL,
  `Expiry_date` CHAR(5) NOT NULL,
  INDEX `fk_Card_details_Customer_idx` (`Customer_id` ASC) VISIBLE,
  PRIMARY KEY (`Customer_id`),
  UNIQUE INDEX `Card_number_UNIQUE` (`Card_number` ASC) VISIBLE,
  CONSTRAINT `fk_Card_details_Customer`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `Customers` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Cart_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cart_items` ;

CREATE TABLE IF NOT EXISTS `Cart_items` (
  `Cart_id` INT(5) NOT NULL,
  `Unique_product_id` INT(5) NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`Cart_id`, `Unique_product_id`),
  INDEX `fk_Cart_items_Carts1_idx` (`Cart_id` ASC) VISIBLE,
  INDEX `fk_Cart_items_Unique_products1_idx` (`Unique_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cart_items_Carts1`
    FOREIGN KEY (`Cart_id`)
    REFERENCES `Carts` (`Cart_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Cart_items_Unique_products1`
    FOREIGN KEY (`Unique_product_id`)
    REFERENCES `Unique_products` (`Unique_product_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Admin` ;

CREATE TABLE IF NOT EXISTS `Admin` (
  `Admin_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Admin_name` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Admin_id`),
  UNIQUE INDEX `Admin_name_UNIQUE` (`Admin_name` ASC) VISIBLE,
  UNIQUE INDEX `Password_UNIQUE` (`Password` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Varients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Varients` ;

CREATE TABLE IF NOT EXISTS `Varients` (
  `Variant_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Variant_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Attributes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Attributes` ;

CREATE TABLE IF NOT EXISTS `Attributes` (
  `Attribute_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Variant_id` INT(5) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Attribute_id`),
  INDEX `fk_Attributes_Varients1_idx` (`Variant_id` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  CONSTRAINT `fk_Attributes_Varients1`
    FOREIGN KEY (`Variant_id`)
    REFERENCES `Varients` (`Variant_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Group32`.`Unique_product_attributes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Unique_product_attributes` ;

CREATE TABLE IF NOT EXISTS `Unique_product_attributes` (
  `Attribute_id` INT(5) NOT NULL,
  `Unique_product_id` INT(5) NOT NULL,
  INDEX `fk_Unique_product_attributes_Attributes1_idx` (`Attribute_id` ASC) VISIBLE,
  INDEX `fk_Unique_product_attributes_Unique_products1_idx` (`Unique_product_id` ASC) VISIBLE,
  PRIMARY KEY (`Attribute_id`, `Unique_product_id`),
  CONSTRAINT `fk_Unique_product_attributes_Attributes1`
    FOREIGN KEY (`Attribute_id`)
    REFERENCES `Attributes` (`Attribute_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Unique_product_attributes_Unique_products1`
    FOREIGN KEY (`Unique_product_id`)
    REFERENCES `Unique_products` (`Unique_product_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Main_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Main_categories` ;

CREATE TABLE IF NOT EXISTS `Main_categories` (
  `Main_category_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Main_category_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Sub_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sub_categories` ;

CREATE TABLE IF NOT EXISTS `Sub_categories` (
  `Sub_category_id` INT(5) NOT NULL AUTO_INCREMENT,
  `Main_category_id` INT(5) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Sub_category_id`),
  INDEX `fk_Sub_categories_Main_categories1_idx` (`Main_category_id` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  CONSTRAINT `fk_Sub_categories_Main_categories1`
    FOREIGN KEY (`Main_category_id`)
    REFERENCES `Main_categories` (`Main_category_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Product_sub_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Product_sub_categories` ;

CREATE TABLE IF NOT EXISTS `Product_sub_categories` (
  `Product_id` INT(5) NOT NULL,
  `Sub_category_id` INT(5) NOT NULL,
  INDEX `fk_Product_sub_categories_Product1_idx` (`Product_id` ASC) VISIBLE,
  INDEX `fk_Product_sub_categories_Sub_categories1_idx` (`Sub_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_Product_sub_categories_Product1`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Products` (`Product_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Product_sub_categories_Sub_categories1`
    FOREIGN KEY (`Sub_category_id`)
    REFERENCES `Sub_categories` (`Sub_category_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

ALTER TABLE `group32`.`customers` 
DROP INDEX `Phone_number_UNIQUE` ;
;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
