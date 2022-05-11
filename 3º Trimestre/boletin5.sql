-- Ejercicio 1:

CREATE OR REPLACE PROCEDURE P_EJ1
AS
     salary NUMBER;
     CURSOR C_EJ1 IS
        SELECT sal
        FROM EMP
        WHERE COMM > 0.05*SAL;
    BEGIN
        FOR REG IN C_EJ1 LOOP
            salary:=reg.SAL*1.10;
            UPDATE emp SET sal=sal*1.10 WHERE EMPNO=REG;
               DBMS_OUTPUT.PUT_LINE('El nuevo salario es de : '|| salary);
            END LOOP;
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
CREATE OR REPLACE PROCEDURE MostrarsodaelpmE (nombreDept VARCHAR2)
AS
    CURSOR C_EJ3 IS
        SELECT E.EMPNO
        FROM EMP E,DEPT D
        WHERE E.DEPTNO=D.DEPTNO
        AND nombreDept=D.DEPTNO;