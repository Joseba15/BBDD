ALTER SESSION SET "_oracle_script" = TRUE;
CREATE USER tiendas IDENTIFIED BY tiendas;
GRANT CONNECT , RESOURCE , DBA TO tiendas;

CREATE TABLE TIENDA (
	nif VARCHAR2(10),
	nombre VARCHAR2(20),
	direccion VARCHAR2(20),
	poblacion VARCHAR2(20),
	provincia VARCHAR2(20),
	codpostal NUMBER(5),
	
	CONSTRAINT pk_tienda PRIMARY KEY (nif),
	CONSTRAINT CH_provincia CHECK (provincia = upper(provincia))
);

CREATE TABLE FABRICANTE (
	cod_fabricante NUMBER(3),
	nombre VARCHAR2(15),
	pais VARCHAR2(15),
	
	CONSTRAINT pk_fabricante PRIMARY KEY (cod_fabricante),
	CONSTRAINT CH_nombre CHECK (nombre = upper(nombre)),
	CONSTRAINT CH_pais CHECK (pais = upper(pais))
	
);

CREATE TABLE ARTICULO (
	articulo VARCHAR2(20),
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL, 
	categoria VARCHAR2(10),
	precio_venta NUMBER (4,2),
	precio_coste NUMBER (4,2),
	existencias NUMBER(5),
	
	CONSTRAINT pk_articulo PRIMARY KEY (articulo,cod_fabricante,peso,categoria), 
	CONSTRAINT fk_articulo FOREIGN KEY (cod_fabricante) REFERENCES 	FABRICANTE(cod_fabricante),
	CONSTRAINT CH_precio_venta CHECK (precio_venta > 0),
	CONSTRAINT CH_precio_costo CHECK (precio_coste > 0),
	CONSTRAINT CH_peso CHECK (peso > 0),
	CONSTRAINT CH_categoria CHECK (categoria IN('PRIMERA','SEGUNDA','TERCERA'))
);


CREATE TABLE PEDIDO (
	nif VARCHAR2(10),
	articulo VARCHAR2(20),
	cod_fabricante NUMBER(3),
	peso NUMBER (3),
	categoria VARCHAR2(10),
	fecha_pedido DATE DEFAULT SYSDATE,
	unidades_pedidos NUMBER(4),
	
	CONSTRAINT pk_pedidos PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
	CONSTRAINT fk_pedidos FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTE(cod_fabricante),
	CONSTRAINT fk_pedidos2 FOREIGN KEY (nif) REFERENCES TIENDA (nif),
	CONSTRAINT fk_pedido3 FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULO(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,	
	CONSTRAINT CH_pedidos CHECK (unidades_pedidos > 0)
);

CREATE TABLE VENTAS (
	nif VARCHAR2(10),
	articulo VARCHAR2(20),
	cod_fabricante NUMBER(3),
	peso NUMBER (3),
	categoria VARCHAR2(10),
	fecha_venta DATE DEFAULT SYSDATE,
	unidades_vendidas NUMBER(4),
	
	CONSTRAINT pk_ventas PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
	CONSTRAINT fk_ventas FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTE(cod_fabricante),
	CONSTRAINT fk_ventas2 FOREIGN KEY (nif) REFERENCES TIENDA (nif),
	CONSTRAINT fk_ventas3 FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULO(articulo,cod_fabricante,peso,categoria)ON DELETE CASCADE,
	CONSTRAINT CH_ventas CHECK (unidades_vendidas > 0)
);


--*******

ALTER TABLE PEDIDO MODIFY unidades_pedidas NUMBER (6);
ALTER TABLE VENTA MODIFY unidades_vendidas NUMBER (6);

ALTER TABLE PEDIDO ADD pvp NUMBER (5);
ALTER TABLE VENTA ADD pvp NUMBER (5);

ALTER TABLE FABRICANTE DROP (pais);

ALTER TABLE VENTAS ADD CONSTRAINT CH_ventas2 CHECK (unidades_vendidas >= 100);
ALTER TABLE VENTAS DROP CONSTRAINT CH_ventas2;
/*
DROP TABLE ARTICULOS CASCADE CONSTRAINT ;
DROP TABLE FABRICANTE CASCADE CONSTRAINT ;
DROP TABLE PEDIDO CASCADE CONSTRAINT ;
DROP TABLE TIENDA CASCADE CONSTRAINT ;
DROP TABLE VENTA CASCADE CONSTRAINT ;
*/






