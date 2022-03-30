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
select count(a.CODART)
from ARTICULOS a,FACTURAS f,LINEAS_FAC lf
where a.STOCK>20
and a.PRECIO>15
and a.CODART=lf.CODART
and lf.CODFAC=f.CODFAC
and extract(year from f.FECHA)= extract(year from sysdate -1)
and extract(month from f.FECHA) between 10 and 12;

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
and extract(year from f.FECHA)=-1
and f.IVA =0
or f.IVA is null;

-- Ejercicio 8:
/*
select c.CODCLI,c.NOMBRE
from CLIENTES c,FACTURAS f
*/

-- Ejercicio 9:
select a.CODART,a.DESCRIP,a.PRECIO
from ARTICULOS a
where a.CODART  in (select max(a2.PRECIO)
                  from ARTICULOS a2);