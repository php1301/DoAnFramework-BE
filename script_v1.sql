-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: chatlife
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Call`
--

DROP TABLE IF EXISTS `Call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Call` (
  `Id` int NOT NULL,
  `GroupCallCode` varchar(32) NOT NULL,
  `UserCode` varchar(32) NOT NULL,
  `Url` varchar(500)  NOT NULL,
  `Status` varchar(32) NOT NULL,
  `Created` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Call_GroupCall` (`GroupCallCode`),
  KEY `FK_Call_User` (`UserCode`),
  CONSTRAINT `FK_Call_GroupCall` FOREIGN KEY (`GroupCallCode`) REFERENCES `GroupCall` (`Code`),
  CONSTRAINT `FK_Call_User` FOREIGN KEY (`UserCode`) REFERENCES `User` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Call`
--

LOCK TABLES `Call` WRITE;
/*!40000 ALTER TABLE `Call` DISABLE KEYS */;
INSERT INTO `Call` VALUES (55,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/PnmNKVWMpvIWxc9bMEhs','OUT_GOING','2021-10-26 23:29:22.713000'),(56,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/PnmNKVWMpvIWxc9bMEhs','MISSED','2021-10-26 23:29:22.713000'),(57,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/0GpyBcgXRhRZvcpcR3cm','OUT_GOING','2021-10-26 23:30:52.207000'),(58,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/0GpyBcgXRhRZvcpcR3cm','MISSED','2021-10-26 23:30:52.207000'),(59,'f0a227f3c28b49c89310de6a8df38a1a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/BxSpP9UmftD8L2qykMBH','OUT_GOING','2021-10-26 23:35:43.140000'),(60,'f0a227f3c28b49c89310de6a8df38a1a','18d2e99f599e4a70862cd299e8a96676','https://ChatLifednx.daily.co/BxSpP9UmftD8L2qykMBH','MISSED','2021-10-26 23:35:43.140000'),(61,'960f365d2c7742b681ee2e6d8aea6ad1','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/XJzshOs67SSOXDnX6yUj','OUT_GOING','2021-10-26 23:36:06.837000'),(62,'960f365d2c7742b681ee2e6d8aea6ad1','1df7822da40b4938a860f318aa84865a','https://ChatLifednx.daily.co/XJzshOs67SSOXDnX6yUj','MISSED','2021-10-26 23:36:06.837000'),(63,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/h7oFSOWgsOQCafQgE8LL','OUT_GOING','2021-10-27 10:28:55.797000'),(64,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/h7oFSOWgsOQCafQgE8LL','MISSED','2021-10-27 10:28:55.797000'),(65,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/Nkq3PfIzlv56IvOqdaLF','OUT_GOING','2021-10-27 10:29:21.783000'),(66,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/Nkq3PfIzlv56IvOqdaLF','MISSED','2021-10-27 10:29:21.783000'),(67,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/eHBLW0JxKm0bWXol4ne3','OUT_GOING','2021-10-27 10:33:21.217000'),(68,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/eHBLW0JxKm0bWXol4ne3','MISSED','2021-10-27 10:33:21.217000'),(69,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/FzwMMebBugO7lG6HX383','OUT_GOING','2021-10-27 10:36:51.043000'),(70,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/FzwMMebBugO7lG6HX383','MISSED','2021-10-27 10:36:51.043000'),(71,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/6t5IrqjyBjo5DieheCfU','OUT_GOING','2021-10-27 10:38:38.650000'),(72,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/6t5IrqjyBjo5DieheCfU','MISSED','2021-10-27 10:38:38.650000'),(73,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/M8jI6dd547sPffCZ0Rbx','OUT_GOING','2021-10-27 11:25:42.657000'),(74,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/M8jI6dd547sPffCZ0Rbx','MISSED','2021-10-27 11:25:42.657000'),(75,'f0a227f3c28b49c89310de6a8df38a1a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/w4E6jTOBNqHgdxgDuS9s','OUT_GOING','2021-10-27 11:33:28.277000'),(76,'f0a227f3c28b49c89310de6a8df38a1a','18d2e99f599e4a70862cd299e8a96676','https://ChatLifednx.daily.co/w4E6jTOBNqHgdxgDuS9s','MISSED','2021-10-27 11:33:28.277000'),(77,'60d491428e6748d4b4f0390b72a41c5a','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/kthFNyal5V7KzQhfDyrI','OUT_GOING','2021-10-27 11:38:18.260000'),(78,'60d491428e6748d4b4f0390b72a41c5a','8053110542b44e04ba59b4dbbc7b830c','https://ChatLifednx.daily.co/kthFNyal5V7KzQhfDyrI','MISSED','2021-10-27 11:38:18.260000'),(79,'c4b1864c4e4844629bfd4b782f984a3d','39c3575543284110a80372b59234d6f7','https://ChatLifednx.daily.co/0vbMNtRdKiJwcehzKglx','OUT_GOING','2021-08-10 00:40:12.247000'),(80,'c4b1864c4e4844629bfd4b782f984a3d','3e48f1ce9f015cc59bd7bf0605681f28','https://ChatLifednx.daily.co/0vbMNtRdKiJwcehzKglx','MISSED','2021-08-10 00:40:12.247000');
/*!40000 ALTER TABLE `Call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contact`
--

DROP TABLE IF EXISTS `Contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contact` (
  `Id` bigint NOT NULL,
  `UserCode` varchar(32) NOT NULL,
  `ContactCode` varchar(32) NOT NULL,
  `Created` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Contact_User` (`UserCode`),
  KEY `FK_Contact_User1` (`ContactCode`),
  CONSTRAINT `FK_Contact_User` FOREIGN KEY (`UserCode`) REFERENCES `User` (`Code`),
  CONSTRAINT `FK_Contact_User1` FOREIGN KEY (`ContactCode`) REFERENCES `User` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contact`
--

LOCK TABLES `Contact` WRITE;
/*!40000 ALTER TABLE `Contact` DISABLE KEYS */;
INSERT INTO `Contact` VALUES (22,'3e48f1ce9f015cc59bd7bf0605681f28','2b388cc0b9b6405c99c6b30b50c9d8ec','2021-10-26 22:39:42.567000'),(23,'3e48f1ce9f015cc59bd7bf0605681f28','18d2e99f599e4a70862cd299e8a96676','2021-10-26 22:39:51.483000'),(24,'3e48f1ce9f015cc59bd7bf0605681f28','2699d7dc23434f81b6501af3175e6bbd','2021-10-26 22:39:54.810000'),(25,'3e48f1ce9f015cc59bd7bf0605681f28','9074aca1de2d42c598fccc0152082d76','2021-10-26 22:39:58.337000'),(26,'3e48f1ce9f015cc59bd7bf0605681f28','8607cf69ac024bfcaca7364883ef5640','2021-10-26 22:40:01.407000'),(27,'3e48f1ce9f015cc59bd7bf0605681f28','1df7822da40b4938a860f318aa84865a','2021-10-26 22:40:05.000000'),(28,'3e48f1ce9f015cc59bd7bf0605681f28','8053110542b44e04ba59b4dbbc7b830c','2021-10-26 22:46:39.517000'),(30,'39c3575543284110a80372b59234d6f7','3e48f1ce9f015cc59bd7bf0605681f28','2021-08-10 00:16:48.430000');
/*!40000 ALTER TABLE `Contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group`
--

DROP TABLE IF EXISTS `Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Group` (
  `Code` varchar(32) NOT NULL,
  `Type` varchar(32) NOT NULL COMMENT 'single: chat 1-1\r\nmulti: chat 1-n',
  `Avatar` longtext,
  `Name` varchar(250)  DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `CreatedBy` varchar(32) NOT NULL,
  `LastActive` datetime(6) NOT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group`
--

LOCK TABLES `Group` WRITE;
/*!40000 ALTER TABLE `Group` DISABLE KEYS */;
INSERT INTO `Group` VALUES ('33c47cc785744d36a517d44c57d8b561','single',NULL,'Phạm Hoàng Phúc','2021-08-10 00:17:03.477000','39c3575543284110a80372b59234d6f7','2021-08-10 00:35:31.940000'),('366a70849f0a49418310ebf4270d9f85','multi','Resource/Avatar/842b975e7bde44558125b11190e3f24e','As Fast As Lightning','2021-10-26 22:49:40.117000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:04:47.433000'),('3fea5e8164b04bc1a3891bd7137d06d8','multi','Resource/Avatar/260a84a298e8460e8cd58e9018fd68b1','Gia đình kiểu mẫu','2021-10-26 22:48:06.460000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:05:50.107000'),('90d94199caf14ae28378ec00b7f90b91','multi','Resource/Avatar/69997b00b5364c259d94c31f79a219f3','Nhóm yêu cái đẹp','2021-10-26 22:49:10.197000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:05:35.110000'),('934b99e5d1cf4d3d9576299e479a1bf1','single',NULL,'Ngô Minh Trí','2021-10-26 23:06:25.957000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-27 11:37:31.160000'),('a90d114f23d7456782370765af767e8f','multi','Resource/Avatar/0ce7a1060217418cb5673b754b657d7c','Chuyện mới lớn','2021-10-26 22:50:28.510000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:04:26.317000'),('b759f5c421ce4a5f8ca08bf76627b233','multi','Resource/Avatar/d7b6a0cb985b4087ab674fa349903e01','Xách balo lên và đi','2021-10-26 22:51:01.550000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:03:08.027000'),('c8b00e01f4c04845b1167aff59e50cc3','multi','Resource/Avatar/3371ac29f4064d78af763103ff8bd063','Dũng sỹ diệt mồi','2021-10-26 22:49:26.187000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:05:18.000000'),('f04778e4b8ae4e4b81bfdb7bcbd50b0d','multi','Resource/Avatar/b1e285b5a2a64187b01f15fdfcdbb1fc','ChatLife <3','2021-10-26 23:10:58.527000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-27 11:38:06.393000'),('f5d4c201f0b84397ab724c648c0db810','single',NULL,'Phạm Băng Trang','2021-10-26 23:10:01.137000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:10:01.137000');
/*!40000 ALTER TABLE `Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupCall`
--

DROP TABLE IF EXISTS `GroupCall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GroupCall` (
  `Code` varchar(32) NOT NULL,
  `Type` varchar(32) NOT NULL COMMENT 'single: chat 1-1\r\nmulti: chat 1-n',
  `Avatar` longtext,
  `Name` varchar(250)  DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `CreatedBy` varchar(32) NOT NULL,
  `LastActive` datetime(6) NOT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupCall`
--

LOCK TABLES `GroupCall` WRITE;
/*!40000 ALTER TABLE `GroupCall` DISABLE KEYS */;
INSERT INTO `GroupCall` VALUES ('60d491428e6748d4b4f0390b72a41c5a','single',NULL,NULL,'2021-10-26 23:29:22.713000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:29:22.713000'),('960f365d2c7742b681ee2e6d8aea6ad1','single',NULL,NULL,'2021-10-26 23:36:06.837000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:36:06.837000'),('c4b1864c4e4844629bfd4b782f984a3d','single',NULL,NULL,'2021-08-10 00:40:12.247000','39c3575543284110a80372b59234d6f7','2021-08-10 00:40:12.247000'),('f0a227f3c28b49c89310de6a8df38a1a','single',NULL,NULL,'2021-10-26 23:35:43.140000','3e48f1ce9f015cc59bd7bf0605681f28','2021-10-26 23:35:43.140000');
/*!40000 ALTER TABLE `GroupCall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupUser`
--

DROP TABLE IF EXISTS `GroupUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GroupUser` (
  `Id` bigint NOT NULL,
  `GroupCode` varchar(32) NOT NULL,
  `UserCode` varchar(32) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_GroupUser_Group` (`GroupCode`),
  KEY `FK_GroupUser_User` (`UserCode`),
  CONSTRAINT `FK_GroupUser_Group` FOREIGN KEY (`GroupCode`) REFERENCES `Group` (`Code`),
  CONSTRAINT `FK_GroupUser_User` FOREIGN KEY (`UserCode`) REFERENCES `User` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupUser`
--

LOCK TABLES `GroupUser` WRITE;
/*!40000 ALTER TABLE `GroupUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `GroupUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message`
--

DROP TABLE IF EXISTS `Message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Message` (
  `Id` bigint NOT NULL,
  `Type` varchar(10) NOT NULL COMMENT 'text\r\nmedia\r\nattachment',
  `GroupCode` varchar(32) NOT NULL,
  `Content` longtext ,
  `Path` varchar(255)  DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `CreatedBy` varchar(32) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Message_Group` (`GroupCode`),
  KEY `FK_Message_User` (`CreatedBy`),
  CONSTRAINT `FK_Message_Group` FOREIGN KEY (`GroupCode`) REFERENCES `Group` (`Code`),
  CONSTRAINT `FK_Message_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message`
--

LOCK TABLES `Message` WRITE;
/*!40000 ALTER TABLE `Message` DISABLE KEYS */;
INSERT INTO `Message` VALUES (189,'text','b759f5c421ce4a5f8ca08bf76627b233','Di chuyển nào anh em ơi!',NULL,'2021-10-26 23:03:08.027000','3e48f1ce9f015cc59bd7bf0605681f28'),(190,'text','a90d114f23d7456782370765af767e8f','chuyện tối hôm qua bây giờ mới kể',NULL,'2021-10-26 23:04:26.317000','3e48f1ce9f015cc59bd7bf0605681f28'),(191,'text','366a70849f0a49418310ebf4270d9f85','Nào nào mình cùng lại đây phê pha',NULL,'2021-10-26 23:04:47.433000','3e48f1ce9f015cc59bd7bf0605681f28'),(192,'text','c8b00e01f4c04845b1167aff59e50cc3','20kg thịt bò, 12kg thịt lơn, 10kg mực',NULL,'2021-10-26 23:05:18.000000','3e48f1ce9f015cc59bd7bf0605681f28'),(193,'text','90d94199caf14ae28378ec00b7f90b91','lần đầu tiên trong cuộc đời',NULL,'2021-10-26 23:05:35.110000','3e48f1ce9f015cc59bd7bf0605681f28'),(194,'text','3fea5e8164b04bc1a3891bd7137d06d8','Một gia đình hạnh phúc là như thế nào?',NULL,'2021-10-26 23:05:50.107000','3e48f1ce9f015cc59bd7bf0605681f28'),(195,'text','934b99e5d1cf4d3d9576299e479a1bf1','Dự án sáng mai bắt đầu họp lúc 9h. Các tài liệu cần chuẩn bị sớm nhé',NULL,'2021-10-26 23:06:25.957000','3e48f1ce9f015cc59bd7bf0605681f28'),(196,'text','f5d4c201f0b84397ab724c648c0db810','Tuyển dụng thêm 5 bạn nhân sự marketing vị trí thực tập',NULL,'2021-10-26 23:10:01.137000','3e48f1ce9f015cc59bd7bf0605681f28'),(197,'text','f04778e4b8ae4e4b81bfdb7bcbd50b0d','Tính đến hiện tại dự án đã phát triển rất nhanh.',NULL,'2021-10-26 23:08:37.380000','3e48f1ce9f015cc59bd7bf0605681f28'),(198,'media','f04778e4b8ae4e4b81bfdb7bcbd50b0d','bieu-do.png','Resource/Attachment/2021/bieu-do.png','2021-10-26 23:09:36.883000','3e48f1ce9f015cc59bd7bf0605681f28'),(199,'text','f04778e4b8ae4e4b81bfdb7bcbd50b0d','Sau buổi báo cáo sáng nay. Em gửi lại file tổng hợp lại các thông tin cần lưu ý cũng như đề xuất của mọi người trong nhóm ạ.',NULL,'2021-10-26 23:11:50.547000','18d2e99f599e4a70862cd299e8a96676'),(200,'attachment','f04778e4b8ae4e4b81bfdb7bcbd50b0d','báo cáo dữ liệu tổng hợp - ChatLife.docx','Resource/Attachment/2021/báo cáo dữ liệu tổng hợp - ChatLife.docx','2021-10-26 23:12:11.980000','18d2e99f599e4a70862cd299e8a96676'),(201,'text','f04778e4b8ae4e4b81bfdb7bcbd50b0d','Các nội dung được đưa vào hệ thống rất phong phú và đa dạng. Nhiều tính năng hữu ích hỗ trợ rất nhiều cho người sử dụng.',NULL,'2021-10-26 23:21:31.667000','2699d7dc23434f81b6501af3175e6bbd'),(202,'text','934b99e5d1cf4d3d9576299e479a1bf1','Hello, good morning!',NULL,'2021-10-27 11:15:48.763000','3e48f1ce9f015cc59bd7bf0605681f28'),(203,'text','934b99e5d1cf4d3d9576299e479a1bf1','Chào Dương nhé',NULL,'2021-10-27 11:16:03.740000','8053110542b44e04ba59b4dbbc7b830c'),(204,'media','934b99e5d1cf4d3d9576299e479a1bf1','566226151661511044021668004432122225985389n-1569234596911848541502-1569517951952686128625.jpg','Resource/Attachment/2021/566226151661511044021668004432122225985389n-1569234596911848541502-1569517951952686128625.jpg','2021-10-27 11:16:23.273000','3e48f1ce9f015cc59bd7bf0605681f28'),(205,'text','934b99e5d1cf4d3d9576299e479a1bf1','Ảnh đẹp đó',NULL,'2021-10-27 11:16:45.227000','3e48f1ce9f015cc59bd7bf0605681f28'),(206,'text','934b99e5d1cf4d3d9576299e479a1bf1','Cuộc họp hôm qua chuẩn bị thế nào rồi',NULL,'2021-10-27 11:17:17.783000','3e48f1ce9f015cc59bd7bf0605681f28'),(207,'text','934b99e5d1cf4d3d9576299e479a1bf1','Sáng nay 9h bắt đầu rồi đó',NULL,'2021-10-27 11:17:41.883000','3e48f1ce9f015cc59bd7bf0605681f28'),(208,'text','934b99e5d1cf4d3d9576299e479a1bf1','Cần thông tin gì thì Call anh',NULL,'2021-10-27 11:17:53.047000','3e48f1ce9f015cc59bd7bf0605681f28'),(209,'text','934b99e5d1cf4d3d9576299e479a1bf1','Vâng em đang chuẩn bị rồi ạ',NULL,'2021-10-27 11:18:01.630000','8053110542b44e04ba59b4dbbc7b830c'),(211,'text','f04778e4b8ae4e4b81bfdb7bcbd50b0d','Good morning!',NULL,'2021-10-27 11:25:06.557000','3e48f1ce9f015cc59bd7bf0605681f28'),(212,'text','934b99e5d1cf4d3d9576299e479a1bf1','Chào em',NULL,'2021-10-27 11:25:27.923000','3e48f1ce9f015cc59bd7bf0605681f28'),(213,'text','934b99e5d1cf4d3d9576299e479a1bf1','Đang làm gì đó',NULL,'2021-10-27 11:36:40.927000','3e48f1ce9f015cc59bd7bf0605681f28'),(214,'text','934b99e5d1cf4d3d9576299e479a1bf1','Em đang họp cùng team XYZ',NULL,'2021-10-27 11:37:05.260000','8053110542b44e04ba59b4dbbc7b830c'),(215,'media','934b99e5d1cf4d3d9576299e479a1bf1','bieu-do.png','Resource/Attachment/2021/bieu-do.png','2021-10-27 11:37:14.683000','3e48f1ce9f015cc59bd7bf0605681f28'),(216,'attachment','934b99e5d1cf4d3d9576299e479a1bf1','báo cáo dữ liệu tổng hợp - ChatLife.docx','Resource/Attachment/2021/báo cáo dữ liệu tổng hợp - ChatLife.docx','2021-10-27 11:37:25.643000','3e48f1ce9f015cc59bd7bf0605681f28'),(217,'text','934b99e5d1cf4d3d9576299e479a1bf1','Gửi em',NULL,'2021-10-27 11:37:31.160000','3e48f1ce9f015cc59bd7bf0605681f28');
/*!40000 ALTER TABLE `Message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `Code` varchar(32) NOT NULL,
  `UserName` varchar(32) DEFAULT NULL,
  `Password` varchar(124) DEFAULT NULL,
  `FullName` varchar(50)  DEFAULT NULL,
  `Dob` varchar(50) DEFAULT NULL,
  `Phone` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Address` varchar(255)  DEFAULT NULL,
  `Avatar` longtext,
  `Gender` varchar(10)  DEFAULT NULL,
  `LastLogin` datetime(6) DEFAULT NULL,
  `CurrentSession` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('18d2e99f599e4a70862cd299e8a96676','hoangphuc.pham','1a33b9a1d9a21935befbee288ef5df5b0f8e05bb213d5e34ea1c3087edeb1d15','Phạm Hoàng Phúc','13/01/2001','0923.123.456','phucpham1301@gmail.com','Thành phố Đà Nẵng, Việt Nam','Resource/Avatar/2f166915f5a0472da1a5674deff5fd04','Nữ','2021-10-26 23:10:23.953000','_nenWLoh683qAuwMulMqcQ'),('1df7822da40b4938a860f318aa84865a','nguyenhanhnguyen.tran','748305c24cb40701a018091cfa2b51787ed4140d285c629396ffd165269a9e0a','Trần Nguyễn Hạnh Nguyên','16/05/2001','0124.321.987','tranbinhminh@gmail.com','Thành Phố Hồ Chí Minh, Việt Nam','Resource/Avatar/84d07c7d1e924a1ebdf258c4d5d3b784','Nam','2021-10-26 22:34:11.670000','O5jF9-fXlakp3EhF-a96tg'),('2699d7dc23434f81b6501af3175e6bbd','thuylinh.nguyen','a013d37d9c52d41ace3f101b48443724bce0a87d0e1ca55995af798c3c3b67d1','Nguyễn Thuỳ Linh','12/12/2001','0934.123.456','nguyenthuylinh@gmail.com','Thành Phố Hồ Chí Minh, Việt Nam','Resource/Avatar/76412470446b4aab86acde51bfff5eeb','Nữ','2021-10-26 23:12:35.190000','5sf7Yb7hQqXmT1e2CVATzg'),('2b388cc0b9b6405c99c6b30b50c9d8ec','ngocanh.bui','980c348c3a944a63d1cda1d09d67eace90a628da49db241919adc79aeba2f27c','Bùi Ngọc Anh','22/01/1994','0983.125.345','buingocanh@gmail.com','TP Hạ Long, Quảng Ninh, Việt Nam','Resource/Avatar/d8ea0463f4d14e9d825bcab117b20ccd','Nữ','2021-10-26 22:35:51.597000','8yqvF0sNKASYMozfQBWVVA'),('39c3575543284110a80372b59234d6f7','ngocanh.truong','676609f1ae67fa102b5841736fa3e0e7b3eb0bbf07f15b68687e371277593175','Trương Ngọc Anh','1990','0983.123.333','ngocanh@gmail.com',NULL,'Resource/Avatar/102132e535df4c29a5ce3590ba16a228','Nữ','2021-08-10 00:16:11.290000','aMGFsmHUQEo_Tuzw2ufytQ'),('3e48f1ce9f015cc59bd7bf0605681f28','admin','4d5c5f61bb3d2c299d3211c2992a28a7849b6ce933919c399ce24903c1715d45','Phạm Hoàng Phúc','13/01/1990','0983216534','phucadmin@gmail.com','Hồ Chí Minh, Việt Nam','Resource/Avatar/9bb8cddea6814c6e97c1cd99b01b5b06','Nam','2021-08-10 00:19:26.907000','B3140sCMECPTWuoLbvs1AQ'),('8053110542b44e04ba59b4dbbc7b830c','minhtri.ngo','087782207b6155f25c3cb5a8b21fe53ad8441a4b206153be399a8cbf91499480','Ngô Minh Trí','15/18/1996','0923.123.456','ngominhtri@gmail.com','Thái Bình, Việt Nam','Resource/Avatar/9c0563b0d44a4c87890396d29a63bc71','Nam','2021-10-26 23:29:16.187000','wtyxBeGqTRSfiTd8bHNGfA'),('8607cf69ac024bfcaca7364883ef5640','quynhanh.pham','05c5302185c8657e4a34a759d1724aac82b7c7318b5e684ac47e534f82811261','Phạm Quỳnh Anh','04/12/2000','0936.234.562','phamquynhanh@gmail.com','Ninh Bình, Việt Nam','Resource/Avatar/8ac2076595304c16a7ad295195a8a92a','Nữ','2021-10-26 22:36:50.593000','S3MBmz0e_bJW9TFrcO2ztw'),('9074aca1de2d42c598fccc0152082d76','trangbang.pham','30f7fb8b6fdb6f36762fafdbcba5cc1fc354e3ffb88b91698448c2b43a8e5717','Phạm Băng Trang','25/08/1999','0983.123.456','phambangtrang@gmail.com','Cầu Giấy, Hà Nội, Việt Nam','Resource/Avatar/3b6b61ae36dd4d25b66a7ef56d313830','Nữ','2021-10-26 22:38:23.633000','aiCM3oXM7rb0-C0sI7HYyw'),('a71eff90f79e40e29881c4149c07ecfe','minhquang.ho','7c244bf95b1d968810e99a6b21638bb582c2a1f4f4408b2abf5dea50d2866155','Hồ Minh Quang',NULL,'0912.321.122','hominhquang@gmail.com',NULL,'Resource/no_img.jpg',NULL,NULL,NULL),('bcd3d540b5094924b701535a23f9855d','ngoctrang.tran','9a35886f3db6a77d14307a1416559727cb06991921ad511e7f3b6e8131d659c4','Trần Ngọc Trang','19/22/2000','0984.123.432','tranngoctrang@gmail.com','Bắc Ninh, Việt Nam','Resource/Avatar/8af7f1b946a442a6a42da02e74eeee83','Nữ','2021-10-26 22:43:19.497000','8fVH7SOWBXxUvapfw7-qGg'),('ea813c82cd87403083abfb2d1c143cfb','baohan.le','e81a271aacd2f4fe6256a407ed3d7bf4d7e15a78b05b73a15cbd818d5aca9340','Lê Ngọc Bảo Hân','12/12/2001','0254.123.349','lengocbaohan@gmail.com','Ninh Giang','Resource/Avatar/f178bdbee0d640f6b09a65046ef78019','Nữ','2021-10-26 22:41:57.580000','LsWWfOT9nMzzYXEuslPfbA'),('ee7dbac1ef704fa79f839eb67fa7e8e8','ngocnhi.truong','d1f160ce90ab7ee87a9e370c37c14dbc232b98d01442b2a35e2f13a10e889f4c','Trương Ngọc Nhi',NULL,'0932.123.333','ngocnhi.truong@gmail.com',NULL,'Resource/no_img.jpg',NULL,NULL,NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-20 22:27:19
