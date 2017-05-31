USE ChildrenCity;

INSERT INTO `Casa` (`nro_casa`) VALUES
    (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL);

INSERT INTO `Medicamento` (`nombre_med`) VALUES
	('none'),
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

 INSERT INTO `a_cargo` (`nro_casa`, `nro_doc`, `h_inicio`, `h_fin`) VALUES
 	(1, 23654124, '10:00:00', '22:30:00'),
 	(2, 15234622, '10:00:00', '23:30:00'),
 	(5, 23654124, '09:00:00', '00:30:00'),
 	(7, 25367124, '08:00:00', '22:30:00'),
 	(9, 14257236, '08:00:00', '21:30:00'),
 	(6, 17286192, '09:00:00', '22:00:00'),
 	(8, 15234622, '14:00:00', '21:30:00'),
 	(4, 23654124, '12:00:00', '20:30:00'),
 	(10, 17286192, '14:00:00', '23:00:00'),
 	(3, 23654124, '14:00:00', '23:30:00');


INSERT INTO `Ocasion` (`nro_casa`, `nro_doc`, `fecha`) VALUES
	(1, 23654124, '2017-05-21'),
	(2, 15234622, '2017-03-25'),
	(5, 23654124, '2017-01-05'),
	(7, 25367124, '2017-08-07'),
	(9, 14257236, '2017-01-13'),
	(6, 17286192, '2017-06-14'),
	(8, 15234622, '2017-03-08'),
	(4, 23654124, '2017-12-15'),
	(10, 17286192, '2017-09-23'),
	(3, 23654124,'2017-09-25');

INSERT INTO `Historia_Clinica` (`nro_doc`) VALUES
	(50417693),
	(58217553),
	(53877633),
	(45439524),
	(60222510);

INSERT INTO `MAntecedente_Salud` (`nro_hist`, `antecedentes`) VALUES
	(1, 'InserteAquiAntecedentes'),
	(2, 'InserteAquiAntecedentes'),
	(3, 'InserteAquiAntecedentes'),
	(4, 'InserteAquiAntecedentes'),
	(5, 'InserteAquiAntecedentes');

INSERT INTO `Episodio_Salud` (`nro_hist`, `descripcion`, `fecha`) VALUES
	(1, 'Varicela', '2014-05-13'),
	(1, 'Migraña', '2016-12-11'),
	(1, 'Hipo', '2016-01-02'),
	(2, 'Varicela', '2011-03-10'),
	(3, 'Varicela', '2015-02-21'),
	(3, 'Gripe', '2016-07-04'),
	(4, 'Varicela', '2016-03-11'),
	(5, 'Varicela', '2015-08-30'),
	(5, 'DolorDeGarganta', '2016-12-15');
	
INSERT INTO `Recetado` (`nombre_med`, `nro_item`, `dosis`) VALUES
	('none', 1, 'none'),
	('none', 4, 'none'),
	('none', 5, 'none'),
	('none', 7, 'none'),
	('none', 8, 'none'),
	('Paracetamol', 2, '500gm c/8hs'),
	('none', 3, 'none'),
	('Amoxicilina', 6, '1 c/12hs'),
	('Ibuprofeno', 9, '500gm c/8hs');