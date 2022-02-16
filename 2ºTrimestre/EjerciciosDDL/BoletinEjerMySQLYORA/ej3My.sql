CREATE TABLE departamento 
(id INT(10),
nombre VARCHAR(50),

CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE profesor
(id INT(10),
nif VARCHAR(9),
nombre VARCHAR(25),
apellido1 VARCHAR(50),
apellido2 VARCHAR(50),
cuidad VARCHAR(25),
direccion VARCHAR(50),
telefono VARCHAR(9),
fecha_nacimiento DATE,
sexo VARCHAR(1),
id_departamento INT(10),

CONSTRAINT pk_profesor PRIMARY KEY (id),
CONSTRAINT fk_profesor FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

CREATE TABLE grado
(id INT(10),
nombre VARCHAR(100),

CONSTRAINT pk_grado PRIMARY KEY (id)
);

CREATE TABLE asignatura
(id INT(10),
nombre VARCHAR(100),
creditos INT(3),
tipo VARCHAR(20),
curso INT(3),
cuatrimestre INT(3),
id_profesor INT(10),
id_grado INT(10),

CONSTRAINT pk_asignatura PRIMARY KEY (id),
CONSTRAINT fk_asignatura FOREIGN KEY (id_profesor) REFERENCES profesor(id),
CONSTRAINT fk_asignatura2 FOREIGN KEY (id_grado) REFERENCES grado(id)
);

CREATE TABLE alumno
(id INT(10),
nif VARCHAR(9),
nombre VARCHAR(25),
apellido1 VARCHAR(50),
apellido2 VARCHAR(50),
cuidad VARCHAR(25),
direccion VARCHAR(50),
telefono VARCHAR(9),
fecha_nacimiento DATE,
sexo VARCHAR(1),

CONSTRAINT pk_alumno PRIMARY KEY (id)
);

CREATE TABLE curso_escolar 
(id INT(10),
anyo_inicio INT(4),
anyo_fin INT(4),

CONSTRAINT pk_curso_escolar PRIMARY KEY (id)
);



CREATE TABLE alumno_se_matricula_asignatura
(id_alumno INT(10),
id_asignatura INT(10),
id_curso_escolar INT(10),

CONSTRAINT pk_alumno_matricula PRIMARY KEY (id_alumno,id_asignatura,id_curso_escolar),
CONSTRAINT fk_alumno_matricula FOREIGN KEY (id_alumno) REFERENCES alumno(id),
CONSTRAINT fk_alumno_matricula2 FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id),
CONSTRAINT fk_alumno_matricula3 FOREIGN KEY (id_asignatura) REFERENCES asignatura (id)

);
