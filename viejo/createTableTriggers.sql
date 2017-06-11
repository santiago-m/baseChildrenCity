create table prueba (
	dni int,
	fecha_nacimiento date,
	edad int
)ENGINE InnoDB;

DELIMITER //

CREATE TRIGGER trig_pruebaFecha BEFORE INSERT ON prueba
FOR EACH ROW
BEGIN
    SET NEW.edad = edad(NEW.fecha_nacimiento, curdate());
END
//

CREATE TRIGGER trig_pruebaFechaUpd8 BEFORE UPDATE ON prueba
FOR EACH ROW
BEGIN
    SET NEW.edad = edad(NEW.fecha_nacimiento, curdate());
END
//

DELIMITER ;

DROP FUNCTION IF EXISTS `edad`; 
CREATE FUNCTION `edad` (
  `pdate_begin` DATE,
  `pdate_end` DATE
) RETURNS INT(11) UNSIGNED   
COMMENT 'Calc age between two dates as INT' 
DETERMINISTIC NO SQL SQL SECURITY DEFINER
RETURN floor(TIMESTAMPDIFF(YEAR, pdate_begin, pdate_end)) ;

insert into prueba (dni, fecha_nacimiento) values
	(38417696, '1995-06-15');
    
select * from prueba;
