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
('1142ENG', 'Suzuki', 'Dzire', 'Mediano', 'A', 1562892),
('4432YUP', 'Mitsubishi', 'Eclipse', 'Pequeño', 'A', 7328931),
('5424BOL', 'Trueno', 'FZ200', 'Pequeño', 'M', 4563234),
('2314FAB', 'Suzuki', 'Vitara', 'Mediano', 'A', 7679493),
('5673PFR', 'Toyota', 'Land Cruiser', 'Grande', 'A', 7323912),
('4435JPG', 'Honda', 'CRF', 'Pequeño', 'M', 4837241),
('3456ANA', 'Suzuki', 'Alto', 'Pequeño', 'A', 7772831),
('6628OBS', 'Ford', 'Range', 'Grande', 'A', 7436482);

INSERT INTO AUTO (MatriculaVehiculo, NumPuertas) VALUES
('1142ENG', 4),
('4432YUP', 2),
('2314FAB', 2),
('5673PFR', 4),
('6628OBS', 4),
('3456ANA', 4);

INSERT INTO MOTO (Matricula, Cilindrada) VALUES
('5424BOL', 200),
('4435JPG', 250);

INSERT INTO EMPLEADO (CI, Puesto) VALUES
(7436482, 'Gerente'),
(7328931, 'Administrador'),
(4837241, 'Lavador'),
(1562892, 'Lavador'),
(7772831, 'Encerador');

INSERT INTO PERTENENCIA (Matricula, PertenenciaID, Nombre, Descripcion) VALUES
('1142ENG', 1, 'Maletín', 'Maletín negro de cuero'),
('4432YUP', 2, 'Gafas de Sol', 'Gafas de sol marca Ray-Ban'),
('5673PFR', 3, 'Casco', 'Casco de moto rojo vino'),
('3456ANA', 4, 'Parasol', 'Parasol con imagen de tigre'),
('2314FAB', 5, 'Botella de Agua', 'Botella de agua Vital de 1 litro');

INSERT INTO FICHALAVADO (FichaID, Fecha, Hora, Estado, MontoTotal, MatriculaVehiculo) VALUES
(1, '2024-06-20', '09:00:00', 'Finalizado', 110.00, '1142ENG'),
(2, '2024-06-20', '10:30:00', 'Finalizado', 150.00, '4432YUP'),
(3, '2024-06-21', '11:00:00', 'Finalizado', 100.00, '5673PFR'),
(4, '2024-06-22', '12:00:00', 'Finalizado', 90.00, '3456ANA'),
(5, '2024-06-23', '14:30:00', 'Finalizado', 45.00, '2314FAB'),
(6, '2024-06-24', '15:00:00', 'Finalizado', 140.00, '4435JPG'),
(7, '2024-06-25', '16:00:00', 'Finalizado', 200.00, '6628OBS'),
(8, '2024-06-26', '09:00:00', 'Finalizado', 180.00, '5673PFR'),
(9, '2024-06-26', '10:00:00', 'En Proceso', 70.00, '4432YUP'),
(10, '2024-06-27', '11:00:00', 'En Proceso', 170.00, '1142ENG');

INSERT INTO ASIGNA (EmpleadoCI, FichaID) VALUES
(7436482, 1),
(7328931, 2),
(4837241, 3),
(1562892, 4),
(7772831, 5),
(7436482, 6),
(7328931, 7),
(4837241, 8),
(1562892, 9),
(7772831, 10);

INSERT INTO SERVICIO (ServicioID, Nombre, Descripcion, PrecioBase) VALUES
(1, 'Lavado Básico', 'Lavado exterior del vehículo', 40.00),
(2, 'Lavado Completo', 'Lavado interior y exterior', 100.00),
(3, 'Encerado', 'Encerado y pulido exterior', 70.00),
(4, 'Desinfección', 'Desinfección interior', 50.00),
(5, 'Lavado de Motor', 'Lavado y desengrasado', 100.00);

INSERT INTO DETALLESERVICIO (FichaID, ServicioID, PrecioFinal) VALUES
(1, 1, 30.00),
(1, 3, 80.00),
(2, 2, 100.00),
(2, 3, 50.00),
(3, 5, 100.00),
(4, 1, 40.00),
(4, 4, 50.00),
(5, 4, 45.00),
(6, 1, 40.00),
(6, 5, 100.00),
(7, 2, 50.00),
(7, 3, 50.00),
(8, 4, 50.00),
(8, 1, 40.00),
(9, 3, 70.00),
(10, 2, 100.00),
(10, 1, 70.00);

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
