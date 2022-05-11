-- Ejercicio 1:

CREATE OR REPLACE PROCEDURE P_EJ1
AS
     salary NUMBER;
     CURSOR C_EJ1 IS
        SELECT sal
        FROM EMP
        WHERE COMM > (0.05*SAL);
    BEGIN
        FOR REG IN C_EJ1 LOOP
            salary:=(reg.SAL*1.10);
            UPDATE emp SET sal=salary WHERE EMPNO=REG.;
               DBMS_OUTPUT.PUT_LINE('El nuevo salario es de : '|| salary);
            END LOOP;

    EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE( 'No se encontraron datos ');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE( 'Error inesperado ');

    END;


BEGIN
   P_EJ1();
END;

-- Ejercicio 2:
CREATE OR REPLACE PROCEDURE MostrarMejoresVendedores
AS
    --NOMBRE_VENDEDOR VARCHAR2(50);
    CURSOR C_EJ2 IS
        SELECT *
        FROM (SELECT ENAME
        FROM EMP
        WHERE COMM IS NOT NULL
        ORDER BY COMM DESC) B
        WHERE ROWNUM<=2;
        --AND NOMBRE_VENDEDOR=ENAME;

        BEGIN
            FOR REG IN C_EJ2 LOOP
                DBMS_OUTPUT.PUT_LINE('Los vendedores son '|| REG.ENAME );
                END LOOP;
        END;

BEGIN
    MostrarMejoresVendedores();
END;


-- Ejercicio 3:
CREATE OR REPLACE PROCEDURE BOLETIN_5.NOMBRE_ALREVES(nombre VARCHAR2)
AS
i NUMBER ;
palabra VARCHAR2(20);

CURSOR C_EJERCICIO3 (nombre VARCHAR2)IS
	SELECT ENAME
	FROM EMP e , DEPT d
	WHERE d.DEPTNO = e.DEPTNO
	AND d.DNAME =palabra;

BEGIN

	FOR i IN  REVERSE 1..LENGTH(nombre) LOOP
		palabra := palabra|| SUBSTR(nombre,i,1);
	END LOOP;

	FOR registro IN C_EJERCICIO3 (palabra) LOOP
		DBMS_OUTPUT.PUT_LINE('El nombre de los empleados es : '|| registro.ENAME);
	END LOOP;

END;

    BEGIN
	MEJORES_VENDEDORES;
END;