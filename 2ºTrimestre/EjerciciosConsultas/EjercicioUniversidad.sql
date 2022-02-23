/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER ej1universidad identified BY ej1universidad;
GRANT CONNECT , RESOURCE, DBA TO ej1universidad;
*/


--Ejercicio 1:

SELECT nombre,creditos FROM ASIGNATURA a ;

--Ejercicio 2:

SELECT DISTINCT creditos FROM ASIGNATURA a ;

--Ejercicio 3: 

SELECT * FROM PERSONA p ;

--Ejercicio 4:

SELECT nombre,creditos FROM ASIGNATURA a  WHERE CUATRIMESTRE=1;

--Ejercicio 5:

SELECT nombre,apellido FROM PERSONA p WHERE FECHA_NACIMIENTO < to_date('01/01/1975','DD/MM/YYYY');          

--Ejercicio 6:

SELECT nombre,costebasico FROM ASIGNATURA a WHERE CREDITOS > 4.5;

--Ejercicio 7: 

SELECT nombre FROM ASIGNATURA a WHERE costebasico BETWEEN 25 AND 35;

--Ejercicio 8:

SELECT idalumno FROM ALUMNO_ASIGNATURA aa WHERE IDASIGNATURA='150212' OR IDASIGNATURA='130113'

--Ejercicio 9: 

SELECT nombre FROM ASIGNATURA a WHERE CUATRIMESTRE =2 AND NOT CREDITOS =6;

--Ejercicio 10: 

SELECT nombre,apellido FROM PERSONA p WHERE APELLIDO LIKE 'G%'; 

--Ejercicio 11:

SELECT nombre FROM ASIGNATURA a WHERE IDTITULACION IS NULL;

--Ejercicio 12:

SELECT nombre FROM ASIGNATURA a WHERE IDTITULACION IS NOT NULL;

--Ejercicio 13:

SELECT nombre FROM ASIGNATURA a WHERE COSTEBASICO >8;

--Ejercicio 14:

SELECT nombre,creditos*10 AS hora_asig FROM ASIGNATURA a;

--Ejercicio 15:

SELECT * FROM ASIGNATURA a WHERE CUATRIMESTRE =2 ORDER BY IDASIGNATURA ;

--Ejercicio 16:

SELECT nombre FROM PERSONA p WHERE CIUDAD ='Madrid' AND VARON=0;

--Ejercicio 17:

SELECT nombre,telefono FROM PERSONA p WHERE TELEFONO LIKE '91%'; 

--Ejercicio 18:

SELECT nombre FROM ASIGNATURA a WHERE NOMBRE LIKE '%Pro%';

--Ejerciico 19:

SELECT nombre FROM ASIGNATURA a WHERE CUATRIMESTRE=1 AND IDPROFESOR='P101';

--Ejercicio 20:

SELECT idalumno,idasignatura FROM ALUMNO_ASIGNATURA aa WHERE NUMEROMATRICULA >=3;









