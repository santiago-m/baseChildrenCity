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
    `nro_doc` INTEGER NOT NULL,
	`tipo_doc` VARCHAR(10) NOT NULL,
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10),
    `estado` ENUM ('ingresado', 'egresado'),
    `condicion` ENUM ('dia', 'permanente'),
    `fecha_nac` DATE,
    `edad` INT,
    `peso` INT,
    `talla` VARCHAR(2),
    `telefono` VARCHAR(15),
    `nro_casa` INTEGER,
	`nro_legajo` INTEGER,
	`nro_hist` INTEGER NOT NULL,
    `fecha_ingreso` DATE,
    PRIMARY KEY(`nro_doc`,`tipo_doc`),
    CONSTRAINT `casaMenor` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `leg` FOREIGN KEY (`nro_legajo`) REFERENCES `Legajo`(`nro_legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `hClinica` FOREIGN KEY (`nro_hist`) REFERENCES `Historia_Clinica`(`nro_hist`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Personal`;
CREATE TABLE `Personal` (
    `nro_doc` INTEGER NOT NULL,
	`tipo_doc` VARCHAR(10) NOT NULL,
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10),
    `direccion` VARCHAR(20),
    `tel_fijo` VARCHAR(15),
   PRIMARY KEY(`nro_doc`,`tipo_doc`)
)ENGINE InnoDB;


DROP TABLE IF EXISTS `MTelPersonal`;
CREATE TABLE `MTelPersonal` (
    `nro_doc` INTEGER NOT NULL,
    `tipo_doc` VARCHAR(10) NOT NULL,
    `celular` VARCHAR(15),
    PRIMARY KEY (`nro_doc`,`tipo_doc`, `celular`),
    CONSTRAINT `telPer` FOREIGN KEY (`nro_doc`,`tipo_doc`) REFERENCES `Personal`(`nro_doc`,`tipo_doc`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `Visitante`;
CREATE TABLE `Visitante` (
	`nro_doc` INTEGER NOT NULL,
	`tipo_doc` VARCHAR(10) NOT NULL,
    `apellido` VARCHAR(10),
    `nombre` VARCHAR(10),
    PRIMARY KEY(`nro_doc`,`tipo_doc`)
)ENGINE InnoDB;

DROP TABLE IF EXISTS `Visita`;
CREATE TABLE `Visita` (
	`nro_visita` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nro_doc_menor` INTEGER NOT NULL,
    `tipo_doc_menor` VARCHAR(10) NOT NULL,
    `nro_doc_visitante` INTEGER NOT NULL,
    `tipo_doc_visitante` VARCHAR(10) NOT NULL,
    `fecha` DATE,
    `hora_llegada` TIME,
    `hora_salida` TIME,
    CONSTRAINT `doc_menor` FOREIGN KEY (`nro_doc_menor`, `tipo_doc_menor`) REFERENCES `Menor`(`nro_doc`,`tipo_doc`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `doc_visitante` FOREIGN KEY (`nro_doc_visitante`,`tipo_doc_visitante`) REFERENCES `Visitante`(`nro_doc`,`tipo_doc`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE InnoDB;


DROP TABLE IF EXISTS `a_cargo`;
CREATE TABLE `a_cargo`(
    `nro_casa` INTEGER NOT NULL,
    `nro_doc_personal` INTEGER NOT NULL,
    `tipo_doc_personal` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`nro_casa`, `nro_doc_personal`, `tipo_doc_personal`),
    CONSTRAINT `doc` FOREIGN KEY (`nro_doc_personal`, `tipo_doc_personal`) REFERENCES `Personal`(`nro_doc`,`tipo_doc`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `casa` FOREIGN KEY (`nro_casa`) REFERENCES `Casa`(`nro_casa`) ON DELETE CASCADE ON UPDATE CASCADE
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

DROP TABLE IF EXISTS `Ocurre`;
CREATE TABLE `Ocurre`(
    `nro_casa` INTEGER NOT NULL,
    `nro_doc_personal` INTEGER NOT NULL,
    `tipo_doc_personal` VARCHAR(10) NOT NULL,
    `fecha` DATE,
    `hora_inicio` TIME,
    `hora_fin` TIME,
    PRIMARY KEY(`nro_casa`,`nro_doc_personal`,`tipo_doc_personal`,`fecha`),
    CONSTRAINT `agregacion` FOREIGN KEY (`nro_casa`,`nro_doc_personal`,`tipo_doc_personal`) REFERENCES `a_cargo`(`nro_casa`,`nro_doc_personal`,`tipo_doc_personal`) ON DELETE CASCADE ON UPDATE CASCADE
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


DROP TABLE IF EXISTS `Audit`;
CREATE TABLE `Audit`(
     `old_estado` ENUM ('ingresado', 'egresado'),
     `old_condicion` ENUM ('dia','permanente'),
     `old_peso` INT,
     `old_talla` VARCHAR(2),
     `old_telefono` VARCHAR(15),
     `old_nro_casa` INTEGER,
     `new_estado` ENUM ('ingresado', 'egresado'),
     `new_condicion` ENUM ('dia','permanente'),
     `new_peso` INT,
     `new_talla` VARCHAR(2),
     `new_telefono` VARCHAR(15),
     `new_nro_casa` INTEGER,
     `fecha_modificacion` DATE,
     `usuario` VARCHAR(10),
     `tbl_name` VARCHAR(100)    
)ENGINE InnoDB;


DELIMITER //

CREATE TRIGGER trig_edad BEFORE INSERT ON `Menor`
FOR EACH ROW
BEGIN
    SET NEW.`edad` = `edad`(NEW.`fecha_nac`, curdate());
END
//

CREATE TRIGGER trig_updateMenor BEFORE UPDATE ON `Menor`
FOR EACH ROW
BEGIN
    SET NEW.`edad` = `edad`(NEW.`fecha_nac`, curdate());
    INSERT INTO Audit(`old_estado`, `old_condicion`, `old_peso`, `old_talla`, `old_telefono`, `old_nro_casa`, `new_estado`, `new_condicion`, `new_peso`, `new_talla`, `new_telefono`, `new_nro_casa`, `fecha_modificacion`, `usuario`, `tbl_name`)
        VALUES (OLD.`estado`, OLD.`condicion`, OLD.`peso`, OLD.`talla`, OLD.`telefono`, OLD.`nro_casa`, NEW.`estado`, NEW.`condicion`, NEW.`peso`, NEW.`talla`, NEW.`telefono`, NEW.`nro_casa`, curdate(), current_user(), "Menor");
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


