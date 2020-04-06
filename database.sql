-- MySQL Script generated by MySQL Workbench
-- Mon 06 Apr 2020 07:02:49 PM CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema birtouta
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema birtouta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `birtouta` DEFAULT CHARACTER SET utf8 ;
USE `birtouta` ;

-- -----------------------------------------------------
-- Table `birtouta`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(10) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `city` VARCHAR(100) NULL,
  `state` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `location_x` VARCHAR(45) NOT NULL,
  `location_y` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  `deleted` TINYINT NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`, `phone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`sessions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `platform` VARCHAR(45) NULL,
  `build` VARCHAR(10) NULL,
  `fcm_token` VARCHAR(255) NULL,
  `smartphone` VARCHAR(45) NULL,
  `id_user` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  `login_at` TIMESTAMP NULL,
  `logout_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`, `id_user`),
  INDEX `fk_sessions_users_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_sessions_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `birtouta`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`stores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qr_code` VARCHAR(255) NOT NULL,
  `location_x` VARCHAR(45) NOT NULL,
  `location_y` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` VARCHAR(45) NULL,
  `deleted` TINYINT NOT NULL DEFAULT -1,
  `id_owner` INT NOT NULL,
  PRIMARY KEY (`id`, `qr_code`, `id_owner`),
  INDEX `fk_stores_users1_idx` (`id_owner` ASC) VISIBLE,
  CONSTRAINT `fk_stores_users1`
    FOREIGN KEY (`id_owner`)
    REFERENCES `birtouta`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  `received_at` TIMESTAMP NULL,
  `prepared` TINYINT NULL,
  `prepared_at` TIMESTAMP NULL,
  `delevered` TINYINT NULL,
  `delivered_at` TIMESTAMP NULL COMMENT '	',
  `id_store` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id`, `id_store`, `id_user`),
  INDEX `fk_orders_stores1_idx` (`id_store` ASC) VISIBLE,
  INDEX `fk_orders_users1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_orders_stores1`
    FOREIGN KEY (`id_store`)
    REFERENCES `birtouta`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `birtouta`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`deliveries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_store` INT NOT NULL,
  `id_target` INT NOT NULL,
  `id_order` INT NOT NULL,
  `id_deliver` INT NOT NULL,
  PRIMARY KEY (`id`, `id_deliver`, `id_order`, `id_store`, `id_target`),
  INDEX `fk_deliveries_stores1_idx` (`id_store` ASC) VISIBLE,
  INDEX `fk_deliveries_users1_idx` (`id_target` ASC) VISIBLE,
  INDEX `fk_deliveries_orders1_idx` (`id_order` ASC) VISIBLE,
  INDEX `fk_deliveries_users2_idx` (`id_deliver` ASC) VISIBLE,
  CONSTRAINT `fk_deliveries_stores1`
    FOREIGN KEY (`id_store`)
    REFERENCES `birtouta`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliveries_users1`
    FOREIGN KEY (`id_target`)
    REFERENCES `birtouta`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliveries_orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `birtouta`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliveries_users2`
    FOREIGN KEY (`id_deliver`)
    REFERENCES `birtouta`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`order_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`order_products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `details` TEXT NULL,
  `quantity` DOUBLE NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id`, `id_order`),
  INDEX `fk_order_product_order1_idx` (`id_order` ASC) VISIBLE,
  CONSTRAINT `fk_order_product_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `birtouta`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`product_category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `translated_fr` VARCHAR(45) NULL,
  `translated_en` VARCHAR(45) NULL,
  `translated_kb` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birtouta`.`store_workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birtouta`.`store_workers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_user` VARCHAR(45) NULL,
  `code_access` VARCHAR(255) NULL,
  `id_store` INT NOT NULL,
  PRIMARY KEY (`id`, `id_store`),
  INDEX `fk_store_workers_stores1_idx` (`id_store` ASC) VISIBLE,
  INDEX `fk_store_workers_users1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_store_workers_stores1`
    FOREIGN KEY (`id_store`)
    REFERENCES `birtouta`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_workers_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `birtouta`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
