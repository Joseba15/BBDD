/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER hipodromo identified BY hipodromo;
GRANT CONNECT , RESOURCE, DBA TO hipodromo;
*/



CREATE TABLE CABALLO (
	codCaballo VARCHAR2(4),
	nombre VARCHAR2(20) NOT NULL,
	peso NUMBER(3),
	fecha_nacimiento DATE,
	propietario VARCHAR2(25),
	nacionalidad VARCHAR2(20),
	
	CONSTRAINT pk_caballo PRIMARY KEY (codCaballo),
	CONSTRAINT chk1_caballo CHECK (peso BETWEEN 240 AND 300),
	CONSTRAINT chk2_caballo CHECK (EXTRACT (YEAR FROM fecha_nacimiento)>'2000')

); 

ALTER TABLE CABALLO ADD CONSTRAINT chk3_caballo CHECK (nacionalidad = upper (nacionalidad));

CREATE TABLE CARRERA (
	codCarrera VARCHAR2(4),
	fecha_hora DATE,
	importe_premio NUMBER(6),
	apuesta_limite NUMBER(5,6),
	
	CONSTRAINT pk_carrera PRIMARY KEY (codCarrera),
	CONSTRAINT chk1_carrera CHECK (EXTRACT (MONTH FROM fecha_hora) NOT IN ('3','8')),
	CONSTRAINT chk2_carrera CHECK (apuesta_limite <20000)

);

CREATE TABLE PARTICIPACION (
	codCaballo VARCHAR2(4),
	codCarrera VARCHAR2(4),
	dorsal NUMBER(2) NOT NULL ,
	jockey VARCHAR2(10) NOT NULL ,
	posicionFinal NUMBER(2),
	
	CONSTRAINT pk_participaciones PRIMARY KEY(codCaballo,codCarrera),
	CONSTRAINT fk1_participaciones FOREIGN KEY (codCaballo) REFERENCES CABALLO(codCaballo),
	CONSTRAINT fk2_participaciones FOREIGN KEY (codCarrera) REFERENCES CARRERA(codCarrera),
	CONSTRAINT chk1_participaciones CHECK (posicionFinal>0)
);


CREATE TABLE CLIENTE (
	dni VARCHAR2(10),
	nombre VARCHAR2(20),
	nacionalidad VARCHAR2(20),

	CONSTRAINT pk_dni PRIMARY KEY (dni),
	--CONSTRAINT chk1_ndi CHECK(dni regexp_like ([0-9]{8})
	CONSTRAINT chk2_nacionalidad CHECK (nacionalidad = UPPER(nacionalidad))
);

CREATE TABLE APUESTA (
	dniCliente VARCHAR2(10),
	codCaballo VARCHAR2(4),
	codCarrera VARCHAR2(4),
	importe NUMBER(6) DEFAULT (6) NOT NULL ,
	tantoporuno NUMBER(4,2),
	
	CONSTRAINT pk_apuesta PRIMARY KEY (dniCliente,codCaballo,codCarrera),
	CONSTRAINT fk1_apuesta FOREIGN KEY (codCaballo) REFERENCES CABALLO(codCaballo) ON DELETE CASCADE ,
 	CONSTRAINT fk2_apuesta FOREIGN KEY (codCarrera) REFERENCES CARRERA(codCarrera) ON DELETE CASCADE,
	CONSTRAINT fk3_apuesta FOREIGN KEY (dniCliente) REFERENCES CLIENTE(dni) ON DELETE CASCADE,
	CONSTRAINT chk1_apuesta CHECK (tantoporuno >1)

);

--2 Inserta el registro o registros necesarios para guardar la siguiente información:

INSERT INTO CLIENTE (dni,nacionalidad) VALUES ('12345678','ESCOCES');
INSERT INTO CABALLO (codCaballo,peso,nombre) VALUES ('1','298','Rocinante');
INSERT INTO CARRERA (codCarrera,fecha_hora,importe_premio) VALUES ('123',to_date ('01/07/2009','DD/MM/YYYY'),2000);
INSERT INTO APUESTA (dniCliente,codCarrera,codCaballo,tantoporuno) VALUES ('12345678','123','1',30);


--3 Inscribe a 2 caballos  en la carrera cuyo código es C6. La carrera aún no se ha celebrado. 
--Invéntate los jockeys y los dorsales y los caballos.. 


INSERT INTO CABALLO (codCaballo,nombre) VALUES ('2A','Pepe');
INSERT INTO CABALLO (codCaballo,nombre) VALUES ('2B','Pepa');
INSERT INTO CARRERA (codCarrera) VALUES ('C6');
INSERT INTO PARTICIPACION (codCaballo,codCarrera,jockey,dorsal) VALUES ('2A','C6','Juan',1); 
INSERT INTO PARTICIPACION (codCaballo,codCarrera,jockey,dorsal) VALUES ('2B','C6','Juana',2); 

SELECT * FROM participacion;


--4. Inserta dos carreras con los datos que creas necesario.

INSERT INTO CARRERA (codCarrera,fecha_hora,importe_premio) VALUES ('001',to_date ('09/02/2021','DD/MM/YYYY'),1000);
INSERT INTO CARRERA (codCarrera,fecha_hora,importe_premio) VALUES ('002',to_date ('01/01/2021','DD/MM/YYYY'),1500);


--5. Quita el campo propietario de la tabla caballos

ALTER TABLE CABALLO DROP COLUMN propietario;

--6.1. En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.
 
ALTER TABLE PARTICIPACION ADD CONSTRAINT chk2_participaciones CHECK (jockey = initcap(jockey));

--6.2 La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
SELECT * FROM CARRERA ;
ALTER TABLE CARRERA ADD CONSTRAINT chk3_carrera CHECK (fecha_hora  to_char(fecha_hora,'DD/MM/')>'10/03' OR   to_char(fecha_hora,'DD/MM')<'10/11');

--6.3 La nacionalidad de los caballos sólo puede ser Española, Británica o Árabe.

ALTER TABLE CABALLO ADD CONSTRAINT chk4_caballo CHECK (nacionalidad IN ('ESPAÑOL','BRITANICA','ARABE'));

--7. Borra las carreras en las que no hay caballos inscritos.

--Carrera y caballo no se relacionan asi que es imposible borrar dichas carreras


--8. Añade un campo llamado código en el campo clientes, que no permita valores nulos ni repetidos

/*
ALTER TABLE CLIENTE ADD codigo varchar2(10) UNIQUE ;
ALTER TABLE CLIENTE MODIFY codigo varchar2(10) UNIQUE NOT NULL  ;
*/

--9. Nos hemos equivocado y el código C6 de la carrera en realidad es C66.

ALTER TABLE PARTICIPACION DISABLE CONSTRAINT fk2_participaciones;
UPDATE CARRERA SET codCarrera='C66' WHERE codCarrera='C6';
UPDATE PARTICIPACION SET codCarrera='C66' WHERE codCarrera='C6';
ALTER TABLE PARTICIPACION ENABLE CONSTRAINT fk2_participaciones;

--10. Añade un campo llamado premio a la tabla apuestas.

ALTER TABLE APUESTA ADD premio VARCHAR2(20);

--11. Borra todas las tablas y datos con el número menor de instrucciones posibles.

DROP TABLE APUESTA CASCADE CONSTRAINT;
DROP TABLE CABALLO CASCADE CONSTRAINT;
DROP TABLE CARRERA CASCADE CONSTRAINT;
DROP TABLE CLIENTE CASCADE CONSTRAINT;
DROP TABLE PARTICIPACION CASCADE CONSTRAINT;


