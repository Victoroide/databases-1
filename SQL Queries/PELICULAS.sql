CREATE DATABASE VideoClubScorpion;
USE VideoClubScorpion;

CREATE TABLE Directores (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(60) NOT NULL,
    Nacionalidad VARCHAR(20)
);

CREATE TABLE Peliculas (
    Codigo INT PRIMARY KEY,
    Titulo VARCHAR(60) NOT NULL,
    Nacionalidad VARCHAR(20),
    Productora VARCHAR(50),
    Año YEAR,
    DirectorID INT,
    FOREIGN KEY (DirectorID) REFERENCES Directores(DirectorID)
);

CREATE TABLE Actores (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(60) NOT NULL,
    Sexo CHAR(1)
);

CREATE TABLE Actuaciones (
    PeliculaID INT,
    ActorID INT,
    Principal BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (PeliculaID) REFERENCES Peliculas(Codigo),
    FOREIGN KEY (ActorID) REFERENCES Actores(ActorID),
    PRIMARY KEY (PeliculaID, ActorID)
);

CREATE TABLE Ejemplares (
    EjemplarID INT PRIMARY KEY,
    Nro INT,
    Estado VARCHAR(100),
    FOREIGN KEY (PeliculaID) REFERENCES Peliculas(Codigo)
);

CREATE TABLE Socios (
    CI INT PRIMARY KEY,
    Nombre VARCHAR(60) NOT NULL,
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    AvaladoPor INT
);

CREATE TABLE NotaAlquiler (
    Nro INT PRIMARY KEY,
    SocioID INT,
    EjemplarID INT,
    FechaInicio DATE,
    FechaFin DATE,
    Dias INT,
    FOREIGN KEY (SocioID) REFERENCES Socios(SocioID),
    FOREIGN KEY (EjemplarID) REFERENCES Ejemplares(EjemplarID)
);

ALTER TABLE Socios
ADD FOREIGN KEY (AvaladoPor) REFERENCES Socios(SocioID)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
    
SELECT * FROM Directores;
SELECT * FROM Peliculas;
SELECT * FROM Actores;
SELECT * FROM Actuaciones;
SELECT * FROM Ejemplares;
SELECT * FROM Socios;
SELECT * FROM Alquileres;


