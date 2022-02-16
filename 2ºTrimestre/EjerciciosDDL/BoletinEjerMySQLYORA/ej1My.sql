CREATE TABLE DEPARTAMENTO(
	codigo INT(10),
	nombre VARCHAR(100),
	presupuesto DOUBLE,	
	
	CONSTRAINT pk_empleado PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO(
	codigo INT(10),
	nif VARCHAR(9),
	nombre VARCHAR(100),
	apellido1 VARCHAR(100),
	apellido2 VARCHAR(100),
	codigo_departamento INT(10),
	

	CONSTRAINT pk_empleado PRIMARY KEY (codigo),
	CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
	
);

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT chk_departamento CHECK (nombre LIKE '%S');
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT chk2_departamento CHECK (presupuesto >0);


