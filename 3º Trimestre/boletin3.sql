/*
ALTER SESSION SET "_oracle_script" = TRUE;
CREATE USER boletin3 IDENTIFIED BY boletin3;
GRANT CONNECT , RESOURCE , DBA TO boletin3;
*/
-- Ejercicio 1:
CREATE OR REPLACE  PROCEDURE  MOSTRAR_DEPT (NUM_DEPT NUMBER)
IS
    CURSOR C_EJ1(V_NUM_DEPT NUMBER) IS
            SELECT DNAME,  LOC
            FROM DEPT
            WHERE DEPTNO LIKE V_NUM_DEPT;

    BEGIN
            FOR REG IN C_EJ1(NUM_DEPT) LOOP
                        DBMS_OUTPUT.PUT_LINE('Nombre del departamento :' || REG.DNAME);
                        DBMS_OUTPUT.PUT_LINE('Localidad del departamento :' || REG.LOC);
                END LOOP;
    END;

BEGIN
            MOSTRAR_DEPT(20);
END;


--Ejercicio 2:

CREATE OR REPLACE FUNCTION  DEVOLVER_SAL (NOM_DEP VARCHAR2) RETURN NUMBER
IS
     SUM_SAL VARCHAR2(50);
         BEGIN
             SELECT SUM(P.SAL)
             INTO SUM_SAL
             FROM EMP P, DEPT D
             WHERE  P.DEPTNO=D.DEPTNO
             AND D.DNAME LIKE NOM_DEP;

            RETURN  SUM_SAL;
         END;

       SELECT  DEVOLVER_SAL('RESEARCH') FROM DUAL;

        /* !!!! PARA SENTENCIAS DML EN FUNCIONES ¡¡¡¡¡
        DECLARE
            V_RESUL NUMBER;
            BEGIN
                    V_RESUL:=NOMBREFUNCION();
             END;
        */


-- Ejercicio 3:


CREATE OR REPLACE PROCEDURE  MOSTRAR_ABREVIATURAS
IS
    CURSOR C_EJ3 IS
        SELECT ENAME
        FROM EMP;

        BEGIN
                FOR REG IN C_EJ3 LOOP
                                     DBMS_OUTPUT.PUT_LINE('Las 3 primeras letra de los empleados ' || SUBSTR(REG.ENAME,1,3));
                    END  LOOP;
        END;

    BEGIN
            MOSTRAR_ABREVIATURAS();
    END;

-- Ejercicio 4

CREATE OR REPLACE PROCEDURE  MOSTRAR_EMPLEADOS (NUM_DEP NUMBER)
IS
        V_EXISTE NUMBER;
        EXCEP_EJ4 EXCEPTION ;
        CURSOR  C_EJ4 (V_NUM_DEP NUMBER) IS
                SELECT E.ENAME,E.SAL,E.JOB
                FROM EMP E, DEPT D
                WHERE E.DEPTNO=D.DEPTNO
                AND D.DEPTNO LIKE NUM_DEP;

        BEGIN
                SELECT COUNT(E.EMPNO) INTO V_EXISTE FROM EMP E, DEPT D WHERE D.DEPTNO LIKE NUM_DEP;
                IF V_EXISTE =0 THEN
                        RAISE  EXCEP_EJ4;
                END IF;

                FOR REG IN C_EJ4(NUM_DEP) LOOP
                            DBMS_OUTPUT.PUT_LINE('Nombre del empleado '|| REG.ENAME );
                            DBMS_OUTPUT.PUT_LINE('Salario del empleado '|| REG.SAL );
                            DBMS_OUTPUT.PUT_LINE('Trabajo del empleado '|| REG.JOB );
                             DBMS_OUTPUT.PUT_LINE('###########################');

                    END LOOP;

                EXCEPTION
                        WHEN EXCEP_EJ4 THEN
                            DBMS_OUTPUT.PUT_LINE('El numero del emplado introducido no es correcto');
        END;

    BEGIN
            MOSTRAR_EMPLEADOS(20);
    END;


-- Ejercicio 5:

CREATE  OR REPLACE PROCEDURE MOSTRAR_JEFES (NOMBRE_DEP VARCHAR2)
IS
    V_EXISTE NUMBER;
    EXCEP_EJ5 EXCEPTION ;
    CURSOR C_EJ5 (V_NOMBRE_DEP VARCHAR2) IS
            SELECT E.ENAME
            FROM EMP E, DEPT D
            WHERE E.DEPTNO=D.DEPTNO
            AND D.DNAME LIKE NOMBRE_DEP
            AND E.EMPNO IN (SELECT MGR
                                            FROM EMP
                                            WHERE  MGR IS NOT NULL);

        BEGIN

             SELECT COUNT(D.DEPTNO) INTO V_EXISTE FROM  DEPT D WHERE D.DNAME LIKE NOMBRE_DEP;
                IF V_EXISTE =0 THEN
                        RAISE  EXCEP_EJ5;
                END IF;
             FOR REG IN C_EJ5(NOMBRE_DEP) LOOP
                        DBMS_OUTPUT.PUT_LINE('Nombre del empleado ' ||REG.ENAME);
                 END LOOP;
                EXCEPTION
                        WHEN EXCEP_EJ5 THEN
                            DBMS_OUTPUT.PUT_LINE('El nombre del departamento introducido no es correcto');
        END;

      BEGIN
            MOSTRAR_JEFES('ACCOUNTING');
    END;