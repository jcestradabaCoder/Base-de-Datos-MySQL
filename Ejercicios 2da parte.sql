/*
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
 Ejercicios 2da parte:
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

-- Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días:

CREATE OR REPLACE VIEW prestamos_usuarios_10_vw AS
SELECT 
us.usuario_id,
us.username, 
CONCAT(us.nombre, " ", us.apellidos) AS nombre_usuario,
us.email,
COUNT(us.usuario_id) AS num_prestamos
FROM usuarios AS us
INNER JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id AND lu.fecha_creacion >= CURDATE() - INTERVAL 10 DAY
GROUP BY us.usuario_id;

SELECT * FROM prestamos_usuarios_10_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener a todos los usuarios que no ha realizado ningún préstamo:

CREATE OR REPLACE VIEW usuarios_sin_prestamos_vw AS
SELECT
us.usuario_id,
us.username,
CONCAT(us.nombre, " ", us.apellidos) AS nombre_usuario,
us.email
FROM usuarios AS us
LEFT JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id
WHERE lu.usuario_id IS NULL;

SELECT * FROM usuarios_sin_prestamos_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Listar de forma descendente a los cinco usuarios con más préstamos:

CREATE OR REPLACE VIEW usrs_con_mas_prestamos_vw AS
SELECT
us.usuario_id,
us.username,
CONCAT(us.nombre, " ", us.apellidos) AS nombre_usuario,
us.email,
COUNT(us.usuario_id) AS num_prestamos
FROM usuarios AS us
INNER JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id
GROUP BY us.usuario_id ORDER BY num_prestamos DESC;

SELECT * FROM usrs_con_mas_prestamos_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Listar 5 títulos con más préstamos en los últimos 30 días:

CREATE OR REPLACE VIEW top5_lib_mas_prestamos_30d_vw AS
SELECT li.titulo,
COUNT(li.libro_id) AS num_prestamo
FROM libros AS li
INNER JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id AND lu.fecha_creacion >= CURDATE() - INTERVAL 30 DAY
GROUP BY li.libro_id ORDER BY num_prestamo DESC LIMIT 5;

SELECT * FROM top5_lib_mas_prestamos_30d_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título de todos los libros que no han sido prestados:

CREATE OR REPLACE VIEW libros_sin_prestamo_vw AS
SELECT
li.libro_id,
li.titulo,
COUNT(lu.libro_id) AS num_prestamo
FROM libros AS li
LEFT JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id 
WHERE lu.libro_id IS NULL
GROUP BY libro_id;

SELECT * FROM libros_sin_prestamo_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener la cantidad de libros prestados el día de hoy:

CREATE OR REPLACE VIEW prestamos_de_hoy_vw AS
SELECT 
COUNT(lu.usuario_id) AS num_prestamos
FROM usuarios AS us
INNER JOIN libros_usuarios AS lu ON us.usuario_id = lu.usuario_id AND DATE(lu.fecha_creacion) = CURDATE();

SELECT * FROM prestamos_de_hoy_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener la cantidad de libros prestados por el autor con id 1:

CREATE OR REPLACE VIEW obt_lib_aut_1_vw AS
SELECT 
COUNT(li.libro_id) AS num_lib_aut_1
FROM libros AS li
INNER JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id AND li.autor_id = 1;

SELECT * FROM obt_lib_aut_1_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el nombre completo de los cinco autores con más préstamos:

CREATE OR REPLACE VIEW obtner_top5_autores_mas_prestamos_vw AS
SELECT
li.autor_id,
CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
COUNT(li.libro_id) AS num_prestamos
FROM libros AS li
INNER JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id
INNER JOIN autores AS au ON li.autor_id = au.autor_id
GROUP BY au.autor_id ORDER BY num_prestamos DESC LIMIT 5;

SELECT * FROM obtner_top5_autores_mas_prestamos_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Obtener el título del libro con más préstamos esta semana:
CREATE OR REPLACE VIEW lib_mas_prestamos_7d_vw AS
SELECT li.titulo,
COUNT(li.libro_id) AS num_prestamo
FROM libros AS li
INNER JOIN libros_usuarios AS lu ON li.libro_id = lu.libro_id AND lu.fecha_creacion >= CURDATE() - INTERVAL 7 DAY
GROUP BY li.libro_id ORDER BY num_prestamo DESC LIMIT 1;

SELECT * FROM lib_mas_prestamos_7d_vw;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------