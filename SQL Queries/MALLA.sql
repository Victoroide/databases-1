CREATE database UNI2024SC;
use UNI2024SC;

create table materia
(
    sigla varchar(6) not null primary key,
    nombre varchar(50) not null,
    semestre tinyint not null
);

create table prerequisito
(
    siglam varchar(6) not null,
    siglapre varchar(6) not null,
    primary key (siglam,siglapre),
    foreign key (siglam) references materia(sigla)
    on update cascade
    on delete cascade,
    foreign key (siglapre) references materia(sigla)
    on update cascade
    on delete cascade
);
DROP TABLE MATERIA; 
DROP TABLE PREREQUISITO;
INSERT INTO MATERIA (SIGLA, NOMBRE, SEMESTRE) VALUES
('MAT101', 'CALCULO I', 1),
('INF119', 'ESTRUCTURAS DISCRETAS', 1),
('INF110', 'INTRODUCCION A LA INFORMATICA', 1),
('LIN100', 'INGLES TECNICO I', 1),
('FIS100', 'FISICA I', 1),
('MAT102', 'CALCULO II', 2),
('MAT103', 'ALGEBRA LINEAL', 2),
('INF120', 'PROGRAMACION I', 2),
('LIN101', 'INGLES TECNICO II', 2),
('FIS102', 'FISICA II', 2),
('MAT207', 'ECUACIONES DIFERENCIALES', 3),
('INF210', 'PROGRAMACION II', 3),
('INF211', 'ARQUITECTURAS DE COMPUTADORAS', 3),
('ADM100', 'ADMINISTRACION', 3),
('FIS200', 'FISICA III', 3),
('MAT202','PROBABILIDAD Y ESTADISTICA I',4),
('MAT205','METODOS NUMERICOS',4),
('INF220','ESTRUCTURA DE DATOS I',4),
('INF221', 'PROGRAMACION ENSAMBLADOR',4),
('ADM200','CONTABILIDAD',4),
('MAT302','PROBABILIDAD Y ESTADISTICA II',5),
('INF310','ESTRUCTURA DE DATOS II',5),
('ADM330','ORGANIZACION Y METODOS',5),
('INF312','BASE DE DATOS I',5),
('ECO300','ECONOMIA PARA LA GESTION',5),
('ELC001','ADMINISTRACION DE RECURSOS HUMANOS',5),
('ELC002','COSTOS Y PRESUPUESTOS',5),
('MAT329','INVESTIFACION OPERATIVA I',6),
('INF323','SISTEMAS OPERATIVOS I',6),
('ADM320','FINANZAS PARA LA EMPRESA',6),
('INF342','SISTEMAS DE INFORMACION I',6),
('INF322','BASE DE DATOS II',6),
('ELC003','PRODUCCION Y MARKETING',	6),
('ELC004','REINGENIERIA',	6),
('MAT419','INVESTIGACION OPERATIVA II',	7),
('INF433','REDES I',	7),
('INF413','SISTEMAS OPERATIVOS II',	7),
('INF432','SISTEMAS PARA EL SOPORTE A LA TOMA DE DECISIONES',	7),
('INF412','SISTEMAS DE INFORMACION II',	7),
('ELC005','INGENIERIA DE LA CALIDAD',	7),
('ELC006','BENCHMARKING',	7),
('ECO449','PREPARACION Y EVALUACION DE PROYECTOS',	8),
('INF423','REDES II',	8),
('INF462','AUDITORIA INFORMATICA',	8),
('INF442','SISTEMAS DE INFORMACION GEOGRAFICA',	8),
('INF422','INGENIERIA DE SOFTWARE I',	8),
('INF511','TALLER DE GRADO I',	9),
('INF512','INGENIERIA DE SOTFWARE II',	9),
('INF513','TECNOLOGIA WEB',	9),
('INF552','ARQUITECTURA DE SOTFWARE',	9);

INSERT INTO PREREQUISITO (siglam,siglapre) VALUES
('MAT102', 'MAT101'),
('MAT103', 'INF119'),
('INF120', 'INF110'),
('LIN101', 'LIN100'),
('FIS102', 'FIS100'),
('MAT207', 'MAT102'),
('INF210', 'MAT103'),
('INF210', 'INF120'),
('INF211', 'INF120'),
('INF211','FIS102'),
('FIS200','FIS102'),
('MAT202','MAT102'),
('MAT205','MAT207'),
('INF220','INF210'),
('INF221','INF211'),
('ADM200','ADM100'),
('MAT302','MAT202'),
('INF310','INF220'),
('ADM330','ADM200'),
('INF312','INF220'),
('ECO300','ADM200'),
('MAT329','MAT302'),
('INF323','INF310'),
('ADM320','ADM330'),
('INF342','INF312'),
('INF322','INF312'),
('MAT419','MAT329'),
('INF433','INF323'),
('INF413','INF323'),
('INF432','INF342'),
('INF432','INF322'),
('INF412','INF342'),
('INF412','INF322'),
('ECO449','MAT419'),
('INF423','INF433'),
('INF462','ADM320'),
('INF462','INF412'),
('INF442','INF412'),
('INF422','INF412'),
('INF511','ECO449'),
('INF511','INF423'),
('INF511','INF462'),
('INF511','INF442'),
('INF511','INF422'),
('INF512','ECO449'),
('INF512','INF423'),
('INF512','INF462'),
('INF512','INF442'),
('INF512','INF422'),
('INF513','ECO449'),
('INF513','INF423'),
('INF513','INF462'),
('INF513','INF442'),
('INF513','INF422'),
('INF552','ECO449'),
('INF552','INF423'),
('INF552','INF462'),
('INF552','INF442'),
('INF552','INF422');

select * 
from materia
order by SEMESTRE asc ;

/* mostrar la materia que es prerequisito para llevar calculo II */

select materiapre.sigla, materiapre.nombre
from materia materia, materia materiapre, prerequisito 
where materia.sigla = siglam and materia.nombre = 'calculo II' 
      and materiapre.sigla = siglapre;
	
/* Mostra de que materia es prerequisito Programacion I */

SELECT mat2.sigla, mat2.nombre
FROM materia mat, prerequisito pre, materia mat2
WHERE mat.sigla=pre.siglapre AND pre.siglam = mat2.sigla AND mat.nombre="Programacion I";

SELECT sigla, nombre
FROM materia
WHERE sigla IN (
				SELECT siglam
				FROM prerequisito
				WHERE siglapre IN (
									SELECT sigla
									FROM materia
									WHERE materia.nombre='Programacion I'
									)
					);
/* Mostrar las materias que no tienen prerequisito */
SELECT *
FROM materia
WHERE sigla NOT IN (
					SELECT siglam
					FROM prerequisito
					);
                    
/* Mostrar la cantidad de prerequisitos que tiene cada materia */
SELECT sigla, nombre, COUNT(materia.sigla)
FROM materia, prerequisito
WHERE sigla=siglam
GROUP BY sigla, nombre
ORDER BY semestre ASC;