-- 1 --
SELECT c.nombre Clientes, p.nombre Pueblo
FROM clientes c , pueblos p 
WHERE c.codpue = p.codpue ;
-- 2 --
SELECT p.nombre Pueblo,p2.nombre Provincia
FROM PUEBLOS p ,PROVINCIAS p2 
WHERE p.codpro = p2.codpro ;
-- 3 --
SELECT c.nombre Clientes,p.nombre Pueblo,p2.nombre Provincia
FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
WHERE c.codpue = p.codpue 
AND p.codpro = p2.codpro ;
-- 4 --
SELECT DISTINCT p2.nombre Provincias
FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
WHERE c.codpue = p.codpue 
AND p.codpro = p2.codpro ;
-- 5 --
SELECT DISTINCT a.descrip Descripcion
FROM LINEAS_FAC lf , ARTICULOS a
WHERE lf.codart = a.codart 
AND CANT >10;
-- 6 --
SELECT f.FECHA , a.CODART Codigo,lf.CANT Cantidad
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
ORDER BY f.fecha DESC, a.codart , lf.cant DESC;
-- 7 --
SELECT f.codfac Codigo, f.fecha 
FROM FACTURAS f ,CLIENTES c 
WHERE f.codcli = c.codcli 
AND c.codpostal LIKE '%7%';
-- 8 --
SELECT f.codfac Codigo_Factura ,f.fecha ,c.NOMBRE 
FROM FACTURAS f ,CLIENTES c 
WHERE f.codcli = c.codcli ;
-- 9 --
SELECT f.codfac Codigo_Factura,f.fecha ,f.iva ,f.dto descuento,c.nombre 
FROM FACTURAS f ,CLIENTES c 
WHERE f.codcli = c.codcli 
AND (iva IS NULL OR iva LIKE '0')
OR  dto IS NULL;
-- 10 --
SELECT a.descrip descripcion,a.precio precio_actual,lf.precio precio_venta
FROM ARTICULOS a , LINEAS_FAC lf
WHERE a.codart = lf.codfac 
AND a.precio > lf.precio ;
-- 11 --
SELECT f.codfac Codigo_Factura ,f.fecha ,f.iva ,f.dto descuento , a.descrip descripción ,lf.precio precio_venta , lf.cant ,lf.dto descuento_articulo
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE a.codart = lf.codfac 
AND lf.codfac = f.codfac ;
-- 12 --
SELECT f.codfac Codigo_Factura ,f.fecha ,f.iva ,f.dto descuento , a.descrip descripción ,lf.precio precio_venta , lf.cant ,lf.dto descuento_articulo, c.nombre 
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND f.codcli = c.codcli ;
-- 13 --
SELECT c.nombre 
FROM CLIENTES c ,PUEBLOS p ,PROVINCIAS p2 
WHERE c.codpue = p.codpue 
AND p.codpro = p2.codpro 
AND UPPER(p2.nombre) LIKE '%MA%';
-- 14 --
SELECT c.codcli Codigo_Cliente
FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE c.codcli = f.codcli 
AND f.codfac = lf.codfac 
AND lf.codart = a.codart 
AND a.stock < a.stock_min ;
-- 15 --
SELECT DISTINCT a.descrip descripción 
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.codart = a.codart ;
-- 16 --
SELECT a.descrip descripción ,lf.precio -lf.dto  PRECIO_real
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.codart = a.codart 
AND lf.dto IS NOT NULL;
-- 17 --
SELECT a.descrip Nombre
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c,PUEBLOS p ,PROVINCIAS p2 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND f.codcli = c.codcli 
AND c.codpue = p.codpue 
AND p.codpro = p2.codpro 
AND UPPER(p2.nombre) LIKE '%A';
-- 18 --
SELECT DISTINCT c.nombre 
FROM CLIENTES c ,FACTURAS f 
WHERE c.codcli = f.codcli 
AND f.dto > 10;
-- 19 -- 
SELECT DISTINCT c.nombre 
FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf 
WHERE c.codcli = f.codcli 
AND f.codfac = lf.codfac 
AND f.dto > 10 OR lf.dto >10;
-- 20 --
SELECT a.descrip ,lf.cant ,lf.precio 
FROM ARTICULOS a ,LINEAS_FAC lf ,FACTURAS f ,CLIENTES c 
WHERE a.codart = lf.codart 
AND lf.codfac = f.codfac 
AND f.codcli = c.codcli 
AND c.nombre LIKE '%MARIA MERCEDES%'