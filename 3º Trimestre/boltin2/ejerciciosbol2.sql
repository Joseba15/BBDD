/*
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER boletin1PLSQL identified BY boletin1PLSQL;
GRANT CONNECT , RESOURCE, DBA TO boletin1PLSQL;
*/

-- Ejercicio 2:

CREATE OR REPLACE PROCEDURE EJ2
AS
    --SALAR_NUEVO NUMBER:=E.SALAR*0.10+E.SALAR;
    CURSOR CUR_EJ2 IS
        SELECT E.NUMEM, E.NOMEM, E.SALAR, E.SALAR +(E.SALAR+0.10) AS SALAR_NUEVO
        FROM EMPLEADOS E
        WHERE E.NUMHI > 2
          AND E.SALAR < 2000;
BEGIN
    FOR EM IN CUR_EJ2
        LOOP
            DBMS_OUTPUT.PUT_LINE('Numero de empleado: ' || EM.NUMEM);
            DBMS_OUTPUT.PUT_LINE('Numero de empleado: ' || EM.NOMEM);
            DBMS_OUTPUT.PUT_LINE('Salario : ' || EM.SALAR);
            DBMS_OUTPUT.PUT_LINE('Salario Nuevo : ' || EM.SALAR_NUEVO);
            UPDATE EMPLEADOS
            SET SALAR=SALAR_nuevo
            WHERE NUMEM = EM.NUMEM;

        END LOOP;
        COMMIT ;
        EXCEPTION
        	WHEN NO_DATA_FOUND THEN
	            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
	            ROLLBACK;
	        WHEN VALUE_ERROR THEN
	            DBMS_OUTPUT.PUT_LINE('Hay un error aritmético, de conversión, de redondeo o de tamaño en una operación');
	            ROLLBACK;
	        WHEN INVALID_NUMBER THEN
	            DBMS_OUTPUT.PUT_LINE('Falla la conversión de carácter a número');
	            ROLLBACK;
	        WHEN OTHERS THEN
	            ROLLBACK;
	            DBMS_OUTPUT.PUT_LINE('Se volvio a la situacion inicial');

END;



begin
    EJ2;
end;




-- Ejercicio 3:

CREATE OR REPLACE PROCEDURE EJ3 (NUMDEPAR NUMBER, NUMHIJOS NUMBER)
AS
CONT NUMBER;
CURSOR CUR_EJ2(NUMDEPAR NUMBER, NUMHIJOS NUMBER) IS
        SELECT *
        FROM EMPLEADOS E
        WHERE NUMHI=NUMHIJOS AND NUMDE=NUMDEPAR;

        BEGIN
            FOR EM IN CUR_EJ2 LOOP
                    DBMS_OUTPUT.PUT_LINE('Numero de empleado: ' || EM.NUMEM);
                    DBMS_OUTPUT.PUT_LINE('Numero de empleado: ' || EM.NOMEM);
                    DBMS_OUTPUT.PUT_LINE('Salario : ' || EM.SALAR);
                    DBMS_OUTPUT.PUT_LINE('Salario : ' || EM.NUMHI);
                    DBMS_OUTPUT.PUT_LINE('Numero de empleados: ' || CONT );

                    CONT:=CONT+1;
                END LOOP;
            EXCEPTION
        	    WHEN OTHERS THEN
	                DBMS_OUTPUT.PUT_LINE('Se ha procucido un error ');
        END;
