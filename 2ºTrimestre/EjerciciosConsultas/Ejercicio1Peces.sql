--Ejercicio 1:

select a.NOMBRE,a.APELLIDOS,a.TELF
from AFILIADOS a
where a.SEXO like 'H'
and a.NACIMIENTO < to_date('01/01/1970','DD/MM/YYYY');

-- Ejercicio 2:
select ce.PESO,ce.TALLA,ce.PEZ
from CAPTURASEVENTOS ce
where ce.TALLA<=45
union
select cs.PESO,cs.TALLA,cs.PEZ
from CAPTURASSOLOS cs
where cs.TALLA<=45
order by PEZ,PESO desc, TALLA desc;

-- Ejercicio 3:
select distinct a.NOMBRE,a.APELLIDOS
from AFILIADOS a,PERMISOS p
where a.FICHA=p.FICHA
and (upper(p.LICENCIA) like 'A%'
or (a.TELF like '9%' and a.DIRECCION like 'Avda%'));

--Ejercicio 4:
select l.LUGAR
from LUGARES l,CAUCES c
where c.CAUCE=l.CAUCE
and c.CAUCE like 'Rio Genil'
and l.OBSERVACIONES is null;

-- Ejercicio 5:
select distinct a.NOMBRE,a.APELLIDOS,cs.AVAL1
from AFILIADOS a,CAPTURASSOLOS cs
where a.FICHA=cs.FICHA;

SELECT DISTINCT a.NOMBRE,a.APELLIDOS,cs.AVAL1
FROM AFILIADOS a JOIN CAPTURASSOLOS cs
ON a.FICHA=cs.FICHA;


--Ejercicio 6:
select distinct l.CAUCE,l.LUGAR,l.COMUNIDAD
from LUGARES l,CAPTURASSOLOS cs
where l.LUGAR=cs.LUGAR
and cs.PEZ like 'Tenca';

select distinct l.CAUCE,l.LUGAR,l.COMUNIDAD
from LUGARES l JOIN CAPTURASSOLOS cs
ON l.LUGAR=cs.LUGAR
WHERE cs.PEZ like 'Tenca';


-- Ejercicio 7:
select a.NOMBRE,a.APELLIDOS
from AFILIADOS a,PARTICIPACIONES p,EVENTOS e
where p.FICHA=a.FICHA
and e.EVENTO=p.EVENTO
and p.TROFEO is not null
order by e.FECHA_EVENTO asc;
/*
select a.NOMBRE,a.APELLIDOS
from AFILIADOS a JOIN PARTICIPACIONES ON p.FICHA=a.FICHA
P   JOIN EVENTOS e

ON e.EVENTO=p.EVENTO
WHERE p.TROFEO is not null
order by e.FECHA_EVENTO asc;
*/
-- Ejercicio 8:
select a.NOMBRE,a.APELLIDOS,p.POSICION,p.TROFEO
from AFILIADOS a,PARTICIPACIONES p
where p.FICHA=a.FICHA
and p.EVENTO like 'Super Barbo';

select a.NOMBRE,a.APELLIDOS,p.POSICION,p.TROFEO
from AFILIADOS a,PARTICIPACIONES p
where p.FICHA=a.FICHA
and p.EVENTO like 'Super Barbo';

-- Ejercicio 9:
select distinct a.NOMBRE,a.APELLIDOS,a2.NOMBRE,a2.APELLIDOS
from AFILIADOS a,AFILIADOS a2,CAPTURASSOLOS cs
where a2.FICHA=cs.AVAL2
and a.FICHA=cs.FICHA;

-- Ejercicio 10:
select e.EVENTO
from EVENTOS e,PARTICIPACIONES p,AFILIADOS a
where e.EVENTO=p.EVENTO
and p.FICHA=a.FICHA
and a.FICHA=3796
and extract(year from e.FECHA_EVENTO)=1995
and p.TROFEO is null
order by e.FECHA_EVENTO desc ;

select p.EVENTO
from PARTICIPACIONES p
where p.FICHA=3796
and extract(year from p.FECHA_EVENTO)=1995
and p.TROFEO is null
order by p.FECHA_EVENTO desc ;






