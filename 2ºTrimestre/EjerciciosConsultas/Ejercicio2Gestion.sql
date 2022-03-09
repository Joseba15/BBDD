-- Ejercicio 1

SELECT c.nombre , p.nombre 
FROM clientes c , pueblos p 
WHERE c.codpue = p.codpue ;

-- Ejercicio 2

SELECT p.nombre ,p2.nombre 
FROM PUEBLOS p ,PROVINCIAS p2 
WHERE p.codpro = p2.codpro ;

-- Ejercicio 3

SELECT c.nombre ,p.nombre ,p2.nombre 
FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
WHERE c.codpue = p.codpue 
AND p.codpro = p2.codpro ;

-- Ejercicio 4


SELECT DISTINCT p2.nombre 
FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
WHERE c.codpue = p.codpue 
AND p.codpro = p2.codpro ;

-- Ejercicio 5


SELECT DISTINCT a.descrip 
FROM LINEAS_FAC lf , ARTICULOS a
WHERE lf.codart = a.codart 
AND lf.CANT >10;

-- Ejercicio 6


SELECT f.FECHA , lf.CODART ,lf.CANT 
FROM FACTURAS f ,LINEAS_FAC lf 
WHERE lf.codfac = f.codfac 
ORDER BY f.fecha DESC,lf.cant DESC;

-- Ejercicio 7

SELECT f.codfac , f.fecha 
FROM FACTURAS f ,CLIENTES c 
WHERE f.codcli = c.codcli 
AND c.codpostal LIKE '%7%';

-- Ejercicio 8

SELECT f.codfac  ,f.fecha ,c.NOMBRE 
FROM FACTURAS f ,CLIENTES c 
WHERE f.codcli = c.codcli ;

-- Ejercicio 9

SELECT f.codfac ,f.fecha ,f.iva ,f.dto descuento,c.nombre 
FROM FACTURAS f ,CLIENTES c 
WHERE f.codcli = c.codcli 
AND (iva IS NULL OR iva='0')
OR  dto IS NULL;

-- Ejercicioc 10 

SELECT a.descrip ,a.precio ,lf.precio 
FROM ARTICULOS a , LINEAS_FAC lf
WHERE a.codart = lf.codart 
AND a.precio > lf.precio ;

-- Ejercicio 11 

SELECT f.codfac  ,f.fecha ,f.iva ,f.dto descuento , a.descrip  ,lf.precio  , lf.cant ,lf.dto 
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac ;

-- Ejericicio 12

SELECT f.codfac  ,f.fecha ,f.iva ,f.dto  , a.descrip  ,lf.precio  , lf.cant ,lf.dto , c.nombre 
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND f.codcli = c.codcli ;

-- Ejercicio 13 

SELECT c.nombre 
FROM CLIENTES c ,PUEBLOS p ,PROVINCIAS p2 
WHERE c.codpue = p.codpue 
AND p.codpro = p2.codpro 
AND UPPER(p2.nombre) LIKE '%MA%';

-- Ejericicio 14

SELECT c.codcli 
FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE c.codcli = f.codcli 
AND f.codfac = lf.codfac 
AND lf.codart = a.codart 
AND a.stock < a.stock_min ;

-- Ejericicio 15

SELECT DISTINCT a.descrip  
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.codart = a.codart ;

-- Ejericicio 16

SELECT a.descrip descripción ,lf.precio -lf.dto  
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.codart = a.codart 
AND lf.dto IS NOT NULL;

-- Ejericico 17 

SELECT a.descrip 
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c,PUEBLOS p ,PROVINCIAS p2 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND f.codcli = c.codcli 
AND c.codpue = p.codpue 
AND p.codpro = p2.codpro 
AND LOWER(p2.nombre) LIKE '%a';

-- Ejercicio 18

SELECT DISTINCT c.nombre 
FROM CLIENTES c ,FACTURAS f 
WHERE c.codcli = f.codcli 
AND f.dto > 10;

-- Ejercicio 19

SELECT DISTINCT c.nombre 
FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf 
WHERE c.codcli = f.codcli 
AND f.codfac = lf.codfac 
AND f.dto > 10 OR lf.dto >10;

-- Ejercicio 20

SELECT a.descrip ,lf.cant ,lf.precio 
FROM ARTICULOS a ,LINEAS_FAC lf ,FACTURAS f ,CLIENTES c 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND f.codcli = c.codcli 
AND c.nombre LIKE '%MARIA MERCEDES%'