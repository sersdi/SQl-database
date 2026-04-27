-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: telegram
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `channel_message_reactions`
--

DROP TABLE IF EXISTS `channel_message_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_message_reactions` (
  `reaction_id` bigint unsigned NOT NULL,
  `message_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `reaction_id` (`reaction_id`),
  KEY `message_id` (`message_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `channel_message_reactions_ibfk_1` FOREIGN KEY (`reaction_id`) REFERENCES `reactions_list` (`id`),
  CONSTRAINT `channel_message_reactions_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `channel_messages` (`id`),
  CONSTRAINT `channel_message_reactions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_message_reactions`
--

LOCK TABLES `channel_message_reactions` WRITE;
/*!40000 ALTER TABLE `channel_message_reactions` DISABLE KEYS */;
INSERT INTO `channel_message_reactions` VALUES (1,1,1,'2023-10-17 17:41:48'),(2,2,2,'1989-05-27 12:45:43'),(3,3,3,'2020-05-31 09:36:56'),(4,4,4,'1983-02-02 19:00:28'),(5,5,5,'1975-11-18 20:29:05');
/*!40000 ALTER TABLE `channel_message_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_messages`
--

DROP TABLE IF EXISTS `channel_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint unsigned NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
  `media_type` enum('text','image','audio','video') DEFAULT NULL,
  `body` text,
  `filename` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `channel_messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `channel_messages_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_messages`
--

LOCK TABLES `channel_messages` WRITE;
/*!40000 ALTER TABLE `channel_messages` DISABLE KEYS */;
INSERT INTO `channel_messages` VALUES (1,1,1,'audio','Eum nam est quia distinctio pariatur. Aperiam possimus ut et et saepe voluptas facilis saepe. Et qui sit nostrum quis quis deserunt.','reiciendis','2002-07-01 09:50:57'),(2,2,2,'text','Placeat et quia voluptatem eos accusamus quia suscipit. Inventore officiis quam et deserunt doloribus. Voluptas et dolores porro ad nostrum.','consequatur','1989-02-14 18:13:35'),(3,3,3,'text','Doloribus fugit aut et occaecati corrupti repellat et. Autem nihil laudantium vitae. Ex nulla dicta atque repellat a dolor ipsa exercitationem.','non','2002-05-16 03:45:02'),(4,4,4,'video','Suscipit sint voluptate modi. Rem architecto ratione omnis tempora.','aut','1974-04-29 13:24:43'),(5,5,5,'image','Unde praesentium eos rem aliquam est reiciendis quae blanditiis. Explicabo error et adipisci nihil dignissimos. Porro amet adipisci ipsa aliquid quis ex sapiente.','aut','1972-06-28 20:35:27');
/*!40000 ALTER TABLE `channel_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_subscribers`
--

DROP TABLE IF EXISTS `channel_subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_subscribers` (
  `channel_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `status` enum('requested','joined','left') DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  KEY `user_id` (`user_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `channel_subscribers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `channel_subscribers_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_subscribers`
--

LOCK TABLES `channel_subscribers` WRITE;
/*!40000 ALTER TABLE `channel_subscribers` DISABLE KEYS */;
INSERT INTO `channel_subscribers` VALUES (1,1,'requested','1992-08-16 12:30:06','1981-03-10 14:15:04'),(1,2,'joined','1982-08-14 20:24:05','2003-03-10 12:40:06'),(1,3,'joined','2023-02-16 18:02:53','2002-12-02 06:56:50'),(1,4,'joined','1979-02-21 12:06:24','2009-01-12 10:05:06'),(1,5,'joined','1985-05-17 09:51:01','2003-08-08 11:46:55');
/*!40000 ALTER TABLE `channel_subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `invite_link` varchar(100) DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `owner_user_id` bigint unsigned NOT NULL,
  `is_private` bit(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `owner_user_id` (`owner_user_id`),
  CONSTRAINT `channels_ibfk_1` FOREIGN KEY (`owner_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels`
--

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
INSERT INTO `channels` VALUES (1,'Et sunt aut soluta ex.','eveniet','http://huel.com/',NULL,1,_binary '\0','1979-05-18 00:38:14'),(2,'In cumque aut deleniti enim culpa.','libero','http://www.lednerraynor.com/',NULL,2,_binary '','1975-08-30 21:00:37'),(3,'Dolorum repellat sequi excepturi commodi qui ','quia','http://ortizzboncak.com/',NULL,3,_binary '','1975-04-06 12:37:26'),(4,'Illo sit minus sunt.','nihil','http://www.tillman.com/',NULL,4,_binary '','1973-11-13 20:22:22'),(5,'Dolor sed consequuntur aperiam.','culpa','http://www.grant.com/',NULL,5,_binary '\0','2012-12-29 18:27:20');
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_members`
--

DROP TABLE IF EXISTS `group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` VALUES (1,1,1,'1993-04-24 22:38:10'),(2,2,2,'1988-12-17 18:06:23'),(3,3,3,'1974-12-02 13:18:28'),(4,4,4,'2006-07-06 03:52:44'),(5,5,5,'1978-11-07 21:26:52');
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_message_reactions`
--

DROP TABLE IF EXISTS `group_message_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_message_reactions` (
  `reaction_id` bigint unsigned NOT NULL,
  `message_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `reaction_id` (`reaction_id`),
  KEY `message_id` (`message_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `group_message_reactions_ibfk_1` FOREIGN KEY (`reaction_id`) REFERENCES `reactions_list` (`id`),
  CONSTRAINT `group_message_reactions_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `group_messages` (`id`),
  CONSTRAINT `group_message_reactions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_message_reactions`
--

LOCK TABLES `group_message_reactions` WRITE;
/*!40000 ALTER TABLE `group_message_reactions` DISABLE KEYS */;
INSERT INTO `group_message_reactions` VALUES (1,1,1,'1979-01-24 20:23:12'),(1,2,1,'2019-07-26 12:05:10'),(1,3,2,'1972-07-11 06:01:18'),(6,4,4,'2019-01-30 09:54:14'),(7,5,5,'1985-06-05 13:19:07');
/*!40000 ALTER TABLE `group_message_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_messages`
--

DROP TABLE IF EXISTS `group_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint unsigned NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
  `reply_to_id` bigint unsigned DEFAULT NULL,
  `media_type` enum('text','image','audio','video') DEFAULT NULL,
  `body` text,
  `filename` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `group_id` (`group_id`),
  KEY `reply_to_id` (`reply_to_id`),
  CONSTRAINT `group_messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `group_messages_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `group_messages_ibfk_3` FOREIGN KEY (`reply_to_id`) REFERENCES `group_messages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_messages`
--

LOCK TABLES `group_messages` WRITE;
/*!40000 ALTER TABLE `group_messages` DISABLE KEYS */;
INSERT INTO `group_messages` VALUES (1,1,2,NULL,'audio','Maiores veritatis quod vitae ut cum. Aut et fugiat omnis minima id a commodi. Dolor iure magni dolor exercitationem rerum dolores aspernatur labore.','sapiente','2000-06-28 15:12:12'),(2,1,3,1,'video','Autem eveniet et et dolore quisquam et. Deserunt rem ut qui officiis explicabo.','ea','2019-09-22 17:52:45'),(3,1,4,2,'image','Et rerum ex ex provident perferendis. Molestiae voluptas ut et consequuntur. Ut hic quibusdam omnis voluptatum adipisci.','id','1977-03-21 06:23:09'),(4,1,5,3,'image','Reprehenderit eius consequuntur officiis iusto delectus. Dolorem veritatis asperiores consequatur aut rerum nostrum eum. Qui molestias dignissimos nisi nemo eveniet. Laborum nihil et ut quia et dolorem ut consequatur.','reprehenderit','2017-09-21 04:14:41'),(5,1,2,NULL,'video','Animi nostrum fugiat quidem cumque et itaque qui. Cum omnis cum corporis quia corporis eveniet. Temporibus vel sapiente laboriosam sequi voluptatem et sit cum. Est eaque modi esse sint.','dolorem','2014-06-25 09:33:54'),(6,1,2,5,'video','Velit quidem cum officiis aperiam. Qui id pariatur amet corrupti. Sit laudantium quasi minus vitae. Accusantium dolores inventore ut sit recusandae qui aut.','esse','1979-01-19 00:26:52'),(7,1,3,6,'video','Quisquam et molestiae nobis vel molestiae sint. Itaque recusandae nam magni molestiae dolores nihil. Et recusandae sed suscipit. Aut nisi omnis tempora quas sit quia ut.','amet','1998-06-24 13:39:41'),(8,1,4,NULL,'image','Aspernatur quod est ut ut voluptatum vitae ut. Amet ut et cumque. Aut dolor praesentium ea magnam laboriosam.','neque','2020-08-09 02:19:12'),(9,1,7,8,'text','Nesciunt dolor omnis voluptas. Occaecati consectetur debitis dolore modi sunt ab libero minus. Aut quam neque ut maiores. Id earum fugit voluptatem non doloribus atque. Quo neque non et corrupti incidunt.','ipsam','1985-10-22 08:24:52');
/*!40000 ALTER TABLE `group_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `invite_link` varchar(100) DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `owner_user_id` bigint unsigned NOT NULL,
  `is_private` bit(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `owner_user_id` (`owner_user_id`),
  CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`owner_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Sit natus qui omnis voluptatum magni commodi ','blanditiis','http://pacocha.com/',NULL,1,_binary '\0','1977-02-20 10:45:38'),(2,'Dolor beatae ut sit distinctio velit quis.','et','http://www.kuhic.com/',NULL,4,_binary '','1972-11-12 08:45:24'),(3,'Et atque est et est.','dicta','http://kozeyortiz.com/',NULL,1,_binary '\0','1983-04-11 02:27:49'),(4,'Aut et suscipit autem aperiam.','rerum','http://www.zemlak.com/',NULL,1,_binary '\0','1978-04-12 06:48:13'),(5,'Omnis hic sapiente recusandae impedit.','veniam','http://kilback.com/',NULL,3,_binary '','1986-01-15 12:06:48');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_message_reactions`
--

DROP TABLE IF EXISTS `private_message_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_message_reactions` (
  `reaction_id` bigint unsigned NOT NULL,
  `message_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `reaction_id` (`reaction_id`),
  KEY `message_id` (`message_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `private_message_reactions_ibfk_1` FOREIGN KEY (`reaction_id`) REFERENCES `reactions_list` (`id`),
  CONSTRAINT `private_message_reactions_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `private_messages` (`id`),
  CONSTRAINT `private_message_reactions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_message_reactions`
--

LOCK TABLES `private_message_reactions` WRITE;
/*!40000 ALTER TABLE `private_message_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_message_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_messages`
--

DROP TABLE IF EXISTS `private_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint unsigned DEFAULT NULL,
  `receiver_id` bigint unsigned NOT NULL,
  `reply_to_id` bigint unsigned DEFAULT NULL,
  `media_type` enum('text','image','audio','video') DEFAULT NULL,
  `body` text,
  `filename` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `reply_to_id` (`reply_to_id`),
  CONSTRAINT `private_messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `private_messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `private_messages_ibfk_3` FOREIGN KEY (`reply_to_id`) REFERENCES `private_messages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_messages`
--

LOCK TABLES `private_messages` WRITE;
/*!40000 ALTER TABLE `private_messages` DISABLE KEYS */;
INSERT INTO `private_messages` VALUES (1,1,2,NULL,'audio','Maiores veritatis quod vitae ut cum. Aut et fugiat omnis minima id a commodi. Dolor iure magni dolor exercitationem rerum dolores aspernatur labore.','sapiente','2000-06-28 15:12:12'),(2,2,3,NULL,'video','Autem eveniet et et dolore quisquam et. Deserunt rem ut qui officiis explicabo.','ea','2019-09-22 17:52:45'),(3,3,4,NULL,'image','Et rerum ex ex provident perferendis. Molestiae voluptas ut et consequuntur. Ut hic quibusdam omnis voluptatum adipisci.','id','1977-03-21 06:23:09'),(4,4,5,NULL,'image','Reprehenderit eius consequuntur officiis iusto delectus. Dolorem veritatis asperiores consequatur aut rerum nostrum eum. Qui molestias dignissimos nisi nemo eveniet. Laborum nihil et ut quia et dolorem ut consequatur.','reprehenderit','2017-09-21 04:14:41'),(5,5,2,NULL,'video','Animi nostrum fugiat quidem cumque et itaque qui. Cum omnis cum corporis quia corporis eveniet. Temporibus vel sapiente laboriosam sequi voluptatem et sit cum. Est eaque modi esse sint.','dolorem','2014-06-25 09:33:54'),(6,NULL,2,NULL,'audio','Maiores veritatis quod vitae ut cum. Aut et fugiat omnis minima id a commodi. Dolor iure magni dolor exercitationem rerum dolores aspernatur labore.','sapiente','2000-06-28 15:12:12'),(7,NULL,3,NULL,'video','Autem eveniet et et dolore quisquam et. Deserunt rem ut qui officiis explicabo.','ea','2019-09-22 17:52:45'),(8,NULL,4,NULL,'image','Et rerum ex ex provident perferendis. Molestiae voluptas ut et consequuntur. Ut hic quibusdam omnis voluptatum adipisci.','id','1977-03-21 06:23:09');
/*!40000 ALTER TABLE `private_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reactions_list`
--

DROP TABLE IF EXISTS `reactions_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reactions_list` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reactions_list`
--

LOCK TABLES `reactions_list` WRITE;
/*!40000 ALTER TABLE `reactions_list` DISABLE KEYS */;
INSERT INTO `reactions_list` VALUES (1,'👍'),(2,'👎'),(3,'🙂'),(4,'😢'),(5,'😋'),(6,'😡'),(7,'🔥'),(8,'❤'),(9,'🖐'),(10,'🙃');
/*!40000 ALTER TABLE `reactions_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_messages`
--

DROP TABLE IF EXISTS `saved_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `body` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  FULLTEXT KEY `full_body_idx` (`body`),
  CONSTRAINT `saved_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_messages`
--

LOCK TABLES `saved_messages` WRITE;
/*!40000 ALTER TABLE `saved_messages` DISABLE KEYS */;
INSERT INTO `saved_messages` VALUES (1,1,'Alias labore dolores dignissimos perferendis repellendus dolore deleniti veniam. Et eum aspernatur quo nesciunt sunt. Deserunt quia natus asperiores cum est. Qui ut voluptas cum qui.','1993-11-29 05:55:15'),(2,2,'Qui quas ea reprehenderit facere. Quia ab nemo nisi quia et vitae aut. Est quia et aut officia nam. Iure mollitia similique a. Distinctio sed sint autem cupiditate qui aspernatur.','2009-04-01 09:26:35'),(3,3,'Doloremque fugiat nesciunt cumque corrupti odio et. Cupiditate sint eum incidunt quaerat dicta similique. Alias eum sapiente odio animi. Ratione numquam aut beatae similique accusantium.','1979-01-22 21:29:46'),(4,4,'Id illum eos vero et harum cupiditate. Reprehenderit eius non nulla quibusdam. Ut ea est temporibus non nam.','1997-12-05 05:40:58'),(5,5,'Sed iusto ex tempore et est aut fuga. Eos omnis quibusdam autem. Rerum vitae expedita odit et quaerat.','1989-01-28 09:15:13');
/*!40000 ALTER TABLE `saved_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `caption` varchar(140) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `views_count` int unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `stories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` VALUES (1,1,'Velit iusto dolorem sed soluta amet.','nihil',6170,'1986-06-04 19:32:16'),(2,2,'Quibusdam sit eos ut omnis ratione.','laborum',5252869,'1977-04-06 09:19:28'),(3,3,'Corrupti praesentium quos cupiditate omnis neque veritatis reiciendis.','est',63127,'1987-07-16 03:49:04'),(4,4,'Placeat magni ut provident eos nemo distinctio.','illum',9017,'1991-07-04 04:26:14'),(5,5,'Omnis id in ut enim dolore et quisquam velit.','accusamus',50903580,'2005-10-10 23:22:18');
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories_likes`
--

DROP TABLE IF EXISTS `stories_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stories_likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `story_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `story_id` (`story_id`),
  CONSTRAINT `stories_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `stories_likes_ibfk_2` FOREIGN KEY (`story_id`) REFERENCES `stories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories_likes`
--

LOCK TABLES `stories_likes` WRITE;
/*!40000 ALTER TABLE `stories_likes` DISABLE KEYS */;
INSERT INTO `stories_likes` VALUES (1,1,1,'2002-05-24 05:07:29'),(2,2,2,'1993-10-25 10:43:17'),(3,3,3,'1987-01-16 15:01:07'),(4,4,4,'1990-08-11 22:27:55'),(5,5,5,'1990-11-17 15:19:33');
/*!40000 ALTER TABLE `stories_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `user_id` bigint unsigned NOT NULL,
  `is_premium_account` bit(1) DEFAULT NULL,
  `is_night_mode_enabled` bit(1) DEFAULT NULL,
  `color_scheme` enum('classic','day','tinted','night') DEFAULT NULL,
  `app_language` enum('english','french','russian','german','belorussian','croatian','dutch') DEFAULT NULL,
  `status_text` varchar(70) DEFAULT NULL,
  `notifications_and_sounds` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_settings_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
INSERT INTO `user_settings` VALUES (1,_binary '\0',_binary '\0','tinted','belorussian','Explicabo quod laudantium id atque eveniet numquam aut. Et sit non tem',NULL,'1987-12-07 21:42:18'),(2,_binary '',_binary '\0','day','english','Perspiciatis ipsa rerum harum enim aut. Rerum voluptates architecto co',NULL,'2022-05-26 20:28:59'),(3,_binary '',_binary '\0','classic','german','Voluptates ea voluptate non necessitatibus. Unde aut facilis dolores a',NULL,'1970-02-13 11:19:50'),(4,_binary '\0',_binary '\0','classic','russian','Aut aut rem ipsam distinctio qui. Modi harum et nesciunt hic illo. Est',NULL,'1972-12-12 09:25:45'),(5,_binary '\0',_binary '','classic','russian','Est est cupiditate blanditiis sit explicabo voluptatibus et. Quia labo',NULL,'2008-01-15 04:10:44');
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL COMMENT 'фамилия',
  `login` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(256) DEFAULT NULL,
  `phone` bigint unsigned DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `idx_users_username` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='пользователи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Fabiola','Gottlieb',NULL,'hardy42@example.com','91a2d21ceb966a9ddbc5d1e42b3880fde4840251',85374584109,'2021-04-27'),(2,'Cordelia','Schmidt',NULL,'pfeffer.julianne@example.org','5b2d07b33b4ca61bff9fdc087e71f964d23d091f',47225135553,'1989-11-18'),(3,'Elenora','Kris',NULL,'hermann.cora@example.org','4cf04ada40acc5cf77a29d290813f08485711ad0',10662280403,'1989-10-12'),(4,'Darien','Kub',NULL,'luciano.collins@example.org','e87f1063ac8b46d4e3f9ca81a15e445897d23176',42114946271,'1981-09-29'),(5,'Janae','Kovacek',NULL,'carmella97@example.org','b909da581364805b1d8b9b680dd8b4f88048bd00',43388084081,'2023-02-24'),(6,'Malinda','Hoeger',NULL,'estel86@example.net','11c13c310474fd7677bf5cc67710dfdcc9194cbe',35871010050,'2004-05-04'),(7,'Morgan','Farrell',NULL,'koby41@example.com','50b60efecfec1bffdd842c0fb027a97c0788df56',75004207760,'1972-03-21'),(8,'Aron','Zieme',NULL,'mittie.macejkovic@example.com','0f4990fd6d6515cc7d92ee08f70a9d2005cae417',75559328704,'2010-03-25'),(9,'Cristobal','Tromp',NULL,'chris.berge@example.net','26004be36bf0027f1f1c05a856c9672c21e3786d',27258759419,'1974-06-15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_user_age_before_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
	IF NEW.birthday > CURRENT_date() THEN
		SET NEW.birthday = current_date();
	END IF;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_user_age_before_update` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN 
	DECLARE message varchar(100);
	
	IF NEW.birthday > current_date() THEN
		SET message = concat ('Update has been cancelled.',
			'New value: ', NEW.birthday, ' is incorrect.'
			'Old value: ', OLD.birthday, ' retained.'
		);
		
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = message;
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `v_users_messages`
--

DROP TABLE IF EXISTS `v_users_messages`;
/*!50001 DROP VIEW IF EXISTS `v_users_messages`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_users_messages` AS SELECT 
 1 AS `uid`,
 1 AS `firstname`,
 1 AS `lastname`,
 1 AS `pmid`,
 1 AS `sender_id`,
 1 AS `body`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'telegram'
--
/*!50003 DROP FUNCTION IF EXISTS `get_premium_percentage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_premium_percentage`() RETURNS float
    READS SQL DATA
BEGIN
    DECLARE premium_users_count INT;
    DECLARE total_users_count INT;
    DECLARE _result FLOAT;    
   
    SET premium_users_count = (
        SELECT count(*)
        FROM user_settings
        WHERE is_premium_account = TRUE 
    );
   
    SET total_users_count = (
        SELECT count(*)
        FROM user_settings
    );
    
    SET _result = premium_users_count / total_users_count;
    
    RETURN _result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_user_to_channel_relation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_to_channel_relation`(_user_id bigint unsigned, _channel_id bigint unsigned) RETURNS varchar(15) CHARSET utf8mb4
    READS SQL DATA
BEGIN
	DECLARE owner_id BIGINT UNSIGNED;
	DECLARE subscriber_id BIGINT UNSIGNED;

	SELECT owner_user_id
	INTO owner_id
	FROM channels
	WHERE id = _channel_id;
	
	IF _user_id = owner_id THEN 
		RETURN 'owner';
	END IF;
	
	SELECT user_id
	INTO subscriber_id
	FROM channel_subscribers
	WHERE channel_id = _channel_id AND user_id = _user_id;
	
	IF subscriber_id THEN 
		RETURN 'subscriber';
	END IF;
	
	RETURN 'outsider';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `my_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `my_procedure`()
BEGIN
    SELECT 456;
    SELECT 456;
    SELECT 456;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `random_society` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `random_society`(cnt int)
BEGIN
    SELECT id, title , invite_link , 'channel' AS community_type
    FROM channels 
        UNION 
    SELECT id, title , invite_link , 'group' AS community_type
    FROM `groups`  
    ORDER BY rand()
    LIMIT cnt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_users_messages`
--

/*!50001 DROP VIEW IF EXISTS `v_users_messages`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_users_messages` AS select `users`.`id` AS `uid`,`users`.`firstname` AS `firstname`,`users`.`lastname` AS `lastname`,`private_messages`.`id` AS `pmid`,`private_messages`.`sender_id` AS `sender_id`,`private_messages`.`body` AS `body`,`private_messages`.`created_at` AS `created_at` from (`users` left join `private_messages` on((`users`.`id` = `private_messages`.`sender_id`))) order by `private_messages`.`id` limit 12 */;
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

-- Dump completed on 2026-04-27 19:26:23
