CREATE DATABASE CARWASH;
USE CARWASH;
CREATE TABLE PERSONA (
    CI INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(10) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    TipoEmpleado BOOLEAN NOT NULL
);

CREATE TABLE VEHICULO (
    Matricula VARCHAR(8) PRIMARY KEY,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Tamaño VARCHAR(10) NOT NULL,
    Tipo CHAR(1) NOT NULL,
    PersonaCI INT NOT NULL,
    FOREIGN KEY (PersonaCI) REFERENCES PERSONA(CI) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE AUTO (
    MatriculaVehiculo VARCHAR(8) PRIMARY KEY,
    NumPuertas INT NOT NULL,
    FOREIGN KEY (MatriculaVehiculo) REFERENCES VEHICULO(Matricula) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE MOTO (
    Matricula VARCHAR(8) PRIMARY KEY NOT NULL,
    Cilindrada INT NOT NULL,
    FOREIGN KEY (Matricula) REFERENCES VEHICULO(Matricula) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE EMPLEADO (
    CI INT PRIMARY KEY NOT NULL,
    Puesto VARCHAR(50) NOT NULL,
    FOREIGN KEY (CI) REFERENCES PERSONA(CI) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE PERTENENCIA (
    Matricula VARCHAR(8) NOT NULL,
    PertenenciaID INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100),
    PRIMARY KEY (Matricula, PertenenciaID),
    FOREIGN KEY (Matricula) REFERENCES VEHICULO(Matricula) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE FICHALAVADO (
    FichaID INT PRIMARY KEY NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    MontoTotal DECIMAL(10, 2) NOT NULL,
    MatriculaVehiculo VARCHAR(8) NOT NULL,
    FOREIGN KEY (MatriculaVehiculo) REFERENCES VEHICULO(Matricula) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE ASIGNA (
    EmpleadoCI INT NOT NULL,
    FichaID INT NOT NULL,
    PRIMARY KEY (EmpleadoCI, FichaID),
    FOREIGN KEY (EmpleadoCI) REFERENCES EMPLEADO(CI) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE,
    FOREIGN KEY (FichaID) REFERENCES FICHALAVADO(FichaID) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE SERVICIO (
    ServicioID INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100),
    PrecioBase DECIMAL(10, 2) NOT NULL
);

CREATE TABLE DETALLESERVICIO (
    FichaID INT NOT NULL,
    ServicioID INT NOT NULL,
    PrecioFinal DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (FichaID, ServicioID),
    FOREIGN KEY (FichaID) REFERENCES FICHALAVADO(FichaID) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE,
    FOREIGN KEY (ServicioID) REFERENCES SERVICIO(ServicioID) 
		ON UPDATE CASCADE 
        ON DELETE CASCADE
);

INSERT INTO PERSONA (CI, Nombre, Apellido, Direccion, Telefono, Email, TipoEmpleado) VALUES
(7436482, 'Victor', 'Cuéllar', 'Av. Los Laureles #789', '69156782', 'vhcuellar14@hotmail.com', TRUE),
(7328931, 'Sebastián', 'Méndez', 'Calle Bolivar #456', '66843426', 'sebas.mendez@gmail.com', TRUE),
(4837241, 'Cesar', 'Santiestevan', 'Av. Beni #33', '67487322', 'chonti.sebas@hotmail.com', TRUE),
(1562892, 'Lucas', 'Lino', 'Calle Murillo #265', '64924121', 'linolucas69@gmail.com', TRUE),
(7772831, 'Jorge', 'Salvador', 'Av. Virgen de Cotoca #13', '72893411', 'jorgesalva.rios@gmail.com', TRUE),
(7392432, 'Briyidt', 'Noa', 'Calle Las Garzas #2130', '77138283', 'briyidtnoa@outlook.com', FALSE),
(4563234, 'Gonzalo', 'Alarcón', 'Barrio Los Tusequis #578', '77732151', 'gonzaloboo25@outlook.com', FALSE),
(7323912, 'Juan Carlos', 'Luna', 'Barrio 21 de enero #23', '67301991', 'jcarlos.luna23@gmail.com', FALSE),
(7679493, 'Fabiana', 'Manzoni', 'Calle Bolivar #456', '77543643', 'fabimanzoni@gmail.com', FALSE);

INSERT INTO VEHICULO (Matricula, Marca, Modelo, Tamaño, Tipo, PersonaCI) VALUES
('6628OBS', 'Ford', 'Range', 'Grande', 'A', 7436482),
('4432YUP', 'Mitsubishi', 'Eclipse', 'Pequeño', 'A', 7328931),
('4435JPG', 'Honda', 'CRF', 'Pequeño', 'M', 4837241),
('1142ENG', 'Suzuki', 'Dzire', 'Mediano', 'A', 1562892),
('3456ANA', 'Suzuki', 'Alto', 'Pequeño', 'A', 7772831),
('4325JJK', 'Yamaha', 'MT-03', 'Pequeño', 'M', 7392432),
('5424BOL', 'Trueno', 'FZ200', 'Pequeño', 'M', 4563234),
('5673PFR', 'Toyota', 'Land Cruiser', 'Grande', 'A', 7323912),
('2314FAB', 'Suzuki', 'Vitara', 'Mediano', 'A', 7679493);

INSERT INTO AUTO (MatriculaVehiculo, NumPuertas) VALUES
('6628OBS', 4),
('4432YUP', 2),
('1142ENG', 4),
('3456ANA', 4),
('5673PFR', 4),
('2314FAB', 2);

INSERT INTO MOTO (Matricula, Cilindrada) VALUES
('4435JPG', 250),
('4325JJK', 320),
('5424BOL', 200);

INSERT INTO EMPLEADO (CI, Puesto) VALUES
(7436482, 'Gerente'),
(7328931, 'Administrador'),
(4837241, 'Lavador'),
(1562892, 'Lavador'),
(7772831, 'Encerador');

INSERT INTO PERTENENCIA (Matricula, PertenenciaID, Nombre, Descripcion) VALUES
('4325JJK', 1, 'Botella de Agua', 'Botella de agua Vital de 1 litro'),
('5424BOL', 2, 'Casco', 'Casco de moto rojo vino'),
('5424BOL', 3, 'Gafas de Sol', 'Gafas de sol marca Ray-Ban'),
('5673PFR', 4, 'Maletín', 'Maletín negro de cuero'),
('2314FAB', 5, 'Parasol', 'Parasol con imagen de tigre');

INSERT INTO FICHALAVADO (FichaID, Fecha, Hora, Estado, MontoTotal, MatriculaVehiculo) VALUES
(1, '2024-06-20', '09:00:00', 'Finalizado', 135.00, '4325JJK'),
(2, '2024-06-20', '10:30:00', 'Finalizado', 63.00, '5424BOL'),
(3, '2024-06-20', '12:00:00', 'Finalizado', 170.00, '5673PFR'),
(4, '2024-06-20', '14:00:00', 'Finalizado', 90.00, '2314FAB'),
(5, '2024-06-20', '15:30:00', 'Finalizado', 207.00, '6628OBS'),
(6, '2024-06-21', '09:00:00', 'Finalizado', 153.00, '4432YUP'),
(7, '2024-06-21', '10:30:00', 'Finalizado', 63.00, '4435JPG'),
(8, '2024-06-21', '12:00:00', 'Finalizado', 81.00, '3456ANA'),
(9, '2024-06-21', '13:30:00', 'Finalizado', 99.00, '1142ENG'),
(10, '2024-06-22', '09:00:00', 'En Proceso', 90.00, '4325JJK'),
(11, '2024-06-22', '10:30:00', 'En Proceso', 63.00, '5424BOL');

INSERT INTO ASIGNA (EmpleadoCI, FichaID) VALUES
(1562892, 1),
(7772831, 1),
(4837241, 2),
(1562892, 2),
(4837241, 3),
(1562892, 3),
(1562892, 4),
(4837241, 4),
(1562892, 5),
(4837241, 5),
(7772831, 5),
(4837241, 6),
(7772831, 6),
(4837241, 7),
(1562892, 7),
(1562892, 8),
(4837241, 8),
(1562892, 9),
(4837241, 9),
(7772831, 10),
(1562892, 10),
(4837241, 11),
(1562892, 11);

INSERT INTO SERVICIO (ServicioID, Nombre, Descripcion, PrecioBase) VALUES
(1, 'Lavado Básico', 'Lavado exterior del vehículo', 40.00),
(2, 'Lavado Completo', 'Lavado interior y exterior', 100.00),
(3, 'Encerado', 'Encerado y pulido exterior', 70.00),
(4, 'Desinfección', 'Desinfección interior', 50.00),
(5, 'Lavado de Motor', 'Lavado y desengrasado', 100.00);

INSERT INTO DETALLESERVICIO (FichaID, ServicioID, PrecioFinal) VALUES
(1, 2, 90.00),
(1, 3, 45.00),
(2, 1, 36.00),
(2, 4, 27.00),
(3, 1, 36.00),
(3, 4, 45.00),
(3, 5, 90.00),
(4, 1, 40.00),
(4, 4, 50.00),
(5, 2, 90.00),
(5, 3, 63.00),
(5, 5, 54.00),
(6, 2, 90.00),
(6, 3, 63.00),
(7, 1, 36.00),
(7, 4, 27.00),
(8, 5, 90.00),
(9, 1, 36.00),
(9, 4, 27.00),
(10, 2, 90.00),
(10, 3, 45.00),
(11, 1, 36.00),
(11, 4, 27.00);

SELECT * FROM PERSONA;
SELECT * FROM VEHICULO;
SELECT * FROM AUTO;
SELECT * FROM MOTO;
SELECT * FROM EMPLEADO;
SELECT * FROM PERTENENCIA;
SELECT * FROM FICHALAVADO;
SELECT * FROM ASIGNA;
SELECT * FROM SERVICIO;
SELECT * FROM DETALLESERVICIO;
