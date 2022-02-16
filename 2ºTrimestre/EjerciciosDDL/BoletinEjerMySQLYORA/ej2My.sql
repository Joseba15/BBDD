
GRANT CREATE USER ON *.* TO dummy;

CREATE TABLE COMERCIAL (
	id int(10),
	nombre varchar(100),
	apellido1 varchar(100),
	apellido2 varchar(100),
	cuidad varchar(100),
	comision float,
	
	CONSTRAINT pk_comercial PRIMARY KEY (id)


);

CREATE TABLE CLIENTE (
	id int(10),
	nombre varchar(100),
	apellido1 varchar(100),
	apellido2 varchar(100),
	cuidad varchar(100),
	categoria int(10),
	
	CONSTRAINT pk_cliente PRIMARY KEY (id) 
	
);


CREATE TABLE PEDIDO (
	id int(10),
	cantidad double,
	fecha date,
	id_cliente int(10),
	id_comercial int(10),

	CONSTRAINT pk_pedido PRIMARY KEY (id),
	CONSTRAINT fk_pedido1 FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id),
	CONSTRAINT fk_pedido2 FOREIGN KEY (id_comercial) REFERENCES COMERCIAL(id)
	
	
);

