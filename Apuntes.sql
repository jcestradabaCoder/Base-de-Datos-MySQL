/*
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
 Base de Datos con MySQL
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

-- Entrar desde CMD a la consola de MySQL:
#	mysql -u root -p

-- Borrar pantalla:
#	System cls

-- Declarar variables en SQL para MySQL:
SET @nombre = "Juan Carlos";
SET @nombre := "Juan Carlos";
SET @curso = "Base de Datos", @gestor = "MySQL";

-- Podemos utilizar variables en Sentencias SQL, funciones, en stored procedures, entre otros lugares.

-- Para visualizar el valor de una variable del servidor:
SELECT @nombre;
SELECT @curso, @gestor, @nombre;

-- Las variables que se crean en la sesión solo le perteneceran a la sesión

-- Crear dase de datos:
CREATE DATABASE libreria_jc;

-- Consultar base de datos:
SHOW DATABASES;

-- Eliminar una base de datos:
DROP DATABASE libreria_jc;

-- Para seleccionar una base de datos:
USE libreria_jc;

/*
	Creación de tabla:
	
	¿Qué tipo de entidades? -> autores
	Nombre de la tabla: autores

	Nombre
	Genero
	Fecha de nacimiento
	País de origen

	Columna y el tipo de dato

	El proceso de normalización nos asegura que no tendremos datos duplicados o columnas compuestas en las tablas.
*/

-- Definición de la tabla:

CREATE TABLE autores(
	autor_id INT, 
	nombre VARCHAR(25),
	apellido VARCHAR(25),
	genero CHAR(1), -- M o F
	fecha_nacimiento DATE,
	pais_origen VARCHAR(40)
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Tipos de datos:

	En general, la mayoría de los servidores de base de datos nos permiten almacenar los mismos tipos de datos, como strings, fechas y números.

	ALFANUMÉRICOS:

	-> CHAR
	-> VARCHAR
	
	En ambos casos nosotros debemos de especificar la longitud máxima que podrá almacenar el campo. Opcionalmente podemos definir el charset que almacenará:
	
	varchar(20) character set utf8
	
	Con MySQL nosotros podemos establecer el charset que usará la base de datos desde su creación create database nombre character set utf8.
	
	NÚMEROS ENTEROS:

	Tipo		Rango
	->Tinyint	-128 a 127
	->Smallint	-32,768 a 32,767
	->Mediumint	−8,388,608 a 8,388,607
	->Int		−2,147,483,648 a 2,147,483,647
	->Bigint	−9,223,372,036,854,775,808 a 9,223,372,036,854,775,807
	
	NÚMEROS FLOTANTES:
	
	Para los flotantes encontraremos dos tipos:

	->Float
	->Double
*/	
	-- En ambos casos nosotros debemos de especificar la cantidad de dígitos que almacenará la columna antes y después del punto (p,s) :
	
	precio FLOAT(3, 2)

/*	
	En este caso la columna podrá almacenar hasta tres dígitos como enteros y dos después del punto decimal.
	Ejemplo: 999.99
	
	TIEMPO:

	Tipo		Formato default
	->Date		YYYY-MM-DD
	->Datetime	YYYY-MM-DD HH:MI:SS
	->Timestamp	YYYY-MM-DD HH:MI:SS
	->Time		HHH:MI:SS
*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Mostrar todas las tablas: 
SHOW TABLES;

-- Muestra en que base de datos estamos trabajando:
SELECT DATABASE();

-- Eliminamos una tabla:
DROP TABLE autores;

-- Describe las columnas de la tabla:
SHOW COLUMNS FROM autores;
DESC autores;

-- Generar una tabla a partir de otra:
CREATE TABLE usuarios LIKE autores;

-- Insertar registros dentro de una tabla:

INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
VALUES (1, 'Joanne', 'Rowling', 'F', '1965-07-31', 'Reino Unido');

INSERT INTO autores (autor_id, nombre)
VALUES (2, 'Test autor');

-- Consulta sencilla de todos los registros de una tabla:
SELECT * FROM autores;

-- Insertar multiples registros:

INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
VALUES	(2, 'Stephen', 'King', 'M', '1947-09-21', 'Estados Unidos'),
		(3, 'George', 'Orwell', 'M', '1903-06-25', 'India'),
		(4, 'Jaime', 'Sabines', 'M', '1926-03-25', 'México'),
		(5, 'José', 'Saramago', 'M', '1922-11-16', 'Portugal'),
		(6, 'Mario', 'Benedetti', 'M', '1920-09-14', 'Uruguay'),
		(7, 'Benjamin', 'Graham', 'M', '1894-05-09', 'Reino Unido');
		
-- Ejecutar un archivo SQL consola:
#	mysql -u root -p < "C:\Users\Juan Carlos EB\Desktop\JCEB\sentencias.sql"
#	SOURCE C:\Users\Juan Carlos EB\Desktop\JCEB\sentencias.sql

-- Consulta fuera de sesión:
#	mysql -u root -p libreria_jc -e "SELECT * FROM autores"

-- Condicionales al crear o eliminar bases de datos y tablas:
DROP DATABASE IF EXISTS libreria_jc;
CREATE DATABASE IF NOT EXISTS libreria_jc;

/*
	Constraints:
	
	Restricciones que se le colocan a las tablas para que estas no almacenen datos corruptos, nulos o vacíos.
	Nos ayudan a prevenir valores nulos, validar columnas únicas, establecer llaves primarias y foráneas y proveernos ciertas validaciones.
*/
	
	-- Con UNIQUE nos permite no insertar nuevamente un registro con el mismo valor en el campo especificado:	
	seudonimo VARCHAR(50) UNIQUE

	-- Con NOT NULL evitamos que se inserten valores vacíos:
	nombre VARCHAR(25) NOT NULL	

-- Obtener la fecha exacta:
SELECT current_timestamp;
SELECT NOW();

/*
	Con default podemos agregar un valor por defecto si no se indica al insertar:
	fecha_creacion DATETIME DEFAULT current_timestamp

	Evitamos la inserción de números negativos:
	autor_id INT UNSIGNED NOT NULL

	Enum es una lista de la cual una columna puede tomar un valor, lo usaremos cuando esas opciones no van a cambiar:
	genero ENUM('M','F')

	Establecemos una llave primaria (Solo se puede tener una llave primaria por tabla):
	autor_id INT UNSIGNED PRIMARY KEY,

	Con AUTO_INCREMENT si no se indica el valor del ID irá incremntando automaticamente;
	autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,

	Para que las tablas tengan relación una con otra, una de ellas almacenara datos redundantes a esto lo conocemos como llaves foráneas:
	
	#Podemos tener más de una llave foránea:
	autor_id INT UNSIGNED NOT NULL
	FOREIGN KEY (autor_id) REFERENCES autores(autor_id)
*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Implementación de restricciones

-- VALORES ÚNICOS:
-- Como sabemos, si nosotros necesitamos validar valores únicos usaremos el constraint UNIQUE:

CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE
);

-- Otra forma de expresarlo, es de la siguiente manera:

CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  CONSTRAINT UNIQUE (nombre)
);

-- La palabra CONSTRAINT es opcional, sin embargo, por temas de legibilidad se debe colocarla.

-- VALORES MÚTIPLES COLUMNAS:
-- Si necesitamos validar el valor único de una combinación de columnas lo haremos de la siguiente manera.

-- En este caso queremos validar que la combinación de nombre, apellido y matricula sean únicas en la tabla:

CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  matricula VARCHAR(10),
  CONSTRAINT unique_combinacion UNIQUE (nombre, apellido, matricula),
  PRIMARY KEY (usuario_id)
);

-- LLAVES PRIMARIAS
-- Existen un par de formas con las cuales nosotros podemos definir un campo como una llave primaria:

CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED AUTO_INCREMENT,
  PRIMARY KEY(usuario_id)
);

-- En ambos casos el resultado es el mismo.

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Mediante ALTER TABLE podemos modificar una tabla:

ALTER TABLE libros ADD existencias INT UNSIGNED NOT NULL;
ALTER TABLE libros ADD stock INT UNSIGNED NOT NULL DEFAULT 10;
ALTER TABLE  libros DROP COLUMN stock;

/*
	Modificar tablas:

	Nosotros podemos modificar la definición de una tabla una vez esta se haya creado, para ello, nos apoyaremos de la sentencia ALTER TABLE.
	Aquí un listado de algunas modificaciones que podemos realizar (Las más comunes):
*/

-- Renombrar tabla:

-- -> Renombrar la tabla usuarios por users:
ALTER TABLE usuarios RENAME users;

-- Agregar una nueva columna:

-- -> Agregar a la tabla usuarios la columna email de tipo VARCHAR con máximo de 50 caracteres:
ALTER TABLE usuarios ADD email VARCHAR(50);

-- Agregar una nueva columna con constraints:

-- -> Agregar a la tabla usuarios la columna email, validando su presencia:
ALTER TABLE usuarios ADD email VARCHAR(50) NOT NULL DEFAULT '';

-- -> Agregar a la tabla usuarios, la columna email, validando su valor único:
ALTER TABLE usuarios ADD email VARCHAR(50) UNIQUE;

-- Eliminar una columna:

-- -> Eliminar la columna email de la tabla usuarios:
ALTER TABLE usuarios DROP COLUMN email;

-- Modificar el tipo de dato de una columna:

-- -> Modificar el tipo de dato de la columna teléfono (tabla usuarios) de INT a VARCHAR, máximo 50 caracteres:
ALTER TABLE usuarios MODIFY telefono VARCHAR(50);

-- Generar una llave primaria:

-- -> Generar una llave primaria a la tabla usuarios:
ALTER TABLE usuarios ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (id);

-- Agregar llave foránea:

-- -> Agregar una llave foránea a la tabla usuarios, con referencia a la tabla grupos:
ALTER TABLE usuarios ADD FOREIGN KEY(grupo_id) REFERENCES grupos(grupo_id);

-- Eliminar llaves foráneas:

-- -> Eliminar la llave foránea grupo_id de la tabla usuarios:
ALTER TABLE usuarios DROP FOREIGN KEY grupo_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Consulta todos los registros de todas las columnas de la tabla libros:
SELECT * FROM libros;

-- Consulta todos los registros de todas las columnas de la tabla libros formato vertical (carta) en cosola:
SELECT * FROM libros\G;

-- Consultas con columnas específicas:
SELECT libro_id, titulo FROM libros;

-- Consultas con condición (operadores):
SELECT * FROM libros WHERE titulo = 'Carrie';

/*
	Operadores:
    <
    >
    <=
    >=
    =
    != <>
	
	Operadores Lógicos:
	AND
	OR
	NOT
*/

-- Consultas con condición (operadores lógicos):

SELECT * FROM libros WHERE titulo = 'Carrie' AND autor_id = 2;
SELECT * FROM libros WHERE titulo = 'Carrie' AND autor_id = 2 AND paginas > 0;
SELECT * FROM libros WHERE titulo = 'Carrie' AND autor_id = 2 AND paginas = 0;
SELECT * FROM libros WHERE titulo = 'Carrie' OR autor_id = 2 OR paginas = 0;
SELECT * FROM libros WHERE (autor_id = 2 AND titulo = 'Carrie') OR (autor_id = 7 AND titulo = 'El inversor inteligente');

-- Consulta para comprobar valores vacíos:
SELECT * FROM autores WHERE seudonimo IS NULL;
SELECT * FROM autores WHERE seudonimo <=> NULL;

-- Consulta para comprobar valores no vacíos:
SELECT * FROM autores WHERE seudonimo IS NOT NULL;

-- Consultas utilizando la clausula BETWEEN (entre):
SELECT libro_id, titulo, fecha_publicacion FROM libros WHERE fecha_publicacion BETWEEN '1995-01-01' AND '2015-01-31';

-- Consulta por listas 'IT', 'Poesía amorosa', 'Antología poética', 'El inversor inteligente':
SELECT libro_id, titulo FROM libros WHERE titulo = "IT" OR titulo = "Poesía amorosa" OR titulo = "Antología poética" OR titulo = "El inversor inteligente";
SELECT libro_id, titulo FROM libros WHERE titulo IN ('IT', 'Poesía amorosa', 'Antología poética', 'El inversor inteligente');

-- Consulta para eliminar datos repetidos:
SELECT DISTINCT titulo FROM libros;

-- Estableciendo un alias a las columnas y tablas:

SELECT autor_id AS autor , titulo AS nombre FROM libros;
SELECT catalogo_libros.autor_id AS autor , catalogo_libros.titulo AS nombre FROM libros AS catalogo_libros;
SELECT 9 * 10 AS resultado;

-- Actualizar Registros:

UPDATE libros SET stock = 1;
UPDATE libros SET stock = 2 WHERE titulo = 'IT';
UPDATE libros SET stock = 3 WHERE libro_id = 2;

-- Eliminar Registros:

DELETE FROM libros;
DELETE FROM libros WHERE autor_id = 8;
DELETE FROM libros WHERE libro_id = 18;

-- Eliminando registros removiendo las referencias de las tablas:
DELETE FROM libros WHERE autor_id = 8;
DELETE FROM autores WHERE autor_id = 8;

-- Para su eliminación en cascada desde la definición en la tabla sería de la siguiente manera:
FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE

-- Para su eliminación en cascada dede un ALTER TABLE:
ALTER TABLE libros ADD FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE;

-- Eliminar todos los registros de nuestra tabla:
-- 	-> Conserva metadatos y elimina registros, es posible recuperar los datos eliminados
DELETE FROM libros;

-- No puede utilizar la clausula WHERE, resetea la definición de la tabla (registros y metadata), durante un truncate la tabla se bloquea 
-- con lo cual no es posible realizar operaciones en esta. Un truncate no dispara ningun trigger:
TRUNCATE TABLE libros;

-- Funciones String:

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores;
SELECT nombre, LENGTH(nombre) AS tam_nombre FROM autores;
SELECT nombre FROM autores WHERE LENGTH(nombre) >= 7;
SELECT UPPER(nombre) AS nombre_upper, LOWER(nombre) AS nombre_lower FROM autores;
SELECT TRIM(" Juan Carlos Estrada Barragán ") AS usuarios;
SELECT LEFT("Juan Carlos", 4) AS primer_nombre, RIGHT("Juan Carlos", 6) AS segundo_nombre;
SELECT * FROM libros WHERE LEFT(titulo, 12) = "Harry Potter";
SELECT * FROM libros WHERE RIGHT(titulo, 2) = "IT";

-- Funciones con números:

SELECT RAND(); -- Número aleatorio flotante entre el 0 y 1
SELECT ROUND(10.558); -- Redondea un número
SELECT TRUNCATE(1.123456789, 3); -- Delimita la cantidad de decimales
SELECT POW(5, 2); -- Resultado de elevar un numero a una potencia
SELECT POWER(2, 3);

-- Funciones para fechas:

SELECT NOW();
SELECT SECOND(NOW()), MINUTE(NOW()), HOUR(NOW()), DAY(NOW()), MONTH(NOW()), YEAR(NOW());
SELECT DAYOFWEEK(NOW()), DAYOFMONTH(NOW()), DAYOFYEAR(NOW());
SELECT DATE(NOW());
SELECT * FROM libros WHERE DATE(fecha_creacion) = CURDATE(); -- Regresa todos los libros creados el dia de hoy
SELECT * FROM libros WHERE DATE(fecha_creacion) = DATE("2022-02-03");
SELECT NOW() - INTERVAL 2 DAY AS past , NOW() AS present, NOW() + INTERVAL 2 DAY AS future;

-- Funciones sobre condiciones:

SELECT IF(10 > 9, "El número si es mayor", "El número no es mayor") AS resultado;
SELECT titulo, stock, IF(stock = 0, "Sin stock", "Con stock") AS disponibilidad FROM libros;
SELECT IFNULL(seudonimo, "No tiene seudónimo") AS res_seudonimo FROM autores;

-- Creando una función:
USE libreria_jc;
DROP FUNCTION IF EXISTS obtener_nombre_completo;

DELIMITER $$
USE libreria_jc $$
CREATE FUNCTION obtener_nombre_completo(nombre VARCHAR(50), apellido VARCHAR(50))
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
	RETURN TRIM(CONCAT(nombre, " ", apellido));
END$$

DELIMITER ;

-- Usando función creada:
SELECT obtener_nombre_completo(nombre, apellido) AS nombre_completo, seudonimo, genero, fecha_nacimiento, pais_origen, fecha_creacion FROM autores;

-- Listamos las funciones creadas:
SHOW FUNCTION STATUS  WHERE db = database() AND type = "FUNCTION";

-- Eliminamos nuestra función:
DROP FUNCTION IF EXISTS obtener_nombre_completo;

-- Creando una función:

USE libreria_jc;
DROP FUNCTION IF EXISTS obtener_stock;

DELIMITER $$
USE libreria_jc $$
CREATE FUNCTION obtener_stock(stock INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	SET @cad_stock = (IF(stock = 0, "Sin stock", "Con stock"));
    RETURN @cad_stock;
END$$

DELIMITER ;

SELECT titulo, stock, obtener_stock(stock) AS stock_msg FROM libros;

-- Creando una función:

USE libreria_jc;
DROP FUNCTION IF EXISTS obtener_new_stock;

DELIMITER $$
USE libreria_jc $$
CREATE FUNCTION obtener_new_stock()
RETURNS INT
DETERMINISTIC
BEGIN
	SET @new_stock = (SELECT ROUND(RAND() * 10));
    RETURN @new_stock;
END$$

DELIMITER ;

-- Actualizando valores con los resultados retornados de una función:
UPDATE libros SET stock = obtener_new_stock();

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Búsqueda mediante Strings:

-- Búsqueda de un string al inicio:
SELECT * FROM libros WHERE titulo LIKE 'Harry%';

-- Búsqueda de un string al final:
SELECT * FROM libros WHERE titulo LIKE '%ceguera';

-- Búsqueda de un string;
SELECT * FROM libros WHERE titulo LIKE '%inversor%';

-- Búsquedas complejas usando LIKE:

SELECT * FROM libros WHERE titulo LIKE '_a____';
SELECT * FROM libros WHERE titulo LIKE '_a%';
SELECT * FROM libros WHERE titulo LIKE '_a__y%';

-- Utilizando sentencias básicas vs expresiones regulares:

-- Sentencias Básicas:
SELECT * FROM libros WHERE LEFT(titulo, 1) = 'H' OR LEFT(titulo, 1) = 'L';
SELECT * FROM libros WHERE titulo LIKE 'H%' OR titulo LIKE 'L%';

-- Utilizando expresiones regulares:
SELECT * FROM libros WHERE titulo REGEXP '^[HL]';

-- Consultas con resultados ordenados:

-- Ascendente:
SELECT * FROM libros ORDER BY titulo; -> SELECT * FROM libros ORDER BY titulo ASC;
SELECT * FROM libros ORDER BY libro_id ASC;

-- Descendente:
SELECT * FROM libros ORDER BY titulo DESC;
SELECT * FROM libros ORDER BY libro_id DESC;

-- Ordenando por más de un campo:
SELECT * FROM libros ORDER BY libro_id AND titulo ASC;

-- Limitando la consulta a cierto numero de registros:

SELECT * FROM libros LIMIT 5;
SELECT * FROM libros WHERE autor_id = 2 LIMIT 2;
SELECT libro_id, titulo FROM libros LIMIT 0,5;

/*
	Funciones de Agregación: Funciones que ese ejecutan en un grupo de datos.
	Grupo de datos: Resultado de una consulta.
	Cuando trabajemos con una columna en específico se tomarán los registros que contengan un valor.
*/

-- COUNT (Cuenta los registros):

SELECT COUNT(*) AS Total FROM autores;
SELECT COUNT(*) AS Total FROM autores WHERE seudonimo IS NOT NULL;
SELECT COUNT(seudonimo) AS Total FROM autores;

-- MAX (Obtenemos el valor máximo de una columna):
SELECT libro_id, titulo, MAX(paginas) AS Libro_con_mas_paginas FROM libros;

-- MIN (Obtenemos el valor mínimo de una columna):
SELECT libro_id, titulo, MIN(paginas) AS Libro_con_mas_paginas FROM libros;

-- AVG (Obtenemos el valor promedio de una columna):
SELECT AVG(stock) AS promedio_stock_por_libro FROM libros;

-- SUM (Suma los registros de una columna especifica):
SELECT SUM(stock) AS Total_libros_en_stock FROM libros;
SELECT SUM(stock) AS Libros_por_autor FROM libros WHERE autor_id = 2;

-- Agrupamiento:

SELECT autor_id, COUNT(*) FROM libros GROUP BY autor_id;
SELECT descripcion, COUNT(descripcion) FROM libros GROUP BY descripcion;
SELECT descripcion, COUNT(descripcion) AS num FROM libros GROUP BY descripcion ORDER BY num DESC;
SELECT descripcion, COUNT(descripcion) AS num FROM libros GROUP BY descripcion ORDER BY num DESC LIMIT 1;

-- Condiciones bajo agrupamiento:
SELECT autor_id, COUNT(*) AS total FROM libros GROUP BY autor_id HAVING total > 1;

-- Unir resultados:

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores UNION
SELECT CONCAT(nombre, " ", apellidos) AS nombre_completo FROM usuarios;

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, "" AS email FROM autores UNION
SELECT CONCAT(nombre, " ", apellidos) AS nombre_completo, email AS email FROM usuarios;

-- Subconsultas:

SELECT autor_id , CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores WHERE autor_id IN (
	SELECT autor_id FROM libros GROUP BY autor_id 
	HAVING SUM(stock) > (SELECT AVG(stock) FROM libros)
);

-- Validar Registros:
SELECT IF(EXISTS(SELECT libro_id FROM libros WHERE titulo = 'El inversor inteligente' AND stock > 0 ), "Disponible!", "No Disponible!") AS resultado;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS

--INNER JOIN (Nos permite obtner registros que se encuentren dentro de la intersección de la unión de dos tablas):

SELECT libros.titulo, CONCAT(autores.nombre, " ", autores.apellido) AS autor, libros.fecha_creacion FROM libros
INNER JOIN autores ON  libros.autor_id = autores.autor_id
ORDER BY libros.titulo;

SELECT li.titulo, CONCAT(au.nombre, " ", au.apellido) AS autor, li.fecha_creacion FROM libros AS li
INNER JOIN autores AS au ON  li.autor_id = au.autor_id
ORDER BY li.titulo;

SELECT li.titulo, CONCAT(au.nombre, " ", au.apellido) AS autor, li.fecha_creacion FROM libros AS li
INNER JOIN autores AS au ON  li.autor_id = au.autor_id AND au.seudonimo IS NOT NULL
ORDER BY li.titulo;

-- INNER JOIN utilizando la clausula USING (Se puede utilizar cuando las tablas se encuentran normalizadas y las dos tablas comparten dicho campo):
-- -> No se puede condicionar utilizando la clausula using

SELECT li.titulo, CONCAT(au.nombre, " ", au.apellido) AS autor, li.fecha_creacion FROM libros AS li
INNER JOIN autores AS au USING(autor_id)
ORDER BY li.titulo;

-- LEFT JOIN y LEFT OUTER JOIN (Son lo mismo) (Obtenemos registros de la unión de dos tablas puede encontrase en la intersección 
-- de ambas o de la tabla A(lado izq)):
SELECT us.usuario_id ,CONCAT(us.nombre, " ", us.apellidos) AS usuario, lu.libro_id FROM usuarios AS us
LEFT JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id;

-- RIGHT JOIN y RIGHT OUTER JOIN (Son lo mismo):
SELECT us.usuario_id ,CONCAT(us.nombre, " ", us.apellidos) AS usuario, lu.libro_id FROM libros_usuarios AS lu
RIGHT JOIN usuarios AS us ON lu.usuario_id = us.usuario_id;

-- Múltiples JOINS:

-- Mejor usar AND que WHERE en consultas en los JOIN para identificar las condiciones más fácil y optimizarlo:

SELECT 
	us.usuario_id, 
    CONCAT(us.nombre, " ", us.apellidos) AS nombre, 
    lu.libro_id, 
    li.titulo, 
    au.autor_id, 
    CONCAT(au.nombre, " ", au.apellido) AS autor 
FROM libros_usuarios AS lu
INNER JOIN usuarios AS us ON lu.usuario_id = us.usuario_id
INNER JOIN libros AS li ON lu.libro_id = li.libro_id
INNER JOIN autores AS au ON au.autor_id = li.autor_id AND au.seudonimo IS NOT NULL
WHERE DATE(lu.fecha_creacion) = CURDATE();

/*
	usuarios
	libros_usuarios
	libros
	autores
*/

SELECT DISTINCT
CONCAT(us.nombre, " ", us.apellidos) AS nombre_usuario 
FROM usuarios AS us
INNER JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id AND DATE(lu.fecha_creacion) = CURDATE()
INNER JOIN libros AS li ON lu.libro_id = li.libro_id
INNER JOIN autores AS au ON li.autor_id = au.autor_id AND au.seudonimo IS NOT NULL;

-- Producto Carteciano CROSS JOIN:
SELECT usuarios.username, libros.titulo FROM usuarios CROSS JOIN libros ORDER BY usuarios.username DESC;

-- INSERT SELECT:
INSERT INTO libros_usuarios(libro_id, usuario_id) SELECT libros.libro_id, usuarios.usuario_id FROM usuarios CROSS JOIN libros;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Vistas:
	-> Podemos exponer columnas específicas.
	-> Es un mecanismo en el cual nos permite consultar datos, a diferencia de las tablas estas no son almacenados.
	-> Podemos realizar vistas a partir de querys complejos.
	-> Una vez que se encuentren generadas podrán realizarse consultas fácilmente.
*/

-- Creando vistas:

CREATE VIEW prestamos_usuarios_vw AS
SELECT 
us.usuario_id,
us.username, 
CONCAT(us.nombre, " ", us.apellidos) AS nombre_usuario,
us.email,
COUNT(us.usuario_id) AS num_prestamos
FROM usuarios AS us
INNER JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id AND DATE(lu.fecha_creacion) BETWEEN '2022-02-28' AND '2022-03-10'
GROUP BY us.usuario_id;

-- Ejecutar vista:
SELECT * FROM prestamos_usuarios_vw;

-- Eliminar vista:
DROP VIEW prestamos_usuarios_vw;

-- Modificar Vista:

CREATE OR REPLACE VIEW prestamos_usuarios_vw AS
SELECT 
us.usuario_id,
us.username, 
CONCAT(us.nombre, " ", us.apellidos) AS nombre_usuario,
us.email,
COUNT(us.usuario_id) AS num_prestamos
FROM usuarios AS us
INNER JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id AND lu.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY us.usuario_id;

-- Listar 5 títulos con más préstamos en los últimos 30 días:

CREATE OR REPLACE VIEW top5_titulos_ultimos_30d_vw AS
SELECT 
li.libro_id,
li.titulo,
COUNT(li.libro_id) AS num_prestamo
FROM libros AS li
INNER JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id AND lu.fecha_creacion >= CURDATE() - INTERVAL 30 DAY 
GROUP BY libro_id ORDER BY num_prestamo DESC LIMIT 5;

SELECT * FROM top5_titulos_ultimos_30d_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Stored Procedures:
	-> Son rutinas las cuales se ejecutan directamente en le motor de bases de datos.
	-> Estas rutinas pueden realizar trabajos complejos.
	-> Podemos ejecutar instrucciones, sentencias, podemos trabajar con flujo de datos, ciclos etc.
	-> Al igual que las funciones pueden recibir distintos tipos de parámetros, sin embargo, los stored procedures no pueden retornar valores.
	-> Cada manejador de BD tiene su propia forma de trabajar con los SP.
*/

-- Consultar los stored procedures existentes:
SHOW PROCEDURE STATUS  WHERE db = database() AND type = "PROCEDURE";

-- Crear stored procedure:

DELIMITER //
CREATE PROCEDURE prestamo(libro_id INT, usuario_id INT)
BEGIN
	DECLARE availableStock INT DEFAULT 0;
    SET availableStock := (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
    
    IF availableStock > 0 THEN
		INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
    END IF;
END //
DELIMITER ;

-- Llamar Stored Procedure:
CALL prestamo(2, 3);

-- Eliminar un Stored Procedure:
DROP PROCEDURE prestamo;

-- Obtener un valor de salida OUT:

DELIMITER //
CREATE PROCEDURE prestamo(libro_id INT, usuario_id INT, OUT newStock INT)
BEGIN
	DECLARE availableStock INT DEFAULT 0;
    SET availableStock := (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
    
    IF availableStock > 0 THEN
		INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
        SET newStock := (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
    END IF;
END //
DELIMITER ;

SET @newStock = -1;
CALL prestamo (2, 3, @newStock);
SELECT @newStock;

-- Condiciones:

DELIMITER //
CREATE PROCEDURE prestamo(libro_id INT, usuario_id INT, OUT availableStock INT)
BEGIN
    SET availableStock = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
    
    IF availableStock > 0 THEN
		INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
        SET availableStock = availableStock - 1;
	ELSE
		SELECT "No es posible realizar el prestamo!" AS msg_error;
    END IF;
END //
DELIMITER ;


SET @newStock = -1;
CALL prestamo (2, 2, @newStock);
SELECT @newStock;

-- Casos:

DELIMITER //
CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN
	SET @cantidad = (SELECT COUNT(*) FROM libros_usuarios WHERE libros_usuarios.usuario_id = usuario_id);
    
    CASE
		WHEN @cantidad > 20 THEN
			SELECT "Lactor Fanatico!" AS msg_rpta;
		WHEN @cantidad > 10 AND @cantidad <= 20 THEN
			SELECT "Lector Destacado!" AS msg_rpta;
		WHEN @cantidad > 5 AND @cantidad <= 10 THEN
			SELECT "Lector Promedio!" AS msg_rpta;
		WHEN @cantidad > 0 AND @cantidad <= 5 THEN
			SELECT "Lector Principiante!" AS msg_rpta;
		ELSE
			SELECT "Nuevo Lector!" AS msg_rpta;
    END CASE;
END //
DELIMITER ;

CALL tipo_lector(4);

-- CICLOS:

-- WHILE:

DELIMITER //
CREATE PROCEDURE libros_azar()
BEGIN
	SET @lim = 0;
    
    WHILE @lim < 5 DO
		SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
        SET @lim = @lim + 1;
    END WHILE;
END //
DELIMITER ;

CALL libros_azar();

-- REPEAT:

DELIMITER //
CREATE PROCEDURE libros_azar()
BEGIN
	SET @lim = 0;
    
	REPEAT
		SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
        SET @lim = @lim + 1;
        
        UNTIL @lim >=5
    END REPEAT;
END //
DELIMITER ;

CALL libros_azar();

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Bloqueo de tablas:

	Los manejadores de BD permiten que más de un usuario puedan ejecutar diferentes sentencias a la misma base de datos.
	En los servidores de BD se utilizan los bloqueos también conocidos como cierres.
	
	Cuando realizamos la inserción de un registro, una porción de la base de datos se bloquea de tal forma que no se permitan ejecutar sentencias a la misma
	en lo que el proceso termina, si una porción de la BD se encuentra bloqueada cualquier otro usuario que realice una sentencia deberá esperar a que el
	bloqueo finalice, principalmente existen 2 tipos de bloqueo.
	
	El primer tipo ocurre cuando una sentencia es ejecutada (consulta, intersección, actualización o eliminación).
	El segundo tipo ocurre cuando se ejecuta alguna de estas sentencias: inserción , actualización o eliminación. En este tipo una consulta no bloquea la BD.
	En mysql se utilizan ambos mecanismos.
	
	Con el motor MyISAM excluimos del bloqueo las consultas y con el motor InnoDB todas las sentencias ocasionaran un bloqueo.
*/

/*
	Transacciones:
	
	-> Es el mecanismo que nos permite agrupar n cantidad de sentencias SQL en una sola de modo que todas o ninguna de las sentencias 
	tengan éxito (propiedad llamada atomicidad).
	-> Utilizar transacciones nos permitirá poder afectar a la BD de una forma segura.
	-> En una transacción podemos definir 3 estados: antes, durante y después de la transacción.
	-> Las sentencias modificaran de manera permanente a la DB siempre y cuando todas las sentencias hayan tenido éxito.
*/

-- Implementar transacciones:

START TRANSACTION;

SET @libro_id = 5, @usuario_id = 3;

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

-- Terminamos la transacción confirmando cambios:
COMMIT;

-- Terminamos la transaccion descartando cambios:
ROLLBACK;

-- En la mayoría de los casos implementaremos transacciones dentro de los stored procedures:

DELIMITER //
CREATE PROCEDURE prestamo(libro_id INT, usuario_id INT)
BEGIN
	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- Cuando ocurre un error
    BEGIN
		-- Aquí va todo lo que se requiera ejecutar en caso de error
		ROLLBACK;
    END;
    
	START TRANSACTION;
		INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
	COMMIT;
END //
DELIMITER ;

-- Comprobando el impacto de datos:

SELECT * FROM libros_usuarios;
SELECT stock FROM libros WHERE libro_id = 6;
CALL prestamo(6, 3);
CALL prestamo(6, 300);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Motores de almacenamiento en MySQL:
	
	Afortunadamente para nosotros, los administradores de base de datos, MySQL nos permite trabajar con diferentes motores de almacenamiento, entre los 
	que destacan MyISAM e InnoDB.

	¿Motor de almacenamiento?, ¿Qué es eso?, verás, un motor de almacenamiento se el encargado de almacenar, gestionar y recuperar toda la información de 
	una tabla. Es por ello que es de suma importancia que nosotros conozcamos la existencia de estos motores, cuales son sus principales diferencias y en 
	qué casos es bueno utilizar uno u otro, de esta forma que podamos garantizar un mejor performance en nuestras aplicaciones.
*/
	-- Para que nosotros conozcamos que motor de almacenamiento podemos utilizar basta con ejecutar la siguiente sentencia en nuestra terminal:
	SHOW ENGINES;

/*
	Obtendremos el siguiente listado.

	- InnoDB
	- MRG_MYISAM
	- MEMORY
	- BLACKHOLE
	- MyISAM
	- CSV
	- ARCHIVE
	- PERFORMANCE_SCHEMA
	- FEDERATED
	
	En esta ocasión nos centraremos en explicar los dos motores de almacenamiento más populares, me refiero a MyISAM e InnoDB.

	MyISAM es el motor por default de MySQL. Una de las principales ventajas de este motor es la velocidad al momento de recuperar información. MyISAM 
	es una excelente opción cuando las sentencias predominantes en nuestra aplicación sean de consultas. Esta es una de las razones por las cuales MyISAM 
	es tan popular en aplicaciones web.
	
	Si tu aplicación necesita realizar búsquedas full-text MyISAM es un mejor opcion.
	
	La principal desventajas de MyISAM recae en la ausencia de atomocidad, ya que no se comprueba la integridad referencial de los datos. Se gana tiempo 
	en la inserción, sí, pero perdemos confiabilidad en los datos.
	
	Por otro lado tenemos el motor de almacenamiento InnoDB. La principal ventaja de este motor recae en la seguridad de las operaciones. InnoDB permite 
	la ejecución de transacciones, esto nos garantiza que los datos se persisten de forma correcta y si existe algún error podamos revertir todos los 
	cambios realizados.
	
	Algo interesante a mencionar sobre InnoDB es que este motor realiza un bloqueo total sobre un tabla cuando es ejecutada una se las siguientes 
	sentencias:

	SELECT
	INSERT
	UPDATE
	DELETE
	
	Si deseamos trabajar con transacción y la integridad de los datos sea crucial nuestra mejor opción será InnoDB, por otro lado, sí lo que deseamos 
	es una mayor rapidez al momento de obtener información será necesario utilizar MyISAM.
	
	GESTIÓN:
	
	Si nosotros así lo deseamos podemos cambiar el motor de almacenamiento. Existen dos formas de hacer esto. La primera, es modificar el archivo my.cnf:

	[mysqld]
	default-storage-engine = innodb
*/	
	-- La segunda forma es hacerlo directamente desde nuestra sección, basta con ejecutar la siguiente sentencia:
	
	SET storage_engine=INNODB;
	
	-- En ambos casos modificamos el motor de almacenamiento de MyISAM a InnoDB.
	
	-- Si nosotros deseamos conocer qué motor de almacenamiento utiliza una tabla en particular, podemos hacerlo ejecutando la siguiente sentencia:
	
	SHOW TABLE STATUS WHERE `Name` = 'tabla' \G;
	
	-- Si deseamos crear una tabla utilizando un motor en particular, debemos seguir la siguiente estructura:
	
	CREATE TABLE tabla_innodb (id int, value int) ENGINE=INNODB;
	CREATE TABLE tabla_myisam (id int, value int) ENGINE=MYISAM;
	CREATE TABLE tabla_default (id int, value int);
	
/*
	Eventos MySQL:
	
	A partir de la versión 5.1, MySQL añade el concepto de eventos. Un evento no es más que una tarea la cual se ejecuta de forma automática en un 
	momento previamente programado. Si eres un usuarios Linux puedes ver a los eventos cómo los cron jobs.
	
	Los eventos nos permitirán a nosotros cómo administradores de base de datos programar ciertas tareas las cuales queremos que se ejecuten de forma 
	periódica o en un momento en concreto, de tal manera que podamos automatizar ciertos procesos.
	
*/	
	-- EJEMPLOS:
	
	CREATE TABLE test(
		evento VARCHAR(50),
		fecha DATETIME 
	);
	
	-- Lo primero que debemos de hacer es habilitar nuestro servidor para que pueda ejecutar eventos:
	
	SET GLOBAL event_scheduler = ON;
	
	-- Posteriormente creamos nuestro evento; En mi caso, tendrá el nombre de insertion event. Este evento se ejecutará dentro de 1 min, y lo que hará,
	-- será insertar un registro en mi tabla:
	
	CREATE EVENT insertion_event
	ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
	DO INSERT INTO test VALUES ('Evento 1', NOW());
	
	-- El nombre del evento no debe de poseer más de 64 caracteres.
	
	-- Si queremos que el evento se ejecute en una fecha en concreto, únicamente debemos de especificarlo en ON SCHEDULE AT. Recuerda, el formato es 
	-- año-mes-día hora:minuto:segundo:
	
	ON SCHEDULE AT '2022-03-17 22:02:00'
	
	-- Si nuestro evento ejecutará más de una sentencia SQL debemos de apoyarnos de BEGIN y END:
	
	DELIMITER //

	CREATE EVENT insertion_event
	ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
	DO
	BEGIN
	 INSERT INTO test VALUES ('Evento 1', NOW());
	 INSERT INTO test VALUES ('Evento 2', NOW());
	 INSERT INTO test VALUES ('Evento 3', NOW());
	END //

	DELIMITER ;
	
	-- Una vez el evento se haya creado, nosotros podemos listarlo:
	
	SHOW events\G;
	
	-- Si queremos eliminar un evento haremos uso de DROP:
	
	DROP EVENT nombre_evento;
	
	-- Es importante mencionar que una vez el evento haya expirado, este, será eliminado de forma automática. Si nosotros no queremos que esto ocurra 
	-- debemos de apoyarnos de ON COMPLETION:
	
	ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
	ON COMPLETION PRESERVE
	
	-- Algo común con los eventos es trabajar con store procedures:
	
	CREATE EVENT nombre_evento
	ON SCHEDULE AT 'fecha de ejeución' 
	DO
	CALL store_procedure();
	
	CREATE EVENT nombre_evento
	ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
	DO INSERT INTO test VALUES ("SP tipo_lector", NOW());
	CALL tipo_lector(3);
	
	-- EVENTOS PERIÓDICOS.
	
	-- Los eventos los podemos programar para que se ejecuten de forma periódica:
	
	CREATE EVENT insertion_event
	ON SCHEDULE EVERY 1 MINUTE STARTS '2022-03-17 18:30:00'
	DO INSERT INTO test VALUES ('Evento 1', NOW());
	
	-- En esta ocasión, el evento se ejecuta cada minuto después de las 6:30 PM. Podemos programar la ejecución para cada segundo, minuto, hora, semana, 
	-- mes o año.
	
	-- Si nosotros queremos que el evento se ejecute entre un rango de fechas debemos de apoyarnos de ENDS:
	
	CREATE EVENT insertion_event
	ON SCHEDULE EVERY 1 MINUTE STARTS '2022-03-17 18:30:00'
	ENDS '2022-03-17 19:00:00'
	DO INSERT INTO test VALUES ('Evento 1', NOW());
	
	-- Ahora, el evento se ejecuta durante un periodo de 30 minutos (De 6:30 PM a 7:00 PM).
	
	-- EDITAR EVENTOS
	
	-- Si por alguna razón necesitamos detener un evento, lo que debemos de hacer es deshabilitarlo:
	
	ALTER EVENT nombre_evento
	DISABLE;
	
	-- Para habilitar nuevamente un evento colocamos ENABLE:
	
	ALTER EVENT nombre_evento
	ENABLE;
	
	-- DETENER EVENTOS
	
	-- Para detener completamente todos los eventos, debemos de ejecutar la siguiente sentencia:
	
	SET GLOBAL event_scheduler = OFF;
	
/*	
	ESTRUCTURA DE UN EVENTO
	
	Los eventos en MySQL pueden ser tan complejos como nosotros los deseemos:
	
	CREATE
    [DEFINER = { user | CURRENT_USER }]
    EVENT
    [IF NOT EXISTS]
    event_name
    ON SCHEDULE schedule
    [ON COMPLETION [NOT] PRESERVE]
    [ENABLE | DISABLE | DISABLE ON SLAVE]
    [COMMENT 'string']
    DO event_body;

	schedule:
		AT timestamp [+ INTERVAL interval] ...
	  | EVERY interval
		[STARTS timestamp [+ INTERVAL interval] ...]
		[ENDS timestamp [+ INTERVAL interval] ...]

	interval:
		quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
				  WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
				  DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}


	Cursores MySQL
	
	En base de datos un Cursor es un mecanismo el cual nos permite procesar fila por fila el resultado de una consulta.
	
	Como sabemos SQL es un lenguaje orientado a conjuntos. Si nosotros deseamos alterar ciertos elementos en nuestra colección tendremos que hacerlo 
	mediante condiciones. Única y exclusivamente los elementos que cumplan con dichas condiciones podrán ser alterados. Con los cursores podremos trabajar 
	con cada uno de los elementos (filas) de nuestra consulta sin tener que obtener nuevos conjuntos. Esto nos permitirá ser mucho más flexibles al momento 
	de manipular la información.
	
	Para nosotros poder hacer uso de un cursor será necesario seguir los siguientes pasos:

	- Crear un cursor a partir de una sentencia SQL.
	- Apertura del cursor.
	- Acceso a datos.
	- Cierre del cursor.
	
	Es importante mencionar que en MySQL los cursores solo podrán ser utilizados dentro de stored procedures.
	
	Ejemplo:
	
	1) Crear un stored procedure el cual incremente en 10 el número de páginas de cada libro (tabla libros). En consola debemos visualizar el título, el 
	anterior número de páginas y el actual número de páginas de cada libro.
	
	Bien, este ejemplo nos permitirá comprender de una mejor manera el uso de cursores.
*/

	-- Veamos como pudiese quedar nuestro stored procedure:
	
	DELIMITER //
	DROP PROCEDURE IF EXISTS aumentar_paginas_sp//
	CREATE PROCEDURE aumentar_paginas_sp()
	BEGIN

	  DECLARE var_id INTEGER;
	  DECLARE var_paginas INTEGER;
	  DECLARE var_titulo VARCHAR(255);
	  DECLARE var_final INTEGER DEFAULT 0;

	  DECLARE cursor1 CURSOR FOR SELECT libro_id, titulo, paginas FROM libros;

	  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;

	  OPEN cursor1;

	  bucle: LOOP

		FETCH cursor1 INTO var_id, var_titulo, var_paginas;

		IF var_final = 1 THEN
		  LEAVE bucle;
		END IF;

		UPDATE libros SET paginas = var_paginas + 10 WHERE libro_id = var_id;

		SELECT
		  var_titulo AS  'titulo',
		  var_paginas AS 'Anterior',
		  paginas AS 'Incremento'
		  FROM libros WHERE libro_id = var_id;


	  END LOOP bucle;
	  CLOSE cursor1;

	END//
	DELIMITER ;

/*
	Dentro del stored procedure lo primero que hacemos es declarar todas las variables que usaremos. En este caso como trabajaremos con el título 
	y el número de páginas de cada libro declaró tres nuevas variables. var_id, var_paginas, var_titulo.
	
	Para tener un control sobre la iteración de cada uno de los elementos en la consulta declaró una cuarta variable llamada var_final, cuyo valor 
	comienza en 0.
	
	Una vez hemos declarado todas las variables procedemos a crear nuestro cursor. El cursor se creará a partir de una consulta SQL. En este caso la 
	consulta no es demasiado compleja, sin embargo, si así lo deseamos podemos crear un cursos a partir de una consulta con joins, order, group etc...

*/
	-- Con la sentencia:
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
	
	-- Indicamos que una vez todos los elementos (filas) dentro de nuestro cursor hayan sido iterados la variable var_final tomará un nuevo valor, de 0 a 1.
	
	-- Para comenzar la iteración de los elementos será necesario abrir el cursor:
	
	OPEN cursor1;
	
	-- La iteración la logramos utilizando un Loop, el cual será controlado a partir de la variable var_final:
	
	 IF var_final = 1 THEN
            -- Si ya no existen más elementos finalizamos el ciclo.
      LEAVE bucle;
    END IF;
	
/*	
	Al nosotros usar la cláusula Fetch obtenemos el elemento (fila) actual de nuestra consulta y avanzamos al siguiente elemento.

	En este caso como en nuestra consulta hemos obtenido 3 columnas (id, titulo, páginas) asignamos el valor de cada una de las columnas a nuestras
	variables. Es importante mencionar que los valores podrán ser asignados únicamente a variables del mismo tipo, no podremos asignar un varchar a una 
	variable de tipo integer.
*/
	
	-- El orden es importante:
	
	FETCH cursor1 INTO var_id, var_titulo, var_paginas;
	
	-- Una vez hemos realizado todas las tareas correspondientes y se han iterado todos los elementos (filas) el siguiente paso será cerrar el cursor:
	
	close cursor1
		
	-- Para ejecutar nuestro stored prcedure ejecutaremos la siguiente sentencia:
	
	CALL aumentar_paginas_sp();
	

	-- RESPALDO DE INFORMACIÓN
	
	-- En MySQL nosotros podemos realizar respaldos de nuestra información, para ello, utilizaremos la aplicación mysqldump.

	-- Si queremos realizar el respaldo de una sola base de datos ejecutaremos el siguiente comando en nuestra terminal:
	
	#	mysqldump base_de_datos > ruta/archivo_respaldo.sql
	#	mysqldump libreria_jc > D:/1/archivo_respaldo.sql -u root -p
	
	-- Si lo que necesitamos es realizar el respaldo de múltiples base de datos, modificaremos nuestro comando, agregando --databases:
	
	#	mysqldump -- databases db1 db2 db3 > ruta/archivo_respaldo.sql
	#	mysqldump -- databases libreria_jc world > D:/1/archivo_respaldo.sql -u root -p
	
	-- Separaremos las base de datos mediante un espacio.
	
	-- Si lo que necesitamos es realizar el respaldo de una o múltiples tablas el comando será el siguiente:
	
	-- Para una sola tabla:
	
	#	mysqldump base_de_datos tabla1 > ruta/archivo_respaldo.sql
	#	mysqldump libreria_jc autores > D:/1/archivo_respaldo.sql -u root -p
	
	-- Para múltiples tablas:
	
	#	mysqldump base_de_datos tabla1 tabla3 > ruta/archivo_respaldo.sql
	#	mysqldump libreria_jc libros autores > D:/1/archivo_respaldo.sql -u root -p
	
/*
	Asignar permisos a usuarios MySQL
	
	Cómo mencionamos anteriormente: el servidor de base de datos permite que más de un usuario pueda trabajar con los recursos del 
	servidor (registros, tablas, bases de datos, funciones, etc..).

	Hasta este punto del curso, todos los ejercicios los hemos realizado utilizando el usuario root.

	Si nosotros somos los únicos administradores del servidor (algo que muy pocas veces sucede) no deberíamos tener problemas en seguir utilizando 
	root, sin embargo, si más personas trabajarán con el servidor, será necesario que generemos nuevos usuarios y asignemos los permisos pertinentes.
*/

	-- AGREGAR NUEVOS USUARIOS
	
	-- Para que nosotros generemos un nuevo usuario lo primero que debemos de hacer es autenticarnos en el servidor:
	
	#	mysql -u root -p -h localhost<ip>
	#	mysql -u root -p -h localhost
	
	-- Posteriormente debemos de generar un nuevo Usuario, Para esto ejecutamos las siguiente sentencia:
	
	CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'password';
	CREATE USER 'jc'@'localhost' IDENTIFIED BY 'password%%';
	
	-- Hasta este punto, nosotros ya podemos autenticarnos con el servidor utilizando el nuevo usuario, sin embargo, una vez autenticado las acciones 
	-- que podemos hacer son mínimas, debido a que este usuario no posee los permisos necesarios para trabajar con las bases de datos.
	
	-- ASIGNAR PERMISOS
	
	-- Para poder establecer permisos, las siguiente sentencias deben de ejecutarse utilizando el usuario root.
	
	-- Si queremos que el nuevo usuario tenga permisos de administrador (Todos los permisos), debemos de ejecutar la siguiente sentencia:
	GRANT ALL PRIVILEGES ON *.* TO 'nombre_usuario'@'localhost';
	GRANT ALL PRIVILEGES ON *.* TO 'jc'@'localhost';
	
	-- Los asteriscos indican que los permisos serán asignados a todas las bases de datos y a todas las tablas (primer asteriscos bases de datos, 
	-- segundo asterisco tablas).

	-- Si queremos asignar permisos para ciertas acciones, la sentencia quedaría de la siguiente manera. Reemplazamos ALL PRIVILEGES y colocamos 
	-- las acciones que queremos asignar:
	
	GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP
    -> ON libreria_jc.*
    -> TO 'nombre_usuario'@'localhost';
	
/*	
	En esta ocasión estamos indicando que el nuevo usuario podrá consultar, crear, actualizar y eliminar registros, así cómo podrá crear o 
	eliminar elementos (tablas, índices, columnas, funciones, stores, etc ...).
	
	Todos estos permisos serán válidos únicamente en la base de datos libreria_jc y se aplicarán a todas las tablas.
	
	Si queremos asignar permisos únicamente a una tabla, reemplazamos el asteriscos por el nombre de la tabla.
	
	Ejemplo:
	
	libreria_jc.usuarios
*/

	-- Una vez hayamos finalizado con los permisos, el último paso será refrescarlos:
	FLUSH PRIVILEGES;
	
/*
	PERMISOS
	
	Aquí un listado de algunos permisos que podemos asignar:

	- CREATE permite crear nuevas tablas o bases de datos.
	- DROP permite eliminar tablas o bases de datos.
	- DELETE permite eliminar registros de tablas.
	- INSERT permite insertar registros en tablas.
	- SELECT permite leer registros en las tablas.
	- UPDATE permite actualizar registros en las tablas.
	- GRANT OPTION permite remover permisos de usuarios.
	- SHOW DATABASE Permite listar las bases de datos existentes.
*/

	-- SENTENCIAS A TENER EN CUENTA
	
	-- Listado de todos los usuarios:
	
	SELECT User FROM mysql.user;
	
	-- Remover permisos en concreto (Ejemplo update y delete):
	
	REVOKE UPDATE, DELETE ON *.* FROM 'usuario'@'localhost';
	REVOKE UPDATE, DELETE ON *.* FROM 'jc'@'localhost';
	
	-- Remover todos los privilegios:
	
	REVOKE ALL PRIVILEGES ON *.* FROM 'usuario'@'localhost';
	REVOKE ALL PRIVILEGES ON *.* FROM 'jc'@'localhost';
	
	-- Eliminar un usuario:
	
	DROP USER 'usuario'@'localhost';
	DROP USER 'jc'@'localhost';
*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Triggers Mysql:
	
	Un trigger, también conocido como disparador (Por su traducción al español) es un conjunto de sentencias SQL las cuales se ejecutan de forma automática 
	cuando ocurre algún evento que modifique a una tabla. Pero no me refieró a una modificación de estructura, no, me refiero a una modificación en cuando 
	a los datos almacenados, es decir, cuando se ejecute una sentencia INSERT, UPDATE o DELETE.
	
	A diferencia de una función o un store procedure, un trigger no puede existir sin una tabla asociada.
	
	Lo interesante aquí es que podemos programar los triggers de tal manera que se ejecuten antes o después, de dichas sentencias; Dando como resultado 
	seis combinaciones de eventos:
	
	-> BEFORE INSERT Acciones a realizar antes de insertar uno más o registros en una tabla.
	-> AFTER INSERT Acciones a realizar después de insertar uno más o registros en una tabla.
	-> BEFORE UPDATE Acciones a realizar antes de actualizar uno más o registros en una tabla.
	-> AFTER UPDATE Acciones a realizar después de actualizar uno más o registros en una tabla.
	-> BEFORE DELETE Acciones a realizar antes de eliminar uno más o registros en una tabla.
	-> AFTER DELETE Acciones a realizar después de eliminar uno más o registros en una tabla.
	
	A partir de la versión 5.7.2 de MySQL podemos tener la n cantidad de triggers asociados a una tabla. Anteriormente estábamos limitados a tener 
	un máximo de seis trigger por tabla (Uno por cada combinación evento).
	
	Podemos ver esto como una relación uno a muchos, una tabla puede poseer muchos triggers y un trigger le pertenece única y exclusivamente a una tabla.
	
	Algo importante a mencionar es que la sentencia TRUNCATE no ejecutará un trigger.
	
	VENTAJAS DE UTILIZAR TRIGGERS:
	
	-> Con los triggers seremos capaces de validar todos aquellos valores los cuales no pudieron ser validados mediante un constraints, asegurando así la 
	integreidad de los datos.
	-> Los triggers nos permitirán ejecutar reglas de negocios.
	-> Utilizando la combinación de eventos nosotros podemos realizar acciones sumamente complejas.
	-> Los trigger nos permitirán llevar un control de los cambios realizados en una tabla. Para esto nos debemos de apoyar de una segunda tabla (Comúnmente
	una tabla log).
	
	DESVENTAJAS DE UTILIZAR TRIGGERS:
	
	-> Los triggers al ejecutarse de forma automática puede dificultar llevar un control sobre qué sentencias SQL fueron ejecutadas.
	-> Los triggers incrementa la sobrecarga del servidor. Un mal uso de triggers puede tornarse en respuestas lentas por parte del servidor.
*/

-- Creacion de Triggers:

-- nomenclatura tiempo_evento_accion_tg

DELIMITER //
CREATE TRIGGER after_insert_actualizacion_libros_tg
AFTER INSERT ON libros
FOR EACH ROW
BEGIN
	UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_delete_actualizacion_libros_tg
AFTER DELETE ON libros
FOR EACH ROW
BEGIN
	UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_update_actualizacion_libros
AFTER UPDATE ON libros
FOR EACH ROW
BEGIN
	IF(NEW.autor_id != OLD.autor_id) THEN
		UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
        UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
    END IF;
END//
DELIMITER ;

-- Consultar Triggers:
SHOW TRIGGERS;

-- Eliminar Triggers:
DROP TRIGGER IF EXISTS libreria_jc.after_update_actualizacion_libros;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------