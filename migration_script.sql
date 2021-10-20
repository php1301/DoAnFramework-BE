-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: ChatLife
-- Source Schemata: ChatLife
-- Created: Wed Oct 20 22:10:34 2021
-- Workbench Version: 8.0.19
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema ChatLife
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Table ChatLife.Call
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Call` (
  `Id` INT NOT NULL,
  `GroupCallCode` VARCHAR(32) NOT NULL,
  `UserCode` VARCHAR(32) NOT NULL,
  `Url` VARCHAR(500) CHARACTER SET 'utf8mb4' NOT NULL,
  `Status` VARCHAR(32) NOT NULL,
  `Created` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_Call_GroupCall`
    FOREIGN KEY (`GroupCallCode`)
    REFERENCES `GroupCall` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Call_User`
    FOREIGN KEY (`UserCode`)
    REFERENCES `User` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table ChatLife.Contact
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contact` (
  `Id` BIGINT NOT NULL,
  `UserCode` VARCHAR(32) NOT NULL,
  `ContactCode` VARCHAR(32) NOT NULL,
  `Created` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_Contact_User`
    FOREIGN KEY (`UserCode`)
    REFERENCES `User` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Contact_User1`
    FOREIGN KEY (`ContactCode`)
    REFERENCES `User` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table ChatLife.Group
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Group` (
  `Code` VARCHAR(32) NOT NULL,
  `Type` VARCHAR(32) NOT NULL COMMENT 'single: chat 1-1\r\nmulti: chat 1-n',
  `Avatar` LONGTEXT NULL,
  `Name` VARCHAR(250) CHARACTER SET 'utf8mb4' NULL,
  `Created` DATETIME(6) NOT NULL,
  `CreatedBy` VARCHAR(32) NOT NULL,
  `LastActive` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Code`));

-- ----------------------------------------------------------------------------
-- Table ChatLife.GroupCall
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupCall` (
  `Code` VARCHAR(32) NOT NULL,
  `Type` VARCHAR(32) NOT NULL COMMENT 'single: chat 1-1\r\nmulti: chat 1-n',
  `Avatar` LONGTEXT NULL,
  `Name` VARCHAR(250) CHARACTER SET 'utf8mb4' NULL,
  `Created` DATETIME(6) NOT NULL,
  `CreatedBy` VARCHAR(32) NOT NULL,
  `LastActive` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Code`));

-- ----------------------------------------------------------------------------
-- Table ChatLife.GroupUser
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `GroupUser` (
  `Id` BIGINT NOT NULL,
  `GroupCode` VARCHAR(32) NOT NULL,
  `UserCode` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_GroupUser_Group`
    FOREIGN KEY (`GroupCode`)
    REFERENCES `Group` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_GroupUser_GroupUser`
    FOREIGN KEY (`Id`)
    REFERENCES `GroupUser` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_GroupUser_User`
    FOREIGN KEY (`UserCode`)
    REFERENCES `User` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table ChatLife.Message
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Message` (
  `Id` BIGINT NOT NULL,
  `Type` VARCHAR(10) NOT NULL COMMENT 'text\r\nmedia\r\nattachment',
  `GroupCode` VARCHAR(32) NOT NULL,
  `Content` LONGTEXT CHARACTER SET 'utf8mb4' NULL,
  `Path` VARCHAR(255) CHARACTER SET 'utf8mb4' NULL,
  `Created` DATETIME(6) NOT NULL,
  `CreatedBy` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_Message_Group`
    FOREIGN KEY (`GroupCode`)
    REFERENCES `Group` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Message_User`
    FOREIGN KEY (`CreatedBy`)
    REFERENCES `User` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table ChatLife.User
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `User` (
  `Code` VARCHAR(32) NOT NULL,
  `UserName` VARCHAR(32) NULL,
  `Password` VARCHAR(124) NULL,
  `FullName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL,
  `Dob` VARCHAR(50) NULL,
  `Phone` VARCHAR(50) NULL,
  `Email` VARCHAR(50) NULL,
  `Address` VARCHAR(255) CHARACTER SET 'utf8mb4' NULL,
  `Avatar` LONGTEXT NULL,
  `Gender` VARCHAR(10) CHARACTER SET 'utf8mb4' NULL,
  `LastLogin` DATETIME(6) NULL,
  `CurrentSession` VARCHAR(500) NULL,
  PRIMARY KEY (`Code`));
SET FOREIGN_KEY_CHECKS = 1;
