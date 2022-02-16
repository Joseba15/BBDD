CREATE TABLE TEMA (
	cod_tema VARCHAR2(30),
	denominacion VARCHAR2(30),
	cod_tema_padre VARCHAR2(30),
	
	CONSTRAINT pk_tema PRIMARY KEY (cod_tema)
);

CREATE TABLE AUTOR (
	cod_autor VARCHAR2(30),
	nombre VARCHAR2 (20),
	f_nacimiento DATE ,
	libro_principal VARCHAR2(40),
	
	CONSTRAINT pk_autor PRIMARY KEY (cod_autor)
);


CREATE TABLE LIBRO (
	cod_libro VARCHAR2(30),
	titulo VARCHAR2 (20),
	f_creacion DATE,
	autor_principal VARCHAR2(40),
	cod_tema VARCHAR2(30),
	
	CONSTRAINT pk_libro PRIMARY KEY (cod_libro),
	CONSTRAINT fk_libro FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema)
);


CREATE TABLE LIBRO_AUTOR (
	cod_libro VARCHAR2(30),
	cod_autor VARCHAR2(30),
	orden VARCHAR2(10),
	
	CONSTRAINT pk_libro_autor PRIMARY KEY (cod_libro,cod_autor),
	CONSTRAINT fk_autor_libro_1 FOREIGN KEY (cod_autor) REFERENCES AUTOR(cod_autor),
	CONSTRAINT fk_autor_libro_2 FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro)
);

CREATE TABLE EDITORIAL (
	cod_editorial VARCHAR2(30),
	denominacion VARCHAR2(30),
	
	CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
);

CREATE TABLE PUBLICACIONES (
	cod_editorial VARCHAR2(30),
	cod_libro VARCHAR2 (30),
	precio NUMBER(5),
	f_publicacion DATE,
	
	CONSTRAINT pk_publicaciones PRIMARY KEY (cod_libro,cod_editorial),
	CONSTRAINT fk_publicaciones1 FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro),
	CONSTRAINT fk_publicaciones2 FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial)
);

ALTER TABLE LIBRO_AUTOR ADD CONSTRAINT update_orden CHECK (orden>=1 AND orden<=5);
ALTER TABLE TEMA MODIFY cod_tema NUMBER(20);
ALTER TABLE TEMA ADD CONSTRAINT update_tema1 CHECK (cod_tema_padre>cod_tema);
ALTER TABLE PUBLICACIONES MODIFY f_publicacion DEFAULT SYSDATE;
ALTER TABLE PUBLICACIONES ADD CONSTRAINT mod_ CHECK (orden>=1 AND orden<=5);







