-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: quotes
-- ------------------------------------------------------
-- Server version	5.5.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`quote_id`),
  KEY `fk_favorites_users1_idx` (`user_id`),
  KEY `fk_favorites_quotes1_idx` (`quote_id`),
  CONSTRAINT `fk_favorites_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_quotes1` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (25,4,5,'2016-07-22 11:52:53','2016-07-22 11:52:53'),(32,5,6,'2016-07-22 12:32:46','2016-07-22 12:32:46'),(34,5,3,'2016-07-22 12:32:51','2016-07-22 12:32:51'),(38,2,3,'2016-07-22 12:35:39','2016-07-22 12:35:39'),(40,2,5,'2016-07-22 12:35:44','2016-07-22 12:35:44'),(42,2,6,'2016-07-22 12:35:49','2016-07-22 12:35:49'),(43,2,7,'2016-07-22 12:37:33','2016-07-22 12:37:33');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotes`
--

DROP TABLE IF EXISTS `quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `speaker` varchar(45) DEFAULT NULL,
  `quote` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_quotes_users_idx` (`user_id`),
  CONSTRAINT `fk_quotes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotes`
--

LOCK TABLES `quotes` WRITE;
/*!40000 ALTER TABLE `quotes` DISABLE KEYS */;
INSERT INTO `quotes` VALUES (1,'Will Rogers','Don\'t let yesterday use up too much of today.','2016-07-22 10:13:34','2016-07-22 10:13:34',1),(3,'Elie Wiesel','We must not see any person as an abstraction. Instead, we must see in every person a universe with its own secrets, with its own treasures, with its own sources of anguish, and with some measure of triumph.','2016-07-22 10:21:00','2016-07-22 10:21:00',1),(4,'Lou Holtz','It is not the load that breaks you down. It\'s the way you carry it.','2016-07-22 10:25:16','2016-07-22 10:25:16',1),(5,'Eleanor Roosevelt','Great minds discuss ideas; average minds discuss events; small minds discuss people. ','2016-07-22 11:01:20','2016-07-22 11:01:20',2),(6,'Ralph Waldo Emerson','To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.','2016-07-22 11:47:44','2016-07-22 11:47:44',4),(7,'Vincent Van Gogh','Great things are done by a series of small things brought together. ','2016-07-22 12:36:21','2016-07-22 12:36:21',2);
/*!40000 ALTER TABLE `quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(45) DEFAULT NULL,
  `alias` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `pw_hash` varchar(255) DEFAULT NULL,
  `dob` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Vanessa Bell','Vanessa','vanessa.bell14@gmail.com','$2b$12$g/UmtMh1iTCc103VCxzecOhZB7YfRs0cDagSeroLFfqlznrvR40uS','1991-01-01 00:00:00','2016-07-22 09:40:47','2016-07-22 09:40:47'),(2,'John Doe','John','john@john.com','$2b$12$fB1WHPLjJ2eE39bA/ojaFORgdzQ4j45dRz3qqla.BNu9F7DpIOoCC','1991-01-01 00:00:00','2016-07-22 09:43:00','2016-07-22 09:43:00'),(4,'Susie Jean','Susie','susie@susie.com','$2b$12$GV6ip7rmXO7WUAYtF8OTl.FjgiNTgpXeQ3t7TjYKQiy6oFS5s/mim','1980-09-09 00:00:00','2016-07-22 11:39:58','2016-07-22 11:39:58'),(5,'Bobby Lon','Bobby','bobby@bobby.com','$2b$12$J8f5CuL1uezDf5SXKlJrYuyJ80Z/h9W8CfyMPb6Yme03W4bYsxdg2','1972-01-12 00:00:00','2016-07-22 12:32:42','2016-07-22 12:32:42');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-22 12:39:00
