

CREATE TABLE Afiliados (
  ficha NUMBER(4) NOT NULL,
  nombre VARCHAR2(20) NOT NULL,
  apellidos VARCHAR2(30) NOT NULL,
  direccion VARCHAR2(30),
  telf NUMBER(9),
  sexo CHAR(1),
  nacimiento DATE,
  observaciones CLOB ) ;

CREATE TABLE Licencias (
  licencia VARCHAR2(9) NOT NULL) ;

CREATE TABLE Permisos (
  ficha NUMBER(4) NOT NULL,
  licencia VARCHAR2(9) NOT NULL);

CREATE TABLE Cauces  (
  cauce VARCHAR2(50) not null,
  observaciones CLOB );

CREATE TABLE Lugares (
  lugar VARCHAR2(50) NOT NULL,
  comunidad VARCHAR2(20) NOT NULL,
  observaciones CLOB,
  cauce varchar2(50));

CREATE TABLE Eventos  (
  evento VARCHAR2(60) not null,
  fecha_evento DATE not null,
  lugar VARCHAR2(50),
  observaciones CLOB );

CREATE TABLE Peces (
  pez VARCHAR2(30),
  observaciones CLOB );

CREATE TABLE Participaciones (
  ficha NUMBER(4) nOT NULL,
  evento VARCHAR2(60) NOT NULL,
  posicion NUMBER(3),
  trofeo VARCHAR2(30) ) ;

CREATE TABLE CapturasSolos (
  ficha NUMBER(4) NOT NULL,
  pez VARCHAR2(30)  NOT NULL,
  fecha_pesca DATE NOT NULL,
  hora_pesca DATE NOT NULL,
  peso NUMBER(5,3),
  talla NUMBER(3),
  foto BLOB,
  lugar VARCHAR2(40),
  aval1 NUMBER(4),
  aval2 NUMBER(4) ) ;

CREATE TABLE CapturasEventos  (
  ficha NUMBER(4) NOT NULL,
  pez VARCHAR2(30) NOT NULL,
  fecha_pesca DATE NOT NULL,
  hora_pesca DATE NOT NULL,
  peso NUMBER(5,3),
  talla NUMBER(3),
  foto BLOB,
  evento VARCHAR2(60) NOT NULL,
  puntos NUMBER(4) ) ;

/* Se definen las claves de las tablas */
ALTER TABLE Afiliados
  ADD CONSTRAINT pks
    PRIMARY KEY (ficha);
ALTER TABLE Licencias
  ADD CONSTRAINT pk_lic
    PRIMARY KEY (licencia);
ALTER TABLE Permisos
  ADD CONSTRAINT pk_Permisos
    PRIMARY KEY (ficha, licencia);
ALTER TABLE Cauces
  ADD CONSTRAINT pk_Cauces
    PRIMARY KEY (cauce);
ALTER TABLE Lugares
  ADD CONSTRAINT pk_lugar
    PRIMARY KEY (lugar);
ALTER TABLE Eventos
  ADD CONSTRAINT pk_evento
    PRIMARY KEY (evento);
ALTER TABLE Peces
  ADD CONSTRAINT pk_Peces
    PRIMARY KEY (pez);
ALTER TABLE Participaciones
  ADD CONSTRAINT pk_Participaciones
    PRIMARY KEY (ficha,evento);
ALTER TABLE CapturasSolos
  ADD CONSTRAINT pk_CapturasSolos
    PRIMARY KEY (ficha, pez, fecha_pesca, hora_pesca,lugar);
ALTER TABLE CapturasEventos
  ADD CONSTRAINT pk_CapturasEventos
    PRIMARY KEY (ficha, pez, fecha_pesca, hora_pesca);

/* Se definen las restricciones de integridad de referencia */
ALTER TABLE Permisos
  ADD CONSTRAINT fk_per_afi
    FOREIGN KEY (ficha)
REFERENCES Afiliados(ficha)
ON DELETE CASCADE;
ALTER TABLE Permisos
  ADD CONSTRAINT fk_per_lic
    FOREIGN KEY (licencia)
REFERENCES Licencias(licencia)
ON DELETE CASCADE;
ALTER TABLE Participaciones
  ADD CONSTRAINT fk_par_aso
    FOREIGN KEY (ficha)
    REFERENCES Afiliados(ficha)
    ON DELETE CASCADE;
ALTER TABLE Participaciones
  ADD CONSTRAINT fk_par_eve
    FOREIGN KEY (evento)
    REFERENCES Eventos(evento)
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos
  ADD CONSTRAINT fk_cps_af1
    FOREIGN KEY (ficha)
    REFERENCES Afiliados(ficha)
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos
  ADD CONSTRAINT fk_cps_pez
    FOREIGN KEY (pez)
    REFERENCES Peces(pez)
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos
  ADD CONSTRAINT fk_cps_lug
    FOREIGN KEY (lugar)
    REFERENCES Lugares(lugar)
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos
  ADD CONSTRAINT fk_cps_af2
    FOREIGN KEY (aval1)
    REFERENCES Afiliados(ficha);
ALTER TABLE CapturasSolos
  ADD CONSTRAINT fk_cps_af3
    FOREIGN KEY (aval2)
    REFERENCES Afiliados(ficha);
ALTER TABLE CapturasEventos
  ADD CONSTRAINT fk_cpe_afi
    FOREIGN KEY (ficha)
    REFERENCES Afiliados(ficha)
    ON DELETE CASCADE;
ALTER TABLE CapturasEventos
  ADD CONSTRAINT fk_cpe_pez
    FOREIGN KEY (pez)
    REFERENCES Peces(pez)
    ON DELETE CASCADE;
ALTER TABLE CapturasEventos
  ADD CONSTRAINT fk_cpe_eve
    FOREIGN KEY (evento)
    REFERENCES Eventos(evento)
    ON DELETE CASCADE;
ALTER TABLE Lugares
  ADD CONSTRAINT fk_lug_cau
      FOREIGN KEY (cauce)
      REFERENCES Cauces(cauce)
      ON DELETE CASCADE;
ALTER TABLE Eventos
  ADD CONSTRAINT fk_eve_lug
    FOREIGN KEY (lugar)
    REFERENCES Lugares(lugar)
    ON DELETE CASCADE;

/* Se definen las restricciones de dominio */
ALTER TABLE Licencias
  ADD CONSTRAINT ck_lic
    CHECK (licencia = UPPER(licencia));
ALTER TABLE Cauces
  ADD CONSTRAINT ck_cau
    CHECK (cauce = INITCAP(cauce));
ALTER TABLE Lugares
  ADD CONSTRAINT ck_lug
    CHECK (lugar = INITCAP(lugar));
ALTER TABLE Lugares
  ADD CONSTRAINT ck_comun
    CHECK (comunidad = UPPER(comunidad));
ALTER TABLE Afiliados
  ADD CONSTRAINT ck_nap
    CHECK (apellidos = INITCAP(apellidos));
ALTER TABLE Afiliados
  ADD CONSTRAINT ck_saf
    CHECK (sexo IN ('H','M'));
ALTER TABLE Afiliados
  ADD CONSTRAINT ck_naf
    CHECK (nombre = INITCAP(nombre));
ALTER TABLE Peces
  ADD CONSTRAINT ck_pez
    CHECK (pez = INITCAP(pez));
ALTER TABLE CapturasSolos
  ADD CONSTRAINT ck_pso
    CHECK (peso > 0);
ALTER TABLE CapturasSolos
  ADD CONSTRAINT ck_tal
    CHECK (talla > 0);
ALTER TABLE CapturasEventos
  ADD CONSTRAINT ck_ps2
    CHECK (peso > 0);
ALTER TABLE CapturasEventos
  ADD CONSTRAINT ck_ta2
    CHECK (talla > 0);
