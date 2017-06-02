CREATE DATABASE IF NOT EXISTS  ChildrenCity;
USE ChildrenCity;

DROP TABLE IF EXISTS `Casa`;
CREATE TABLE `Casa`(
    `nro_casa` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
)ENGINE InnoDB;

/*nro_legajo no es asignado automaticamente porque proviene del SENAF*/
DROP TABLE IF EXISTS `Legajo`;
CREATE TABLE `Legajo`(
    `nro_legajo` INTEGER PRIMARY KEY NOT NULL,
    `visita_familiar` BIT,
    `foto_dni` VARCHAR(60),
    `part_nac` VARCHAR(60),
    `otros_hogares` VARCHAR(60) /*Informes escaneados de otros hogares. URL*/
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Historia_Clinica`;
CREATE TABLE `Historia_Clinica`(
	`nro_hist` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
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
    `talla` VARCHAR(2),
    `telefono` BIGINT,
    `nro_casa` INTEGER,
	`nro_legajo` INTEGER,
	`nro_hist` INTEGER NOT NULL,
    CONSTRAINT `casaMenor` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `leg` FOREIGN KEY (`nro_legajo`) REFERENCES `Legajo`(`nro_legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `hClinica` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Personal`;
CREATE TABLE `Personal` (
    `nro_doc` INTEGER NOT NULL PRIMARY KEY,
	`tipo_doc` VARCHAR(10),
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10),
    `direccion` VARCHAR(20),
    `tel_fijo` BIGINT
)ENGINE InnoDB;


DROP TABLE IF EXISTS `MTelPersonal`;
CREATE TABLE `MTelPersonal` (
    `nro_doc` INTEGER NOT NULL,
    `celular` BIGINT,
    PRIMARY KEY (`nro_doc`, `celular`),
    CONSTRAINT `telPer` FOREIGN KEY (`nro_doc`) REFERENCES `Personal`(`nro_doc`) ON DELETE CASCADE ON UPDATE CASCADE
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
	`nro_visita` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_doc_menor` INTEGER NOT NULL,
    `nro_doc_visitante` INTEGER NOT NULL,
    `fecha` DATE,
    `hora_llegada` TIME,
    `hora_salida` TIME,
    CONSTRAINT `doc_menor` FOREIGN KEY (`nro_doc_menor`) REFERENCES `Menor`(`nro_doc`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `doc_visitante` FOREIGN KEY (`nro_doc_visitante`) REFERENCES `Visitante`(`nro_doc`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `a_cargo`;
CREATE TABLE `a_cargo`(
    `nro_casa` INTEGER NOT NULL,
    `nro_doc` INTEGER NOT NULL,
    `fecha` DATE,
    `h_inicio` TIME,
    `h_fin` TIME,
    CONSTRAINT `doc` FOREIGN KEY (`nro_doc`) REFERENCES `Personal`(`nro_doc`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `casa` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`nro_casa`, `nro_doc`)
)ENGINE InnoDB;


DROP TABLE IF EXISTS `MAntecedente_Salud`;
CREATE TABLE `MAntecedente_Salud`(
	`nro_hist` INTEGER NOT NULL,
    `antecedentes` VARCHAR(30),
    PRIMARY KEY (`nro_hist`, `antecedentes`),
    CONSTRAINT `ant` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Episodio_Salud`;
CREATE TABLE `Episodio_Salud`(
	`nro_episodio` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_hist` INTEGER NOT NULL,
    `descripcion` VARCHAR(50),
    `fecha` DATE,
     CONSTRAINT `histc` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Medicamento`;
CREATE TABLE `Medicamento`(
	`nro_medicamento` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`nombre_med` VARCHAR(15)
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Receta`;
CREATE TABLE `Receta`(
	`nro_medicamento` INTEGER NOT NULL,
    `nro_episodio` INTEGER NOT NULL,
    `dosis`	VARCHAR(20),
    PRIMARY KEY (`nro_medicamento`, `nro_episodio`),
    CONSTRAINT `rec` FOREIGN KEY (`nro_episodio`) REFERENCES `Episodio_Salud`(`nro_episodio`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `rec2` FOREIGN KEY (`nro_medicamento`) REFERENCES `Medicamento`(`nro_medicamento`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DELIMITER //

CREATE TRIGGER trig_edad BEFORE INSERT ON `Menor`
FOR EACH ROW
BEGIN
    SET NEW.`edad` = `edad`(NEW.`fecha_nac`, curdate());
END
//

CREATE TRIGGER trig_edadUpd8 BEFORE UPDATE ON `Menor`
FOR EACH ROW
BEGIN
    SET NEW.`edad` = `edad`(NEW.`fecha_nac`, curdate());
END
//

DELIMITER ;

DROP FUNCTION IF EXISTS `edad`; 
CREATE FUNCTION `edad` (
  `pdate_begin` DATE,
  `pdate_end` DATE
) RETURNS INT(11) UNSIGNED   
COMMENT 'Calcula la edad dadas dos fechas'
DETERMINISTIC NO SQL SQL SECURITY DEFINER
RETURN floor(TIMESTAMPDIFF(YEAR, pdate_begin, pdate_end));


