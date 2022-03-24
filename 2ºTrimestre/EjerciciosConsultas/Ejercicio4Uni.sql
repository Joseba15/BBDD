-- Ejercicio 5:
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION='130110'
AND a.COSTEBASICO > (SELECT AVG(a.COSTEBASICO)
					 FROM ASIGNATURA a2
					 WHERE a2.IDTITULACION='130110');

-- Ejericicio 6:
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA !='150212'
AND aa.IDASIGNATURA !='130113';

-- Ejercicio 7:

SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa
WHERE aa.IDASIGNATURA ='150212'
AND aa.IDASIGNATURA !='130113';



-- Ejercicio 8:
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS > (SELECT a2.CREDITOS 
					FROM ASIGNATURA a2
					WHERE a2.NOMBRE LIKE 'Seguridad Vial');

-- Ejercicio 9:

SELECT DISTINCT p.NOMBRE  
FROM PERSONA p  
WHERE p.DNI NOT IN (
		SELECT p.NOMBRE 
		FROM PERSONA p2 ,ALUMNO a,PERSONA p3 
		WHERE p2.DNI =p3.DNI
		AND a.DNI =p3.DNI 
	);

-- Ejercicio 10:

SELECT a.NOMBRE  
FROM ASIGNATURA a 
WHERE a.CREDITOS =(
			SELECT max(a2.CREDITOS)
			FROM ASIGNATURA a2 
);

-- Ejercicio 11:

SELECT a.NOMBRE 
FROM ASIGNATURA a,ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA=a.IDASIGNATURA 
AND aa.NUMEROMATRICULA =0;

-- Ejercicio 12:

SELECT p.CIUDAD 
FROM PERSONA p,PROFESOR p2 ,ALUMNO a 
WHERE p.DNI =p2.DNI 
AND a.DNI =p.DNI ;
		