SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `SISLIC` ;
CREATE SCHEMA IF NOT EXISTS `SISLIC` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `SISLIC` ;

-- -----------------------------------------------------
-- Table `SISLIC`.`fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`fornecedor` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`fornecedor` (
  `id_fornecedor` INT NOT NULL AUTO_INCREMENT ,
  `razao_social` VARCHAR(50) NOT NULL ,
  `telefone` VARCHAR(20) NULL ,
  `pontucao` INT NULL ,
  PRIMARY KEY (`id_fornecedor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`funcionario` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`funcionario` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `telefone` VARCHAR(45) NULL ,
  `cargo` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_funcionario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`pedido` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT ,
  `data_lancamento` DATE NOT NULL ,
  `data_limite` DATE NOT NULL ,
  `id_funcionario` INT NULL ,
  PRIMARY KEY (`id_pedido`) ,
  INDEX `id_funcionario` (`id_funcionario` ASC) ,
  CONSTRAINT `id_funcionario`
    FOREIGN KEY (`id_funcionario` )
    REFERENCES `SISLIC`.`funcionario` (`id_funcionario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`unidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`unidade` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`unidade` (
  `id_unidade` INT NOT NULL AUTO_INCREMENT ,
  `medida` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id_unidade`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`produto` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `descricao` VARCHAR(45) NULL ,
  `id_unidade` INT NULL ,
  PRIMARY KEY (`id_produto`) ,
  INDEX `id_medida` (`id_unidade` ASC) ,
  CONSTRAINT `id_medida`
    FOREIGN KEY (`id_unidade` )
    REFERENCES `SISLIC`.`unidade` (`id_unidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`categoria` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `descricao` VARCHAR(65) NULL ,
  PRIMARY KEY (`id_categoria`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`item_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`item_pedido` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`item_pedido` (
  `id_item_pedido` INT NOT NULL AUTO_INCREMENT ,
  `quantidade` INT NULL ,
  `preco_unitario` FLOAT NULL ,
  `id_produto` INT NOT NULL ,
  `id_pedido` INT NOT NULL ,
  PRIMARY KEY (`id_item_pedido`) ,
  INDEX `id_produto` (`id_produto` ASC) ,
  INDEX `fk_itemPedido_pedido1` (`id_pedido` ASC) ,
  CONSTRAINT `id_produto`
    FOREIGN KEY (`id_produto` )
    REFERENCES `SISLIC`.`produto` (`id_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itemPedido_pedido1`
    FOREIGN KEY (`id_pedido` )
    REFERENCES `SISLIC`.`pedido` (`id_pedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`catetogia_fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`catetogia_fornecedor` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`catetogia_fornecedor` (
  `id_catetogia_fornecedor` INT NOT NULL AUTO_INCREMENT ,
  `id_categoria` INT NOT NULL ,
  `id_fornecedor` INT NULL ,
  INDEX `id_categoria` (`id_categoria` ASC) ,
  PRIMARY KEY (`id_catetogia_fornecedor`) ,
  INDEX `id_fornecedor` (`id_fornecedor` ASC) ,
  CONSTRAINT `id_categoria`
    FOREIGN KEY (`id_categoria` )
    REFERENCES `SISLIC`.`categoria` (`id_categoria` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_fornecedor`
    FOREIGN KEY (`id_fornecedor` )
    REFERENCES `SISLIC`.`fornecedor` (`id_fornecedor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`lance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`lance` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`lance` (
  `id_lance` INT NOT NULL AUTO_INCREMENT ,
  `valor_total` FLOAT NOT NULL ,
  `id_pedido` INT NOT NULL ,
  `id_fornecedor` INT NOT NULL ,
  `data` DATE NULL ,
  PRIMARY KEY (`id_lance`) ,
  INDEX `id_pedido` (`id_pedido` ASC) ,
  INDEX `id_fornecedor` (`id_fornecedor` ASC) ,
  CONSTRAINT `id_pedido`
    FOREIGN KEY (`id_pedido` )
    REFERENCES `SISLIC`.`pedido` (`id_pedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_fornecedor`
    FOREIGN KEY (`id_fornecedor` )
    REFERENCES `SISLIC`.`fornecedor` (`id_fornecedor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SISLIC`.`log_penalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SISLIC`.`log_penalidade` ;

CREATE  TABLE IF NOT EXISTS `SISLIC`.`log_penalidade` (
  `id_log_pontuacao` INT NOT NULL AUTO_INCREMENT ,
  `id_fornecedor` INT NOT NULL ,
  `id_funcionario` INT NOT NULL ,
  `descricao` VARCHAR(45) NULL ,
  `valor` INT NULL ,
  PRIMARY KEY (`id_log_pontuacao`) ,
  INDEX `id_fornecedor` (`id_fornecedor` ASC) ,
  INDEX `id_funcionario` (`id_funcionario` ASC) ,
  CONSTRAINT `id_fornecedor`
    FOREIGN KEY (`id_fornecedor` )
    REFERENCES `SISLIC`.`fornecedor` (`id_fornecedor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_funcionario`
    FOREIGN KEY (`id_funcionario` )
    REFERENCES `SISLIC`.`funcionario` (`id_funcionario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
