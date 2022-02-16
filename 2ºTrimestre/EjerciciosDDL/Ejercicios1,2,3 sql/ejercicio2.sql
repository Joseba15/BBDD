CREATE TABLE EQUIPO (
	cod_equipo VARCHAR2(4),
	nombre VARCHAR2(30) NOT NULL,		
	localidad VARCHAR2(15),

	CONSTRAINT pk_equipo PRIMARY KEY (cod_equipo)

);


CREATE TABLE JUGADOR (
	cod_jugador VARCHAR2(4),
	nombre VARCHAR2(30) NOT NULL,
	fecha_nacimiento DATE,
	demarcacion VARCHAR2(10),
	cod_equipo VARCHAR2(4),

	CONSTRAINT pk_jugador PRIMARY KEY (cod_jugador),
	CONSTRAINT fk_equipo FOREIGN KEY (cod_equipo) REFERENCES EQUIPO(cod_equipo)

);

CREATE TABLE PARTIDO (
	cod_partido VARCHAR2(4),
	fecha DATE,
	competicion VARCHAR2(4),
	jornada VARCHAR2(20),
	cod_equipo_local VARCHAR2(4),
	cod_equipo_visitante VARCHAR2(4),

	CONSTRAINT pk_partido PRIMARY KEY (cod_partido),
	CONSTRAINT fk_partido1 FOREIGN KEY (cod_equipo_local) REFERENCES EQUIPO(cod_equipo),
	CONSTRAINT fk_partido2 FOREIGN KEY (cod_equipo_visitante) REFERENCES EQUIPO(cod_equipo),
	CONSTRAINT che_fecha CHECK (EXTRACT (MONTH FROM fecha)!=7 OR EXTRACT (MONTH FROM fecha)!=8),
	CONSTRAINT che_competicion CHECK (competicion IN ('copa') OR  competicion IN ('liga'))
);

CREATE TABLE INCIDENCIAS (
	num_incidencias VARCHAR2(6),
	cod_partido VARCHAR2(4),
	cod_jugador VARCHAR2(4),
	minuto NUMBER(2),
	tipo VARCHAR2(20), 
	
	CONSTRAINT  che_min CHECK (minuto < 100 AND minuto > 1),
	CONSTRAINT pk_incidendias PRIMARY KEY (num_incidencias),
	CONSTRAINT fk_incidendias1 FOREIGN  KEY (cod_partido) REFERENCES PARTIDO(cod_partido),
	CONSTRAINT fk_incidendias2 FOREIGN  KEY (cod_jugador) REFERENCES JUGADOR(cod_jugador)
);

ALTER TABLE JUGADOR ADD CONSTRAINT nom_jugador CHECK (INITCAP (nombre) =nombre );
ALTER TABLE JUGADOR ADD CONSTRAINT demarc_jugador CHECK (demarcacion IN ('Portero') OR demarcacion IN ('Defensa') OR demarcacion IN ('Medio') OR demarcacion IN ('Delantero'));
ALTER TABLE EQUIPO ADD CONSTRAINT cod_eq_check CHECK ( REGEXP_LIKE (cod_equipo ,'^[0-9]{1}'));
ALTER TABLE INCIDENCIA MODIFY tipo NOT NULL;
ALTER TABLE EQUIPOS ADD golesMarcados NUMBER (3);







