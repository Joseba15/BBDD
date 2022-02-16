CREATE TABLE FAMILIA (
	nombre VARCHAR2(20),
	caracteristicas VARCHAR2(50),
	
	CONSTRAINT pk_familia PRIMARY KEY (nombre)
);

CREATE TABLE GENERO (
	nombre VARCHAR2(20),
	caracteristicas VARCHAR2(50),
	nombre_familia VARCHAR2(20),
	
	CONSTRAINT pk_genero PRIMARY KEY (nombre),
	CONSTRAINT fk_genero FOREIGN KEY (nombre_familia) REFERENCES FAMILIA(nombre)

);

CREATE TABLE ESPECIE (
	nombre VARCHAR2(20),
	caracteristicas VARCHAR2(50),
	nombre_genero VARCHAR2(20),
	CONSTRAINT pk_especie PRIMARY KEY (nombre),	
	CONSTRAINT fk_especie FOREIGN KEY (nombre_genero) REFERENCES GENERO(nombre)


);

CREATE TABLE ZONA (
	nombre VARCHAR2(20),
	localidad VARCHAR2(50),
	extension NUMBER(4),
	protegida VARCHAR2(10),
	
	CONSTRAINT pk_zona PRIMARY KEY (nombre)
	
);

CREATE TABLE 











