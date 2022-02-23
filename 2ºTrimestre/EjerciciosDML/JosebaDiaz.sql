/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER josebadiaz identified BY josebadiaz;
GRANT CONNECT , RESOURCE, DBA TO josebadiaz;
*/




--Ejercicio1 :

INSERT INTO DIRECTOR VALUES ('Steven','Americano');
INSERT INTO DIRECTOR VALUES ('Joseba','Español');
SELECT * FROM DIRECTOR d ;


INSERT INTO PELICULA VALUES (01,'ET','Universal','Americana',to_date('06/06/1992','DD/MM/YYYY'),'Steven');
INSERT INTO PELICULA VALUES (02,'IndianaJones','Universal','Americana',to_date('14/11/1988','DD/MM/YYYY'),'Steven');
INSERT INTO PELICULA VALUES (03,'Campeones','Telecinco','Española',to_date('12/08/2019','DD/MM/YYYY'),'Joseba');
INSERT INTO PELICULA VALUES (04,'8apellidos','Universal','Española',to_date('12/12/2017','DD/MM/YYYY'),'Joseba');

COMMIT;

INSERT INTO EJEMPLAR VALUES (01,001,'En venta');
INSERT INTO EJEMPLAR VALUES (03,002,'En venta');

INSERT INTO SOCIO VALUES ('199999999','Pepe','Plaza Pio Baroja','671444444','199999999');
INSERT INTO SOCIO VALUES ('200000000','Juan','Calle Madrid','671444455','200000000');
INSERT INTO SOCIO VALUES ('200000001','Herme','Calle Malaga','671444466','200000001');
INSERT INTO SOCIO VALUES ('200000002','Luke','Calle San Luque','671444477','200000002');

INSERT INTO ACTORES VALUES ('Harrison','Americano','H');
INSERT INTO ACTORES VALUES ('George','Americano','H');
INSERT INTO ACTORES VALUES ('Clara','Española','M');
INSERT INTO ACTORES VALUES ('Pablo','Español','H');

COMMIT;

INSERT INTO ACTUA VALUES ('Clara',04,'S');
INSERT INTO ACTUA VALUES ('George',01,'N');

INSERT INTO ALQUILA VALUES ('199999999',01,0001,to_date('09/01/2021','DD/MM/YYYY'),to_date('09/02/2021','DD/MM/YYYY'));
INSERT INTO ALQUILA VALUES ('200000000',03,0002,to_date('09/01/2022','DD/MM/YYYY'),to_date('09/02/2022','DD/MM/YYYY'));

COMMIT;

--Ejercicio 2:

UPDATE DIRECTOR SET nacionalidad='USA' WHERE nacionalidad='Americano';
SELECT * FROM DIRECTOR d ;

--Ejercicio 3: 
SELECT * FROM SOCIO s ;
UPDATE SOCIO SET avalador='199999999';
UPDATE SOCIO SET avalador =NULL WHERE DNI='199999999';

--Ejercicio 4:
INSERT INTO SOCIO VALUES ('199999988','Juana','Plaza Pio Baroja','571444444','199999999');

SELECT * FROM SOCIO WHERE telefono LIKE '5%';
DELETE FROM SOCIO WHERE telefono LIKE '5%';

--Nos deja ejecutar la sentencia porque no tenemos ningun dato cuyo num de telefono empiece por 5, pero si lo tendriamos nos saldria un error de 
-- la pk de Alquila violada , es por ello que haremos lo siguiente:

--Ejercicio 5: 

ALTER TABLE ALQUILA DROP CONSTRAINT FK1_DNI;
ALTER TABLE ALQUILA ADD CONSTRAINT FK1_DNI FOREIGN KEY(DNI) REFERENCES SOCIO(DNI) ON DELETE CASCADE ;


--Ejercicio 6:

DELETE FROM PELICULA p WHERE id=01 ;
DELETE FROM PELICULA p WHERE id=02 ;

SELECT * FROM PELICULA p ;

--nos da un error de integridad de la constraint en la pelicula con id 1, no podemos borrar un dato de la tabla 
--si esta es a su vez Pk compuesta de otra tabla;

--Para solucionar esto, tendriamos que borrar las constraint de sus fk y crearlas otra vez con la muletilla de ON CASCADE CONSTRAINT

ALTER TABLE EJEMPLAR DROP CONSTRAINT FK_EJEMPLAR;
ALTER TABLE EJEMPLAR ADD CONSTRAINT FK_EJEMPLAR FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID) ON DELETE CASCADE; 
DELETE FROM PELICULA p WHERE id=01 ;
SELECT * FROM PELICULA WHERE id=01 ;


--Ejercicio 7:

CREATE TABLE DIRECTORES_BACKUP (
	NOMBRE_BU VARCHAR2(40),
	NACIONALIDAD_BU VARCHAR2(40) ,
	CONSTRAINT PK_DIRECTORES_BACKUP PRIMARY KEY(NOMBRE_BU)

);

SELECT * FROM DIRECTOR;
INSERT INTO DIRECTORES_BACKUP SELECT * FROM DIRECTOR;
SELECT * FROM DIRECTORES_BACKUP db ;


--Ejercicio 8: 

ALTER TABLE DIRECTORES_BACKUP ADD valoracion VARCHAR2(50);
SELECT * FROM DIRECTORES_BACKUP db ;
UPDATE DIRECTORES_BACKUP SET valoracion = 'Muy buena trayectoria profesional' WHERE nacionalidad_bu='Español';
SELECT * FROM DIRECTORES_BACKUP db WHERE NACIONALIDAD_BU ='Español' ;

--Ejercicio 9:

CREATE TABLE DIRECTOR
(
NOMBRE VARCHAR(40),
NACIONALIDAD VARCHAR(40) ,
CONSTRAINT PK_DIRECTOR PRIMARY KEY(NOMBRE)
);
CREATE TABLE PELICULA
(
ID int,
TITULO VARCHAR(40),
PRODUCTORA VARCHAR(40),
NACIONALIDAD VARCHAR(40),
FECHA DATE,
DIRECTOR VARCHAR(40),
CONSTRAINT FK_DIRECTOR FOREIGN KEY (DIRECTOR) REFERENCES DIRECTOR(NOMBRE) ,
CONSTRAINT PK_PELICULA PRIMARY KEY (ID)
);
CREATE TABLE EJEMPLAR
(
IDPELICULA int,
NUMERO int(2),
ESTADO VARCHAR(40),
CONSTRAINT PK_EJEMPLAR PRIMARY KEY(IDPELICULA, NUMERO),
CONSTRAINT FK_EJEMPLAR FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID)
);
CREATE TABLE ACTORES
(
NOMBRE VARCHAR(40),
NACIONALIDAD VARCHAR(40),
SEXO VARCHAR(1),
CONSTRAINT PK_ACTORES PRIMARY KEY(NOMBRE),
CONSTRAINT CK_SEXO CHECK (SEXO IN ('H', 'M'))
);
CREATE TABLE SOCIO
(
DNI VARCHAR(9),
NOMBRE VARCHAR(40) CONSTRAINT NN_NOMBRE NOT NULL,
DIRECCION VARCHAR(40),
TELEFONO VARCHAR(9),
AVALADOR VARCHAR(9),
CONSTRAINT PK_SOCIO PRIMARY KEY(DNI),
CONSTRAINT FK_SOCIO FOREIGN KEY(AVALADOR) REFERENCES SOCIO(DNI)
);
CREATE TABLE ACTUA
(
ACTOR VARCHAR(40) ,
IDPELICULA int,
PROTAGONISTA VARCHAR(1) DEFAULT 'N',
CONSTRAINT PK_ACTUA PRIMARY KEY(ACTOR, IDPELICULA),
CONSTRAINT FK1_ACTUA FOREIGN KEY(ACTOR )REFERENCES ACTORES(NOMBRE) ON DELETE
CASCADE,
CONSTRAINT FK2_ACTUA FOREIGN KEY (IDPELICULA) REFERENCES PELICULA(ID) ON DELETE
CASCADE,
CONSTRAINT CK_PROTAGONISTA CHECK (PROTAGONISTA IN ('S', 'N')) );
CREATE TABLE ALQUILA
(
DNI VARCHAR(9),
IDPELICULA int(10),
NUMERO int(2),
FECHA_ALQUILER DATE,
FECHA_DEVOLUCION DATE,
CONSTRAINT PK_ALQUILA PRIMARY KEY(DNI, IDPELICULA, NUMERO,FECHA_ALQUILER),
CONSTRAINT FK1_DNI FOREIGN KEY(DNI) REFERENCES SOCIO(DNI), CONSTRAINT
FK2_PELI FOREIGN KEY(IDPELICULA, NUMERO)
REFERENCES EJEMPLAR(IDPELICULA, NUMERO),
CONSTRAINT CK_FECHAS CHECK (FECHA_DEVOLUCION > FECHA_ALQUILER) );






--Ejercicio 10: 

CREATE SEQUENCE sq_idpelicula 
START WITH 5
INCREMENT BY 1;


INSERT INTO PELICULA VALUES (sq_idpelicula.nextval,'StarWars','LucasFilm','Americana',to_date('02/12/1988','DD/MM/YYYY'),'Steven');
INSERT INTO PELICULA VALUES (sq_idpelicula.nextval,'Celda 101','Culumbia','Española',to_date('12/12/2007','DD/MM/YYYY'),'Joseba');


SELECT * FROM PELICULA p ;

COMMIT ;	

--Ejercicio 12:

	--Ejercicio 12.1:
		/*
		Los datos no podra verlos pero si podra acceder a la base de datos, ya que al ejecutar la tabla de taquilla, haremos automaticamente el 
		commit y es por ello que los demas usuarios podran acceder
		*/

	--Ejercicio 12.2:

		/*
		 * Para retroceder utilizador la sentencia ROLLBACK, pero como acabos ejecutar la tabla FANS, no podremos hacer rollback hacia los datos 
		 * de TAQUILLA, ya que al ejecutar esta, se nos genera automaticamente el COMMIT, y no podemos acceder 
		 */

	--Ejercicio 12.3:
		
		/*
		 * Si queremos persistir los datos introducidos en la tabla FANS haremos un COMMIT justo despues de la inserccion de datos para
		 * que se queden persistidos en la BD, para ello solo escribimos COMMIT
		 */

	--Ejercicio 12.4:

		/*
		 * Si, al tener persistidos los datos en nuestra base de datos podemos hacer un ROLLBACK a dicho commit que hemos indicado anteriormente, 
		 * asi, podemos tener de nuevo todos los datos
		 */

	--Ejercicio 12.5:
	
		/*
		INSERT INTO NOMBRETABLA (....)
		INSERT INTO NOMBRETABLA (....)
		
		SAVEPOINT svnombretabla;

		*/


