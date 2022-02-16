CREATE SEQUENCE  sec_libros
START WITH 1
INCREMENT BY 1;

INSERT INTO LIBROS VALUES (sec_libros.nextval,'pruebasecuencia','yo','santorini');

SELECT	sec.currval FROM LIBROS;


------------------------------------------

--Lo mismo pero con Mysql


CREATE TABLE LIBROS  (
	codigo int(5) AUTO_INCREMENT ,
	nombre VARCHAR(10),

	CONSTRAINT pk_libros PRIMARY KEY (codigo)

)

INSERT INTO  LIBROS (nombre) VALUES ('manolito')

select * from libros;


--oracle 

CREATE TABLE LIBROS  (
        codigo NUMBER(5) AUTO_INCREMENT ,
        nombre VARCHAR2(10),

        CONSTRAINT pk_libros PRIMARY KEY (codigo)

);

CREATE SEQUENCE  sec_libros
START WITH 1
INCREMENT BY 1;


INSERT INTO  LIBROS (codigo,nombre) VALUES (sec_libros.nextval,'manolito')
ROLLBACK;
SELECT * FORM LIBROS;








