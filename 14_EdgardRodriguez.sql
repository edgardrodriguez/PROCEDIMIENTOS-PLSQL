 --EJERCICIOS
 create or replace function f_incremento10 (avalor number)
  return number
 is
 begin 
   return avalor+(avalor*0.1);
 end;
 /

set serveroutput on;
DECLARE variableID number; -- El tipo de dato a contener
BEGIN
    select  f_incremento10(10) as ss into variableID from dual;
    dbms_output.put_line ('EL RESULTADO SERIA:' || variableID );
END;

SELECT *FROM dba_tables;
SELECT *FROM USER_tables;
SELECT *FROM ALL_tables;

 -- EJEMPLO DE EXCEPCION
 DECLARE

varA    NUMBER ;

BEGIN

varA := 10 / 0 ;        -- El dividendo es0

DBMS_OUTPUT.put_line('¡El código después de la excepción ya no se ejecutará!') ;

EXCEPTION

WHEN zero_divide THEN

DBMS_OUTPUT.put_line('El dividendo no puede ser cero.') ;

DBMS_OUTPUT.put_line('SQLCODE = ' || SQLCODE) ;

END ;

/
-- EJEMPLO DE EXEPCION
  BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE libros';
  EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  /

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
 );

 insert into libros values ('Uno','Richard Bach','Planeta',15);
 insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
 insert into libros values ('El aleph','Borges','Emece',25);
 insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
 insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
 insert into libros values ('Antología','J. L. Borges','Paidos',24);
 insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

 -- Creamos un procedimiento que recibe el nombre de una editorial y luego aumenta en
 -- un 10% los precios de los libros de tal editorial:
 create or replace procedure pa_libros_aumentar10(aeditorial in varchar2)
 as
 begin
  update libros set precio=precio+(precio*0.1)
  where editorial=aeditorial;
 end;
 /
 
 
 GRANT privileges ON object TO user;

 
-- Ejecutamos el procedimiento:
 execute pa_libros_aumentar10('Planeta');

 -- Verificamos que los precios de los libros de la editorial "Planeta" han aumentado un 10%:
 select * from libros;

 -- Creamos otro procedimiento que recibe 2 parámetros, el nombre de una editorial
 -- y el valor de incremento (que tiene por defecto el valor 10):
 create or replace procedure pa_libros_aumentar(aeditorial in varchar2,aporcentaje in number default 10)
 as
 begin
  update libros set precio=precio+(precio*aporcentaje/100)
  where editorial=aeditorial;
 end;
 /
 
 -- Ejecutamos el procedimiento enviando valores para ambos argumentos:
 execute pa_libros_aumentar('Planeta',30);

 --Consultamos la tabla "libros" para verificar que los precios de los libros de la
 -- editorial "Planeta" han sido aumentados en un 30%:
 select * from libros;

-- Ejecutamos el procedimiento "pa_libros_aumentar" omitiendo el segundo parámetro
-- porque tiene establecido un valor por defecto:
 execute pa_libros_aumentar('Paidos');

 -- Consultamos la tabla "libros" para verificar que los precios de los libros
 -- de la editorial "Paidos" han sido aumentados en un 10% (valor por defecto):
 select * from libros;

 --Definimos un procedimiento almacenado que ingrese un nuevo libro en la tabla "libros":
 create or replace procedure pa_libros_insertar
  (atitulo in varchar2 default null, aautor in varchar2 default 'desconocido',
   aeditorial in varchar2 default 'sin especificar', aprecio in number default 0)
 as
 begin
  insert into libros values (atitulo,aautor,aeditorial,aprecio);
 end;
 /

 -- Llamamos al procedimiento sin enviarle valores para los parámetros:
 execute pa_libros_insertar;

 -- Veamos cómo se almacenó el registro:
 select *from libros;

 --Llamamos al procedimiento enviándole valores solamente para el primer
 -- y cuarto parámetros correspondientes al título y precio:

 execute pa_libros_insertar('Uno',100);
 -- Oracle asume que los argumentos son el primero y segundo,
 -- vea cómo se almacenó el nuevo registro:
 select * from libros;