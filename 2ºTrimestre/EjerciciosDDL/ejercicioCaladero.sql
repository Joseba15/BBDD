CREATE TABLE BARCO (
	matricula VARCHAR2(20),
	nombre VARCHAR2(10),
	clase  VARCHAR2(10),
	armador  VARCHAR2(20),
	capacidad NUMBER(10),
	nacionalidad  VARCHAR2(15),
	
	CONSTRAINT pk_barco PRIMARY KEY (matricula)
);

CREATE TABLE ESPECIE (
	codigo VARCHAR2(20),
	nombre VARCHAR2(20),
	tipo  VARCHAR2(25),
	cupoporbarco NUMBER (10),
	caladero_principal VARCHAR2(20),
		
	CONSTRAINT pk_especie PRIMARY KEY (codigo)
);


CREATE TABLE CALADERO (
	codigo VARCHAR2(20),
	nombre VARCHAR2(20),
	ubicacion  VARCHAR2(25),
	especie_principal VARCHAR2(20),
		
	CONSTRAINT pk_caladero PRIMARY KEY (codigo),
	CONSTRAINT fk_caladero FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo) ON DELETE SET NULL 
);

CREATE TABLE LOTE (
	codigo VARCHAR2(20),
	matricula VARCHAR2(20),
	numkilos NUMBER (20),
	precioporkiloadjudicado NUMBER(20),
	fechaventa DATE,
	cod_especie VARCHAR2(20),

	CONSTRAINT pk_lote PRIMARY KEY (codigo),	
	CONSTRAINT fk_lote FOREIGN KEY (matricula) REFERENCES BARCO(matricula) ON DELETE CASCADE,
	CONSTRAINT fk_lote2 FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo) ON DELETE CASCADE
	
);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDA (
	cod_especie VARCHAR2(20),
	cod_caladero VARCHAR2(20),
	numkilos NUMBER (20),
	fecha_inicial DATE ,
	fecha_final DATE ,

	CONSTRAINT pk_fechas PRIMARY KEY (cod_especie,cod_caladero),	
	CONSTRAINT fk_fechas1 FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo),
	CONSTRAINT fk_fechas2 FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo)
	
);

ALTER TABLE ESPECIE ADD CONSTRAINT fk_especie FOREIGN KEY () REFERENCES ESPECIE(codigo) ON DELETE SET NULL 

