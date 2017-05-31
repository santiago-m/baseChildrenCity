USE ChildrenCity;

INSERT INTO `Casa` (`nro_casa`) VALUES
    (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL);

INSERT INTO `Medicamento` (`nombre_med`) VALUES
 	('Diclofenac'),
 	('Ibuprofeno'),
 	('Amoxicilina'),
 	('Paracetamol'),
 	('Dipirona');

INSERT INTO `Legajo` (`nro_legajo`, `visita_familiar`, `foto_dni`, `part_nac`, `otros_hogares`) VALUES
	(100, 1, 'http://imagenes.com/dniPanchito', 'http://imagenes.com/part_nacPanchito', 'http://imagenes.com/listadoHogaresPanchito'),
	(101, 1, 'http://imagenes.com/dniRogelio', 'http://imagenes.com/part_nacRogelio', 'http://imagenes.com/listadoHogaresRogelio'),
	(102, 0, 'http://imagenes.com/dniRoberto', 'http://imagenes.com/part_nacRoberto', 'http://imagenes.com/listadoHogaresRoberto'),
	(103, 1, 'http://imagenes.com/dniJose', 'http://imagenes.com/part_nacJose', 'http://imagenes.com/listadoHogaresJose'),
	(104, 0, 'http://imagenes.com/dniPaula', 'http://imagenes.com/part_nacPaula', 'http://imagenes.com/listadoHogaresPaula');

INSERT INTO `Menor` (`nro_doc`, `tipo_doc`, `apellido`, `nombre`, `estado`, `condicion`, `fecha_nac`, `peso`, `talla`, `telefono`, `nro_casa`, `nro_legajo`) VALUES
	(50417693, 'DNI', 'Grosso', 'Jose', 'ingresado', 'permanente', '2005-07-13', 50, 'S', 3584555443, 7, 102),
	(58217553, 'DNI', 'Rodriguez', 'Rogelio', 'ingresado', 'dia', '2006-08-08', 45, 'XS', 3586212534, 5, 104),
	(53877633, 'DNI', 'Tobaldo', 'Roberto', 'egresado', 'dia', '2008-10-20', 53, 'M', 3585563412, 4, 101),
	(45439524, 'DNI', 'Gimenez', 'Francisco', 'egresado', 'permanente', '2005-03-21', 60, 'L', 3584887324, 7, 100),
	(60222510, 'DNI', 'Menendez', 'Paula', 'ingresado', 'dia', '2000-01-11', 61, 'L', 3584223652, 2, 103);
 
 INSERT INTO `Visitante` (`nro_doc`, `tipo_doc`, `apellido`, `nombre`) VALUES 
 	(34213567,'DNI','Fenoglio','Marcelo'),
 	(34247175,'DNI','Romero','Juana'),
 	(37643138,'DNI','Ramirez','Carla'),
 	(35123571,'DNI','Di Santo','Gonzalo'),
 	(32567124,'DNI','Heredia','Maria');
 
 INSERT INTO `Personal` (`nro_doc`, `tipo_doc`, `apellido`, `nombre`, `direccion`, `tel_fijo`) VALUES
 	(23654124,'DNI','Romero','Nicolas','Lamadrid 236',358460123),
 	(15234622,'DNI','Gonzalez','Yamila','Colon 1921',358470235),
 	(25367124,'DNI','Diaz','Camila','Mendoza 975',358467213),
 	(14257236,'DNI','Lucero','Daniel','Buenos Aires 45',358470671),
 	(17286192,'DNI','Martinez','German','Sobremonte 765',358476194);

 INSERT INTO `MTelPersonal` (`nro_doc`, `celular`) VALUES
 	(23654124, 3585331648),
 	(23654124, 3584453352),
 	(15234622, 3516687544),
 	(25367124, 3584553987),
 	(17286192, 3585147638),
 	(14257236, 3586652237),
 	(14257236, 3585559892);

 INSERT INTO `Visita` (`nro_doc_menor`, `nro_doc_visitante`, `dia_hora`) VALUES
 	(53877633, 34213567, '2017-05-17 19:35:40'),
 	(45439524, 37643138, '2016-02-11 16:40:19'),
 	(60222510, 34247175, '2017-03-25 10:05:15'),
 	(60222510, 32567124, '2016-07-23 10:13:04'),
 	(45439524, 34213567, '2017-07-23 11:09:30'),
 	(53877633, 35123571, '2016-05-15 16:35:50'),
 	(45439524, 32567124, '2017-04-14 18:45:43');
 
 