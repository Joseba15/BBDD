-- Ejercicio 1

SELECT avg(dto) 
FROM facturas;

-- Ejercicio 2

SELECT avg(dto) 
FROM facturas
WHERE dto IS NOT NULL;

-- Ejericicio 3 

SELECT avg(nvl(dto,0))
FROM facturas;

-- Ejercicio 4 

SELECT count(codfac) 
FROM facturas;

-- Ejercicio 5 

SELECT count(codpue) 
FROM pueblos p,provincias pr
WHERE p.codpro = pr.codpro 
AND pr.nombre LIKE 'V%';

-- Ejercicio 6 

SELECT sum(precio*stock) 
FROM articulos;

-- Ejercicio 7 

SELECT count(p.nombre)  
FROM pueblos p,clientes c
WHERE p.codpue = c.codpue 
AND c.codpostal LIKE '12%';

-- Ejercicio 8 

SELECT max(stock), min(stock) 
FROM articulos
WHERE precio > 9 AND precio < 12;

-- Ejercicio 9

SELECT avg(precio)
FROM articulos
WHERE stock > 10;

-- Ejercicio 10 

SELECT max(fecha) , min(fecha) 
FROM facturas f,clientes c
WHERE f.codcli = c.codcli 
AND c.codcli = 210;

-- Ejercicio 11 

SELECT count(codart) 
FROM articulos
WHERE stock IS NULL;

-- Ejercicio 12 

SELECT count(linea)
FROM lineas_fac
WHERE dto IS NULL;

-- Ejercicio 13 

SELECT count(f.codfac),c.nombre
FROM facturas f,clientes c
WHERE f.codcli = c.codcli 
GROUP BY c.nombre;

-- Ejercicio 14

SELECT count(f.codfac),c.nombre
FROM facturas f,clientes c
WHERE f.codcli = c.codcli 
GROUP BY c.nombre
HAVING count(f.codfac)>=2;

-- Ejercicio 15 

SELECT cant*linea , codart
FROM lineas_fac;

-- Ejercicio 16 

SELECT cant*linea, codart
FROM lineas_fac
WHERE upper(codart) LIKE '%A%';

-- Ejercicio 17 

SELECT count(codfac) , fecha
FROM facturas
GROUP BY fecha;

-- Ejercicio 18 

SELECT count(c.codcli),p.nombre
FROM clientes c,pueblos p
WHERE c.codpue = p.codpue 
GROUP BY p.nombre
ORDER BY count(c.nombre) desc;

-- Ejercicio 19 

SELECT count(c.codcli),p.nombre
FROM clientes c,pueblos p
WHERE c.codpue = p.codpue 
GROUP BY p.nombre
HAVING count(c.codcli) > 2
ORDER BY count(c.nombre) desc;



-- Ejercicio 22 

SELECT a.descrip
FROM lineas_fac lf,articulos a
WHERE a.codart = lf.codart 
AND a.precio*cant > 10000;

-- Ejericico 23

SELECT count(codfac),codfac
FROM facturas f,clientes c
WHERE f.codcli = c.codcli 
AND c.codcli BETWEEN 150 AND 300
GROUP BY codfac;

-- Ejericicio 24 
SELECT avg(cant*linea)
FROM lineas_fac;