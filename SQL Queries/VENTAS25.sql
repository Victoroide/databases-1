CREATE DATABASE VENTAS25;
USE VENTAS25;

CREATE TABLE CATEGORIA
(
   ID INTEGER NOT NULL,
   DESCRIPCION VARCHAR(50) NOT NULL,
   IDPADRE INTEGER,
   PRIMARY KEY (ID)
);

ALTER TABLE CATEGORIA
ADD foreign key (IDPADRE) references CATEGORIA (ID)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;
  
CREATE TABLE PRODUCTO
(
  CODIGO VARCHAR(4) NOT NULL,
  NOMBRE VARCHAR(50) NOT NULL,
  PRECIOV INTEGER NOT NULL,
  IDCATEGORIA INTEGER NOT NULL,
  PRIMARY KEY (CODIGO),
  foreign key (IDCATEGORIA) references CATEGORIA (ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE TABLE CLIENTE
(
  CI INTEGER NOT NULL,
  NOMBRE VARCHAR(50) NOT NULL,
  TELEFONO INTEGER NOT NULL,
  PRIMARY KEY (CI)
);

CREATE TABLE FACTURA
(
   NRO INTEGER NOT NULL,
   FECHA DATE NOT NULL,
   MONTO INTEGER NOT NULL,
   CICLIENTE INTEGER NOT NULL,
   PRIMARY KEY (NRO),
   FOREIGN KEY (CICLIENTE) REFERENCES CLIENTE(CI)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE DETALLEFACTURA
(
 NROF INTEGER NOT NULL,
 ID tinyint NOT NULL,
 CANTIDAD INTEGER NOT NULL,
 PRECIO INTEGER NOT NULL,
 CODIGOP VARCHAR (4) NOT NULL,
 PRIMARY KEY (NROF,ID),
 FOREIGN KEY (NROF) REFERENCES FACTURA(NRO)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
 FOREIGN KEY (CODIGOP) REFERENCES PRODUCTO(CODIGO)
  ON UPDATE CASCADE
  ON DELETE CASCADE 
);

INSERT INTO CATEGORIA VALUES (1,'BEBIDAS',NULL);
INSERT INTO CATEGORIA VALUES (2,'BEBIDAS ALCOHOLICAS',1);
INSERT INTO CATEGORIA VALUES (3,'VINO',2);
INSERT INTO CATEGORIA VALUES (4,'CERVEZA',2);
INSERT INTO CATEGORIA VALUES (5,'BEBIDAS NO ALCOHOLICAS',1);
INSERT INTO CATEGORIA VALUES (6,'GASEOSA',5);
INSERT INTO CATEGORIA VALUES (7,'JUGOS',5);
INSERT INTO CATEGORIA VALUES (8,'ENERGIZANTE',5);
INSERT INTO CATEGORIA VALUES (9,'AGUA',5);

INSERT INTO PRODUCTO VALUES ('P001','COCA COLA 2 LTS',10,6);
INSERT INTO PRODUCTO VALUES ('P002','COCA COLA 3 LTS',15,6);
INSERT INTO PRODUCTO VALUES ('P003','VINO KOLBERT 450 ML',30,3);
INSERT INTO PRODUCTO VALUES ('P004','CERVEZA PACEÑA LATA',12,4);
INSERT INTO PRODUCTO VALUES ('P005','JUGO DEL VALLE FRESH 2 LTS',15,7);
INSERT INTO PRODUCTO VALUES ('P006','ACUARIO PERA 3 LTS',20,7);
INSERT INTO PRODUCTO VALUES ('P007','POWER 450 ML',10,8);

INSERT INTO CLIENTE VALUES (111,'JOAQUIN CHUMACERO',7102030);
INSERT INTO CLIENTE VALUES (222,'SATURNINO MAMANI',3562040);
INSERT INTO CLIENTE VALUES (333,'FABIOLA MENDEZ',7202030);

INSERT INTO FACTURA VALUES (100,'2022/1/10',300,111);
INSERT INTO FACTURA VALUES (101,'2022/1/10',150,222);
INSERT INTO FACTURA VALUES (102,'2022/1/15',180,333);
INSERT INTO FACTURA VALUES (103,'2022/1/20',250,111);

INSERT INTO DETALLEFACTURA VALUES (100,1,10,15,'P002');
INSERT INTO DETALLEFACTURA VALUES (100,2,11,10,'P007');
INSERT INTO DETALLEFACTURA VALUES (100,3,2,20,'P006');
INSERT INTO DETALLEFACTURA VALUES (101,1,15,10,'P007');
INSERT INTO DETALLEFACTURA VALUES (102,1,4,30,'P003');
INSERT INTO DETALLEFACTURA VALUES (102,2,4,15,'P002');
INSERT INTO DETALLEFACTURA VALUES (103,1,12,20,'P006');
INSERT INTO DETALLEFACTURA VALUES (103,2,1,10,'P004');

SELECT * FROM DETALLEFACTURA;
SELECT * FROM FACTURA;

SELECT CODIGO, NOMBRE, SUM(CANTIDAD) AS CANTIDAD_VENDIDA
FROM PRODUCTO, DETALLEFACTURA
WHERE CODIGOP=PRODUCTO.CODIGO GROUP BY CODIGO, NOMBRE;	

SELECT CLIENTE.CI, CLIENTE.NOMBRE, SUM(MONTO) AS TOTAL_FACTURADO
FROM CLIENTE, FACTURA
WHERE CLIENTE.CI = CICLIENTE
GROUP BY CLIENTE.CI, CLIENTE.NOMBRE
HAVING TOTAL_FACTURADO > 450;

SELECT FACTURA.* 
FROM FACTURA, CLIENTE, PRODUCTO, DETALLEFACTURA
WHERE CICLIENTE=CLIENTE.CI AND CLIENTE.NOMBRE='JOAQUIN CHUMACERO' 
AND FACTURA.NRO=NROF AND CODIGOP=CODIGO AND PRODUCTO.NOMBRE='CERVEZA PACEÑA LATA'
