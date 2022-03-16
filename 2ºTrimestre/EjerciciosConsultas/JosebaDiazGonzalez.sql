-- Ejercicio 1:

SELECT DISTINCT p.NACIONALIDAD FROM PELICULA p;

-- Ejercicio 2:

SELECT p.CIP, p2.FECHA_ESTRENO,p2.RECAUDACION
FROM PELICULA p,PROYECCION p2
WHERE p.CIP=p2.CIP 
AND p2.FECHA_ESTRENO <to_date('22/09/1997','DD/MM/YYYY')
ORDER BY p2.RECAUDACION DESC;

--Ejercicio 3:

SELECT p.CIP,p.RECAUDACION,p.ESPECTADORES 
FROM PROYECCION p
WHERE p.ESPECTADORES>3000 OR p.RECAUDACION>=2000000
ORDER BY p.ESPECTADORES DESC;

-- Ejercicio 4:

SELECT c.CINE 
FROM CINE c
WHERE lower(c.CINE) LIKE '%ar%';

-- Ejercicio 5:

SELECT s.CINE,sum(s.AFORO) AS aforo_total 
FROM SALA s
GROUP BY s.CINE
HAVING sum(s.AFORO)>600
ORDER BY sum(s.AFORO) DESC;
-- Ejercicio 6:

SELECT p.TITULO_P
FROM PELICULA p, PROYECCION p2
WHERE p.CIP=p2.CIP
AND EXTRACT(DAY FROM p2.FECHA_ESTRENO)<=15;

-- Ejercicio 7:

SELECT p.NACIONALIDAD,AVG(p.PRESUPUESTO)
FROM PELICULA p 
WHERE p.PRESUPUESTO>500
GROUP BY p.NACIONALIDAD;

-- Ejercicio 8:

SELECT p.NOMBRE_PERSONA,p.SEXO_PERSONA 
FROM PERSONAJE p
WHERE (p.NOMBRE_PERSONA LIKE '%n' 
OR  p.NOMBRE_PERSONA LIKE '%s'
OR  p.NOMBRE_PERSONA LIKE '%e')
AND p.SEXO_PERSONA IS NULL ;

-- Ejercicio 9:

SELECT p.TITULO_P 
FROM PELICULA p,PROYECCION p2
WHERE p.CIP=p2.CIP
GROUP BY p.TITULO_P
HAVING sum(p2.DIAS_ESTRENO)>50;

-- Ejercicio 10:

SELECT c.CINE,c.DIRECCION_CINE,c.CIUDAD_CINE,s.SALA,s.AFORO,p2.TITULO_P 
FROM CINE c,SALA s,PROYECCION p,PELICULA p2
WHERE c.CINE=s.CINE
AND s.SALA=p.SALA
AND p.CIP=p2.CIP
ORDER BY c.CINE,s.SALA,p2.TITULO_P;

-- Ejercicio 11:     

SELECT  t.TAREA,COUNT(t.NOMBRE_PERSONA)
FROM TRABAJO t
GROUP BY t.TAREA;

-- Ejercicio 12:

SELECT DISTINCT *  
FROM PELICULA p,PROYECCION p2 
WHERE p.CIP=p2.CIP
AND p2.FECHA_ESTRENO BETWEEN to_date('20/09/1995','DD/MM/YYYY')
AND to_date('15/12/1995','DD/MM/YYYY')
AND p2.DIAS_ESTRENO>=2;

--No he podido mostrar solo un dato, pero para ello creo que se podria hacer de la siguiente manera
GROUP BY *
HAVING count(p.TITULO_P)=1;

-- Ejercicio 13:

SELECT DISTINCT c.CINE,c.CIUDAD_CINE,count(p.FECHA_ESTRENO) 
FROM CINE c,PROYECCION p
WHERE c.CINE=p.CINE
GROUP BY c.CINE,c.CIUDAD_CINE
HAVING count(p.FECHA_ESTRENO)>=22;

-- Ejercicio 14:

SELECT p.TITULO_P,p.PRESUPUESTO 
FROM PELICULA p,CINE c,PROYECCION p2,SALA s
WHERE p.CIP=p2.CIP
AND p2.SALA=s.SALA
AND s.CINE=c.CINE
AND p.NACIONALIDAD LIKE 'EE.UU'
AND lower(c.CIUDAD_CINE) LIKE 'cordoba';

-- Ejercicio 15:

SELECT p.TITULO_P,sum(p2.RECAUDACION) AS recaudacion_total
FROM PELICULA p,PROYECCION p2
WHERE p.CIP=p2.CIP
AND p.TITULO_P LIKE '%vi%' 
OR p.TITULO_P LIKE '%7%'
GROUP BY p.TITULO_P;

-- Ejercicio 16:

SELECT min(p.PRESUPUESTO) AS presupuesto_minimo,max(p.PRESUPUESTO) AS presupuesto_maximo 
FROM PELICULA p;

-- Ejercicio 17:

/*
 * Un outer join como su propio nombre indica es un join,
 * sirve unir tablas cuyos campos de una tabla no se encuentran asignados 
 * en otras tablas, entonces tendriamos que poner el simbolo (+) en el campo el cual no esta asignado
 */


/*
 * Por ejemplo, tenemos dos tablas, una se llama empleado y otra departamento, 
 * las cuales, las podemos unir con la clave primaria 'cod_departamento'
 * y el cual, el cod_departamento 20 no esta asignado a ningun empleado, entonces haremos lo siguiente: 
 */

SELECT e.NOMBRE,d.NOMBRE_DEPART 
FROM EMPLEADO e, DEPARTAMENTO d
WHERE e.COD_DEPARTAMENTO(+)=d.COD_DEPARTAMENTO;

-- Ejercicio 18:

SELECT ADD_MONTHS(p.FECHA_ESTRENO,2) AS FECHA_ESTIMADA 
FROM PROYECCION p;


-- Ejercicio 19:

SELECT * 
FROM PELICULA p,PROYECCION p2
WHERE p2.CIP(+)=p.CIP;

-- Ejercicio 20:

SELECT count(t.NOMBRE_PERSONA),p.TITULO_P 
FROM TRABAJO t,PELICULA p
WHERE t.CIP=p.CIP
GROUP BY p.TITULO_P
ORDER BY p.TITULO_P ASC;



