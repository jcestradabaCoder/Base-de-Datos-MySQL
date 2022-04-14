DROP DATABASE IF EXISTS libreria_jc;

CREATE DATABASE IF NOT EXISTS libreria_jc;

USE libreria_jc;

CREATE TABLE IF NOT EXISTS autores(
autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
nombre VARCHAR(25)  NOT NULL,
apellido VARCHAR(25)  NOT NULL,
seudonimo VARCHAR(50)  UNIQUE,
genero ENUM('M','F'), -- M o F
fecha_nacimiento DATE NOT NULL,
pais_origen VARCHAR(40)  NOT NULL,
fecha_creacion DATETIME DEFAULT current_timestamp
);

CREATE TABLE libros(
libro_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
autor_id INT UNSIGNED NOT NULL,
titulo VARCHAR(50)  NOT NULL,
descripcion VARCHAR (250),
paginas INT UNSIGNED,
fecha_publicacion DATE NOT NULL,
stock INT UNSIGNED DEFAULT 0,
fecha_creacion DATETIME DEFAULT current_timestamp,
FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE
);

INSERT INTO autores (nombre, apellido, seudonimo,genero, fecha_nacimiento, pais_origen)
VALUES	('Joanne', 'Rowling',  "J.K. Rowling", 'F','1965-07-31', 'Reino Unido'),
		('Stephen', 'King', "Richard Bachman", 'M','1947-09-21', 'Estados Unidos'),
		('George', 'Orwell', NULL, 'M', '1903-06-25', 'India'),
		('Jaime', 'Sabines', NULL, 'M', '1926-03-25', 'México'),
		('José', 'Saramago', NULL, 'M','1922-11-16', 'Portugal'),
		('Mario', 'Benedetti', NULL, 'M','1920-09-14', 'Uruguay'),
		('Benjamin', 'Graham', NULL, 'M','1894-05-09', 'Reino Unido'),
		('Marina', 'Tsvetaeva', NULL, 'M','1941-08-31', 'Rusia'),
		('Charles', 'Bukowski', NULL, 'M','1894-05-09', 'Alemania');

INSERT INTO libros (autor_id, titulo, descripcion, paginas, fecha_publicacion)
VALUES	(1,'Harry Potter y la piedra filosofal', 'Novela', 223, '1997-06-26'),
		(2,'IT', 'Novela, Terror', 1504, '1986-09-15'),
		(3,'Rebelión en la granja', 'Novela en clave', 112, '1945-08-17'),
		(4,'Poesía amorosa', 'Poesía', 168, '2018-10-15'),
		(5,'Ensayo sobre la ceguera', 'Novela, Alegoría', 376, '1995-01-01'),
		(6,'Antología poética', 'Poesía', 320, '2011-07-14'),
		(7,'El inversor inteligente', 'Inversiones', 640, '1949-01-01'),
		(1,'Harry Potter y la cámara secreta', 'Novela', 251, '1998-07-02'),
		(1,'Harry Potter y el prisionero de Azkaban', 'Novela', 336, '1999-07-08'),
		(1,'Harry Potter y el cáliz de fuego', 'Novela', 636, '2000-07-08'),
		(1,'Harry Potter y la orden del fénix', 'Novela', 928, '2003-06-21'),
		(1,'Harry Potter y el misterio del príncipe', 'Novela', 607, '2005-07-16'),
		(1,'Harry Potter y las reliquias de la muerte', 'Novela', 607, '2007-07-21'),		
		(2,'El resplandor', 'Novela, Terror', 688, '1977-01-28'),
		(2,'Doctor sueño', 'Novela, Terror', 531, '2013-09-24'),
		(2,'Carrie', 'Novela, Terror', 256, '1974-04-05'),
		(8,'Antología poética', 'Poesía', 199, '2019-07-11'),
		(9,'La senda del perdedor', 'Novela autobiográfica', 288, '1982-09-01');
		
SELECT * FROM autores;
SELECT * FROM libros;

CREATE TABLE usuarios(
	usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	apellidos VARCHAR(25),
	username VARCHAR(25) NOT NULL,
	email VARCHAR(50) NOT NULL,
	fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios(nombre, apellidos, username, email) 
VALUES ('Juan Carlos', 'Estrada Barragán','jestradab','jc.estrada.ba@gmail.com'),
	   ('JC', 'Estrada','biosmanjc','biosmanjc@gmail.com');
	   

CREATE TABLE libros_usuarios(
	libro_id INT UNSIGNED NOT NULL,
	usuario_id INT UNSIGNED NOT NULL,

	FOREIGN KEY (libro_id) REFERENCES libros(libro_id),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
	fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO libros_usuarios(libro_id, usuario_id) 
VALUES(1,1), (2,1), (3,1);

INSERT INTO usuarios(nombre, apellidos, username, email) 
VALUES ('testName1', 'testSurname1','test1','test1@gmail.com'),
	   ('testName2', 'testSurname2','test2','test2@gmail.com');

INSERT INTO libros_usuarios(libro_id, usuario_id) 
VALUES(8,3), (9,3), (10,3);

ALTER TABLE autores ADD COLUMN cantidad_libros INT DEFAULT 0;

INSERT INTO libros (autor_id, titulo, descripcion, paginas, fecha_publicacion)
VALUES (2,'Area 81', 'Novela, Terror', 67, '2011-09-01');