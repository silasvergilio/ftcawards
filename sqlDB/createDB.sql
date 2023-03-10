-- MySQL Script generated by MySQL Workbench
-- Sun Mar 21 15:54:45 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ftcAwards
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ftcAwards
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ftcAwards` DEFAULT CHARACTER SET utf8 ;
USE `ftcAwards` ;

-- -----------------------------------------------------
-- Table `ftcAwards`.`Teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`Teams` (
  `idTime` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `text` VARCHAR(45) NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `school` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTime`),
  UNIQUE INDEX `_UNIQUE` (`idTime` ASC) VISIBLE,
  UNIQUE INDEX `value_UNIQUE` (`value` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ftcAwards`.`Conexao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`Conexao` (
  `idConexao` INT NOT NULL,
  `motive` VARCHAR(45) NOT NULL,
  `premiado` TINYINT NOT NULL,
  `sala` VARCHAR(45) NOT NULL,
  `position` INT NOT NULL,
  `Teams_idTime` INT NOT NULL,
  PRIMARY KEY (`idConexao`),
  UNIQUE INDEX `position_UNIQUE` (`position` ASC) VISIBLE,
  INDEX `fk_Conexao_Teams_idx` (`Teams_idTime` ASC) VISIBLE,
  CONSTRAINT `fk_Conexao_Teams`
    FOREIGN KEY (`Teams_idTime`)
    REFERENCES `ftcAwards`.`Teams` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ftcAwards`.`Controle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`Controle` (
  `idControle` INT NOT NULL,
  `motive` VARCHAR(45) NOT NULL,
  `premiado` TINYINT NOT NULL,
  `sala` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `Teams_idTime` INT NOT NULL,
  PRIMARY KEY (`idControle`),
  UNIQUE INDEX `position_UNIQUE` (`position` ASC) VISIBLE,
  INDEX `fk_Controle_Teams1_idx` (`Teams_idTime` ASC) VISIBLE,
  CONSTRAINT `fk_Controle_Teams1`
    FOREIGN KEY (`Teams_idTime`)
    REFERENCES `ftcAwards`.`Teams` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ftcAwards`.`Design`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`Design` (
  `idDesign` INT NOT NULL,
  `motive` VARCHAR(45) NOT NULL,
  `premiado` TINYINT NOT NULL,
  `sala` VARCHAR(45) NOT NULL,
  `position` INT NOT NULL,
  `Teams_idTime` INT NOT NULL,
  PRIMARY KEY (`idDesign`),
  INDEX `fk_Design_Teams1_idx` (`Teams_idTime` ASC) VISIBLE,
  CONSTRAINT `fk_Design_Teams1`
    FOREIGN KEY (`Teams_idTime`)
    REFERENCES `ftcAwards`.`Teams` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ftcAwards`.`Inovacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`Inovacao` (
  `idInovacao` INT NOT NULL,
  `motive` VARCHAR(45) NOT NULL,
  `premiado` TINYINT NOT NULL,
  `sala` VARCHAR(45) NOT NULL,
  `position` INT NOT NULL,
  `Teams_idTime` INT NOT NULL,
  PRIMARY KEY (`idInovacao`),
  UNIQUE INDEX `position_UNIQUE` (`position` ASC) VISIBLE,
  INDEX `fk_Inovacao_Teams1_idx` (`Teams_idTime` ASC) VISIBLE,
  CONSTRAINT `fk_Inovacao_Teams1`
    FOREIGN KEY (`Teams_idTime`)
    REFERENCES `ftcAwards`.`Teams` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ftcAwards`.`Motivacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`Motivacao` (
  `idMotivacao` INT NOT NULL,
  `motive` VARCHAR(45) NOT NULL,
  `premiado` TINYINT NOT NULL,
  `sala` VARCHAR(45) NOT NULL,
  `position` INT NOT NULL,
  `Teams_idTime` INT NOT NULL,
  PRIMARY KEY (`idMotivacao`),
  UNIQUE INDEX `position_UNIQUE` (`position` ASC) VISIBLE,
  INDEX `fk_Motivacao_Teams1_idx` (`Teams_idTime` ASC) VISIBLE,
  CONSTRAINT `fk_Motivacao_Teams1`
    FOREIGN KEY (`Teams_idTime`)
    REFERENCES `ftcAwards`.`Teams` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ftcAwards`.`PensamentoCriativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ftcAwards`.`PensamentoCriativo` (
  `idPensamentoCriativo` INT NOT NULL,
  `motive` VARCHAR(45) NOT NULL,
  `premiado` TINYINT NOT NULL,
  `sala` VARCHAR(45) NOT NULL,
  `position` INT NOT NULL,
  `Teams_idTime` INT NOT NULL,
  PRIMARY KEY (`idPensamentoCriativo`),
  UNIQUE INDEX `position_UNIQUE` (`position` ASC) VISIBLE,
  INDEX `fk_PensamentoCriativo_Teams1_idx` (`Teams_idTime` ASC) VISIBLE,
  CONSTRAINT `fk_PensamentoCriativo_Teams1`
    FOREIGN KEY (`Teams_idTime`)
    REFERENCES `ftcAwards`.`Teams` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
