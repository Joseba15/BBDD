 -- Ejercicio 1:

 CREATE OR REPLACE PACKAGE  PACK_CICLISMO
IS
        PROCEDURE LISTADO;
        FUNCTION NUM_CARRERAS_GANAD (NOM_EQUIPO VARCHAR2 ) RETURN NUMBER;
        FUNCTION AGREGAR_CICLISTA (NOMBRE VARCHAR2,NACIONALIDAD VARCHAR2, FECHA_NAC DATE, COD_EQUIPOS NUMBER, NOM_EQUIPO VARCHAR2) RETURN VARCHAR2;
        FUNCTION MOSTRAR_CICLISTA RETURN NUMBER;
     END PACK_CICLISMO;


CREATE SEQUENCE SEQ_DOR
START WITH 17
INCREMENT BY 1;

CREATE OR REPLACE PACKAGE BODY PACK_CICLISMO
IS

    PROCEDURE  LISTADO
    IS
        TOTAL_CICLISTA NUMBER:=0;
        TOTAL_EQUIPO NUMBER:=0;
       CURSOR C_EQUIPO IS
            SELECT NOMBRE, NACIONALIDAD, NOMBREDIRECTOR,CODEQUIPO
            FROM EQUIPOS ;

        CURSOR C_JUGADOR IS
            SELECT NOMBRE, FECHANACIMIENTO
            FROM CICLISTAS ;

        BEGIN
                    FOR REG IN C_EQUIPO LOOP
                            DBMS_OUTPUT.PUT_LINE('Nombre : '|| REG.NOMBRE );
                            DBMS_OUTPUT.PUT_LINE('Nacionalidad : '|| REG.NACIONALIDAD );
                            DBMS_OUTPUT.PUT_LINE('Nombre director : '|| REG.NOMBREDIRECTOR || CHR(13) );

                            FOR REG2 IN C_JUGADOR  LOOP
                                    DBMS_OUTPUT.PUT_LINE('Nombre : '|| REG2.NOMBRE || ' Fecha nacimiento '|| REG2.FECHANACIMIENTO   );
                                    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------- ');
                                    TOTAL_CICLISTA:=TOTAL_CICLISTA+1;
                                END LOOP;
                            DBMS_OUTPUT.PUT_LINE('Nº Total de ciclistas en el equipos: ' || TOTAL_CICLISTA);
                           TOTAL_EQUIPO:=TOTAL_EQUIPO+1;
                        END LOOP;
                    DBMS_OUTPUT.PUT_LINE('Nº Total de equpos en el equipos: ' || TOTAL_EQUIPO);
        END;


    FUNCTION NUM_CARRERAS_GANAD (NOM_EQUIPO VARCHAR2 ) RETURN NUMBER
    IS
        NUM_CARR_GAN NUMBER :=0;
        V_EXISTE NUMBER;
        NO_EXIS_EQUIPO EXCEPTION ;
        BEGIN
                SELECT COUNT(NOMBRE) INTO V_EXISTE FROM EQUIPOS WHERE NOMBRE LIKE NOM_EQUIPO;

                IF  V_EXISTE=0 THEN
                     RAISE NO_EXIS_EQUIPO;
                END  IF ;
                RETURN NUM_CARR_GAN;
        END;

FUNCTION AGREGAR_CICLISTA (NOM VARCHAR2,NACIONA VARCHAR2, FECHA_NAC DATE, COD_EQUIPOS NUMBER, NOM_EQUIPO VARCHAR2) RETURN VARCHAR2
IS


    AGREGAR_CICL_EXC EXCEPTION;
    V_EXISTE NUMBER;
        V_EXISTE2 NUMBER ;
    BEGIN
            SELECT COUNT(NOMBRE) INTO V_EXISTE FROM EQUIPOS WHERE NOMBRE LIKE NOM_EQUIPO ;
              SELECT COUNT(NOMBRE) INTO V_EXISTE2 FROM CICLISTAS WHERE NOMBRE LIKE NOM ;
            IF V_EXISTE=0 THEN
               DBMS_OUTPUT.PUT_LINE('No existe el equipo. Procedemos a crearlo');
               INSERT INTO EQUIPOS(CODEQUIPO,NOMBRE) VALUES (22,'Caixa Team');
            END  IF;

          --  INSERT INTO CICLISTAS (SEQ_DOR.nextval, NOM, NACIONA, COD_EQUIPOS, FECHA_NAC);

            RETURN SEQ_DOR.currval;

    END;



FUNCTION MOSTRAR_CICLISTA RETURN NUMBER
    IS
        ERROR_MOSTRAR EXCEPTION ;
        NUM_FILA_UDATE NUMBER;
        CURSOR  C_EQU IS
            SELECT  E.NOMBRE,CODEQUIPO
            FROM  EQUIPOS E;


        CURSOR C_CICLISTAS IS
            SELECT B.*
            FROM ( SELECT C.NOMBRE,C.NACIONALIDAD
                        FROM CICLISTAS C, EQUIPOS E
                        WHERE C.CODEQUIPO=E.CODEQUIPO
                        ORDER BY NOMBRE ASC ) B
            WHERE ROWNUM<=2;


        BEGIN
            FOR  REG IN C_EQU LOOP
                DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------- ' );
                FOR REG2 IN C_CICLISTAS LOOP
                        UPDATE CICLISTAS SET NACIONALIDAD= 'Inglesa' ;
                        DBMS_OUTPUT.PUT_LINE('Nombre del  ciclista : ' || reg2.NOMBRE );
                        NUM_FILA_UDATE:=NUM_FILA_UDATE+1;
                    END LOOP;
                END LOOP;



            RETURN NUM_FILA_UDATE;

        END;



    END PACK_CICLISMO;











    DECLARE
        RESUL NUMBER:=0;
    BEGIN
            RESUL:=MOSTRAR_CICLISTA();
    END;
