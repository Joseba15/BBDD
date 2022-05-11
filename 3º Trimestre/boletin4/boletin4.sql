-- Ejercicio 5.6.1:

CREATE OR REPLACE
PACKAGE aritmetica IS

      FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
END aritmetica;



CREATE OR REPLACE
PACKAGE BODY aritmetica IS

  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a+b);
  END suma;

  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a-b);
  END resta;

  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a*b);
  END multiplica;

  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a/b);
  END divide;

END aritmetica;


SELECT ARITMETICA.SUMA(4,3) FROM DUAL;
SELECT ARITMETICA.RESTA(4,3) FROM DUAL;
SELECT ARITMETICA.MULTIPLICA(4,3) FROM DUAL;
SELECT ARITMETICA.DIVIDE(4,3) FROM DUAL;





-- Ejercicio 5.6.2:
CREATE OR REPLACE
PACKAGE aritmetica IS

      FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION resto    (dividendo NUMBER, divisor NUMBER) RETURN NUMBER;
END aritmetica;


CREATE OR REPLACE
PACKAGE BODY aritmetica IS

      FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a+b);
      END suma;

      FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a-b);
      END resta;

      FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a*b);
      END multiplica;

      FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a/b);
      END divide;

        FUNCTION  resto    ( dividendo NUMBER,divisor NUMBER )  RETURN  NUMBER IS
        BEGIN
                    RETURN  MOD(dividendo,divisor);
            END;

END aritmetica;


SELECT ARITMETICA.resto(26,8) FROM DUAL;






-- Ejercicio 5.6.3:

CREATE OR REPLACE
PACKAGE aritmetica IS

      FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
      FUNCTION resto    (dividendo NUMBER, divisor NUMBER) RETURN NUMBER;
      PROCEDURE  ayuda ;
END aritmetica;



CREATE OR REPLACE
PACKAGE BODY aritmetica IS

      FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a+b);
      END suma;

      FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a-b);
      END resta;

      FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a*b);
      END multiplica;

      FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
      BEGIN
        RETURN (a/b);
      END divide;

        FUNCTION  resto    ( dividendo NUMBER,divisor NUMBER )  RETURN  NUMBER IS
        BEGIN
                    RETURN  MOD(dividendo,divisor);
            END resto;

       PROCEDURE ayuda IS
        BEGIN


             DBMS_OUTPUT.PUT_LINE(Este paquete contiene 4 funciones y 1 procedimiento:  '' || CHR(13));
             DBMS_OUTPUT.PUT_LINE(La funcion suma pasa por parámetro un numero a y un numero b,  y calcula la suma de ambos'' || CHR(13));
             DBMS_OUTPUT.PUT_LINE(La funcion resta pasa por parámetro un numero a y un numero b,  y calcula la resta de ambos'' || CHR(13));
             DBMS_OUTPUT.PUT_LINE(La funcion multiplica pasa por parámetro un numero a y un numero b,  y calcula la multiplicacion  de ambos'' || CHR(13));
             DBMS_OUTPUT.PUT_LINE(La funcion divide  pasa por parámetro un numero a y un numero b,  y calcula la division de ambos'' || CHR(13));
             DBMS_OUTPUT.PUT_LINE (El procedimiento  calcula el resto con la funcion de MOD , de las variables dividendo y divisor''|| CHR(13));

        END ayuda;

END aritmetica;

    BEGIN
        aritmetica.ayuda();
        END;

-- Ejercicio 5.6.4:

CREATE TABLE DEPARTAMENTO(
      NUM_DEPARTAMENTO NUMBER(3),
      NOMBRE VARCHAR2(30),
      PRESUPUESTO NUMBER(10),

      CONSTRAINT PK_DEP PRIMARY KEY (NUM_DEPARTAMENTO)

);

CREATE SEQUENCE  incr_codigo
    START WITH 0
    MINVALUE  0
    INCREMENT BY 1;



CREATE OR REPLACE
PACKAGE GESTION AS
    PROCEDURE CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER);
    FUNCTION NUM_DEP (V_nombre VARCHAR2) RETURN NUMBER;
    PROCEDURE MOSTRAR_DEP (numero NUMBER);
    PROCEDURE BORRAR_DEP (numero NUMBER);
    PROCEDURE MODIFICAR_DEP (numero NUMBER, presu NUMBER);
END GESTION;


CREATE OR REPLACE
PACKAGE BODY GESTION IS

    PROCEDURE  CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER) IS
            miExcepcion EXCEPTION ;
            C_NUMERO_DEPARTAMENTO NUMBER;
            BEGIN
                    SELECT COUNT(D.NUM_DEPARTAMENTO) INTO C_NUMERO_DEPARTAMENTO
                    FROM DEPARTAMENTO D
                    WHERE D.NOMBRE=nombre;

                    IF (C_NUMERO_DEPARTAMENTO=0) THEN
                                DBMS_OUTPUT.PUT_LINE('Insertado nuevo departamento');
                                RAISE miExcepcion;
                    ELSE

                    END IF;

                    INSERT INTO  DEPARTAMENTO VALUES (INCR_CODIGO.nextval,nombre, presupuesto);
            END;

      FUNCTION  NUM_DEP (v_nombre VARCHAR2)RETURN NUMBER IS
          num NUMBER;
          miExcepcion EXCEPTION;
          BEGIN

                    SELECT COUNT(NUM_DEPARTAMENTO) INTO NUM
                    FROM DEPARTAMENTO D
                    WHERE D.NOMBRE=V_NOMBRE ;
                    RETURN num;

                    IF (NUM=0) THEN
                        RAISE miExcepcion;
                    END IF;

                    EXCEPTION
                     WHEN miExcepcion

            END;

       PROCEDURE  MOSTRAR_DEP(numero NUMBER ) IS
            INFO DEPARTAMENTO%rowtype;
        BEGIN
                SELECT * INTO INFO
                FROM DEPARTAMENTO
                WHERE NUM_DEPARTAMENTO=numero;
                DBMS_OUTPUT.PUT_LINE('Nombre del departamento'|| INFO.NOMBRE);
                DBMS_OUTPUT.PUT_LINE('Presupuesto del departamento'|| INFO.PRESUPUESTO);
        END ;

      PROCEDURE  BORRAR_DEP(numero NUMBER ) IS
        BEGIN
                 DELETE FROM DEPARTAMENTO
                 WHERE NUM_DEPARTAMENTO=numero;
        END;

       PROCEDURE  MODIFICAR_DEP(numero NUMBER,presu NUMBER ) IS
        BEGIN
                UPDATE DEPARTAMENTO
                SET PRESUPUESTO = presu
                WHERE NUM_DEPARTAMENTO=numero;
        END;

        END GESTION;



    BEGIN
        GESTION.MOSTRAR_DEP(1);
    END;
