/*
ALTER SESSION SET "_oracle_script" = TRUE;
CREATE USER examPasadoPLSQL IDENTIFIED BY examPasadoPLSQL;
GRANT CONNECT , RESOURCE , DBA TO examPasadoPLSQL;
 */

CREATE OR REPLACE PACKAGE JOSEBAGestionCarreras
IS
    FUNCTION ListadiCaballo RETURN NUMBER;
    PROCEDURE AgregarCaballo(nombre VARCHAR2,peso VARCHAR2, fecha_nacimiento DATE,nacionalidad VARCHAR2, dni VARCHAR2,nombre_dueno VARCHAR2 );
    END JOSEBAGestionCarreras;



CREATE OR REPLACE PACKAGE BODY JOSEBAGESTIONCARRERAS
    IS
        FUNCTION ListadoCaballo RETURN NUMBER
        IS
            CONT_CABALLOS_CONTADOS NUMBER:=0;
            NUM_CARRERAS_GANADAS NUMBER:=0;
            TOTAL_IMPORTE NUMBER:=0;

            CURSOR C_1Listado IS
                SELECT NOMBRE,PESO,PROPIETARIO,CODCABALLO
                FROM CABALLOS
                ORDER BY NACIONALIDAD DESC,PROPIETARIO DESC;

            CURSOR C_2Listado IS
                SELECT C.NOMBRECARRERA,PE.NOMBRE AS NOMBRE_JOCKEY,C.FECHAHORA,PA.POSICIONFINAL,A.IMPORTE
                FROM CARRERAS C,PERSONAS PE, PARTICIPACIONES PA,APUESTAS A
                WHERE C.CODCARRERA=A.CODCARRERA
                AND C.CODCARRERA=PA.CODCARRERA
                AND PE.CODIGO=PA.JOCKEY
                ORDER BY C.NOMBRECARRERA DESC,C.FECHAHORA DESC ;

            BEGIN
                   FOR EM IN C_1Listado LOOP
            DBMS_OUTPUT.PUT_LINE('Caballo : '|| em.NOMBRE);
            DBMS_OUTPUT.PUT_LINE('Peso : '|| em.PESO);
            DBMS_OUTPUT.PUT_LINE('Nombre del dueño : '|| em.PROPIETARIO);
            DBMS_OUTPUT.PUT_LINE(''||CHR(13));

            FOR EM2 IN C_2Listado(EM.CODCABALLO) LOOP
                            DBMS_OUTPUT.PUT_LINE('Nombre de carrera: '|| em2.NOMBRECARRERA);
                            DBMS_OUTPUT.PUT_LINE('Nombre del joskey: '|| em2.NOMBRE_JOCKEY);
                            DBMS_OUTPUT.PUT_LINE('Fecha: '|| em2.FECHAHORA);
                            DBMS_OUTPUT.PUT_LINE('Posicion Final  : '|| em2.POSICIONFINAL);
                            DBMS_OUTPUT.PUT_LINE('Importe Premio  : '|| em2.IMPORTE);
                            DBMS_OUTPUT.PUT_LINE('');
                            IF (EM2.POSICIONFINAL=1) THEN
                                TOTAL_IMPORTE:=TOTAL_IMPORTE+EM2.IMPORTE;
                                NUM_CARRERAS_GANADAS:=NUM_CARRERAS_GANADAS+1;
                            END IF;
                    END LOOP;
                            DBMS_OUTPUT.PUT_LINE('Numero de carreras ganadas: '||NUM_CARRERAS_GANADAS );
                            DBMS_OUTPUT.PUT_LINE('Total del importe de todos sus premios: '|| TOTAL_IMPORTE);
                            DBMS_OUTPUT.PUT_LINE('######################################################');
                            CONT_CABALLOS_CONTADOS:=CONT_CABALLOS_CONTADOS+1;
                            NUM_CARRERAS_GANADAS:=0;
                            TOTAL_IMPORTE:=0;
                END LOOP;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        DBMS_OUTPUT.PUT_LINE('No existen caballos');
                    WHEN OTHERS THEN
                        DBMS_OUTPUT.PUT_LINE('Error Inesperado');


                RETURN CONT_CABALLOS_CONTADOS;
            END;


        PROCEDURE AgregarCaballos(nombre VARCHAR2,peso VARCHAR2, fecha_nacimiento DATE,nacionalidad VARCHAR2, dni VARCHAR2,nombre_dueno VARCHAR2) IS
           CURSOR C_1Agregar IS
                SELECT NOMBRE,DNI
                FROM PERSONAS;

           BEGIN


           END ;





    END;