/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER banco2 identified BY banco2;
GRANT CONNECT , RESOURCE, DBA TO banco2;
*/







-- Ejercicio 9:
select avg(c.SALDO)
from CUENTA c,MOVIMIENTO m,TIPO_MOVIMIENTO tm,CLIENTE cl
where c.COD_CUENTA=m.COD_CUENTA
and m.COD_TIPO_MOVIMIENTO=tm.COD_TIPO_MOVIMIENTO
and lower(tm.DESCRIPCION) like 'Retirada por cajero% '












