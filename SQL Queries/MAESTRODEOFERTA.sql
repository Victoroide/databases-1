CREATE DATABASE MAESTRODEOFERTA;
USE MAESTRODEOFERTA;

CREATE TABLE DOCENTE (
	CI INTEGER PRIMARY KEY NOT NULL, 
    Nombre VARCHAR(60) NOT NULL
);

CREATE TABLE MATERIA(
	Sigla VARCHAR(6) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(60) NOT NULL
);

CREATE TABLE GRUPO(
	IDGrupo SMALLINT PRIMARY KEY NOT NULL, 
    Nombre VARCHAR(2) NOT NULL,
    CIDOCENTE INTEGER NOT NULL,
    SIGLAM VARCHAR(6) NOT NULL,
    IDPERIODO INTEGER NOT NULL,
    FOREIGN KEY (CIDOCENTE) REFERENCES DOCENTE(CI)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (SIGLAM) REFERENCES MATERIA(Sigla)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);
ALTER TABLE GRUPO ADD COLUMN IDPERIODO INTEGER;
ALTER TABLE GRUPO ADD FOREIGN KEY (IDPERIODO) REFERENCES PERIODO(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

CREATE TABLE HORARIO (
	IDGRUPO SMALLINT NOT NULL, 
    IDHorario TINYINT NOT NULL,
    FOREIGN KEY (IDGRUPO) REFERENCES GRUPO(IDGrupo)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(IDGRUPO, IDHorario),
    Dia VARCHAR(10) NOT NULL, 
    HoraI TIME NOT NULL, 	
    HoraF TIME NOT NULL
);

CREATE TABLE PERIODO (
	ID INTEGER PRIMARY KEY NOT NULL,
    Semestre TINYINT NOT NULL, 
    Año YEAR NOT NULL
);

CREATE TABLE ALUMNO(
	Registro INTEGER PRIMARY KEY NOT NULL, 
    Nombre VARCHAR(60) NOT NULL, 
    Telefono INTEGER NOT NULL
);

CREATE TABLE BOLETA (
	Nro INTEGER PRIMARY KEY NOT NULL, 
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    RegAlum INTEGER NOT NULL, 
    FOREIGN KEY (RegistroA) REFERENCES ALUMNO(Registro)
		ON UPDATE CASCADE
        ON DELETE CASCADE
); 

CREATE TABLE INSCRIBE (
	NroBoleta INTEGER NOT NULL, 
    IDGrupo SMALLINT NOT NULL, 
    PRIMARY KEY(NroBoleta, IDGRUPO),
    FOREIGN KEY (NroBoleta) REFERENCES BOLETA(Nro)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (IDGrupo) REFERENCES GRUPO(IDGrupo)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

DROP TABLE INSCRIBE;
DROP TABLE BOLETA;
DROP TABLE ALUMNO;

INSERT INTO DOCENTE VALUES (111, 'VEIZAGA GONZALES JOSUE OBED');
INSERT INTO DOCENTE VALUES (222, 'CONTRERAS VILLEGAS JUAN CARLOS');
INSERT INTO DOCENTE VALUES (333, 'LOPEZ WINNIPEG MARIO MILTON');

INSERT INTO MATERIA VALUES ('INF110', 'INTRODUCCION A LA INFORMATICA');
INSERT INTO MATERIA VALUES ('INF312', 'BASE DE DATOS I');

INSERT INTO GRUPO VALUES (100, 'SI', 111, 'INF110');
INSERT INTO GRUPO VALUES (101, 'Z4', 222, 'INF110');
INSERT INTO GRUPO VALUES (102, 'Z1', 333, 'INF110');
INSERT INTO GRUPO VALUES (103, 'SA', 111, 'INF312');
INSERT INTO GRUPO VALUES (104, 'SC', 111, 'INF312');
INSERT INTO GRUPO VALUES (105, 'SI', 111, 'INF110', 2);

INSERT INTO HORARIO VALUES (100, 1, 'MAR', '09:15', '11:30');
INSERT INTO HORARIO VALUES (100, 2, 'JUE', '09:15', '11:30');
INSERT INTO HORARIO VALUES (101, 1, 'LUN', '13:45', '15:15');
INSERT INTO HORARIO VALUES (101, 2, 'MIE', '13:45', '15:15');
INSERT INTO HORARIO VALUES (101, 3, 'VIE', '13:45', '15:15');
INSERT INTO HORARIO VALUES (102, 1, 'LUN', '07:00', '08:30');
INSERT INTO HORARIO VALUES (102, 2, 'MIE', '07:00', '08:30');
INSERT INTO HORARIO VALUES (102, 3, 'VIE', '07:00', '08:30');
INSERT INTO HORARIO VALUES (103, 1, 'LUN', '08:30', '10:00');
INSERT INTO HORARIO VALUES (103, 2, 'MIE', '08:30', '10:00');
INSERT INTO HORARIO VALUES (103, 3, 'VIE', '08:30', '10:00');
INSERT INTO HORARIO VALUES (104, 1, 'MAR', '07:00', '09:15');
INSERT INTO HORARIO VALUES (104, 2, 'JUE', '07:00', '09:15');
INSERT INTO HORARIO VALUES (105, 1, 'MAR', '09:15', '11:30');
INSERT INTO HORARIO VALUES (105, 2, 'JUE', '09:15', '11:30');

INSERT INTO PERIODO VALUES (1, 1, 2024);
INSERT INTO PERIODO VALUES (2, 2, 2024);
UPDATE GRUPO SET IDPERIODO=1;

INSERT INTO ALUMNO VALUES (202401, 'CARLOS GARCIA', 7102030);
INSERT INTO ALUMNO VALUES (202402, 'PATRICIA AGUILERA', 3568999);
INSERT INTO ALUMNO VALUES (202403, 'RENE LOPEZ', 7828288);

INSERT INTO BOLETA VALUES (1, '2024-03-10', '08:00', 202401);
INSERT INTO BOLETA VALUES (2, '2024-03-12', '09:00', 202402);
INSERT INTO BOLETA VALUES (3, '2024-03-12', '09:15', 202403);

INSERT INTO INSCRIBE VALUES (1, 100);
INSERT INTO INSCRIBE VALUES (1, 103);
INSERT INTO INSCRIBE VALUES (2, 103);
INSERT INTO INSCRIBE VALUES (3, 101);
INSERT INTO INSCRIBE VALUES (3, 104);

SELECT * FROM DOCENTE;
SELECT * FROM MATERIA;
SELECT * FROM GRUPO;
SELECT * FROM HORARIO;

/* Mostrar los docentes que enseñan la materia de introduccion a la informatica */
SELECT DOCENTE.CI, DOCENTE.Nombre
FROM DOCENTE, MATERIA, GRUPO
WHERE GRUPO.CIDOCENTE=DOCENTE.CI AND GRUPO.SIGLAM=MATERIA.SIGLA AND MATERIA.Nombre='INTRODUCCION A LA INFORMATICA'
GROUP BY DOCENTE.CI, DOCENTE.Nombre;

/* Mostrar los docentes que pasan clases de INTRODUCCION A LA INFORMATICA los dias Martes */
SELECT DOCENTE.CI, DOCENTE.Nombre
FROM DOCENTE, MATERIA, GRUPO, HORARIO
WHERE GRUPO.CIDOCENTE=DOCENTE.CI 
	AND GRUPO.SIGLAM=MATERIA.SIGLA 
	AND MATERIA.Nombre='INTRODUCCION A LA INFORMATICA' 
	AND GRUPO.IDGrupo=HORARIO.IDGRUPO 
	AND HORARIO.DIA='MAR';
    
/* Mostrar la cantidad de horarios que tiene la materia BASE DE DATOS I en su grupo SA*/
SELECT MATERIA.Nombre as Materia, GRUPO.Nombre AS Grupo, COUNT(IDHorario) AS Horarios
FROM MATERIA, GRUPO, HORARIO
WHERE GRUPO.SIGLAM=MATERIA.SIGLA 
	AND MATERIA.Nombre='BASE DE DATOS I' 
	AND GRUPO.IDGrupo=HORARIO.IDGRUPO 
	AND GRUPO.Nombre='SA';
    
/* Mostrar la cantidad de horarios por cada grupo */
SELECT MATERIA.Sigla, MATERIA.Nombre AS Materia, GRUPO.IDGrupo, GRUPO.Nombre AS Grupo, COUNT(IDHorario) AS Horarios
FROM MATERIA, GRUPO, HORARIO
WHERE GRUPO.SIGLAM=MATERIA.SIGLA 
	AND GRUPO.IDGrupo=HORARIO.IDGRUPO 
GROUP BY HORARIO.IDGrupo;

/* Mostrar la cantidad de grupos ofertados por docente */
SELECT DOCENTE.CI, DOCENTE.Nombre as Docente, COUNT(IDGrupo) as Grupos
FROM DOCENTE, GRUPO
WHERE DOCENTE.CI=CIDOCENTE 
GROUP BY DOCENTE.CI;

/* Mostrar los semestres en los cuales fue programado el docente JOSUE OBED VEIZAGA GONZALES en la materia INTRODUCCION A LA INFORMATICA */
SELECT DOCENTE.Nombre, MATERIA.Nombre, Semestre, Año
FROM DOCENTE, GRUPO, PERIODO, MATERIA
WHERE DOCENTE.CI=CIDOCENTE 
	AND SIGLAM=SIGLA
	AND IDPERIODO=PERIODO.ID
    AND MATERIA.Nombre='INTRODUCCION A LA INFORMATICA'
    AND DOCENTE.Nombre='VEIZAGA GONZALES JOSUE OBED'
ORDER BY SEMESTRE, AÑO;

/* Mostrar todos los alumnos que han inscrito la materia de INTRODUCCION A LA INFORMATICA en el semestre 1-2024 */
SELECT ALUMNO.*
FROM ALUMNO, BOLETA, INSCRIBE, GRUPO, MATERIA, PERIODO
WHERE PERIODO.Semestre=1 AND PERIODO.Año=2024
    AND SIGLAM=Sigla 
    AND MATERIA.Nombre='INTRODUCCION A LA INFORMATICA'	
    AND Registro=RegAlum 
	AND BOLETA.Nro=NroBoleta
	AND GRUPO.IDGrupo=INSCRIBE.IDGrupo;
    
/* Que materias del periodo 1-2024 ha inscrito el alumno CARLOS GARCIA */
SELECT MATERIA.Nombre 
FROM PERIODO, GRUPO, MATERIA, INSCRIBE, ALUMNO, BOLETA
WHERE PERIODO.Semestre=1 AND PERIODO.Año=2024
	AND ALUMNO.Registro=BOLETA.RegAlum
	AND SIGLAM=Sigla 
    AND INSCRIBE.NroBoleta=BOLETA.Nro
    AND INSCRIBE.IDGrupo=GRUPO.IDGrupo
    AND ALUMNO.Nombre='CARLOS GARCIA'