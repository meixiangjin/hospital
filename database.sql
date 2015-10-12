CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 5.6.11, for Win32 (x86)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.6.13-log

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
-- Table structure for table `adminstaff`
--

DROP TABLE IF EXISTS `adminstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminstaff` (
  `AdminStaffID` int(11) NOT NULL,
  `UserName` varchar(50) DEFAULT NULL,
  `Password` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`AdminStaffID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminstaff`
--

LOCK TABLES `adminstaff` WRITE;
/*!40000 ALTER TABLE `adminstaff` DISABLE KEYS */;
INSERT INTO `adminstaff` VALUES (1,'admin','admin');
/*!40000 ALTER TABLE `adminstaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `QuestonID` int(11) NOT NULL,
  `PhysicianID` int(11) NOT NULL,
  `Content` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`QuestonID`,`PhysicianID`),
  KEY `fk_Ans_Ques_idx` (`QuestonID`),
  KEY `fk_Ans_Phys_idx` (`PhysicianID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,9,'KLA'),(1,10,''),(2,9,'Cat'),(2,10,''),(3,9,'VT'),(3,10,''),(4,9,'Peter'),(4,10,''),(5,9,'Red'),(5,10,'');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `AppointmentID` int(11) NOT NULL,
  `PatientID` int(11) DEFAULT NULL,
  `PhysicianID` int(11) DEFAULT NULL,
  `AdminStaffID` int(11) DEFAULT NULL,
  `AppointmentTime` datetime DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `fk_Appoint_Patient_idx` (`PatientID`),
  KEY `fk_Appoint_Physic_idx` (`PhysicianID`),
  KEY `fk_Appoint_Admin_idx` (`AdminStaffID`),
  CONSTRAINT `fk_Appoint_Admin` FOREIGN KEY (`AdminStaffID`) REFERENCES `adminstaff` (`AdminStaffID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appoint_Patient` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appoint_Physic` FOREIGN KEY (`PhysicianID`) REFERENCES `physician` (`PhysicianID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `DeptID` int(11) NOT NULL,
  `DeptName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`DeptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (0,'N/A');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergencycontact`
--

DROP TABLE IF EXISTS `emergencycontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emergencycontact` (
  `PatientID` int(11) NOT NULL,
  `FirstName` varchar(80) DEFAULT NULL,
  `LastName` varchar(80) DEFAULT NULL,
  `PhoneNumber` varchar(12) DEFAULT NULL,
  `EmailAddress` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  CONSTRAINT `fk_Emer_Patient` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergencycontact`
--

LOCK TABLES `emergencycontact` WRITE;
/*!40000 ALTER TABLE `emergencycontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `emergencycontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurancecompany`
--

DROP TABLE IF EXISTS `insurancecompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurancecompany` (
  `InsuranceComID` int(11) NOT NULL,
  `InsuranceName` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`InsuranceComID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurancecompany`
--

LOCK TABLES `insurancecompany` WRITE;
/*!40000 ALTER TABLE `insurancecompany` DISABLE KEYS */;
/*!40000 ALTER TABLE `insurancecompany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `PatientID` int(11) NOT NULL,
  `FirstName` varchar(80) DEFAULT NULL,
  `LastName` varchar(80) DEFAULT NULL,
  `Street` varchar(100) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `ZipCode` char(5) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(12) DEFAULT NULL,
  `EmailAddress` varchar(80) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `InsuranceComID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `fk_Patient_Insurance_idx` (`InsuranceComID`),
  CONSTRAINT `fk_Patient_Insurance` FOREIGN KEY (`InsuranceComID`) REFERENCES `insurancecompany` (`InsuranceComID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL,
  `VistiRecordID` int(11) DEFAULT NULL,
  `Amount` double DEFAULT NULL,
  `BillingDate` datetime DEFAULT NULL,
  `PaymentDate` datetime DEFAULT NULL,
  `InsuranceComID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `fk_Payment_Vsit_idx` (`VistiRecordID`),
  KEY `fk_Payment_Insurance_idx` (`InsuranceComID`),
  CONSTRAINT `fk_Payment_Insurance` FOREIGN KEY (`InsuranceComID`) REFERENCES `insurancecompany` (`InsuranceComID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Vsit` FOREIGN KEY (`VistiRecordID`) REFERENCES `visitrecord` (`VisitRecordID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physician`
--

DROP TABLE IF EXISTS `physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physician` (
  `PhysicianID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(80) DEFAULT NULL,
  `LastName` varchar(80) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(12) DEFAULT NULL,
  `EmailAddress` varchar(80) DEFAULT NULL,
  `SpecID` int(11) DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL,
  `UserName` varchar(50) DEFAULT NULL,
  `Password` varchar(200) DEFAULT NULL,
  `FirstLogin` int(11) DEFAULT '0',
  `Active` int(11) DEFAULT '1',
  PRIMARY KEY (`PhysicianID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`),
  KEY `fk_Physician_Specialty_idx` (`SpecID`),
  KEY `fk_Physician_Dept_idx` (`DeptID`),
  CONSTRAINT `fk_Physician_Dept` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Physician_Specialty` FOREIGN KEY (`SpecID`) REFERENCES `specialty` (`SpecID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physician`
--

LOCK TABLES `physician` WRITE;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` VALUES (9,'Tom','Cruise','123 Main Street','1234567890','tom@gmail.com',0,0,'tom','tom',0,0),(10,'peter','peter','NA','NA','NA',0,0,'peter','peter',0,1);
/*!40000 ALTER TABLE `physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `QuestionID` int(11) NOT NULL,
  `Content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'What is your first school?'),(2,'What is your favourite pet?'),(3,'Where were you born?'),(4,'What is your first teacher\'s name?'),(5,'Which color do you like?');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialty`
--

DROP TABLE IF EXISTS `specialty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialty` (
  `SpecID` int(11) NOT NULL,
  `SpecName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SpecID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialty`
--

LOCK TABLES `specialty` WRITE;
/*!40000 ALTER TABLE `specialty` DISABLE KEYS */;
INSERT INTO `specialty` VALUES (0,'N/A');
/*!40000 ALTER TABLE `specialty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treatment` (
  `TreatmentID` int(11) NOT NULL,
  `PatientID` int(11) DEFAULT NULL,
  `PhysicianID` int(11) DEFAULT NULL,
  `Role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`TreatmentID`),
  KEY `fk_Treat_Patient_idx` (`PatientID`),
  KEY `fk_Treat_Physician_idx` (`PhysicianID`),
  CONSTRAINT `fk_Treat_Patient` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treat_Physician` FOREIGN KEY (`PhysicianID`) REFERENCES `physician` (`PhysicianID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitrecord`
--

DROP TABLE IF EXISTS `visitrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitrecord` (
  `VisitRecordID` int(11) NOT NULL,
  `VisitTime` datetime DEFAULT NULL,
  `Reason` varchar(200) DEFAULT NULL,
  `Result` varchar(200) DEFAULT NULL,
  `AppointmentID` int(11) NOT NULL,
  PRIMARY KEY (`VisitRecordID`),
  KEY `fk_Visit_Appoint_idx` (`AppointmentID`),
  CONSTRAINT `fk_Visit_Appoint` FOREIGN KEY (`AppointmentID`) REFERENCES `appointment` (`AppointmentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitrecord`
--

LOCK TABLES `visitrecord` WRITE;
/*!40000 ALTER TABLE `visitrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitrecord` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-04 22:44:31
