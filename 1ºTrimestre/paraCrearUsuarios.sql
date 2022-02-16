
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER ej1DML identified BY ej1DML;
GRANT CONNECT , RESOURCE, DBA TO ej1DML;


CREATE TABLE FABRICANTE(
	codigo NUMBER(10),
	nombre VARCHAR2(100),
	
	CONSTRAINT pk_fabricante  PRIMARY KEY (codigo)
);

CREATE TABLE PRODUCTO(
	codigo NUMBER(10),
	nombre VARCHAR2(100),
	precio NUMBER(5,2),
	codigo_fabricante NUMBER(10),
	

	CONSTRAINT pk_producto PRIMARY KEY (codigo),
	CONSTRAINT fk_producto FOREIGN KEY (codigo_fabricante) REFERENCES FABRICANTE(codigo)
);

ALTER TABLE PRODUCTO DROP CONSTRAINT fk_producto;
ALTER TABLE PRODUCTO ADD CONSTRAINT fk_producto2 FOREIGN KEY (codigo_fabricante) REFERENCES FABRICANTE(codigo) ON DELETE CASCADE ;



INSERT INTO FABRICANTE VALUES (1,'Asus');
INSERT INTO FABRICANTE VALUES (2, 'Lenovo');
INSERT INTO FABRICANTE VALUES (3,'Hewlett-Packard');
INSERT INTO FABRICANTE VALUES (4,'Samsung');
INSERT INTO FABRICANTE VALUES (5,'Seagate');
INSERT INTO FABRICANTE VALUES (6,'Crucial');
INSERT INTO FABRICANTE VALUES (7,'Gigabyte');
INSERT INTO FABRICANTE VALUES (8,'Huawei');
INSERT INTO FABRICANTE VALUES (9,'Xiaomi');

SELECT * FROM FABRICANTE;

INSERT INTO PRODUCTO VALUES (1,'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO PRODUCTO VALUES (2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO PRODUCTO VALUES (3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO PRODUCTO VALUES (4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO PRODUCTO VALUES (5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO PRODUCTO VALUES (6, 'Monitor 24 LED Full HD', 202, 1 );
INSERT INTO PRODUCTO VALUES (7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO PRODUCTO VALUES (8, 'Portátil Yoga 520', 559, 2);
INSERT INTO PRODUCTO VALUES (9, 'Portátil Ideapd 320', 444, 2 );
INSERT INTO PRODUCTO VALUES (10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO PRODUCTO VALUES (11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-----------------------------

INSERT INTO FABRICANTE VALUES (10,'HyperX');
--INSERT INTO FABRICANTE (nombre) VALUES ('Hola'); esta parte no se puede realizar porque no se puede establecer la PK a nulo
INSERT INTO PRODUCTO VALUES (12, 'hola que tal', 190, 10);
--INSERT INTO PRODUCTO (nombre,precio,codigo_fabricante) VALUES ('hola mundo', 110, 10);esta parte no se puede realizar porque no se puede establecer la PK a nulo
DELETE FROM FABRICANTE WHERE codigo=1; 
DELETE FROM FABRICANTE WHERE codigo=9;
--UPDATE FABRICANTE SET codigo=20 WHERE codigo=2; no es posible ya que tiene una foreign key de la otra tabla 
UPDATE FABRICANTE SET codigo=30 WHERE codigo=8;
UPDATE PRODUCTO SET precio=precio+5 ;
DELETE FROM PRODUCTO WHERE (nombre LIKE ('Impresora%')) AND (precio<200);




