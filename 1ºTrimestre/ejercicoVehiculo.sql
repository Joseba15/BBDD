CREATE TABLE VEHICULOS (
	matricula VARCHAR2(7),
	marca VARCHAR2(10) NOT NULL,
	modelo VARCHAR2(10) NOT NULL,
	fechaCompra DATE,
	precio_por_dia NUMBER(5,2),
   
	CONSTRAINT pk_vehic PRIMARY KEY (matricula)
);

CREATE TABLE CLIENTES (
	DNI VARCHAR2(9),
	nombre VARCHAR2(30) NOT NULL,
	nacionalidad VARCHAR2(30),
	fechaNaciemiento DATE,
	direccion VARCHAR2 (50),
   
	CONSTRAINT pk_cliente PRIMARY KEY (DNI)
);

CREATE TABLE ALQUILERES (
	matricula VARCHAR2(7),
	DNI VARCHAR2(9),
	fecha_hora DATE, 
	num_dias NUMBER(2) NOT NULL,
	kilometros NUMBER(4), 
	
	CONSTRAINT pk_alq PRIMARY KEY (matricula,DNI,fecha_hora),
	CONSTRAINT fk_cliente FOREIGN KEY (DNI) REFERENCES CLIENTES(DNI),
	CONSTRAINT fk_alq FOREIGN KEY (matricula) REFERENCES VEHICULOS(matricula)
);

ALTER TABLE VEHICULOS ADD CONSTRAINT update_fecha CHECK (fechaCompra>TO_DATE('01/01/2001', 'DD/MM/YYYY'));

ALTER TABLE VEHICULOS ADD CONSTRAINT update_precio CHECK (precio_por_dia>0);

ALTER TABLE ALQUILERES MODIFY kilometros DEFAULT(0);



