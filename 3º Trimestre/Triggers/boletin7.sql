/*
ALTER SESSION SET "_oracle_script" = TRUE;
CREATE USER boletin7 IDENTIFIED BY boletin7;
GRANT CONNECT , RESOURCE , DBA TO boletin7;
*/

CREATE TABLE AUDITORIA_EMPLEADOS (descripcion VARCHAR2(200));

-- Ejercicio 1:

CREATE OR REPLACE
TRIGGER EJ1
    AFTER INSERT OR DELETE ON EMPLEADOS
    FOR EACH ROW

    BEGIN
        IF INSERTING  THEN
                        INSERT INTO AUDITORIA_EMPLEADOS VALUES ('Fecha del suceso: ' ||   TO_CHAR(sysdate) || ' , numero del empleado: ' ||  TO_CHAR(:NEW.NUMEM)  || ' , nombre del empleado:  ' ||  :NEW.NOMEM  ||  ' , y el tipo de operacion es INSERCION ' );
        ELSIF DELETING  THEN
                        INSERT INTO AUDITORIA_EMPLEADOS VALUES ('Fecha del suceso: ' ||   TO_CHAR(sysdate) || ' , numero del empleado: ' ||   TO_CHAR(:OLD.NUMEM)  || ' , nombre del empleado:  ' ||   :OLD.NOMEM ||  ' , y el tipo de operacion es ELIMINACION ' );
        END  IF;
    END;


INSERT INTO BOLETIN7.EMPLEADOS(NUMEM, NOMEM, NUMHI) VALUES (343,'Pepa', 4);
SELECT * FROM AUDITORIA_EMPLEADOS;



-- Ejercicio 2:


CREATE OR REPLACE
TRIGGER EJ2
    AFTER UPDATE ON BOLETIN7.EMPLEADOS
    FOR EACH ROW

    BEGIN
              INSERT INTO AUDITORIA_EMPLEADOS VALUES ('Fecha del suceso: ' ||   TO_CHAR(sysdate) || ' , numero del empleado antiguo : ' ||   TO_CHAR(:OLD.NUMEM)  || ' , numero del empleado nuevo:  ' ||   TO_CHAR(:NEW.NUMEM) ||  ' , y el tipo de operacion es MODIFICACION ' );
    END;


UPDATE BOLETIN7.EMPLEADOS SET NUMEM=014 WHERE  NUMEM=110;

SELECT * FROM AUDITORIA_EMPLEADOS WHERE descripcion LIKE '%MODIFICACION%';


-- Ejercicio 3:

CREATE OR REPLACE
TRIGGER EJ3
    AFTER UPDATE ON BOLETIN7.EMPLEADOS
    FOR EACH ROW

    BEGIN
        IF  :NEW.SALAR>(:OLD.SALAR*1.05) THEN
                INSERT INTO AUDITORIA_EMPLEADOS VALUES ('Salario del empleado antiguo : ' ||   TO_CHAR(:OLD.SALAR)  || ' , salario del empleado nuevo:  ' ||   TO_CHAR(:NEW.SALAR) );
        END IF;
    END;

UPDATE BOLETIN7.EMPLEADOS SET SALAR=800 WHERE  NUMEM=550;

SELECT  * FROM AUDITORIA_EMPLEADOS WHERE descripcion LIKE '%salario%';

