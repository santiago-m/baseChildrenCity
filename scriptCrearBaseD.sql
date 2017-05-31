CREATE DATABASE IF NOT EXISTS  ChildrenCity;
USE ChildrenCity;

DROP TABLE IF EXISTS `Casa`;
CREATE TABLE `Casa`(
    `nro_casa` INTEGER NOT NULL PRIMARY KEY
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Legajo`;
CREATE TABLE `Legajo`(
    `nro_legajo` INTEGER PRIMARY KEY NOT NULL,
    `visita_familiar` VARCHAR(30),
    `foto_dni` VARCHAR(30),
    `part_nac` VARCHAR(30),
    `otros_hogares` VARCHAR(30)
)ENGINE InnoDB;


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
    CONSTRAINT `casaMenor` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE,
    CONSTRAINT `leg` FOREIGN KEY (`nro_legajo`) REFERENCES `Legajo`(`nro_legajo` ON DELETE CASCADE)
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


DROP TABLE IF EXISTS `MTelPersonal`;
CREATE TABLE `MTelPersonal` (
    `nro_doc` INTEGER NOT NULL,
    `celular` INTEGER,
    PRIMARY KEY (`nro_doc`, `celular`),
    CONSTRAINT `telPer` FOREIGN KEY (`nro_doc`) REFERENCES `Personal`(`nro_doc`) ON DELETE CASCADE,
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Visitante`;
CREATE TABLE `Visitante` (
	`nro_doc` INTEGER NOT NULL PRIMARY KEY,
	`tipo_doc` VARCHAR(10),
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10)
)ENGINE InnoDB;

DROP TABLE IF EXISTS `Visita`;
CREATE TABLE `Visita` (
    `nro_doc_menor` INTEGER NOT NULL,
    `nro_doc_visitante` INTEGER NOT NULL,
    `nro_visita` INTEGER,
    `dia_hora` DATETIME,
    PRIMARY KEY (`nro_doc_menor`, `nro_doc_visitante`),
    CONSTRAINT `doc_menor` FOREIGN KEY (`nro_doc_menor`) REFERENCES `Menor`(`nro_doc`) ON DELETE CASCADE,
    CONSTRAINT `doc_visitante` FOREIGN KEY (`nro_doc_visitante`) REFERENCES `Visitante`(`nro_doc`) ON DELETE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `a_cargo`;
CREATE TABLE `a_cargo`(
	`nro_casa` INTEGER NOT NULL,
    `nro_doc` INTEGER NOT NULL,
    CONSTRAINT `doc` FOREIGN KEY (`nro_doc`) REFERENCES `Personal`(`nro_doc`) ON DELETE CASCADE,
    CONSTRAINT `casa` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE,
    PRIMARY KEY (`nro_casa`, `nro_doc`) ON DELETE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Ocasion`;
CREATE TABLE `Ocasion`(
	`nro_casa` INTEGER NOT NULL,
    `nro_doc` INTEGER NOT NULL,
    `fecha` DATE,
    PRIMARY KEY (`nro_casa`, `nro_doc`, `fecha`),
	CONSTRAINT `doc_Ocasion` FOREIGN KEY (`nro_doc`) REFERENCES `Personal`(`nro_doc`) ON DELETE CASCADE,
    CONSTRAINT `casa_Ocasion` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Historia_Clinica`;
CREATE TABLE `Historia_Clinica`(
	`nro_hist` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_doc` INTEGER NOT NULL,
    CONSTRAINT `dc` FOREIGN KEY (`nro_doc`) REFERENCES `Menor`(`nro_doc`) ON DELETE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `MAntecedente_Salud`;
CREATE TABLE `MAntecedente_Salud`(
	`nro_hist` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `antecedentes` VARCHAR(30),
    CONSTRAINT `ant` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`) ON DELETE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Episodio_Salud`;
CREATE TABLE `Episodio_Salud`(
	`nro_item` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_hist` INTEGER NOT NULL,
    `descripcion` VARCHAR(50),
    `fecha` DATE,
     CONSTRAINT `histc` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`) ON DELETE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Medicamento`;
CREATE TABLE `Medicamento`(
	`nombre_med` VARCHAR(15) PRIMARY KEY NOT NULL
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Recetado`;
CREATE TABLE `Recetado`(
	`nombre_med` VARCHAR(15) PRIMARY KEY NOT NULL,
    `nro_item` INTEGER NOT NULL AUTO_INCREMENT,
    `dosis`	VARCHAR(20),
    CONSTRAINT `rec` FOREIGN KEY (`nro_item`) REFERENCES `Episodio_Salud`(`nro_item`) ON DELETE CASCADE,
    CONSTRAINT `rec2` FOREIGN KEY (`nombre_med`) REFERENCES `Medicamento`(`nombre_med`) ON DELETE CASCADE
)ENGINE InnoDB;
