/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER DiazJosebaej2 identified BY DiazJosebaej2;
GRANT CONNECT , RESOURCE, DBA TO DiazJosebaej2;
*/

CREATE TABLE CLIENTE (
	dni VARCHAR2(10),
	nombre VARCHAR2(10),
	apellidos VARCHAR2(20),
	ciudad VARCHAR2(20),
	
	CONSTRAINT pk_cliente PRIMARY KEY (dni)

);

CREATE TABLE MARCA (
	codMarca NUMBER(10),
	nombre 	VARCHAR2(10),
	pais VARCHAR2(15),
	
	CONSTRAINT pk_marca PRIMARY KEY (codMarca)
);

CREATE TABLE CONCESIONARIO (
	cifc VARCHAR2(15),
	nombre 	VARCHAR2(20),
	ciudad 	VARCHAR2(15),
	cifcmatriz 	VARCHAR2(15),
	
	CONSTRAINT pk_concesionario PRIMARY KEY (cifc),
	CONSTRAINT fk_concesionario FOREIGN KEY (cifc) REFERENCES CONCESIONARIO(cifc)

);

CREATE TABLE COCHE (
	codCoche NUMBER(15),
	codMarca NUMBER(10),
	modelo 	VARCHAR2(20),
	matricula 	VARCHAR2(8),
	color  	VARCHAR2(10),
	
	CONSTRAINT pk_coche PRIMARY KEY (codCoche),
	CONSTRAINT fk_coche FOREIGN KEY (codMarca) REFERENCES MARCA(codMarca)

);

CREATE TABLE DISTRIBUCION (
	cifc VARCHAR2(15),
	codCoche NUMBER(15),
	fecha DATE,

	CONSTRAINT pk_distribucion PRIMARY KEY (cifc,codCoche),
	CONSTRAINT fk1_distribucion FOREIGN KEY (cifc) REFERENCES CONCESIONARIO(cifc),
	CONSTRAINT fk2_distribucion FOREIGN KEY (codCoche) REFERENCES COCHE(codCoche)

);


CREATE TABLE VENTA (
	cifc VARCHAR2(15),
	codCoche NUMBER(15),		
	dni VARCHAR2(10),
	fecha_venta DATE,
	pvp NUMBER(6),

	CONSTRAINT pk_venta PRIMARY KEY (codCoche),
	CONSTRAINT fk_venta FOREIGN KEY (cifc) REFERENCES CONCESIONARIO(cifc),
	CONSTRAINT fk2_venta FOREIGN KEY (dni) REFERENCES CLIENTE(dni),
	CONSTRAINT fk3_venta FOREIGN KEY (codCoche) REFERENCES COCHE(codCoche)
	

);

ALTER TABLE VENTA MODIFY fecha_venta DATE DEFAULT SYSDATE;
ALTER TABLE COCHE ADD CONSTRAINT chk1_coche CHECK (color IN ('rojo','amarillo','verde'))










