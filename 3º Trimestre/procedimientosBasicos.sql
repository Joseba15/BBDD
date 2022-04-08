-- Ejercicio 1:

CREATE OR REPLACE PROCEDURE
PAR_IMPAR(NUM NUMBER)
AS
    BEGIN
       IF mod(NUM,2)=0 THEN
            DBMS_OUTPUT.PUT_LINE('El numero'|| NUM || ' es par');
       ELSIF mod(NUM,2)!=0 THEN
            DBMS_OUTPUT.PUT_LINE('El numero'|| NUM || ' es impar');
       END IF;
    END;
/*
BEGIN
    PAR_IMPAR(3);
END ;
 */

 -- Ejercicio 2:
CREATE OR REPLACE PROCEDURE
PAR_IMPAR(NUM_A NUMBER,NUM_B NUMBER)
AS
     BEGIN
        FOR i IN 1..NUM_B LOOP
            NUM_A:=NUM_A+i;
            END LOOP;
     END;
