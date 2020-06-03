-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`Proveïdor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Proveïdor` (
  `id_proveïdor` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `adreça_país` VARCHAR(45) NOT NULL,
  `adreça_ciutat` VARCHAR(45) NOT NULL,
  `adreça_CP` VARCHAR(10) NOT NULL,
  `adreça_carrer` VARCHAR(255) NOT NULL,
  `adreça_número` VARCHAR(4) NULL DEFAULT 's/n',
  `adreça_pis` VARCHAR(3) NULL,
  `adreça_porta` VARCHAR(1) NULL,
  `telèfon` VARCHAR(15) NOT NULL,
  `fax` VARCHAR(15) NULL,
  `NIF` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_proveïdor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Marca` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `id_proveïdor` INT NOT NULL,
  `nom_marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_Marca_Proveïdor_idx` (`id_proveïdor` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Proveïdor`
    FOREIGN KEY (`id_proveïdor`)
    REFERENCES `optica`.`Proveïdor` (`id_proveïdor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Vidre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Vidre` (
  `id_vidre` INT NOT NULL,
  `graduació` DECIMAL NOT NULL,
  `color_vidre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_vidre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Ullera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Ullera` (
  `id_ullera` INT NOT NULL AUTO_INCREMENT,
  `id_marca` INT NOT NULL,
  `id_vidre_esq` INT NOT NULL,
  `id_vidre_dta` INT NOT NULL,
  `muntura` VARCHAR(1) NOT NULL,
  `color_muntura` VARCHAR(45) NOT NULL,
  `preu` DECIMAL NOT NULL,
  PRIMARY KEY (`id_ullera`),
  INDEX `fk_Ullera_Marca1_idx` (`id_marca` ASC) VISIBLE,
  INDEX `fk_Ullera_Vidre1_idx` (`id_vidre_esq` ASC) VISIBLE,
  INDEX `fk_Ullera_Vidre2_idx` (`id_vidre_dta` ASC) VISIBLE,
  CONSTRAINT `fk_Ullera_Marca1`
    FOREIGN KEY (`id_marca`)
    REFERENCES `optica`.`Marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ullera_Vidre1`
    FOREIGN KEY (`id_vidre_esq`)
    REFERENCES `optica`.`Vidre` (`id_vidre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ullera_Vidre2`
    FOREIGN KEY (`id_vidre_dta`)
    REFERENCES `optica`.`Vidre` (`id_vidre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom(s)` VARCHAR(45) NOT NULL,
  `adreça_ciutat` VARCHAR(45) NULL,
  `adreça_CP` VARCHAR(45) NULL,
  `adreça_carrer` VARCHAR(255) NULL,
  `adreça_número` INT NULL,
  `adreça_pis` VARCHAR(3) NULL,
  `adreça_porta` VARCHAR(1) NULL,
  `telèfon` VARCHAR(15) NULL,
  `email` VARCHAR(255) NULL,
  `registre` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Venda` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `id_ullera` INT NOT NULL,
  `empleat` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor (€)` DECIMAL NOT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `fk_Venda_Ullera1_idx` (`id_ullera` ASC) VISIBLE,
  INDEX `fk_Venda_Client1_idx` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Ullera1`
    FOREIGN KEY (`id_ullera`)
    REFERENCES `optica`.`Ullera` (`id_ullera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Client1`
    FOREIGN KEY (`id_client`)
    REFERENCES `optica`.`Client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Item` (
  `id_item` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_ullera` INT NOT NULL,
  PRIMARY KEY (`id_item`),
  INDEX `fk_Item_Venda1_idx` (`id_venda` ASC) VISIBLE,
  INDEX `fk_Item_Ullera1_idx` (`id_ullera` ASC) VISIBLE,
  CONSTRAINT `fk_Item_Venda1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `optica`.`Venda` (`id_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Ullera1`
    FOREIGN KEY (`id_ullera`)
    REFERENCES `optica`.`Ullera` (`id_ullera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
