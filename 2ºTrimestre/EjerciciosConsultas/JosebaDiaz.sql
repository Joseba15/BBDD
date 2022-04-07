-- CONSULTAS:

-- Ejercicio 13:

SELECT DISTINCT e.NOMBRE_ESPECIE
FROM EJEMPLARESMARIPOSAS e
WHERE e.TAMANO BETWEEN 124 and 270;

-- Ejercicio 14:
SELECT DISTINCT G.NOMBRE_FAMILIA
FROM EJEMPLARESMARIPOSAS E,ESPECIES ES,GENEROS G
WHERE G.NOMBRE_GENERO=ES.NOMBRE_GENERO
AND ES.NOMBRE_ESPECIE=E.NOMBRE_ESPECIE
AND E.DNI_CAPTURA LIKE '12323459';

-- Ejercicio 15:

SELECT ES.NOMBRE_ESPECIE,ES.NOMBRE_CIENTIFICO,EJ.FECHA_CAPTURA
FROM EJEMPLARESMARIPOSAS EJ, ESPECIES ES,ZONLOCPRO Z
WHERE EJ.NOMBRE_ZONA=Z.NOMBRE_ZONA
AND EJ.NOMBRE_ESPECIE=ES.NOMBRE_ESPECIE
AND Z.PROVINCIA LIKE 'Huesca'
OR Z.PROVINCIA LIKE 'Zaragoza'
ORDER BY ES.NOMBRE_ESPECIE, EJ.FECHA_CAPTURA ASC;

-- Ejercicio 16:

SELECT DISTINCT G.NOMBRE_FAMILIA, COUNT(E.NOMBRE_ESPECIE)
FROM GENEROS G,ESPECIES E
WHERE E.NOMBRE_GENERO=G.NOMBRE_GENERO
AND UPPER(E.NOMBRE_ESPECIE) LIKE 'A%'
GROUP BY G.NOMBRE_FAMILIA
HAVING  COUNT(E.NOMBRE_ESPECIE)>5
ORDER BY G.NOMBRE_FAMILIA ASC;

-- Ejercicio 17:
SELECT Z.PROVINCIA,SUM(EJ.TAMANO)
FROM EJEMPLARESMARIPOSAS EJ,ZONLOCPRO Z
WHERE EJ.NOMBRE_ZONA=Z.NOMBRE_ZONA
GROUP BY Z.PROVINCIA
ORDER BY SUM(EJ.TAMANO) ASC;

-- Ejercicio 18:

SELECT DISTINCT EJ.NOMBRE_ESPECIE,EJ.SEXO,AVG(EJ.TAMANO)
FROM EJEMPLARESMARIPOSAS EJ
GROUP BY EJ.SEXO,EJ.NOMBRE_ESPECIE;

-- Ejercicio 19:

SELECT DISTINCT G.NOMBRE_FAMILIA
FROM GENEROS G,EJEMPLARESMARIPOSAS EJ,ESPECIES E
WHERE G.NOMBRE_GENERO=E.NOMBRE_GENERO
AND E.NOMBRE_ESPECIE= EJ.NOMBRE_ESPECIE
AND EJ.TIPO_EJEMPLAR LIKE 'L';

-- Ejercicio 20:

SELECT DISTINCT E.NOMBRE_ESPECIE, E.NOMBRE_CIENTIFICO
FROM ESPECIES E,EJEMPLARESMARIPOSAS EJ
WHERE E.NOMBRE_ESPECIE=EJ.NOMBRE_ESPECIE
AND EJ.FECHA_CAPTURA BETWEEN
TO_DATE('01/01/1996','DD/MM/YYYY')
AND TO_DATE('31/12/1997','DD/MM/YYYY');

-- SUBCONSULTAS:

-- Ejercicio 1:
SELECT A.NOMBRE,A.APELLIDOS
FROM AFICIONADOS A ,(SELECT EJ.DNI_CAPTURA,MAX(COUNT(EJ.NOMBRE_ESPECIE))
                     FROM EJEMPLARESMARIPOSAS EJ
                     GROUP BY EJ.DNI_CAPTURA) W
WHERE A.DNI=W.DNI_CAPTURA;


-- Ejercicio 2:
SELECT E.NOMBRE_ESPECIE
FROM ESPECIES E
WHERE E.NOMBRE_ESPECIE IN (SELECT EJ.NOMBRE_ESPECIE
                           FROM EJEMPLARESMARIPOSAS EJ
                           WHERE EJ.TIPO_EJEMPLAR LIKE 'L');

-- Ejercicio 3:
SELECT *
FROM AFICIONADOS A,(SELECT C.PRECIO_ESTIMADO,C.DNI
       FROM COLECCIONES C
       ORDER BY C.PRECIO_ESTIMADO DESC ) W
WHERE A.DNI=W.DNI
AND ROWNUM=1;

-- Ejercicio 4:

SELECT DISTINCT A.DNI
FROM AFICIONADOS A
WHERE A.DNI in (SELECT EJ.DNI_CAPTURA
               FROM EJEMPLARESMARIPOSAS EJ
               WHERE EJ.NOMBRE_ESPECIE LIKE '%Saturnia Pavonia%');

-- Ejercicio 5:

SELECT G.NOMBRE_FAMILIA,G.NOMBRE_GENERO,E.NOMBRE_ESPECIE
FROM GENEROS G,ESPECIES E
WHERE G.NOMBRE_GENERO=E.NOMBRE_GENERO
AND E.NOMBRE_ESPECIE NOT IN (SELECT EJ.NOMBRE_ESPECIE
                             FROM EJEMPLARESMARIPOSAS EJ);

-- Ejercicio 6:
SELECT DISTINCT G.NOMBRE_FAMILIA,G.NOMBRE_GENERO,E.NOMBRE_ESPECIE
FROM GENEROS G,ESPECIES E,EJEMPLARESMARIPOSAS EJ
WHERE G.NOMBRE_GENERO=E.NOMBRE_GENERO
AND E.NOMBRE_ESPECIE=EJ.NOMBRE_ESPECIE(+)
AND EJ.NOMBRE_ESPECIE IS NULL;

-- Ejercicio 7:

SELECT *
FROM AFICIONADOS A
WHERE A.DNI IN (SELECT EJ.DNI_CAPTURA
                FROM EJEMPLARESMARIPOSAS EJ )
AND A.DNI NOT IN (SELECT C.DNI
            FROM COLECCIONES C );

-- Ejercicio 8:

SELECT G.NOMBRE_FAMILIA
FROM GENEROS G
WHERE G.NOMBRE_GENERO IN (SELECT E.NOMBRE_GENERO,COUNT(E.NOMBRE_ESPECIE)
                          FROM ESPECIES E
                          WHERE UPPER(E.NOMBRE_ESPECIE) LIKE 'A%'
                          GROUP BY E.NOMBRE_GENERO
                          HAVING COUNT(E.NOMBRE_ESPECIE)>5
                          ORDER BY  E.NOMBRE_GENERO DESC);

-- Ejercicio 9:

SELECT EJ.NOMBRE_ESPECIE,MIN(EJ.TAMANO),a.NOMBRE
FROM EJEMPLARESMARIPOSAS EJ,AFICIONADOS A
WHERE EJ.DNI_CAPTURA IN (SELECT A.DNI
                         FROM AFICIONADOS A)
AND EJ.DNI_COLECCION IN (SELECT C.DNI
                         FROM COLECCIONES C)
AND EJ.DNI_CAPTURA=A.DNI
GROUP BY EJ.NOMBRE_ESPECIE,a.NOMBRE;

-- Ejercicio 10:

SELECT DISTINCT E.NOMBRE_CIENTIFICO,EJ.TAMANO
FROM ESPECIES E,EJEMPLARESMARIPOSAS EJ
WHERE E.NOMBRE_ESPECIE=EJ.NOMBRE_ESPECIE
AND EJ.TAMANO > (SELECT AVG(EJ.TAMANO)
                FROM EJEMPLARESMARIPOSAS EJ);

-- Ejercicio 11:

SELECT Z.PROVINCIA
FROM ZONLOCPRO Z
WHERE Z.NOMBRE_ZONA NOT IN (SELECT EJ.NOMBRE_ZONA
                            FROM EJEMPLARESMARIPOSAS EJ);

-- Ejercicio 12:

SELECT EJ.SEXO ,COUNT(EJ.NOMBRE_ESPECIE)
FROM EJEMPLARESMARIPOSAS EJ
WHERE EJ.NOMBRE_ESPECIE

