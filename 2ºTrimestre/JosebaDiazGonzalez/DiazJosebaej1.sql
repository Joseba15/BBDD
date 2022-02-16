/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER DiazJosebaej1 identified BY DiazJosebaej1;
GRANT CONNECT , RESOURCE, DBA TO DiazJosebaej1;
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
	--CONSTRAINT chk1_ndi CHECK(dni regexp_like ([0-9]{0})
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

ALTER TABLE PARTICIPACION ADD CONSTRAINT chk2_participacion CHECK (jockey = INITCAP(jockey)); 
--ALTER TABLE CARRERA ADD CONSTRAINT chk3_carrera CHECK (fecha_hora BETWEEN fecha_hora to_char ('10/03','DD/MM') AND fecha_hora to_char ('10/11','DD/MM')  );
ALTER TABLE CABALLO ADD CONSTRAINT chk3_caballo CHECK (nacionalidad IN ('Española','Britanica','Arabe'));
ALTER TABLE CABALLO DROP COLUMN propietario;
ALTER TABLE CARRERA ADD CONSTRAINT chk4_carrera CHECK (importe_premio >= 1000);
ALTER TABLE CLIENTE ADD codigo VARCHAR2(10) UNIQUE NOT NULL ;
ALTER TABLE APUESTA ADD premio NUMBER(5);
ALTER TABLE CARRERA MODIFY CONSTRAINT chk4_carrera DISABLE;
ALTER TABLE CARRERA DROP CONSTRAINT chk4_carrera;

/*
DROP TABLE CARRERA CASCADE CONSTRAINT;
DROP TABLE CABALLO CASCADE CONSTRAINT;
DROP TABLE PARTICIPACION CASCADE CONSTRAINT;
DROP TABLE CLIENTE CASCADE CONSTRAINT;
DROP TABLE APUESTA CASCADE CONSTRAINT;
*/






