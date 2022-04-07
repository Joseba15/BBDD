CREATE OR REPLACE
PROCEDURE TAMHOTEL (cod Hotel.ID%TYPE)
AS
  NumHabitaciones  Hotel.Nhabs%TYPE;
  Comentario       VARCHAR2(40);
BEGIN
  -- Número de habitaciones del Hotel cuyo ID es cod
  SELECT Nhabs INTO NumHabitaciones
  FROM Hotel WHERE ID=cod;

  IF NumHabitaciones IS NULL THEN
    Comentario := 'de tamaño indeterminado';
  ELSIF NumHabitaciones < 50 THEN
    Comentario := 'Pequeño';
  ELSIF NumHabitaciones < 100 THEN
    Comentario := 'Mediano';
  ELSE
    Comentario := 'Grande';
  END IF;

  DBMS_OUTPUT.PUT_LINE ('El hotel con ID '|| cod ||' es '|| Comentario);
END;


BEGIN
   TAMHOTEL(1);
   TAMHOTEL(2);
   TAMHOTEL(3);
   TAMHOTEL(99);
END;


