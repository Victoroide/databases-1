CREATE DATABASE UNIVSC2024;
USE UNIVSC2024;

CREATE TABLE ALUMNO (
	Registro integer not null primary key, 
    NombreCompleto varchar(60) not null, 
    CI integer not null, 
    Telefono integer, 
    CorreoElectronico varchar(60),
    Sexo char not null, 
    EstadoCivil char not null, 
    Direccion varchar(50),
    FechaNac date not null
);

/* Muestra todos los atributos de la tabla ALUMNO */
SELECT * FROM ALUMNO;

/* Insertar datos dentro de la tabla ALUMNO */
INSERT INTO ALUMNO VALUES (111, 'Joaquin Chumacero', 323, 7102030, 'jchuma@gmail.com', 'M','S','Urb. Las Palmas','2002/01/10');
INSERT INTO ALUMNO VALUES (222, 'Saturnino Mamani', 556, 6782929, 'smamani@gmail.com', 'M','C','Calle Landivar #500','2005/12/15');
INSERT INTO ALUMNO VALUES (333, 'Fabiola Mendez', '777', '7202020', 'fmendez@gmail.com', 'F', 'S', 'Calle Seoane #600', '2000-03-10');
INSERT INTO ALUMNO VALUES (444, 'Carlos Camacho', '555', NULL, 'camacho@gmail.com', 'M', 'S', 'Urb. Las Palmas', '2005-06-20');

/* Modificar el apellido paterno de Joaquin Chumacero */
UPDATE ALUMNO SET NombreCompleto="Joaquin Chumachuma" WHERE Registro=111;
UPDATE ALUMNO SET NombreCompleto="Joaquin Chumaceiro" WHERE Registro=111;

/* Eliminar a Joaquin Chumacero y Saturnino Mamani */
DELETE FROM ALUMNO WHERE Registro=111;
DELETE FROM ALUMNO WHERE Registro=222;

/* Mostrar el registro y el nombre de la tabla AlUMNO */
SELECT Registro, NombreCompleto FROM ALUMNO;

/* Mostrar todos los alumnos varones */
SELECT * FROM ALUMNO WHERE Sexo='M';
/* Mostar los alumnos varones solteros */
SELECT * FROM ALUMNO WHERE Sexo='M' AND EstadoCivil='S';

/* Mostar los alumnos que no tienen telefono */
SELECT * FROM ALUMNO WHERE Telefono IS NULL;
/* Mostrar los alumnos que tienen telefono */
SELECT * FROM ALUMNO WHERE Telefono IS NOT NULL; 

/* Borrar la tabla ALUMNO */
DROP TABLE ALUMNO;

/* Borrar la base de datos */
DROP DATABASE UNIVSC2024;

/* Mostrar los alumnos, donde su nombre comienza con J */
SELECT * FROM ALUMNO WHERE NombreCompleto LIKE 'J%';
/* Mostrar los alumnos, donde su nombre termina en O */
SELECT * FROM ALUMNO WHERE NombreCompleto LIKE '%o%';
/* Mostrar todos los alumnos, donde su nombre tenga la letra A */
SELECT * FROM ALUMNO WHERE NombreCompleto LIKE '%a%';

/* Mostrar la cantidad de alumnos que existen */
SELECT COUNT(*) FROM ALUMNO;
SELECT COUNT(Registro) FROM ALUMNO ;

/* Mostrar la cantidad de alumnos varones */
SELECT COUNT(*) AS alumnos_varones FROM ALUMNO WHERE Sexo='M';
/* Mostrar la cantidad de alumnos que tienen telefono */
SELECT COUNT(Telefono) FROM ALUMNO; 
/* Mostrar la cantidad de alumnos que no tienen telefono */
SELECT COUNT(*) FROM ALUMNO WHERE Telefono IS NULL;

/* Mostrar en orden ascendente los alumnos ordenados por su nombre completo */
SELECT * FROM ALUMNO ORDER BY NombreCompleto ASC;
/* Mostrar en orden descendente los alumnos ordenados por su nombre completo */
SELECT * FROM ALUMNO ORDER BY NombreCompleto DESC;

/* Mostrar la cantidad de alumnos varones y mujeres que existen */
SELECT Sexo, COUNT(*) FROM ALUMNO GROUP BY Sexo

