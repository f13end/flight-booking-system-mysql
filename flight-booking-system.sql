-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flight_booking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flight_booking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flight_booking` DEFAULT CHARACTER SET utf8 ;
USE `flight_booking` ;

-- -----------------------------------------------------
-- Table `flight_booking`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`classes` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`airlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`airlines` (
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`airports` (
  `IATACode` CHAR(3) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  PRIMARY KEY (`IATACode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`flights` (
  `flight_number` VARCHAR(50) NOT NULL,
  `arrival_date_time` DATETIME NOT NULL,
  `arrival_IATA_code` CHAR(3) NOT NULL,
  `departure_date_time` DATETIME NOT NULL,
  `departure_IATA_code` CHAR(3) NOT NULL,
  `distance_in_miles` INT NOT NULL,
  `duration_in_minutes` DATETIME NOT NULL,
  `airlines_name` SMALLINT NOT NULL,
  `airports_IATACode` CHAR(3) NOT NULL,
  PRIMARY KEY (`flight_number`),
  INDEX `fk_flights_airlines1_idx` (`airlines_name` ASC) VISIBLE,
  INDEX `fk_flights_airports1_idx` (`airports_IATACode` ASC) VISIBLE,
  CONSTRAINT `fk_flights_airlines`
    FOREIGN KEY (`airlines_name`)
    REFERENCES `flight_booking`.`airlines` (`name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_flights_airports`
    FOREIGN KEY (`airports_IATACode`)
    REFERENCES `flight_booking`.`airports` (`IATACode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`tickets` (
  `confirmation_number` VARCHAR(50) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `customers_customer_id` INT NOT NULL,
  `classes_class_id` INT NOT NULL,
  `flights_flight_number` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`confirmation_number`, `customers_customer_id`, `classes_class_id`, `flights_flight_number`),
  INDEX `fk_tickets_customers_idx` (`customers_customer_id` ASC) VISIBLE,
  INDEX `fk_tickets_classes1_idx` (`classes_class_id` ASC) VISIBLE,
  INDEX `fk_tickets_flights1_idx` (`flights_flight_number` ASC) VISIBLE,
  CONSTRAINT `fk_tickets_customers`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `flight_booking`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_classes`
    FOREIGN KEY (`classes_class_id`)
    REFERENCES `flight_booking`.`classes` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_flights1`
    FOREIGN KEY (`flights_flight_number`)
    REFERENCES `flight_booking`.`flights` (`flight_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`orders` (
  `confirmation_number` VARCHAR(50) NOT NULL,
  `customer_id` INT NOT NULL,
  `number_of_tickets` TINYINT NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `customers_customer_id` INT NOT NULL,
  PRIMARY KEY (`confirmation_number`, `customers_customer_id`),
  INDEX `fk_orders_customers1_idx` (`customers_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `flight_booking`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`id_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`id_count` (
  `most_recent_customer_id` INT NOT NULL,
  PRIMARY KEY (`most_recent_customer_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
