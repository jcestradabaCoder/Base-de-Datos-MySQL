/*
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
 Ejercicios 1era parte:
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

-- Obtener todos los libros escritos por autores que cuenten con un seudónimo:

SELECT autor_id, titulo FROM libros WHERE autor_id IN(
SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título de todos los libros publicados en el año actual cuyos autores poseen un pseudónimo:

SELECT autor_id, titulo, YEAR(fecha_publicacion) AS anio FROM libros 
WHERE YEAR(fecha_publicacion) = YEAR(NOW()) AND autor_id 
IN(	SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido ante de 1965:

SELECT autor_id, titulo FROM libros WHERE autor_id 
IN(SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL AND YEAR(fecha_nacimiento) < 1965);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000:

SELECT libro_id, titulo, fecha_publicacion, IF(YEAR(fecha_publicacion) < 2000, "No Disponible", "Disponible") AS descripcion FROM libros;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener la llave primaria de todos los libros cuya descripción sea diferente de Novela:

SELECT libro_id, titulo, descripcion FROM libros WHERE descripcion NOT LIKE LOWER("%novela%");

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título de los últimos 3 libros escritos por el autor con id 2:

SELECT libro_id, titulo FROM libros WHERE autor_id = 2 ORDER BY fecha_publicacion DESC LIMIT 3;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo:

SELECT (SELECT COUNT(*) FROM libros WHERE autor_id IN(SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL)) AS con_seudonimo,  
(SELECT COUNT(*) FROM libros WHERE autor_id IN(SELECT autor_id FROM autores WHERE seudonimo IS NULL)) AS sin_seudonimo;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005:

SELECT COUNT(*) AS libros_publicados FROM libros WHERE fecha_publicacion BETWEEN '2000-01-01'AND '2005-01-01';

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título y el número de stock de los cinco libros con más stock:

SELECT libro_id, titulo, stock FROM libros ORDER BY stock DESC LIMIT 5;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título de los libros publicados en última década:

SELECT titulo, fecha_publicacion FROM libros WHERE fecha_publicacion BETWEEN "2021-01-01" AND "2030-01-01";

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener la cantidad de libros de los autores con id 1, 2 y 3:

SELECT autor_id, COUNT(*) AS libros FROM libros WHERE autor_id = 1 OR autor_id = 2 OR autor_id = 3 GROUP BY autor_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título del libro con más páginas:

SELECT titulo, paginas FROM libros ORDER BY paginas DESC LIMIT 1;
SELECT titulo, MAX(paginas) AS paginas FROM libros;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener todos los libros cuyo título comience con la palabra “La”:

SELECT * FROM libros WHERE titulo LIKE "La%";

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”:

SELECT * FROM libros WHERE titulo LIKE "La%" AND titulo LIKE "%a";

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Establecer el stock en cero a todos los libros publicados antes del año de 1995:

UPDATE libros SET stock = 0 WHERE YEAR(fecha_publicacion) < 1995;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Mostrar el mensaje Disponible si el libro con id 1 posee más de 5 ejemplares en stock, en caso contrario mostrar el mensaje No disponible:

SELECT titulo, stock, IF(stock > 5, "Disponible", "No Disponible") AS descripcion FROM libros WHERE libro_id = 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título de los libros ordenados por fecha de publicación del más reciente al más viejo:

SELECT titulo, fecha_publicacion FROM libros ORDER BY fecha_publicacion DESC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950:

SELECT * FROM autores WHERE fecha_nacimiento > "1950-01-01";

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener la el nombre completo y la edad de todos los autores:

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, (YEAR(NOW()) - YEAR(fecha_nacimiento)) AS edad FROM autores;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005:

SELECT autor_id, CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores 
WHERE autor_id IN(
	SELECT autor_id FROM libros 
	WHERE YEAR(fecha_publicacion) > 2005 GROUP BY autor_id
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el id de todos los escritores cuyo stock de libros superen la cantidad promedio por libro:

SELECT autor_id, titulo, stock FROM libros WHERE stock > (SELECT AVG(stock) FROM libros);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el id de todos los escritores cuyo stock de libros sean mayores a 7 libros:

SELECT autor_id, titulo, stock FROM libros WHERE stock > 7;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
* Crear una función la cual nos permita saber si un libro es candidato a préstamo o no. Retornar “Disponible”
* si el libro posee por lo menos un ejemplar en stock, en caso contrario retornar “No disponible.”:
*/

USE libreria_jc;
DROP FUNCTION IF EXISTS verificar_prestamo;

DELIMITER $$
USE libreria_jc $$
CREATE FUNCTION verificar_prestamo(stock INT)
RETURNS VARCHAR(25)
DETERMINISTIC
BEGIN
	SET @msg_stock = (IF(stock = 0, "No Disponible", "Disponible"));
	RETURN @msg_stock;
END$$

DELIMITER ;

SELECT titulo, stock, verificar_prestamo(stock) FROM libros;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------