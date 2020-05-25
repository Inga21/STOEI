-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bemn
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `company` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `company_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Плеханова 49','Бемн'),(2,'Куприевича 23','База'),(3,'Лукьянова 19','Атомка');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `department` (
  `id` bigint(20) NOT NULL,
  `department_title` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `number_room` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKh1m88q0f7sc0mk76kju4kcn6f` (`company_id`),
  CONSTRAINT `FKh1m88q0f7sc0mk76kju4kcn6f` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (11,'ОИТ',1,303),(34,'ПИТ',1,201),(35,'КИТ',3,101),(71,'фыв',1,123);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `device` (
  `id` bigint(20) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `personnel_number` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk92m2qj36vn62ctp5pgbt4982` (`user_id`),
  CONSTRAINT `FKk92m2qj36vn62ctp5pgbt4982` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'ASUS','DSA12',1),(2,'LOGITECH','DS-123-FFD',1),(29,'ASUS 324','123-АС-324',28),(33,'asd','asd`',8),(35,'Телефон Samsung A50','A-232-fde43',28),(40,'123','123',8),(41,'123','123',8),(67,'AS-12-TK_Samsung','123-33-32-443',66),(75,'Samsung g505','AS-FN-123',66);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (78);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `request` (
  `id` bigint(20) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `date_create` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `effects` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_fio` bigint(20) DEFAULT NULL,
  `date_end` datetime(6) DEFAULT NULL,
  `priority` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqws2fdeknk90txm7qnm9bxd07` (`user_id`),
  KEY `FK4ay431rtufoht77fotcjtfrka` (`user_fio`),
  CONSTRAINT `FK4ay431rtufoht77fotcjtfrka` FOREIGN KEY (`user_fio`) REFERENCES `user` (`id`),
  CONSTRAINT `FKqws2fdeknk90txm7qnm9bxd07` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (30,'Другое','2019-11-23 16:57:45.582000','фы','Весь_офис','Закрыто','фыв',1,1,'2019-11-25 23:08:42.414000','Самый_Низкий'),(31,'Другое','2020-03-23 17:09:23.496000','123','Весь_офис','Закрыто','123',8,1,'2020-04-23 18:16:58.171000','Самый_Низкий'),(32,'Монтаж_сети','2020-04-23 17:10:53.486000','АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА\r\n                                    \r\n                                    \r\n                                    ','Несколько_человек','Закрыто','выф',1,8,'2019-11-24 17:37:25.874000','Безотлагательный'),(36,'Оборудование','2019-11-24 23:04:48.978000','ффффффффффффффффффффффффффффффффффф','Несколько_человек','Закрыто','Поломка компьютера',8,8,'2019-11-27 23:07:47.000000','Самый_Низкий'),(37,'Другое','2019-11-24 23:15:32.317000','11111111111111111111111','Весь_офис','Работа','11111111',8,1,NULL,'Самый_Низкий'),(38,'Другое','2019-11-24 23:38:43.247000','','Весь_офис','Работа','Не запускается Excel',8,8,NULL,'Самый_Низкий'),(39,'Активация_ПО','2019-11-25 15:24:03.452000','Тормоза появились при запуске, не наблюдается запуска программы','Один_человек','Закрыто','Не работает Excel ',8,28,'2019-11-26 20:46:48.458000','Самый_Низкий'),(43,'Другое','2019-11-27 17:43:13.327000','1','Весь_офис','Работа','1',28,NULL,NULL,'Самый_Низкий'),(44,'Другое','2019-11-27 22:32:41.056000','1','Весь_офис','Работа','1',28,NULL,NULL,'Самый_Низкий'),(45,'Другое','2019-11-27 22:33:02.615000','1','Весь_офис','Работа','1',1,NULL,NULL,'Самый_Низкий'),(46,'Оборудование','2019-11-27 22:33:25.352000','                                                                                                            3\r\n                                    \r\n                                    \r\n                                    ','Один_человек','Пауза','3',8,NULL,NULL,'Безотлагательный'),(47,'Штрафы','2019-11-27 22:43:14.722000','                                                                                                                                                4\r\n\r\n\r\n\r\n                                    \r\n                                    \r\n                          ','Несколько_человек','Закрыто','Не работает Skype',1,8,NULL,'Безотлагательный'),(48,'Активация_ПО','2019-11-27 22:54:41.667000','                                                                                                                                                5\r\n                                    \r\n                                    \r\n                                ','Один_человек','Работа','5',1,NULL,'2019-11-27 23:11:43.073000','Безотлагательный'),(49,'Другое','2019-11-27 23:20:08.093000','1','Весь_офис','Работа','1',28,NULL,NULL,'Высокий'),(50,'Другое','2019-11-27 23:21:23.172000','asd','Весь_офис','Закрыто','Не работает Skype',1,NULL,'2019-11-27 23:21:23.172000','Высокий'),(51,'Другое','2019-11-27 23:21:42.230000','                                    5\r\n                                    ','Весь_офис','Пауза','5',1,1,NULL,'Высокий'),(52,'Другое','2019-11-27 23:24:50.088000','                                    Перестал подключаться, висит загрузка и дальше не идет\r\n                                    ','Один_человек','Закрыто','Не работает Skype',8,8,NULL,'Обычный'),(53,'Другое','2019-11-27 23:25:04.556000','5','Весь_офис','Закрыто','5',8,1,'2019-11-27 23:25:04.556000','Обычный'),(54,'Другое','2019-11-27 23:25:15.105000','6','Весь_офис','Пауза','6',1,1,NULL,'Обычный'),(55,'Другое','2019-11-27 23:25:27.719000','7','Весь_офис','Работа','7',28,28,NULL,'Низкий'),(56,'Другое','2019-11-27 23:25:38.671000','1','Весь_офис','Закрыто','1',1,28,'2019-11-27 23:25:38.671000','Низкий'),(57,'Другое','2019-11-27 23:25:52.598000','1','Весь_офис','Пауза','1',28,28,NULL,'Низкий'),(68,'Оборудование','2019-12-03 13:28:58.652000','Перестал отвечать принтер после отправки на него документа на печать','Весь_офис','Закрыто','Перестал отвечать принтер',66,8,'2019-12-03 13:48:11.554000','Обычный'),(69,'Активация_ПО','2019-12-03 15:39:22.845000','Необходимо активировать автокад','Один_человек','Работа','Активация AutoCad',66,NULL,NULL,'Высокий');
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `active` bit(1) NOT NULL,
  `fio` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `telephone_mobile` varchar(255) DEFAULT NULL,
  `telephone_work` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgkh2fko1e4ydv1y6vtrwdc6my` (`department_id`),
  CONSTRAINT `FKgkh2fko1e4ydv1y6vtrwdc6my` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,_binary '','Дубок В.В.','a','7638550','2659854','a',NULL,11),(8,_binary '','Дубок Владислав Васильевич','$2a$08$ZOhjTQB1s01206BdxjQS/.2W1wbDw6Pm9n0abaoMq8DRdeZlK7oLS','+375 44 763-85-50','276-54-92','vallidol@bk.ru',NULL,34),(28,_binary '','Лукашук Е.В.','$2a$08$6Ie2f2jH8nzYXii4F0vZKebmLO/sJT0xgWQOa5/qtP2LCR1BLJdZS','1231231','3213213','jat3q@wimsg.com',NULL,35),(66,_binary '','Романчук И.Г.','$2a$08$Od2.bwZ6zEDSA.WrGjqvhu.i0igIoxeBCRF4bezwO7/8DYRK3DJ12','+375447638550','2765492','giwama3756@newmail.top',NULL,71);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_role` (
  `user_id` bigint(20) NOT NULL,
  `roles` varchar(255) DEFAULT NULL,
  KEY `FK859n2jvi8ivhui0rl0esws6o` (`user_id`),
  CONSTRAINT `FK859n2jvi8ivhui0rl0esws6o` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (8,'SUPER_ADMIN'),(1,'ADMIN'),(66,'SUPER_ADMIN'),(28,'SUPER_ADMIN');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bemn'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-06 10:41:28
