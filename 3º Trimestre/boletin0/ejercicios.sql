-- Ejercicio 1:

BEGIN
    IF 10 > 5 THEN
        DBMS_OUTPUT.PUT_LINE ('Cierto');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Falso');
    END IF;
END;

-- Nos imprime por consola Cierto

-- Ejercicio 2:

BEGIN
    IF 10 > 5 AND 5 > 1 THEN
        DBMS_OUTPUT.PUT_LINE ('Cierto');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Falso');
    END IF;
END;
-- Nos imprime por consola Cierto

-- Ejercicio 3:

BEGIN
    IF 10 > 5 AND 5 > 50 THEN
        DBMS_OUTPUT.PUT_LINE ('Cierto');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Falso');
    END IF;
END;

-- Nos imprime por consola Falso

-- Ejercicio 4:

BEGIN
    CASE
        WHEN 10 > 5 AND 5 > 50 THEN
            DBMS_OUTPUT.PUT_LINE ('Cierto');
        ELSE
            DBMS_OUTPUT.PUT_LINE ('Falso');
    END CASE;
END;

-- Nos imprime por consola Falso

-- Ejercicio 5:
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE (i);
    END LOOP;
END;

-- Nos imprime por consola numeros del 1 al 10

-- Ejercicio 6:
BEGIN
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE (i);
    END LOOP;
END;


-- Nos imprime por consola numeros del 10 al 1:

DECLARE
    num NUMBER(3) := 0;
BEGIN
    WHILE num<=100 LOOP
        DBMS_OUTPUT.PUT_LINE (num);
        num:= num+2;
    END LOOP;
END;

-- Nos imprime por consola numeros del 0 al 100 llendo de 2 a 2:

-- Ejercicio 8:

DECLARE
    num NUMBER(3) := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (num);
        IF num > 100 THEN EXIT; END IF;
        num:= num+2;
END LOOP;
END;