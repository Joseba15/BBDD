-- Ejercicio 1:

select count(c.CODCLI)
from CLIENTES c,FACTURAS f
where c.CODCLI=f.CODCLI
and f.IVA=16;

-- Ejercicio 2:
select count(c.CODCLI)
from CLIENTES c,FACTURAS f
where c.CODCLI=f.CODCLI
and f.IVA!=16;

-- Ejericicio 3:

select count(f.CODCLI),f.IVA,f.CODCLI
from FACTURAS f
where f.CODCLI not in (select f2.CODCLI
                       from FACTURAS f2
                        where f.IVA!=16)
and iva is not null
group by f.IVA,f.CODCLI;

-- Ejercicio 4:

select *
from (select f2.FECHA from FACTURAS f2)
from FACTURAS f,LINEAS_FAC lf
where f.CODFAC=lf.CODFAC;
group by f.fecha;

-- Ejercicio 5:
select distinct count(p.CODPUE)
from PUEBLOS p,CLIENTES c
where p.CODPUE=c.CODPUE(+)
and c.CODPUE is null ;

-- Ejercicio 6:
SELECT count(a.CODART)
FROM LINEAS_FAC lf ,ARTICULOS a
WHERE lf.CODART =a.CODART
AND a.STOCK >20 AND lf.PRECIO >15
AND CODFAC NOT IN (SELECT CODFAC
					FROM FACTURAS f
					WHERE EXTRACT(MONTH FROM fecha) BETWEEN 10 AND 12
					AND EXTRACT(YEAR FROM fecha)=EXTRACT(YEAR FROM sysdate)-1);

-- Ejercicio 7:
/*
select count(c.CODCLI)
from CLIENTES c,FACTURAS f
where f.CODCLI=c.CODCLI
and extract(year from f.FECHA)=extract(year from f.FECHA)-1
and f.IVA =0
or f.IVA is null;
*/
select count(c.CODCLI)
from CLIENTES c,FACTURAS f
where f.CODCLI=c.CODCLI
and extract(year from f.FECHA)=extract(year from sysdate -1)
and (f.IVA !=0
or f.IVA is not null);

-- Ejercicio 8:
SELECT c.CODCLI , c.NOMBRE
FROM CLIENTES c , FACTURAS f
WHERE c.CODCLI = f.CODCLI
AND EXTRACT (YEAR FROM f.FECHA) = EXTRACT (YEAR FROM SYSDATE)-1
AND EXTRACT (MONTH FROM f.FECHA) IN (11, 12)
AND f.CODFAC IN (SELECT lf.CODFAC
				FROM LINEAS_FAC lf
				WHERE lf.CANT * lf.PRECIO >60.5 );

-- Ejercicio 9:
select *
from (select a.CODART,a.DESCRIP,a.PRECIO
from ARTICULOS a
order by a.PRECIO desc)
where ROWNUM<11;

-- Ejercicio 10:
select p.NOMBRE
from (select p2.NOMBRE,count(c.CODCLI)
                  from CLIENTES c,PROVINCIAS p2,PUEBLOS pu2
                  where p2.CODPRO=pu2.CODPRO
                  and pu2.CODPUE=c.CODPUE
                  group by p2.NOMBRE
                  order by count(c.CODCLI) desc) p
where ROWNUM=1;



-- Ejercicio 11:
SELECT ARTICULOS.codart, ARTICULOS.descrip
FROM ARTICULOS, LINEAS_FAC, FACTURAS
WHERE ARTICULOS.codart = LINEAS_FAC.codart AND LINEAS_FAC.CODFAC = FACTURAS.CODFAC
AND ARTICULOS.PRECIO > 90.15
AND extract(YEAR FROM FECHA) = (extract(YEAR FROM sysdate)-1)
AND ARTICULOS.codart IN(SELECT codart
						  FROM LINEAS_FAC
						  GROUP BY codart
						  HAVING SUM(nvl(CANT,0)) < 10);

-- Ejercicio 12:
select a.CODART,a.DESCRIP
from ARTICULOS a ,LINEAS_FAC ln,FACTURAS f
where a.CODART=ln.CODART
and ln.CODFAC=f.CODFAC
and ln.PRECIO > (select  min(a2.PRECIO) *3000
                from ARTICULOS a2) ;

-- Ejercicio 13:
SELECT B.NOMBRE
FROM (SELECT c.NOMBRE, MAX(fc.PRECIO*fc.CANT)
FROM CLIENTES c, FACTURAS f, LINEAS_FAC fc
WHERE c.CODCLI = f.CODCLI
AND f.CODFAC = fc.CODFAC
GROUP BY c.NOMBRE
ORDER BY MAX(fc.PRECIO*fc.CANT) DESC) B
WHERE ROWNUM =1;



