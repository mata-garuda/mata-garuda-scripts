-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: MGMETADATA
-- ------------------------------------------------------
-- Server version	5.7.15

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
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(40) NOT NULL DEFAULT '',
  `controller` varchar(50) NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `limits`
--

DROP TABLE IF EXISTS `limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `count` int(10) NOT NULL,
  `hour_started` int(11) NOT NULL,
  `api_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `limits`
--

LOCK TABLES `limits` WRITE;
/*!40000 ALTER TABLE `limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `method` varchar(6) NOT NULL,
  `params` text,
  `api_key` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `time` int(11) NOT NULL,
  `rtime` float DEFAULT NULL,
  `authorized` tinyint(1) NOT NULL,
  `response_code` smallint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `menuid` int(11) NOT NULL AUTO_INCREMENT,
  `menuname` varchar(50) NOT NULL,
  `menudescription` varchar(100) DEFAULT NULL,
  `menualias` varchar(45) DEFAULT NULL,
  `menuicon` varchar(45) DEFAULT NULL,
  `menucontroller` varchar(45) DEFAULT NULL,
  `menulink` varchar(45) DEFAULT NULL,
  `menuparent` int(11) DEFAULT NULL,
  `menuactive` tinyint(1) DEFAULT NULL,
  `menucode` varchar(45) DEFAULT NULL,
  `menuexpand` tinyint(1) DEFAULT NULL,
  `menuleaf` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`menuid`),
  UNIQUE KEY `INDEX_MENU_CODE` (`menucode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'1. Monitoring','Monitoring','monitoring','xtion-ico ic-module',NULL,NULL,0,1,'00',1,0),(2,'3. Database','Database','database','xtion-ico ic-module',NULL,NULL,0,0,'02',1,0),(3,'4. Master','Master','master','xtion-ico ic-module',NULL,NULL,0,0,'03',1,0),(4,'5. Analysis','Analysis','analysis','xtion-ico ic-module',NULL,NULL,0,1,'04',1,0),(5,'6. Configuration','Configuration','configuration','xtion-ico ic-module',NULL,NULL,0,1,'05',1,0),(6,'1.1 Event','Event','event','xtion-ico ic-module','menu.event','',1,1,'00:00',NULL,1),(7,'1.2 Packet Statistic','Packet Statistic','paketstatistic','xtion-ico ic-module',NULL,NULL,1,0,'00:01',NULL,1),(8,'1.3 Event Statistics','Event Statistics','eventstatistic','xtion-ico ic-module','menu.eventstatistics',NULL,1,1,'00:02',NULL,1),(9,'1.4 Net Awareness','Net Awareness','netawareness','xtion-ico ic-module',NULL,NULL,1,0,'00:03',NULL,1),(10,'1.5 Attack Visualization','Attack Visualization','attackvisualization','xtion-ico ic-module',NULL,NULL,1,0,'00:04',NULL,1),(11,'1.6 SiLK Monitoring','SiLK Monitoring','silkmonitoring','xtion-ico ic-module',NULL,NULL,1,0,'00:05',NULL,1),(12,'1.7 User Statistic','User Statistic','userstatistic','xtion-ico ic-module',NULL,NULL,1,0,'00:06',NULL,1),(13,'3.1 Data Backup','Data Backup','databackup','xtion-ico ic-module',NULL,NULL,2,1,'02:00',NULL,1),(14,'3.2 Configuration','Configuration','databaseconfiguration','xtion-ico ic-module',NULL,NULL,2,1,'02:01',NULL,1),(15,'4.1 Snort','Snort','snort','xtion-ico ic-module',NULL,NULL,3,1,'03:00',1,0),(16,'4.2 Countries','Countries','countries','xtion-ico ic-module',NULL,NULL,3,1,'03:01',NULL,1),(17,'4.3 Event Summary','Event Summary','eventsummary','xtion-ico ic-module',NULL,NULL,3,1,'03:02',NULL,1),(18,'4.4 IP Filter','IP Filter','ipfilter','xtion-ico ic-module',NULL,NULL,3,1,'03:03',NULL,1),(19,'4.5 IP Location','IP Location','iplocation','xtion-ico ic-module',NULL,NULL,3,1,'03:04',NULL,1),(20,'4.6 IP Map','IP Map','ipmap','xtion-ico ic-module',NULL,NULL,3,1,'03:05',NULL,1),(21,'4.7 IP Map Summary','IP Map Summary','ipmapsummary','xtion-ico ic-module',NULL,NULL,3,1,'03:06',NULL,1),(22,'4.8 IP Severity','IP Severity','ipseverity','xtion-ico ic-module',NULL,NULL,3,1,'03:07',NULL,1),(23,'4.9 Job','Job','job','xtion-ico ic-module',NULL,NULL,3,1,'03:08',NULL,1),(24,'4.10 Role','Role','role','xtion-ico ic-module',NULL,NULL,3,1,'03:09',NULL,1),(25,'4.11 Settings','Settings','settings','xtion-ico ic-module',NULL,NULL,3,1,'03:10',NULL,1),(26,'4.1.1 Icmphdr','Icmphdr','icmphdr','xtion-ico ic-module',NULL,NULL,15,1,'03:00:00',NULL,1),(27,'4.1.2 Data','Data','data','xtion-ico ic-module',NULL,NULL,15,1,'03:00:01',NULL,1),(28,'4.1.3 Detail','Detail','detail','xtion-ico ic-module',NULL,NULL,15,1,'03:00:02',NULL,1),(29,'4.1.4 Encoding','Encoding','encoding','xtion-ico ic-module',NULL,NULL,15,1,'03:00:03',NULL,1),(30,'4.1.5 Event','Event','event','xtion-ico ic-module',NULL,NULL,15,1,'03:00:04',NULL,1),(31,'4.1.6 Log','Log','log','xtion-ico ic-module',NULL,NULL,15,1,'03:00:05',NULL,1),(32,'4.1.7 Opt','Opt','opt','xtion-ico ic-module',NULL,NULL,15,1,'03:00:06',NULL,1),(33,'4.1.8 Port List','Port List','portlist','xtion-ico ic-module',NULL,NULL,15,1,'03:00:07',NULL,1),(34,'4.1.9 Reference','Reference','reference','xtion-ico ic-module',NULL,NULL,15,1,'03:00:08',NULL,1),(35,'4.1.10 Reference Config','Reference Config','referenceconfig','xtion-ico ic-module',NULL,NULL,15,1,'03:00:09',NULL,1),(36,'4.1.11 Reference System','Reference System','referencesystem','xtion-ico ic-module',NULL,NULL,15,1,'03:00:10',NULL,1),(37,'4.1.12 Rule Activity Log','Rule Activity Log','ruleactivitylog','xtion-ico ic-module',NULL,NULL,15,1,'03:00:11',NULL,1),(38,'4.1.13 Rule File','Rule File','rulefile','xtion-ico ic-module',NULL,NULL,15,1,'03:00:12',NULL,1),(39,'4.1.14 Rule File Log','Rule File Log','rulefilelog','xtion-ico ic-module',NULL,NULL,15,1,'03:00:13',NULL,1),(40,'4.1.15 Rule Line','Rule Line','ruleline','xtion-ico ic-module',NULL,NULL,15,1,'03:00:14',NULL,1),(41,'4.1.16 Rules Content','Rules Content','rulescontent','xtion-ico ic-module','',NULL,15,1,'03:00:15',NULL,1),(42,'4.1.17 Rules Temporary','Rules Temporary','rulestemporary','xtion-ico ic-module',NULL,NULL,15,1,'03:00:16',NULL,1),(43,'4.1.18 Schema','Schema','schema','xtion-ico ic-module',NULL,NULL,15,1,'03:00:17',NULL,1),(44,'4.1.19 Sensor','Sensor','sensor','xtion-ico ic-module',NULL,NULL,15,1,'03:00:18',NULL,1),(45,'4.1.20 Signature','Signature','signature','xtion-ico ic-module',NULL,NULL,15,1,'03:00:19',NULL,1),(46,'4.1.21 Signature Class','Signature Class','signatureclass','xtion-ico ic-module',NULL,NULL,15,1,'03:00:20',NULL,1),(47,'4.1.22 Signature Reference','Signature Reference','signaturereference','xtion-ico ic-module',NULL,NULL,15,1,'03:00:21',NULL,1),(48,'4.1.23 System Log','System Log','systemlog','xtion-ico ic-module',NULL,NULL,15,1,'03:00:22',NULL,1),(49,'4.1.24 Tcphdr','Tcphdr','tcphdr','xtion-ico ic-module',NULL,NULL,15,1,'03:00:23',NULL,1),(50,'4.1.25 Udphdr','Udphdr','udphdr','xtion-ico ic-module',NULL,NULL,15,1,'03:00:24',NULL,1),(51,'4.12 User','User','user','xtion-ico ic-module',NULL,NULL,3,1,'03:11',NULL,1),(52,'5.1 Attack Trend','Attack Trend','attacktrend','xtion-ico ic-module',NULL,NULL,4,1,'04:00',NULL,1),(53,'5.2 Event','Event','analysisevent','xtion-ico ic-module',NULL,NULL,4,1,'04:01',NULL,1),(54,'6.1 User Management','User Management','usermanagement','xtion-ico ic-module',NULL,NULL,5,1,'05:00',NULL,1),(55,'6.2 Role Management','Role Management','rolemanagement','xtion-ico ic-module','menu.role',NULL,5,1,'05:01',NULL,1),(56,'6.3 Profile Management','Profile Management','profilemanagement','xtion-ico ic-module',NULL,NULL,5,1,'05:02',NULL,1),(57,'6.4 Menu Management','Menu Management','menumanagement','xtion-ico ic-module','menu.menu',NULL,5,1,'05:03',NULL,1),(58,'2. Report','Report','report','xtion-ico ic-box',NULL,NULL,0,1,'01',1,0),(59,'2.1 Daily ','Daily','daily','xtion-ico ic-module','menu.reportdaily',NULL,58,1,'01:00',NULL,1),(60,'2.2 Monthly','Monthly','monthly','xtion-ico ic-module','menu.reportmonthly',NULL,58,1,'01:01',NULL,1),(61,'2.3 Annually','Annually','annually','xtion-ico ic-module','menu.reportannually',NULL,58,1,'01:02',NULL,1),(62,'2.4 Big Data','Big Data','bigdata','xtion-ico ic-module',NULL,NULL,58,0,'01:03',NULL,1),(63,'7. API','API','api','xtion-ico ic-box',NULL,NULL,0,0,'06',1,0),(64,'7.1 Log','Log','log','xtion-ico ic-module',NULL,NULL,63,1,'06:00',NULL,1),(65,'7.2 Access','Access','access','xtion-ico ic-module',NULL,NULL,63,1,'06:01',NULL,1),(66,'7.3 Limit','Limit','limit','xtion-ico ic-module',NULL,NULL,63,1,'06:02',NULL,1),(68,'1.8 Top Signature','Top 20 Signature','topsignature','xtion-ico ic-module','menu.top20sig',NULL,1,1,'01:07',NULL,1),(69,'1.9 Top Protocols','Top 20 Protocols','topprotocols','xtion-ico ic-module','menu.top20proto',NULL,1,1,'01:08',NULL,1),(70,'1.10 Sensor Statistics','Sensor Statistics','sensorstatistics','xtion-ico ic-module','menu.sensorstatistics',NULL,1,1,'01:09',NULL,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `roleid` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(45) NOT NULL,
  `roledescription` varchar(100) DEFAULT NULL,
  `monitoring` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`roleid`),
  KEY `INDEX_ROLE_ID` (`roleid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Administrator','Person who can access all feature',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roletomenu`
--

DROP TABLE IF EXISTS `roletomenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roletomenu` (
  `roleid` int(11) NOT NULL,
  `menuid` int(11) NOT NULL,
  PRIMARY KEY (`roleid`,`menuid`),
  KEY `FK_ROLETOMENU_MENU_MENU_ID_idx` (`menuid`),
  KEY `INDEX_ROLETOMENU_ROLEID` (`roleid`) USING BTREE,
  CONSTRAINT `FK_ROLETOMENU_MENU_MENU_ID` FOREIGN KEY (`menuid`) REFERENCES `menu` (`menuid`),
  CONSTRAINT `FK_ROLETOMENU_ROLE_ROLE_ID` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roletomenu`
--

LOCK TABLES `roletomenu` WRITE;
/*!40000 ALTER TABLE `roletomenu` DISABLE KEYS */;
/*!40000 ALTER TABLE `roletomenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor` (
  `sensorid` int(11) NOT NULL AUTO_INCREMENT,
  `sensorcode` varchar(15) NOT NULL,
  `sensorname` varchar(45) NOT NULL,
  `sensoractice` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`sensorid`),
  KEY `INDEX_SENSOR_CODE` (`sensorcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensor`
--

LOCK TABLES `sensor` WRITE;
/*!40000 ALTER TABLE `sensor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensortouser`
--

DROP TABLE IF EXISTS `sensortouser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensortouser` (
  `sensorid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`sensorid`,`userid`),
  KEY `INDEX_USER_ID` (`userid`) USING BTREE,
  CONSTRAINT `FK_SENSORTOUSER_SENSOR_ID` FOREIGN KEY (`sensorid`) REFERENCES `sensor` (`sensorid`),
  CONSTRAINT `FK_SENSORTOUSER_USER_ID` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensortouser`
--

LOCK TABLES `sensortouser` WRITE;
/*!40000 ALTER TABLE `sensortouser` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensortouser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting` (
  `threshold` int(11) DEFAULT NULL,
  `default_number_per_page` varchar(45) DEFAULT NULL,
  `ip_server` varchar(45) DEFAULT NULL,
  `ip_netsa` varchar(45) DEFAULT NULL,
  `backup_path` varchar(45) DEFAULT NULL,
  `backup_time` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `tokenid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `token` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`tokenid`),
  KEY `INDEX_TOKEN_CREATE` (`created`) USING BTREE,
  KEY `FK_TOKEN_USER_USER_ID_idx` (`userid`),
  CONSTRAINT `FK_TOKEN_USER_USER_ID` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `userpassword` varchar(50) NOT NULL,
  `userfullname` varchar(50) DEFAULT NULL,
  `useraddress` varchar(100) DEFAULT NULL,
  `userphone` varchar(20) DEFAULT NULL,
  `useractive` tinyint(1) DEFAULT NULL,
  `token` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `INDEX_USER_ID` (`userid`) USING BTREE,
  KEY `FK_USER_ROLE_ROLE_ID_idx` (`roleid`),
  CONSTRAINT `FK_USER_ROLE_ROLE_ID` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'admin','21232f297a57a5a743894a0e4a801fc3','Admin Demo','Surabaya, Indonesia','007',1,'');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-19  5:45:07
