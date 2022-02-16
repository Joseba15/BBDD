CREATE TABLE PROFESOR(
	dni VARCHAR2(9),
	nombre VARCHAR2(20),
	sueldo NUMBER(5),
	titulacion VARCHAR2(20),
	direccion VARCHAR2(30),

	CONSTRAINT pk_profesor PRIMARY KEY (dni)

);

CREATE TABLE CURSO (
	cod_curso VARCHAR2(10),
	nombre VARCHAR2(15),
	num_alumno NUMBER(3),
	fecha_inicio DATE,
	fecha_fin DATE,
	horas_curso NUMBER(3),	
	dni_profesor VARCHAR(9),
	
	CONSTRAINT pk_curso PRIMARY KEY (cod_curso),
	CONSTRAINT fk_curso FOREIGN KEY (dni_profesor) REFERENCES PROFESOR(dni)
);


CREATE TABLE ALUMNO (
	dni  VARCHAR2(9),
	nombre VARCHAR2(15),
	apellidos VARCHAR2(30),
	direccion VARCHAR2(20),
	fecha_nacimiento DATE,
	sexo VARCHAR2(5),
	cod_curso VARCHAR2(10),
	
	CONSTRAINT pk_alumno PRIMARY KEY (dni),
	CONSTRAINT fk_alumno FOREIGN KEY (cod_curso) REFERENCES CURSO(cod_curso),
	CONSTRAINT ch_alumno CHECK (sexo IN ('H','M'))
);

ALTER TABLE ALUMNO MODIFY (cod_curso VARCHAR(10) NOT NULL); 
ALTER TABLE CURSO MODIFY (horas_curso NUMBER(3) NOT NULL); 
ALTER TABLE PROFESOR MODIFY (sueldo NUMBER(5) NOT NULL); 
ALTER TABLE PROFESOR MODIFY ( nombre NUMBER(5) UNIQUE ); 
ALTER TABLE CURSO ADD CONSTRAINT chk_curso CHECK (fecha_inicio>fecha_fin);
ALTER TABLE ALUMNO ADD CONSTRAINT chk_alumno CHECK (sexo=UPPER(sexo));

--SELECT upper('hola mundo') FROM DUAL; 

