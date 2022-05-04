-- Ejercicio 1:
CREATE OR REPLACE  PROCEDURE  EJER1
AS
    CURSOR CUR_EJER1 IS
        SELECT  NOMBRE,APELLIDO1,APELLIDO2,PUESTO
        FROM JARDINERIA.EMPLEADO
        ORDER BY APELLIDO1;

        BEGIN
            FOR  regi IN CUR_EJER1 LOOP
                         DBMS_OUTPUT.PUT_LINE('#############################');
                         DBMS_OUTPUT.PUT_LINE('Nombre del empleado: ' || regi.NOMBRE );
                         DBMS_OUTPUT.PUT_LINE('1 apellido del empleado: ' || regi.APELLIDO1 );
                         DBMS_OUTPUT.PUT_LINE('2 apellido del empleado: ' || regi.APELLIDO2 );
                         DBMS_OUTPUT.PUT_LINE(' puesto del empleado: ' || regi.PUESTO );
                         DBMS_OUTPUT.PUT_LINE('#############################');
                END LOOP;
        END;

    CREATE OR REPLACE  PROCEDURE  EJER1_FETCH
    AS
    CURSOR CUR_EJER1V2 IS
        SELECT  NOMBRE,APELLIDO1,APELLIDO2,PUESTO
        FROM JARDINERIA.EMPLEADO
        ORDER BY APELLIDO1;
        regi CUR_EJER1V2%ROWTYPE;

        BEGIN
            OPEN CUR_EJER1V2;
            LOOP
                         FETCH CUR_EJER1V2 INTO regi;
                         EXIT WHEN CUR_EJER1V2%NOTFOUND;
                         DBMS_OUTPUT.PUT_LINE('#############################');
                         DBMS_OUTPUT.PUT_LINE('Nombre del empleado: ' || regi.NOMBRE );
                         DBMS_OUTPUT.PUT_LINE('1 apellido del empleado: ' || regi.APELLIDO1 );
                         DBMS_OUTPUT.PUT_LINE('2 apellido del empleado: ' || regi.APELLIDO2 );
                         DBMS_OUTPUT.PUT_LINE(' puesto del empleado: ' || regi.PUESTO );
                         DBMS_OUTPUT.PUT_LINE('#############################');
                END LOOP;
                CLOSE CUR_EJER1V2;
        END;



    BEGIN
       EJER1_FETCH();
    end;


    -- Ejercicio 2:
CREATE OR REPLACE  PROCEDURE  EJER2
AS
    CURSOR CUR_EJER2 IS
        SELECT  O.CODIGO_OFICINA,COUNT(e.CODIGO_EMPLEADO) AS CANTEMP
        FROM JARDINERIA.EMPLEADO E,JARDINERIA.OFICINA O
        WHERE E.CODIGO_OFICINA=O.CODIGO_OFICINA
        GROUP BY  O.CODIGO_OFICINA;

        BEGIN
            FOR  regi IN CUR_EJER2 LOOP
                         DBMS_OUTPUT.PUT_LINE('Codigo de la oficina : ' || regi.CODIGO_OFICINA);
                         DBMS_OUTPUT.PUT_LINE('Cantidad de empleado: ' || regi.CANTEMP);
                         DBMS_OUTPUT.PUT_LINE('#############################');
                END LOOP;
        END;

        BEGIN
            EJER2();
        END;


-- Ejercicio 3:
CREATE OR REPLACE  PROCEDURE  EJER3(CADENA VARCHAR2)
AS
    CONTCLI NUMBER:=0;
    CURSOR CUR_EJER3(CADENA2 VARCHAR2) IS
        SELECT CODIGO_CLIENTE,NOMBRE_CLIENTE,CONTCLI
        FROM  JARDINERIA.CLIENTE
        WHERE UPPER(NOMBRE_CLIENTE) LIKE '%'||CADENA||'%';

        BEGIN
                 FOR  regi IN CUR_EJER3(CADENA) LOOP
                         DBMS_OUTPUT.PUT_LINE('Codigo del cliente ' || regi.CODIGO_CLIENTE);
                         DBMS_OUTPUT.PUT_LINE('Nombre del cliente: ' || regi.NOMBRE_CLIENTE);
                         DBMS_OUTPUT.PUT_LINE('#############################');
                         CONTCLI:=CONTCLI+1;
                END LOOP;
                        DBMS_OUTPUT.PUT_LINE('Cantidad de clientes:  ' || CONTCLI);
        END;

    BEGIN
        EJER3('AN');
    END;


-- Ejercicio 4

CREATE OR REPLACE  PROCEDURE  EJER4
AS
    CURSOR CUR_EJER4  IS
        SELECT CODIGO_PRODUCTO,NOMBRE,GAMA,MAX(PRECIO_VENTA)
        FROM  (CODIGO_PRODUCTO,NOMBRE,GAMA,P.DETALLE_PEDIDO,
                    FROM  DETALLE_PEDIDO DP
                    ORDER BY )
        WHERE  ROWNUM=5
        GROUP BY CODIGO_PRODUCTO,NOMBRE,GAMA ;

        BEGIN
             FOR  regi IN CUR_EJER4 LOOP
                         DBMS_OUTPUT.PUT_LINE('Codigo del producto ' || regi.CODIGO_PRODUCTO);
                         DBMS_OUTPUT.PUT_LINE('Gama del producto ' || regi.GAMA);
                         DBMS_OUTPUT.PUT_LINE('Nombre del producto ' || regi.NOMBRE);
                         DBMS_OUTPUT.PUT_LINE('#############################');
                END LOOP;
        END;

    BEGIN
        EJER4();
    END;

-- Ejercicio 6:

CREATE OR REPLACE FUNCTION EJ6(CODIGO NUMBER)
RETURN NUMBER
AS
    CANT DETALLE_PEDIDO.CANTIDAD%TYPE;
    EXC_NO_DATA EXCEPTION;
    CURSOR CUR_EJ6(CODIGO NUMBER) IS
        SELECT SUM(CANTIDAD) INTO CANT
        FROM DETALLE_PEDIDO DP
        WHERE CODIGO_PRODUCTO LIKE CODIGO;
    BEGIN
        IF  CANT IS NULL THEN
            RAISE EXC_NO_DATA;
        ELSE
            RETURN CANT;
        END IF;

        EXCEPTION
                WHEN EXC_NO_DATA THEN
                RETURN -1;
    END;

    SELECT EJ6('11679') FROM DUAL;

-- Ejercicio 7:


CREATE OR REPLACE FUNCTION EJ7(F_CODIGO VARCHAR2, F_FECHA NUMBER)
RETURN NUMBER
IS
F_CANTIDAD NUMBER:= 0;
EXC_NO_DATA_FOUND EXCEPTION;
BEGIN

	SELECT SUM(TOTAL) INTO F_CANTIDAD
	FROM PAGO
	WHERE CODIGO_CLIENTE = F_CODIGO
	AND EXTRACT(YEAR FROM FECHA_PAGO) = F_FECHA ;

	IF F_CANTIDAD IS NULL THEN
		RAISE EXC_NO_DATA_FOUND;
	ELSE
		RETURN F_CANTIDAD;
	END IF;

	EXCEPTION
		WHEN EXC_NO_DATA_FOUND THEN
		RETURN -1;
END;

SELECT EJ7('545454', 2008) FROM DUAL;

