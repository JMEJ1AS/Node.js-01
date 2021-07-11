# ************************************************************
# Sequel Pro SQL dump
# Versión 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: xxx.xxx.xxx.xxx (MySQL 5.5.5-10.3.29-MariaDB-0ubuntu0.20.04.1)
# Base de datos: support
# Tiempo de Generación: 2021-07-10 00:13:54 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Volcado de tabla correos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `correos`;

CREATE TABLE `correos` (
  `correos_uuid` varchar(36) NOT NULL DEFAULT '',
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `imapID` int(11) NOT NULL,
  `fromaddr` varchar(100) NOT NULL DEFAULT '',
  `destinatario` varchar(100) NOT NULL DEFAULT '',
  `asunto` varchar(100) DEFAULT '',
  `cuerpo` text DEFAULT NULL,
  `iniciales` varchar(5) NOT NULL DEFAULT '',
  `etiqueta` varchar(25) DEFAULT '',
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`correos_uuid`),
  UNIQUE KEY `numero` (`numero`),
  UNIQUE KEY `imapID` (`imapID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `correos` WRITE;
/*!40000 ALTER TABLE `correos` DISABLE KEYS */;

INSERT INTO `correos` (`correos_uuid`, `numero`, `imapID`, `fromaddr`, `destinatario`, `asunto`, `cuerpo`, `iniciales`, `etiqueta`, `fecha`)
VALUES
	('2847ee3c-a38b-11eb-9b8c-02001700e552',7,42,'remitente-1@algo.cl','Remitente 1 <remitente-1@algo.cl>','Prueba 1','Cuerpo Prueba 1','MA','warning','2021-04-22 13:52:29'),
	('570c7cf8-a38b-11eb-9b8c-02001700e552',14,43,'remitente-2@algo.cl','Remitente 2 <remitente-2@algo.cl>','Prueba 2','Cuerpo Prueba 2','MA','info','2021-04-22 13:53:38'),
	('61e5d2dc-a38c-11eb-9b8c-02001700e552',71,47,'remitente-3@algo.cl','Remitente 2 <remitente-3@algo.cl>','Prueba 3','Cuerpo Prueba 3','JM','info','2021-04-22 14:01:13');

/*!40000 ALTER TABLE `correos` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `pass` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `user`, `name`, `rol`, `pass`)
VALUES
	(1,'admin','admin','admin','$2a$08$RsxPpmJ7kSrgJfbKc/vs/ekr2GIdq4ICh7TbBWYw8QexkOnHtrddi');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
