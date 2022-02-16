CREATE TABLE GAMA_PRODUCTO (
	gama VARCHAR2(50),
	descripcion_texto VARCHAR2(30),
	descripcion_html VARCHAR2(30),
	imagen VARCHAR2(256),
	
	CONSTRAINT pk_gama_p PRIMARY KEY (gama)

);

CREATE TABLE PRODUCTO (
	cod_producto VARCHAR2(15),
	nombre VARCHAR2(70),
	gama VARCHAR2(50),
	dimensiones VARCHAR2(25),
	proveedor VARCHAR2(50),
	descripcion VARCHAR2(25),
	cantidad_en_stock NUMBER(6),
	precio_venta NUMBER(15),
	precio_proveedor NUMBER(15),
	
	CONSTRAINT pk_producto PRIMARY KEY (cod_producto),
	CONSTRAINT fk_producto FOREIGN KEY (gama) REFERENCES GAMA_PRODUCTO(gama)    
	
);

CREATE TABLE CLIENTE (
	cod_cliente NUMBER(11),
	nombre_cliente VARCHAR2(50),
	nombre_contacto VARCHAR2(30),
	apellido_contacto VARCHAR2(30),
	telefono VARCHAR2(15),
	fax VARCHAR2(15),
	linea_direccion1 VARCHAR2(50),
	linea_direccion2 VARCHAR2(50),
	ciudad VARCHAR2(50),
	region VARCHAR2(50),
	pais VARCHAR2(50),
	codigo_postal VARCHAR2(10),
	codigo_empleado_rep_ventas NUMBER(11),
	limite_credito NUMBER(15),
	
	CONSTRAINT pk_cliente PRIMARY KEY (cod_cliente)
	

);
	ALTER TABLE CLIENTE ADD CONSTRAINT fk_cliente FOREIGN KEY (cod_empleado_rep_ventas) 		REFERENCES CLIENTE(cod_empleado)

CREATE TABLE PEDIDO (
	cod_pedido NUMBER(11),
	nombre VARCHAR2(70),
	fecha_pedido DATE,
	fecha_esperada DATE,
	fecha_entrega DATE,
	estado VARCHAR2(15),
	comentarios VARCHAR2(15),
	cod_cliente NUMBER(11),
	
	CONSTRAINT pk_pedido PRIMARY KEY (cod_pedido),
	CONSTRAINT fk_pedido FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente)    
	
);

CREATE TABLE DETALLE_PEDIDO (
	cod_pedido NUMBER(11),
	cod_producto VARCHAR2(15),
	cantidad NUMBER(11),
	precio_unidad NUMBER(15),
	numero_linea NUMBER(6),

	CONSTRAINT pk_detalle_pedido PRIMARY KEY (cod_pedido,cod_producto),
	CONSTRAINT fk_detalle_pedido1 FOREIGN KEY (cod_pedido) REFERENCES PEDIDO(cod_pedido),	
	CONSTRAINT fk_detalle_pedido2 FOREIGN KEY (cod_producto) REFERENCES PRODUCTO(cod_producto)
); 

CREATE TABLE PAGO (
	cod_cliente NUMBER(11),
	forma_pago VARCHAR2(40),
	id_transaccion VARCHAR2(50),
	fecha_pago DATE,
	total NUMBER(15),

	CONSTRAINT pk_pago PRIMARY KEY (cod_cliente,id_transaccion),
	CONSTRAINT fk_pago FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente)	

);

CREATE TABLE EMPLEADO (
	cod_empleado NUMBER(15),
	nombre VARCHAR2(50),
	apellido1 VARCHAR2(50),
	apellido2 VARCHAR2(50),
	extension VARCHAR2(10),
	email VARCHAR2(100),
	cod_oficina VARCHAR2(10),
	cod_jefe  NUMBER(11),
	puesto VARCHAR2(50),
	
	CONSTRAINT pk_empleado PRIMARY KEY (cod_empleado),
	CONSTRAINT fk_empleado1 FOREIGN KEY (cod_oficina) REFERENCES OFICINA(cod_oficina),
	CONSTRAINT fk_empleado2 FOREIGN KEY (cod_jefe) REFERENCES EMPLEADO (cod_empleado)


);

CREATE TABLE OFICINA (
	cod_oficina VARCHAR2(10),
	ciudad VARCHAR2(30),
	pais VARCHAR2(50),
	region VARCHAR2(50),
	codigo_postal VARCHAR2(10),
	telefono VARCHAR2(20),
	linea_direccion1 VARCHAR2(50),
	linea_direccion2 VARCHAR2(50),
	
	CONSTRAINT pk_oficina PRIMARY KEY (cod_oficina)
);




--SELECT * FROM user_tables;
--CREATE INDEX nombre_index ON nombre_tabla (campo1,campo2),




