-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: libreria_jc
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `autor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `apellido` varchar(25) NOT NULL,
  `seudonimo` varchar(50) DEFAULT NULL,
  `genero` enum('M','F') DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `pais_origen` varchar(40) NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `cantidad_libros` int DEFAULT '0',
  PRIMARY KEY (`autor_id`),
  UNIQUE KEY `seudonimo` (`seudonimo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'Joanne','Rowling','J.K. Rowling','F','1965-07-31','Reino Unido','2022-02-03 12:30:01',0),(2,'Stephen','King','Richard Bachman','M','1947-09-21','Estados Unidos','2022-02-03 12:30:01',0),(3,'George','Orwell',NULL,'M','1903-06-25','India','2022-02-03 12:30:01',0),(4,'Jaime','Sabines',NULL,'M','1926-03-25','México','2022-02-03 12:30:01',0),(5,'José','Saramago',NULL,'M','1922-11-16','Portugal','2022-02-03 12:30:01',0),(6,'Mario','Benedetti',NULL,'M','1920-09-14','Uruguay','2022-02-03 12:30:01',0),(7,'Benjamin','Graham',NULL,'M','1894-05-09','Reino Unido','2022-02-03 12:30:01',0),(9,'Charles','Bukowski',NULL,'M','1894-05-09','Alemania','2022-02-03 12:30:01',0);
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `lib_mas_prestamos_7d_vw`
--

DROP TABLE IF EXISTS `lib_mas_prestamos_7d_vw`;
/*!50001 DROP VIEW IF EXISTS `lib_mas_prestamos_7d_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `lib_mas_prestamos_7d_vw` AS SELECT 
 1 AS `titulo`,
 1 AS `num_prestamo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `libro_id` int unsigned NOT NULL AUTO_INCREMENT,
  `autor_id` int unsigned NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `paginas` int unsigned DEFAULT NULL,
  `fecha_publicacion` date NOT NULL,
  `stock` int unsigned DEFAULT '0',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`libro_id`),
  KEY `autor_id` (`autor_id`),
  CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`autor_id`) ON DELETE CASCADE,
  CONSTRAINT `libros_ibfk_2` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`autor_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,1,'Harry Potter y la piedra filosofal','Novela',250,'1997-06-26',3,'2022-02-03 13:00:59'),(2,2,'IT','Novela, Terror',1514,'1986-09-15',4,'2022-02-03 13:00:59'),(3,3,'Rebelión en la granja','Novela en clave',122,'1945-08-17',3,'2022-02-03 13:00:59'),(4,4,'Poesía amorosa','Poesía',178,'2018-10-15',2,'2022-02-03 13:00:59'),(5,5,'Ensayo sobre la ceguera','Novela, Alegoría',386,'1995-01-01',4,'2022-02-03 13:00:59'),(6,6,'Antología poética','Poesía',330,'2011-07-14',9,'2022-02-03 13:00:59'),(7,7,'El inversor inteligente','Inversiones',650,'1949-01-01',3,'2022-02-03 13:00:59'),(8,1,'Harry Potter y la cámara secreta','Novela',261,'1998-07-02',7,'2022-02-03 13:00:59'),(9,1,'Harry Potter y el prisionero de Azkaban','Novela',346,'1999-07-08',7,'2022-02-03 13:00:59'),(10,1,'Harry Potter y el cáliz de fuego','Novela',646,'2000-07-08',4,'2022-02-03 13:00:59'),(11,1,'Harry Potter y la orden del fénix','Novela',938,'2003-06-21',8,'2022-02-03 13:00:59'),(12,1,'Harry Potter y el misterio del príncipe','Novela',617,'2005-07-16',7,'2022-02-03 13:00:59'),(13,1,'Harry Potter y las reliquias de la muerte','Novela',617,'2007-07-21',0,'2022-02-03 13:00:59'),(14,2,'El resplandor','Novela, Terror',698,'1977-01-28',1,'2022-02-03 13:00:59'),(15,2,'Doctor sueño','Novela, Terror',541,'2013-09-24',5,'2022-02-03 13:00:59'),(16,2,'Carrie','Novela, Terror',266,'1974-04-05',2,'2022-02-03 13:00:59'),(17,9,'La senda del perdedor','Novela autobiográfica',298,'1982-09-01',5,'2022-02-03 13:00:59');
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_actualizacion_libros_tg` AFTER INSERT ON `libros` FOR EACH ROW BEGIN
	UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_actualizacion_libros_tg` AFTER DELETE ON `libros` FOR EACH ROW BEGIN
	UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `libros_sin_prestamo_vw`
--

DROP TABLE IF EXISTS `libros_sin_prestamo_vw`;
/*!50001 DROP VIEW IF EXISTS `libros_sin_prestamo_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `libros_sin_prestamo_vw` AS SELECT 
 1 AS `libro_id`,
 1 AS `titulo`,
 1 AS `num_prestamo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libros_usuarios`
--

DROP TABLE IF EXISTS `libros_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros_usuarios` (
  `libro_id` int unsigned NOT NULL,
  `usuario_id` int unsigned NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `libro_id` (`libro_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `libros_usuarios_ibfk_1` FOREIGN KEY (`libro_id`) REFERENCES `libros` (`libro_id`),
  CONSTRAINT `libros_usuarios_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros_usuarios`
--

LOCK TABLES `libros_usuarios` WRITE;
/*!40000 ALTER TABLE `libros_usuarios` DISABLE KEYS */;
INSERT INTO `libros_usuarios` VALUES (1,1,'2022-03-10 15:07:50'),(2,1,'2022-03-10 15:07:50'),(3,1,'2022-03-10 15:07:50'),(8,3,'2022-03-10 15:08:20'),(9,3,'2022-03-10 15:08:20'),(10,3,'2022-03-10 15:08:20'),(3,2,'2022-03-16 22:44:08'),(2,3,'2022-03-16 22:48:03'),(2,3,'2022-03-16 22:51:22'),(2,3,'2022-03-16 23:34:27'),(2,2,'2022-03-16 23:56:37'),(5,3,'2022-03-17 01:06:36'),(6,3,'2022-03-17 01:25:31');
/*!40000 ALTER TABLE `libros_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `obt_lib_aut_1_vw`
--

DROP TABLE IF EXISTS `obt_lib_aut_1_vw`;
/*!50001 DROP VIEW IF EXISTS `obt_lib_aut_1_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `obt_lib_aut_1_vw` AS SELECT 
 1 AS `num_lib_aut_1`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `obtner_top5_autores_mas_prestamos_vw`
--

DROP TABLE IF EXISTS `obtner_top5_autores_mas_prestamos_vw`;
/*!50001 DROP VIEW IF EXISTS `obtner_top5_autores_mas_prestamos_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `obtner_top5_autores_mas_prestamos_vw` AS SELECT 
 1 AS `autor_id`,
 1 AS `nombre_autor`,
 1 AS `num_prestamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `prestamos_de_hoy_vw`
--

DROP TABLE IF EXISTS `prestamos_de_hoy_vw`;
/*!50001 DROP VIEW IF EXISTS `prestamos_de_hoy_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `prestamos_de_hoy_vw` AS SELECT 
 1 AS `num_prestamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `prestamos_usuarios_10_vw`
--

DROP TABLE IF EXISTS `prestamos_usuarios_10_vw`;
/*!50001 DROP VIEW IF EXISTS `prestamos_usuarios_10_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `prestamos_usuarios_10_vw` AS SELECT 
 1 AS `usuario_id`,
 1 AS `username`,
 1 AS `nombre_usuario`,
 1 AS `email`,
 1 AS `num_prestamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `prestamos_usuarios_vw`
--

DROP TABLE IF EXISTS `prestamos_usuarios_vw`;
/*!50001 DROP VIEW IF EXISTS `prestamos_usuarios_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `prestamos_usuarios_vw` AS SELECT 
 1 AS `usuario_id`,
 1 AS `username`,
 1 AS `nombre_usuario`,
 1 AS `email`,
 1 AS `num_prestamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `evento` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('','2022-03-18 14:14:54'),(NULL,'2022-03-18 14:14:54');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `top5_lib_mas_prestamos_30d_vw`
--

DROP TABLE IF EXISTS `top5_lib_mas_prestamos_30d_vw`;
/*!50001 DROP VIEW IF EXISTS `top5_lib_mas_prestamos_30d_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `top5_lib_mas_prestamos_30d_vw` AS SELECT 
 1 AS `titulo`,
 1 AS `num_prestamo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `top5_titulos_ultimos_30d_vw`
--

DROP TABLE IF EXISTS `top5_titulos_ultimos_30d_vw`;
/*!50001 DROP VIEW IF EXISTS `top5_titulos_ultimos_30d_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `top5_titulos_ultimos_30d_vw` AS SELECT 
 1 AS `libro_id`,
 1 AS `titulo`,
 1 AS `num_prestamo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `usrs_con_mas_prestamos_vw`
--

DROP TABLE IF EXISTS `usrs_con_mas_prestamos_vw`;
/*!50001 DROP VIEW IF EXISTS `usrs_con_mas_prestamos_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usrs_con_mas_prestamos_vw` AS SELECT 
 1 AS `usuario_id`,
 1 AS `username`,
 1 AS `nombre_usuario`,
 1 AS `email`,
 1 AS `num_prestamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usuario_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `apellidos` varchar(25) DEFAULT NULL,
  `username` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Juan Carlos','Estrada Barragán','jestradab','jc.estrada.ba@gmail.com','2022-03-09 17:42:04'),(2,'JC','Estrada','biosmanjc','biosmanjc@gmail.com','2022-03-09 17:42:04'),(3,'testName1','testSurname1','test1','test1@gmail.com','2022-03-10 13:24:06'),(4,'testName2','testSurname2','test2','test2@gmail.com','2022-03-10 13:24:06');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `usuarios_sin_prestamos_vw`
--

DROP TABLE IF EXISTS `usuarios_sin_prestamos_vw`;
/*!50001 DROP VIEW IF EXISTS `usuarios_sin_prestamos_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usuarios_sin_prestamos_vw` AS SELECT 
 1 AS `usuario_id`,
 1 AS `username`,
 1 AS `nombre_usuario`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `lib_mas_prestamos_7d_vw`
--

/*!50001 DROP VIEW IF EXISTS `lib_mas_prestamos_7d_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lib_mas_prestamos_7d_vw` AS select `li`.`titulo` AS `titulo`,count(`li`.`libro_id`) AS `num_prestamo` from (`libros` `li` join `libros_usuarios` `lu` on(((`li`.`libro_id` = `lu`.`libro_id`) and (`lu`.`fecha_creacion` >= (curdate() - interval 7 day))))) group by `li`.`libro_id` order by `num_prestamo` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `libros_sin_prestamo_vw`
--

/*!50001 DROP VIEW IF EXISTS `libros_sin_prestamo_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `libros_sin_prestamo_vw` AS select `li`.`libro_id` AS `libro_id`,`li`.`titulo` AS `titulo`,count(`lu`.`libro_id`) AS `num_prestamo` from (`libros` `li` left join `libros_usuarios` `lu` on((`li`.`libro_id` = `lu`.`libro_id`))) where (`lu`.`libro_id` is null) group by `li`.`libro_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `obt_lib_aut_1_vw`
--

/*!50001 DROP VIEW IF EXISTS `obt_lib_aut_1_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `obt_lib_aut_1_vw` AS select count(`li`.`libro_id`) AS `num_lib_aut_1` from (`libros` `li` join `libros_usuarios` `lu` on(((`li`.`libro_id` = `lu`.`libro_id`) and (`li`.`autor_id` = 1)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `obtner_top5_autores_mas_prestamos_vw`
--

/*!50001 DROP VIEW IF EXISTS `obtner_top5_autores_mas_prestamos_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `obtner_top5_autores_mas_prestamos_vw` AS select `li`.`autor_id` AS `autor_id`,concat(`au`.`nombre`,' ',`au`.`apellido`) AS `nombre_autor`,count(`li`.`libro_id`) AS `num_prestamos` from ((`libros` `li` join `libros_usuarios` `lu` on((`li`.`libro_id` = `lu`.`libro_id`))) join `autores` `au` on((`li`.`autor_id` = `au`.`autor_id`))) group by `au`.`autor_id` order by `num_prestamos` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prestamos_de_hoy_vw`
--

/*!50001 DROP VIEW IF EXISTS `prestamos_de_hoy_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prestamos_de_hoy_vw` AS select count(`lu`.`usuario_id`) AS `num_prestamos` from (`usuarios` `us` join `libros_usuarios` `lu` on(((`us`.`usuario_id` = `lu`.`usuario_id`) and (cast(`lu`.`fecha_creacion` as date) = curdate())))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prestamos_usuarios_10_vw`
--

/*!50001 DROP VIEW IF EXISTS `prestamos_usuarios_10_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prestamos_usuarios_10_vw` AS select `us`.`usuario_id` AS `usuario_id`,`us`.`username` AS `username`,concat(`us`.`nombre`,' ',`us`.`apellidos`) AS `nombre_usuario`,`us`.`email` AS `email`,count(`us`.`usuario_id`) AS `num_prestamos` from (`usuarios` `us` join `libros_usuarios` `lu` on(((`us`.`usuario_id` = `lu`.`usuario_id`) and (`lu`.`fecha_creacion` >= (curdate() - interval 10 day))))) group by `us`.`usuario_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prestamos_usuarios_vw`
--

/*!50001 DROP VIEW IF EXISTS `prestamos_usuarios_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prestamos_usuarios_vw` AS select `us`.`usuario_id` AS `usuario_id`,`us`.`username` AS `username`,concat(`us`.`nombre`,' ',`us`.`apellidos`) AS `nombre_usuario`,`us`.`email` AS `email`,count(`us`.`usuario_id`) AS `num_prestamos` from (`usuarios` `us` join `libros_usuarios` `lu` on(((`us`.`usuario_id` = `lu`.`usuario_id`) and (`lu`.`fecha_creacion` >= (curdate() - interval 5 day))))) group by `us`.`usuario_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `top5_lib_mas_prestamos_30d_vw`
--

/*!50001 DROP VIEW IF EXISTS `top5_lib_mas_prestamos_30d_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `top5_lib_mas_prestamos_30d_vw` AS select `li`.`titulo` AS `titulo`,count(`li`.`libro_id`) AS `num_prestamo` from (`libros` `li` join `libros_usuarios` `lu` on(((`li`.`libro_id` = `lu`.`libro_id`) and (`lu`.`fecha_creacion` >= (curdate() - interval 30 day))))) group by `li`.`libro_id` order by `num_prestamo` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `top5_titulos_ultimos_30d_vw`
--

/*!50001 DROP VIEW IF EXISTS `top5_titulos_ultimos_30d_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `top5_titulos_ultimos_30d_vw` AS select `li`.`libro_id` AS `libro_id`,`li`.`titulo` AS `titulo`,count(`li`.`libro_id`) AS `num_prestamo` from (`libros` `li` join `libros_usuarios` `lu` on(((`li`.`libro_id` = `lu`.`libro_id`) and (`lu`.`fecha_creacion` >= (curdate() - interval 30 day))))) group by `li`.`libro_id` order by `num_prestamo` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usrs_con_mas_prestamos_vw`
--

/*!50001 DROP VIEW IF EXISTS `usrs_con_mas_prestamos_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usrs_con_mas_prestamos_vw` AS select `us`.`usuario_id` AS `usuario_id`,`us`.`username` AS `username`,concat(`us`.`nombre`,' ',`us`.`apellidos`) AS `nombre_usuario`,`us`.`email` AS `email`,count(`us`.`usuario_id`) AS `num_prestamos` from (`usuarios` `us` join `libros_usuarios` `lu` on((`us`.`usuario_id` = `lu`.`usuario_id`))) group by `us`.`usuario_id` order by `num_prestamos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usuarios_sin_prestamos_vw`
--

/*!50001 DROP VIEW IF EXISTS `usuarios_sin_prestamos_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usuarios_sin_prestamos_vw` AS select `us`.`usuario_id` AS `usuario_id`,`us`.`username` AS `username`,concat(`us`.`nombre`,' ',`us`.`apellidos`) AS `nombre_usuario`,`us`.`email` AS `email` from (`usuarios` `us` left join `libros_usuarios` `lu` on((`us`.`usuario_id` = `lu`.`usuario_id`))) where (`lu`.`usuario_id` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-14 14:08:00
