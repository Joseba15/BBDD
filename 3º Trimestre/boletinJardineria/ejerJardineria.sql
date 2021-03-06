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



-- EJEMPLO CURSOR DENTRO DE OTRO:

CREATE OR REPLACE  PROCEDURE  MOSTRAR_PEDIDOS
AS
        CURSOR C_PRIMERO IS
        SELECT CODIGO_PEDIDO,FECHA_PEDIDO
        FROM  JARDINERIA.PEDIDO;

        CURSOR  C_SEGUNDO(CODIGO_P NUMBER) IS
        SELECT DP.CODIGO_PEDIDO,DP.CANTIDAD,DP.PRECIO_UNIDAD,DP.NUMERO_LINEA
        FROM JARDINERIA.DETALLE_PEDIDO DP
        WHERE CODIGO_P=CODIGO_PEDIDO;

        BEGIN
                FOR EM IN C_PRIMERO LOOP
                    DBMS_OUTPUT.PUT_LINE('Codigo del pedido: '|| em.CODIGO_PEDIDO);
                    DBMS_OUTPUT.PUT_LINE('Fecha del pedido: '|| em.FECHA_PEDIDO);
                    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------: ');

                    FOR EM2 IN C_SEGUNDO(EM.CODIGO_PEDIDO) LOOP
                                    DBMS_OUTPUT.PUT_LINE('              CODIGO del pedido: '|| em2.CODIGO_PEDIDO);
                                    DBMS_OUTPUT.PUT_LINE('              Cantidad del pedido: '|| em2.CANTIDAD);
                                    DBMS_OUTPUT.PUT_LINE('              Precio por unidad: '|| em2.PRECIO_UNIDAD);
                                    DBMS_OUTPUT.PUT_LINE('              Numero de linea: '|| em2.NUMERO_LINEA);
                                    DBMS_OUTPUT.PUT_LINE('              ############################### '|| CHR(12));
                    END LOOP;
                END LOOP;

        END ;

BEGIN
        MOSTRAR_PEDIDOS();
END ;

-- Ejercicio 10:


CREATE OR REPLACE  PROCEDURE  EJ10
AS
        CURSOR C_EMP IS
        SELECT E.CODIGO_EMPLEADO,E.NOMBRE,E.APELLIDO1,E.APELLIDO2,E.PUESTO,O.CODIGO_OFICINA,O.CIUDAD,COUNT( DISTINCT C.CODIGO_CLIENTE) AS TOTAL_CLI
        FROM JARDINERIA.EMPLEADO E , JARDINERIA.OFICINA O,JARDINERIA.CLIENTE C
        WHERE E.CODIGO_OFICINA=O.CODIGO_OFICINA
        AND C.CODIGO_EMPLEADO_REP_VENTAS=E.CODIGO_EMPLEADO
        GROUP BY E.NOMBRE,E.APELLIDO1,E.APELLIDO2,E.PUESTO,O.CODIGO_OFICINA,O.CIUDAD,E.CODIGO_EMPLEADO ;

        CURSOR C_CLI(COD_EMP NUMBER) IS
        SELECT C.CODIGO_CLIENTE,C.NOMBRE_CLIENTE,COUNT(PE.CODIGO_PEDIDO) AS pedido,SUM(PA.TOTAL) as pago
        FROM  JARDINERIA.CLIENTE C, JARDINERIA.PAGO PA ,JARDINERIA.PEDIDO PE
        WHERE  COD_EMP=C.CODIGO_EMPLEADO_REP_VENTAS
        AND  C.CODIGO_CLIENTE=PA.CODIGO_CLIENTE(+)
        AND C.CODIGO_CLIENTE=PE.CODIGO_CLIENTE(+)
        GROUP BY C.CODIGO_CLIENTE,C.NOMBRE_CLIENTE;

        BEGIN
                FOR EM IN C_EMP LOOP
                    DBMS_OUTPUT.PUT_LINE('************************************************************'|| CHR(13));
                    DBMS_OUTPUT.PUT_LINE('Nombre del empleado: '|| em.NOMBRE  || '  ' || em.APELLIDO1 || '  ' || em.APELLIDO2 || ' Oficina: '|| em.CODIGO_OFICINA ||  '  ' ||  em.CIUDAD || ' Puesto:   '||  em.PUESTO || CHR(13) || ' N?? Total de clientes :'  || em.TOTAL_CLI) ;
                    FOR EM2 IN C_CLI(EM.CODIGO_EMPLEADO) LOOP
                                DBMS_OUTPUT.PUT_LINE('                   -------- Cliente ' || em2.NOMBRE_CLIENTE  || '  ' || em2.CODIGO_CLIENTE || ' Total pagos:  '|| em2.pago || ' Total pedido:   '||  em2.pedido|| CHR(13)) ;
                        END LOOP;
                    END LOOP;

        END;

BEGIN
        EJ10();
END ;
