CREATE TABLE departamento 
(id NUMBER(10),
nombre VARCHAR2(50),

CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE profesor
(id NUMBER(10),
nif VARCHAR2(9),
nombre VARCHAR2(25),
apellido1 VARCHAR2(50),
apellido2 VARCHAR2(50),
cuidad VARCHAR2(25),
direccion VARCHAR2(50),
telefono VARCHAR2(9),
fecha_nacimiento DATE,
sexo VARCHAR2(1),
id_departamento NUMBER(10),

CONSTRAINT pk_profesor PRIMARY KEY (id),
CONSTRAINT fk_profesor FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

CREATE TABLE grado
(id NUMBER(10),
nombre VARCHAR2(100),

CONSTRAINT pk_grado PRIMARY KEY (id)
);

CREATE TABLE asignatura
(id NUMBER(10),
nombre VARCHAR2(100),
creditos NUMBER(5,3),
tipo VARCHAR(20),
curso NUMBER(3),
cuatrimestre NUMBER(3),
id_profesor NUMBER(10),
id_grado NUMBER(10),

CONSTRAINT pk_asignatura PRIMARY KEY (id),
CONSTRAINT fk_asignatura FOREIGN KEY (id_profesor) REFERENCES profesor(id),
CONSTRAINT fk_asignatura2 FOREIGN KEY (id_grado) REFERENCES grado(id)
);

CREATE TABLE alumno
(id NUMBER(10),
nif VARCHAR2(9),
nombre VARCHAR2(25),
apellido1 VARCHAR2(50),
apellido2 VARCHAR2(50),
cuidad VARCHAR2(25),
direccion VARCHAR2(50),
telefono VARCHAR2(9),
fecha_nacimiento DATE,
sexo VARCHAR2(1),

CONSTRAINT pk_alumno PRIMARY KEY (id)
);

CREATE TABLE curso_escolar 
(id NUMBER(10),
anyo_inicio NUMBER(4),
anyo_fin NUMBER(4),

CONSTRAINT pk_curso_escolar PRIMARY KEY (id)
);



CREATE TABLE alumno_se_matricula_asignatura
(id_alumno NUMBER(10),
id_asignatura NUMBER(10),
id_curso_escolar NUMBER(10),

CONSTRAINT pk_alumno_matricula PRIMARY KEY (id_alumno,id_asignatura,id_curso_escolar),
CONSTRAINT fk_alumno_matricula FOREIGN KEY (id_alumno) REFERENCES alumno(id),
CONSTRAINT fk_alumno_matricula2 FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id),
CONSTRAINT fk_alumno_matricula3 FOREIGN KEY (id_asignatura) REFERENCES asignatura (id)

);
