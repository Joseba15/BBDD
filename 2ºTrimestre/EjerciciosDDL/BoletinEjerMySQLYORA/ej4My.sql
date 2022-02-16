CREATE TABLE GAMA_PRODUCTO (
	gama VARCHAR(50),
	descripcion_texto TEXT(30),
	descripcion_html TEXT(30),
	imagen VARCHAR(256),
	
	CONSTRAINT pk_gama_p PRIMARY KEY (gama)

);

CREATE TABLE PRODUCTO (
	cod_producto VARCHAR(15),
	nombre VARCHAR(70),
	gama VARCHAR(50),
	dimensiones VARCHAR(25),
	proveedor VARCHAR(50),
	descripcion TEXT(25),
	cantidad_en_stock SMALLINT(6),
	precio_venta DECIMAL(15,2),
	precio_proveedor DECIMAL(15,2),
	
	CONSTRAINT pk_producto PRIMARY KEY (cod_producto),
	CONSTRAINT fk_producto FOREIGN KEY (gama) REFERENCES GAMA_PRODUCTO(gama)    
	
);

CREATE TABLE CLIENTE (
	cod_cliente INT(11),
	nombre_cliente VARCHAR(50),
	nombre_contacto VARCHAR(30),
	apellido_contacto VARCHAR(30),
	telefono VARCHAR(15),
	fax VARCHAR(15),
	linea_direccion1 VARCHAR(50),
	linea_direccion2 VARCHAR(50),
	ciudad VARCHAR(50),
	region VARCHAR(50),
	pais VARCHAR(50),
	codigo_postal VARCHAR(10),
	codigo_empleado_rep_ventas INT(11),
	limite_credito INT(15),
	
	CONSTRAINT pk_cliente PRIMARY KEY (cod_cliente)
	

);
ALTER TABLE CLIENTE ADD CONSTRAINT fk_cliente FOREIGN KEY (cod_empleado_rep_ventas) REFERENCES CLIENTE(cod_empleado)

CREATE TABLE PEDIDO (
	cod_pedido INT(11),
	nombre VARCHAR(70),
	fecha_pedido DATE,
	fecha_esperada DATE,
	fecha_entrega DATE,
	estado VARCHAR(15),
	comentarios VARCHAR(15),
	cod_cliente INT(11),
	
	CONSTRAINT pk_pedido PRIMARY KEY (cod_pedido),
	CONSTRAINT fk_pedido FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente)    
	
);

CREATE TABLE DETALLE_PEDIDO (
	cod_pedido INT(11),
	cod_producto VARCHAR(15),
	cantidad INT(11),
	precio_unidad INT(15),
	numero_linea INT(6),

	CONSTRAINT pk_detalle_pedido PRIMARY KEY (cod_pedido,cod_producto),
	CONSTRAINT fk_detalle_pedido1 FOREIGN KEY (cod_pedido) REFERENCES PEDIDO(cod_pedido),	
	CONSTRAINT fk_detalle_pedido2 FOREIGN KEY (cod_producto) REFERENCES PRODUCTO(cod_producto)
); 

CREATE TABLE PAGO (
	cod_cliente INT(11),
	forma_pago VARCHAR(40),
	id_transaccion VARCHAR(50),
	fecha_pago DATE,
	total INT(15),

	CONSTRAINT pk_pago PRIMARY KEY (cod_cliente,id_transaccion),
	CONSTRAINT fk_pago FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente)	

);
CREATE TABLE OFICINA (
	cod_oficina VARCHAR(10),
	ciudad VARCHAR(30),
	pais VARCHAR(50),
	region VARCHAR(50),
	codigo_postal VARCHAR(10),
	telefono VARCHAR(20),
	linea_direccion1 VARCHAR(50),
	linea_direccion2 VARCHAR(50),
	
	CONSTRAINT pk_oficina PRIMARY KEY (cod_oficina)
);

CREATE TABLE EMPLEADO (
	cod_empleado INT(15),
	nombre VARCHAR(50),
	apellido1 VARCHAR(50),
	apellido2 VARCHAR(50),
	extension VARCHAR(10),
	email VARCHAR(100),
	cod_oficina VARCHAR(10),
	cod_jefe  INT(11),
	puesto VARCHAR(50),
	
	CONSTRAINT pk_empleado PRIMARY KEY (cod_empleado),
	CONSTRAINT fk_empleado1 FOREIGN KEY (cod_oficina) REFERENCES OFICINA(cod_oficina),
	CONSTRAINT fk_empleado2 FOREIGN KEY (cod_jefe) REFERENCES EMPLEADO (cod_empleado)


);



--SELECT * FROM user_tables;
--CREATE INDEX nombre_index ON nombre_tabla (campo1,campo2),