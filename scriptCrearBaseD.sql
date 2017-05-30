CREATE DATABASE IF NOT EXISTS  ChildrenCity;
USE ChildrenCity;
DROP TABLE IF EXISTS `Menor`;
CREATE TABLE `Menor` (
    `nro_doc` INTEGER NOT NULL PRIMARY KEY,
	`tipo_doc` VARCHAR(10),
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10),
    `estado` ENUM ('ingresado', 'egresado'),
    `condicion` ENUM ('dia', 'permanente'),
    `fecha_nac` DATE,
    `edad` INT,
    `peso` INT,
    `talla` VARCHAR(1),
    `telefono` INTEGER,
    `nro_casa` INTEGER,
	`nro_legajo` INTEGER,
    CONSTRAINT `casa` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`),
    CONSTRAINT `leg` FOREIGN KEY (`nro_legajo`) REFERENCES `Legajo`(`nro_legajo`)
)ENGINE InnoDB;

DROP TABLE IF EXISTS `Personal`;
CREATE TABLE `Personal` (
    `nro_doc` INTEGER NOT NULL PRIMARY KEY,
	`tipo_doc` VARCHAR(10),
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10),
    `direccion` VARCHAR(20),
    `tel_fijo` INTEGER
)ENGINE InnoDB;

DROP TABLE IF EXISTS `Visitante`;
CREATE TABLE `Visitante` (
	`nro_doc` INTEGER NOT NULL PRIMARY KEY,
	`tipo_doc` VARCHAR(10),
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10)
)ENGINE InnoDB;

CREATE TABLE `MTelPersonal` (
    `nro_doc` INTEGER NOT NULL PRIMARY KEY,
    `celulares` INTEGER PRIMARY KEY,
CONSTRAINT `telPer` FOREIGN KEY (`nro_doc`) REFERENCES `Personal`(`nro_doc`)
)ENGINE InnoDB; 

CREATE TABLE `Casa`(
	`nro_casa` INTEGER NOT NULL PRIMARY KEY
)ENGINE InnoDB;

CREATE TABLE `Historia_Clinica`(
	`nro_hist` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_doc` INTEGER NOT NULL,
    CONSTRAINT `dc` FOREIGN KEY (`nro_doc`) REFERENCES `Menor`(`nro_doc`)
)ENGINE InnoDB;

CREATE TABLE `MAntecedente_Salud`(
	`nro_hist` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `antecedentes` VARCHAR(30),
    CONSTRAINT `ant` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`)
)ENGINE InnoDB;

CREATE TABLE `Episodio_Salud`(
	`nro_item` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_hist` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(50), 
    `fecha` DATE,
     CONSTRAINT `histc` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`)
)ENGINE InnoDB;

CREATE TABLE `Medicamento`(
	`nombre_med` VARCHAR(15) PRIMARY KEY NOT NULL
)
ENGINE InnoDB;

CREATE TABLE `Recetado`(
	`nombre_med` VARCHAR(15) PRIMARY KEY NOT NULL,
    `nro_item` INTEGER NOT NULL AUTO_INCREMENT,
    CONSTRAINT `rec` FOREIGN KEY (`nro_item`) REFERENCES `Episodio_Salud`(`nro_item`),
    CONSTRAINT `rec2` FOREIGN KEY (`nombre_med`) REFERENCES `Medicamento`(`nombre_med`)
)
ENGINE InnoDB;