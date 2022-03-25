-- CONSULTAS MULTITABLA (COMPOSICION INTERNA);
-- Ejercicio 1:
SELECT c.NOMBRE_CLIENTE,e.NOMBRE,e.APELLIDO1 
FROM CLIENTE c,EMPLEADO e 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS =e.CODIGO_EMPLEADO;

-- Ejercicio 2:

SELECT c.NOMBRE_CLIENTE,e.NOMBRE
FROM CLIENTE c,EMPLEADO e,PAGO p 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS =e.CODIGO_EMPLEADO
AND c.CODIGO_CLIENTE =p.CODIGO_CLIENTE;

-- Ejercicio 3:

SELECT DISTINCT c.NOMBRE_CLIENTE,e.NOMBRE
FROM CLIENTE c,EMPLEADO e,PAGO p 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS =e.CODIGO_EMPLEADO
AND c.CODIGO_CLIENTE NOT IN (SELECT p2.CODIGO_CLIENTE 
							FROM PAGO p2);
						
-- Ejercicio 4:
SELECT DISTINCT C.NOMBRE_CLIENTE, E.NOMBRE, O.CIUDAD 
FROM CLIENTE C, PAGO P, EMPLEADO E, OFICINA O
WHERE C.CODIGO_CLIENTE NOT IN 
        (SELECT P.CODIGO_CLIENTE 
         FROM PAGO P)
AND C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO 
AND E.CODIGO_OFICINA = O.CODIGO_OFICINA;

--Forma sin subconsulta:
SELECT DISTINCT C.NOMBRE_CLIENTE,O.CIUDAD
FROM CLIENTE C,OFICINA O,EMPLEADO E,PAGO P
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
AND E.CODIGO_OFICINA=O.CODIGO_OFICINA
AND P.CODIGO_CLIENTE(+)=C.CODIGO_CLIENTE
AND P.CODIGO_CLIENTE IS NULL;
 -- Ejercicio 5:
SELECT DISTINCT O.LINEA_DIRECCION1, O.LINEA_DIRECCION2
FROM OFICINA O, EMPLEADO E, CLIENTE C
WHERE O.CODIGO_OFICINA = E.CODIGO_OFICINA 
AND E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS
AND UPPER(C.CIUDAD) LIKE 'FUENLABRADA';
			
-- Ejercicio 7:
SELECT DISTINCT C.NOMBRE_CLIENTE, E.NOMBRE, O.CODIGO_OFICINA
FROM CLIENTE C, EMPLEADO E, OFICINA O
WHERE E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS
AND E.CODIGO_OFICINA = O.CODIGO_OFICINA;

--Ejercicio 8:
 SELECT E.NOMBRE AS EMPLEADO, E2.NOMBRE AS JEFE
FROM EMPLEADO E, EMPLEADO E2
WHERE E.CODIGO_EMPLEADO = E2.CODIGO_JEFE;

-- Ejercicio 9:
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C, PEDIDO P
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
AND P.FECHA_ESPERADA < P.FECHA_ENTREGA;

-- Ejercicio 10:

SELECT DISTINCT PR.GAMA, C.NOMBRE_CLIENTE 
FROM CLIENTE C, PEDIDO P, DETALLE_PEDIDO DP, PRODUCTO PR
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
AND P.CODIGO_PEDIDO = DP.CODIGO_PEDIDO 
AND DP.CODIGO_PRODUCTO = PR.CODIGO_PRODUCTO;



-- CONSULTAS MULTITABLA (COMPOSICION EXTERNA);

-- Ejercicio 1:
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C 
WHERE C.CODIGO_CLIENTE NOT IN 
        (SELECT P.CODIGO_CLIENTE 
         FROM PAGO P);
-- Parte Subconsulta:

SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C ,PAGO P
WHERE C.CODIGO_CLIENTE =P.CODIGO_CLIENTE(+)
AND P.CODIGO_CLIENTE IS NULL;

-- Ejercicio 2 :
SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C
WHERE C.CODIGO_CLIENTE NOT IN 
        (SELECT P.CODIGO_CLIENTE 
         FROM PEDIDO P);

SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C,PAGO P
WHERE C.CODIGO_CLIENTE =P.CODIGO_CLIENTE(+)
AND P.CODIGO_CLIENTE IS NULL;

-- Ejercicio 3:
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C
WHERE C.CODIGO_CLIENTE NOT IN 
        (SELECT P.CODIGO_CLIENTE 
         FROM PEDIDO P)
AND C.CODIGO_CLIENTE NOT IN 
        (SELECT P2.CODIGO_CLIENTE 
         FROM PAGO P2 );


SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C,PEDIDO P,PAGO P2
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE(+)
AND C.CODIGO_CLIENTE=P2.CODIGO_CLIENTE(+)
AND P.CODIGO_CLIENTE IS NULL
AND P2.CODIGO_CLIENTE IS NULL;



-- Ejercicio 4:
SELECT E.NOMBRE 
FROM EMPLEADO E
WHERE E.CODIGO_OFICINA NOT IN (SELECT O.CODIGO_OFICINA
                                FROM OFICINA O );

SELECT E.NOMBRE
FROM EMPLEADO E, OFICINA O
WHERE E.CODIGO_OFICINA = O.CODIGO_OFICINA(+)
AND O.CODIGO_OFICINA IS NULL;

-- Ejericicio 5:
SELECT DISTINCT E.NOMBRE 
FROM EMPLEADO E, CLIENTE C
WHERE E.CODIGO_EMPLEADO NOT IN 
        (SELECT C.CODIGO_EMPLEADO_REP_VENTAS 
         FROM CLIENTE C);

SELECT DISTINCT E.NOMBRE
FROM EMPLEADO E, CLIENTE C
WHERE E.CODIGO_EMPLEADO=C.CODIGO_EMPLEADO_REP_VENTAS(+)
AND C.CODIGO_EMPLEADO_REP_VENTAS IS NULL ;

-- Ejercicio 6:
SELECT e.NOMBRE
FROM EMPLEADO e 
WHERE e.CODIGO_OFICINA NOT IN (SELECT o.CODIGO_OFICINA 
							   FROM OFICINA o
							   WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA)
AND  e.CODIGO_EMPLEADO NOT IN (SELECT c.CODIGO_EMPLEADO_REP_VENTAS
							  FROM CLIENTE c
							  WHERE e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS);

SELECT e.NOMBRE
FROM EMPLEADO e,OFICINA o,CLIENTE c
WHERE e.CODIGO_OFICINA =o.CODIGO_OFICINA(+)
AND e.CODIGO_OFICINA =c.CODIGO_EMPLEADO_REP_VENTAS(+)
AND o.CODIGO_OFICINA IS NULL
AND c.CODIGO_EMPLEADO_REP_VENTAS IS NULL;


-- Ejercicio 7:					 
SELECT DISTINCT p.NOMBRE 
FROM PRODUCTO p
WHERE p.CODIGO_PRODUCTO NOT IN (S   ELECT dp.CODIGO_PRODUCTO
								FROM DETALLE_PEDIDO dp);

SELECT DISTINCT p.NOMBRE
FROM PRODUCTO p,DETALLE_PEDIDO DP
WHERE p.CODIGO_PRODUCTO=DP.CODIGO_PRODUCTO(+)
AND DP.CODIGO_PRODUCTO IS NULL;
-- Ejercicio 8:
SELECT o.CODIGO_OFICINA 
FROM OFICINA o 
WHERE o.CODIGO_OFICINA NOT IN (SELECT e.CODIGO_OFICINA 
								FROM EMPLEADO e,CLIENTE c,DETALLE_PEDIDO dp,PEDIDO p,PRODUCTO p2, GAMA_PRODUCTO gp 
								WHERE e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS
								AND c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
								AND p.CODIGO_PEDIDO=dp.CODIGO_PEDIDO
								AND dp.CODIGO_PRODUCTO=p2.CODIGO_PRODUCTO
								AND p2.GAMA=gp.GAMA
								AND gp.GAMA LIKE 'Frutales');


SELECT o.CODIGO_OFICINA
FROM OFICINA o, (SELECT e.CODIGO_OFICINA,e.CODIGO_EMPLEADO
								FROM EMPLEADO e,CLIENTE c,DETALLE_PEDIDO dp,PEDIDO p,PRODUCTO p2, GAMA_PRODUCTO gp
								WHERE e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS
								AND c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
								AND p.CODIGO_PEDIDO=dp.CODIGO_PEDIDO
								AND dp.CODIGO_PRODUCTO=p2.CODIGO_PRODUCTO
								AND p2.GAMA=gp.GAMA
								AND gp.GAMA LIKE 'Frutales') ef
where o.CODIGO_OFICINA=ef.CODIGO_OFICINA(+)
and ef.CODIGO_OFICINA is null;
;



-- Ejercicio 9:

SELECT DISTINCT c.NOMBRE_CLIENTE 
FROM CLIENTE c ,PEDIDO p
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE 
AND c.CODIGO_CLIENTE NOT IN (SELECT p2.CODIGO_CLIENTE 
							 FROM PAGO p2);

SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c ,PEDIDO p,PAGO p2
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
AND c.CODIGO_CLIENTE =p2.CODIGO_CLIENTE(+)
AND p2.CODIGO_CLIENTE is null;

-- Ejercicio 10:

SELECT Distinct E.CODIGO_EMPLEADO, E.NOMBRE,E2.NOMBRE AS JEFE
FROM EMPLEADO e, EMPLEADO e2
WHERE e.CODIGO_EMPLEADO =e2.CODIGO_JEFE
AND e.CODIGO_EMPLEADO NOT IN (SELECT c.CODIGO_EMPLEADO_REP_VENTAS 
							  FROM CLIENTE c);


SELECT DISTINCT E.CODIGO_EMPLEADO, E.NOMBRE,E2.NOMBRE AS JEFE
FROM EMPLEADO e,CLIENTE c,EMPLEADO e2
WHERE e2.CODIGO_EMPLEADO =e.CODIGO_JEFE
AND e.CODIGO_EMPLEADO =c.CODIGO_EMPLEADO_REP_VENTAS(+)
AND c.CODIGO_EMPLEADO_REP_VENTAS IS NULL;
							 
							 
							 

-- CONSULTAS RESUMEN:
	
							 
							 
					
-- Ejericicio 1:
SELECT count(e.CODIGO_EMPLEADO)
FROM EMPLEADO e;
	
-- Ejercicio2:
 SELECT C.PAIS, COUNT(C.CODIGO_CLIENTE)
    FROM CLIENTE C
    GROUP BY C.PAIS;

-- Ejercicio 3:
SELECT TRUNC(NVL(AVG(p.TOTAL),0),2)
FROM PAGO p 
WHERE EXTRACT (YEAR FROM p.FECHA_PAGO)=2009;

-- Ejercicio 4:
SELECT P.ESTADO, COUNT(P.CODIGO_PEDIDO) AS NUM_PEDIDOS
FROM PEDIDO P
GROUP BY P.ESTADO
ORDER BY COUNT(P.CODIGO_PEDIDO) DESC;

-- Ejercicio 5:
SELECT max(p.PRECIO_VENTA),MIN(p.PRECIO_VENTA) 
FROM PRODUCTO p;

-- Ejercicio 6:
SELECT COUNT(C.CODIGO_CLIENTE)
FROM CLIENTE C;

-- Ejercicio 7:
SELECT count(c.CODIGO_CLIENTE)
FROM CLIENTE c 
WHERE LOWER(c.CIUDAD) LIKE 'madrid';
		

-- Ejercicio 8:
SELECT C.CIUDAD, COUNT(C.CODIGO_CLIENTE) AS NUM_CLIENTE
FROM CLIENTE C
WHERE C.CIUDAD LIKE 'M%'
GROUP BY C.CIUDAD;

-- Ejericicio 9:
SELECT e.CODIGO_EMPLEADO,COUNT(c.CODIGO_CLIENTE) 
FROM CLIENTE c,EMPLEADO e 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS=e.CODIGO_EMPLEADO
GROUP BY e.CODIGO_EMPLEADO;

-- Ejercicio 10:
/*
SELECT COUNT(c.CODIGO_CLIENTE)
FROM CLIENTE c 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS NOT IN (SELECT e.CODIGO_EMPLEADO 
							   FROM EMPLEADO e);
 */

select count(c.CODIGO_CLIENTE)
from CLIENTE c
where c.CODIGO_EMPLEADO_REP_VENTAS is null;

-- Ejercicio 11:
SELECT c.NOMBRE_CLIENTE,min(p.FECHA_PAGO), max(p.FECHA_PAGO)
FROM PAGO p,CLIENTE c 
WHERE p.CODIGO_CLIENTE =c.CODIGO_CLIENTE
group by c.NOMBRE_CLIENTE;

-- Ejercicio 12:

 SELECT  DP.CODIGO_PEDIDO, COUNT(distinct DP.CODIGO_PRODUCTO)
 FROM DETALLE_PEDIDO DP
 GROUP BY DP.CODIGO_PEDIDO;

-- Ejercicio 13:
SELECT sum(dp.CANTIDAD),p2.CODIGO_PEDIDO
FROM PEDIDO p2,DETALLE_PEDIDO dp
WHERE dp.CODIGO_PEDIDO =p2.CODIGO_PEDIDO
group by p2.CODIGO_PEDIDO;

-- Ejercicio 14:
select p.*
from
    (select dp.CODIGO_PRODUCTO ,sum(dp.CANTIDAD)
    from DETALLE_PEDIDO dp
    group by dp.CODIGO_PRODUCTO
    order by sum(dp.CANTIDAD) desc) p
where ROWNUM<=20;

-- Ejericico 15:
SELECT SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD),(SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))*0.21,
       (SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))+(SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))*0.21
FROM DETALLE_PEDIDO DP
GROUP BY DP.PRECIO_UNIDAD;

-- Ejercicio 16:
SELECT  SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD),(SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))*0.21,
       (SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))+(SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))*0.21,DP.CODIGO_PRODUCTO
FROM DETALLE_PEDIDO DP 
GROUP BY DP.PRECIO_UNIDAD,CODIGO_PRODUCTO;

-- Ejercicio 17:
SELECT SUM(DP.CANTIDAD)*DP.PRECIO_UNIDAD
FROM DETALLE_PEDIDO DP 
WHERE UPPER(CODIGO_PRODUCTO) LIKE 'OR%'
GROUP BY DP.PRECIO_UNIDAD,CODIGO_PRODUCTO;

--Ejercicio 18:
SELECT distinct PR.NOMBRE,SUM(DP.CANTIDAD),SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD),SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD)+(SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD))*0.21
FROM PAGO P, PRODUCTO PR, DETALLE_PEDIDO DP, PEDIDO P2, CLIENTE C
WHERE P.CODIGO_CLIENTE = C.CODIGO_CLIENTE 
AND C.CODIGO_CLIENTE = P2.CODIGO_CLIENTE
AND DP.CODIGO_PRODUCTO = PR.CODIGO_PRODUCTO 
GROUP BY PR.NOMBRE,P.TOTAL,DP.PRECIO_UNIDAD
HAVING SUM(DP.CANTIDAD*DP.PRECIO_UNIDAD) > 3000;
					  
-- CONSULTAS VARIADAS:


-- Ejercicio 1:
SELECT C.CODIGO_CLIENTE,COUNT(NVL(P.CODIGO_PEDIDO,0))
FROM CLIENTE C,PEDIDO P
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE(+)
GROUP BY C.CODIGO_CLIENTE;

-- Ejercicio 2:
SELECT C.NOMBRE_CLIENTE,sum(nvl(P.TOTAL,0))
FROM CLIENTE C,PAGO P
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE(+)
group by c.NOMBRE_CLIENTE;

-- Ejercicio 3:
SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C,PEDIDO P
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
ORDER BY C.NOMBRE_CLIENTE ASC ;

-- Ejercicio 4:
SELECT DISTINCT C.NOMBRE_CLIENTE,E.NOMBRE,E.APELLIDO1,o.TELEFONO
FROM CLIENTE C,OFICINA O,EMPLEADO E,PAGO P
WHERE C.CODIGO_EMPLEADO_REP_VENTAS=E.CODIGO_EMPLEADO
AND E.CODIGO_OFICINA=O.CODIGO_OFICINA
AND C.CODIGO_CLIENTE=P.CODIGO_CLIENTE(+)
AND P.CODIGO_CLIENTE IS NULL ;

-- Ejercicio 5:
SELECT  C.NOMBRE_CLIENTE,E.NOMBRE,E.APELLIDO1,o.CIUDAD
FROM CLIENTE C,OFICINA O,EMPLEADO E,PAGO P
WHERE C.CODIGO_EMPLEADO_REP_VENTAS=E.CODIGO_EMPLEADO
AND E.CODIGO_OFICINA=O.CODIGO_OFICINA
AND C.CODIGO_CLIENTE=P.CODIGO_CLIENTE(+)
AND P.CODIGO_CLIENTE IS NULL ;

-- Ejercicio 6:
SELECT DISTINCT E.NOMBRE,E.APELLIDO1,E.PUESTO,o.TELEFONO
FROM CLIENTE C,OFICINA O,EMPLEADO E
WHERE C.CODIGO_EMPLEADO_REP_VENTAS(+)=E.CODIGO_EMPLEADO
and o.CODIGO_OFICINA=e.CODIGO_OFICINA
AND c.CODIGO_EMPLEADO_REP_VENTAS IS NULL ;

-- Ejercicio 7:
select o.CIUDAD,count(nvl(e.CODIGO_EMPLEADO,0))
from OFICINA o,EMPLEADO e
where o.CODIGO_OFICINA=e.CODIGO_OFICINA
group by o.CIUDAD;

-- Ejercicio 8:

select o.CIUDAD,count(nvl(e.CODIGO_EMPLEADO,0))
from OFICINA o,EMPLEADO e
where o.CODIGO_OFICINA=e.CODIGO_OFICINA(+)
and e.CODIGO_OFICINA is null
group by o.CIUDAD;