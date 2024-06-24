CREATE DATABASE CARWASH;
USE CARWASH;

CREATE TABLE PERSONA (
    CI INTEGER PRIMARY KEY NOT NULL,
    Nombre VARCHAR(30) NOT NULL,
    Apellido VARCHAR(30) NOT NULL,
    Direccion VARCHAR(50),
    Telefono CHAR(10) NOT NULL,
    Email VARCHAR(50),
    TipoEmpleado BOOLEAN NOT NULL
);

CREATE TABLE EMPLEADO (
    CI INTEGER PRIMARY KEY NOT NULL,
    Puesto VARCHAR(30) NOT NULL,
    FOREIGN KEY (CI) REFERENCES PERSONA(CI)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE VEHICULO (
    Matricula CHAR(7) PRIMARY KEY NOT NULL,
    Marca VARCHAR(20) NOT NULL,
    Modelo VARCHAR(20) NOT NULL,
    Tamaño VARCHAR(10) NOT NULL,
    Tipo CHAR(1) NOT NULL,
    PersonaCI INTEGER NOT NULL,
    FOREIGN KEY (PersonaCI) REFERENCES PERSONA(CI)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE AUTO (
    MatriculaVehiculo CHAR(7) PRIMARY KEY NOT NULL,
    NumPuertas TINYINT NOT NULL,
    FOREIGN KEY (MatriculaVehiculo) REFERENCES VEHICULO(Matricula)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE MOTO (
    Matricula CHAR(7) PRIMARY KEY NOT NULL,
    Cilindrada SMALLINT NOT NULL,
    FOREIGN KEY (Matricula) REFERENCES VEHICULO(Matricula)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE PERTENENCIA (
    Matricula CHAR(7) NOT NULL,
    PertenenciaID SMALLINT NOT NULL,
    Nombre VARCHAR(30) NOT NULL,
    Descripcion VARCHAR(50),
    PRIMARY KEY (Matricula, PertenenciaID),
    FOREIGN KEY (Matricula) REFERENCES VEHICULO(Matricula)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE FICHALAVADO (
    FichaID INTEGER PRIMARY KEY NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Estado VARCHAR(15) NOT NULL,
    MontoTotal DECIMAL(6, 2) NOT NULL,
    MatriculaVehiculo CHAR(7) NOT NULL,
    FOREIGN KEY (MatriculaVehiculo) REFERENCES VEHICULO(Matricula)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE SERVICIO (
    ServicioID TINYINT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    Descripcion VARCHAR(50),
    PrecioBase DECIMAL(5, 2) NOT NULL
);

CREATE TABLE DETALLESERVICIO (
    FichaID INTEGER NOT NULL,
    ServicioID TINYINT NOT NULL,
    PrecioFinal DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (FichaID) REFERENCES FICHALAVADO(FichaID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
    FOREIGN KEY (ServicioID) REFERENCES SERVICIO(ServicioID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE ASIGNA (
    EmpleadoCI INTEGER NOT NULL,
    FichaID INTEGER NOT NULL,
    PRIMARY KEY (EmpleadoCI , FichaID),
    FOREIGN KEY (EmpleadoCI ) REFERENCES EMPLEADO(CI)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
    FOREIGN KEY (FichaID) REFERENCES FICHALAVADO(FichaID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO PERSONA VALUES ('7679493', 'Juan', 'Pérez', 'Av. Brasil 432', '5551234', 'j.perezl@gmail.com', FALSE);
INSERT INTO PERSONA VALUES ('7328931', 'María', 'Gómez', 'Calle Bolivar 456', '5555678', 'margom@outlook.com', TRUE);
INSERT INTO PERSONA VALUES ('7436482', 'Carlos', 'López', 'Av. Los Laureles 789', '5557890', 'carlopez52@google.com', TRUE);

INSERT INTO EMPLEADO VALUES ('7436482', 'Lavador');
INSERT INTO EMPLEADO VALUES ('7328931', 'Gerente');

INSERT INTO VEHICULO VALUES ('1142ENG', 'Toyota', 'Corolla', 'Mediano', 'A', '7679493');
INSERT INTO VEHICULO VALUES ('4432YUP', 'Honda', 'Civic', 'Mediano', 'A', '7328931');
INSERT INTO VEHICULO VALUES ('5424BOL', 'Yamaha', 'R6', 'Pequeño', 'M', '7679493');

INSERT INTO AUTO VALUES ('1142ENG', 4);
INSERT INTO AUTO VALUES ('4432YUP', 4);

INSERT INTO MOTO VALUES ('5424BOL', 600);

INSERT INTO PERTENENCIA VALUES ('1142ENG', 1, 'Sombrero', 'Sombrero de paja');
INSERT INTO PERTENENCIA VALUES ('4432YUP', 2, 'Gafas', 'Gafas de sol');
INSERT INTO PERTENENCIA VALUES ('5424BOL', 3, 'Casco', 'Casco integral');

INSERT INTO FICHALAVADO VALUES (1, '2024-06-01', '09:00:00', 'Completo', 20.00, '1142ENG');
INSERT INTO FICHALAVADO VALUES (2, '2024-06-02', '10:00:00', 'Completo', 15.00, '4432YUP');
INSERT INTO FICHALAVADO VALUES (3, '2024-06-03', '11:00:00', 'En progreso', 10.00, '5424BOL');

INSERT INTO ASIGNA VALUES ('7436482', 1);
INSERT INTO ASIGNA VALUES ('7436482', 2);
INSERT INTO ASIGNA VALUES ('7436482', 3);

INSERT INTO SERVICIO VALUES (1, 'Lavado básico', 'Lavado exterior', 10.00);
INSERT INTO SERVICIO VALUES (2, 'Lavado completo', 'Lavado exterior e interior', 20.00);
INSERT INTO SERVICIO VALUES (3, 'Lavado moto', 'Lavado para motocicletas', 15.00);

INSERT INTO DETALLESERVICIO VALUES (1, 2, 20.00);
INSERT INTO DETALLESERVICIO VALUES (2, 2, 20.00);
INSERT INTO DETALLESERVICIO VALUES (3, 3, 15.00);

DROP DATABASE CARWASH;
SELECT * FROM PERSONA;
SELECT * FROM EMPLEADO;
SELECT * FROM VEHICULO;
SELECT * FROM AUTO;
SELECT * FROM MOTO;
SELECT * FROM PERTENENCIA;
SELECT * FROM FICHALAVADO;
SELECT * FROM ASIGNA;
SELECT * FROM SERVICIO;
SELECT * FROM DETALLESERVICIO;