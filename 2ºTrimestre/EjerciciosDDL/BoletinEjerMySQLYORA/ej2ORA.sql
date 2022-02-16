
CREATE TABLE COMERCIAL (
	id NUMBER(10),
	nombre varchar(100),
	apellido1 varchar(100),
	apellido2 varchar2(100),
	cuidad varchar2(100),
	comision NUMBER,
	
	CONSTRAINT pk_comercial PRIMARY KEY (id)


);

CREATE TABLE CLIENTE (
	id NUMBER(10),
	nombre varchar2(100),
	apellido1 varchar2(100),
	apellido2 varchar2(100),
	cuidad varchar2(100),
	categoria NUMBER(10),
	
	CONSTRAINT pk_cliente PRIMARY KEY (id) 
	
);


CREATE TABLE PEDIDO (
	id NUMBER(10),
	cantidad NUMBER,
	fecha DATE,
	id_cliente NUMBER(10),
	id_comercial NUMBER(10),

	CONSTRAINT pk_pedido PRIMARY KEY (id),
	CONSTRAINT fk_pedido1 FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id),
	CONSTRAINT fk_pedido2 FOREIGN KEY (id_comercial) REFERENCES COMERCIAL(id)
	
	
);

