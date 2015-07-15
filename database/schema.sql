-- MySQL Script generated by MySQL Workbench
-- Sat Jul 11 00:47:44 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BookDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BookDB` ;

-- -----------------------------------------------------
-- Schema BookDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BookDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `BookDB` ;

-- -----------------------------------------------------
-- Table `BookDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`User` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`User` (
  `UserID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NULL,
  `EmailAddress` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `AvatarURL` VARCHAR(50) NULL,
  `DateCreated` DATETIME NOT NULL,
  `DateUpdated` DATETIME NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`SocialProvider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`SocialProvider` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`SocialProvider` (
  `SocialProviderID` INT UNSIGNED NOT NULL,
  `SocialProviderName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SocialProviderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`AuthenticationProvider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`AuthenticationProvider` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`AuthenticationProvider` (
  `ProviderKey` INT UNSIGNED NOT NULL,
  `UserId` INT UNSIGNED NOT NULL,
  `SocialProviderID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ProviderKey`),
  INDEX `fk_AuthenticationProvider_User_idx` (`UserId` ASC),
  INDEX `fk_AuthenticationProvider_SocialProvider1_idx` (`SocialProviderID` ASC),
  CONSTRAINT `fk_AuthenticationProvider_User`
    FOREIGN KEY (`UserId`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AuthenticationProvider_SocialProvider1`
    FOREIGN KEY (`SocialProviderID`)
    REFERENCES `BookDB`.`SocialProvider` (`SocialProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Author` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Author` (
  `AuthorID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `AuthorName` VARCHAR(45) NOT NULL,
  `AuthorDescription` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Book` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Book` (
  `BookID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `AuthorID` INT UNSIGNED NOT NULL,
  `BookName` VARCHAR(45) NOT NULL,
  `BookPublisher` VARCHAR(45) NOT NULL,
  `BookYear` DATE NOT NULL,
  `BookContent` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`BookID`),
  INDEX `fk_Book_Author1_idx` (`AuthorID` ASC),
  CONSTRAINT `fk_Book_Author1`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `BookDB`.`Author` (`AuthorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Chapter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Chapter` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Chapter` (
  `ChapterID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `BookID` INT UNSIGNED NOT NULL,
  `ChapterName` VARCHAR(45) NOT NULL,
  `ChapterContent` VARCHAR(300) NOT NULL,
  `ChapterDescription` VARCHAR(300) NULL,
  PRIMARY KEY (`ChapterID`),
  INDEX `fk_Chapter_Book1_idx` (`BookID` ASC),
  CONSTRAINT `fk_Chapter_Book1`
    FOREIGN KEY (`BookID`)
    REFERENCES `BookDB`.`Book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Quote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Quote` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Quote` (
  `QuoteID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `AuthorID` INT UNSIGNED NULL,
  `UserID` INT UNSIGNED NOT NULL,
  `BookID` INT UNSIGNED NULL,
  `ChapterID` INT UNSIGNED NULL,
  `QuoteContent` VARCHAR(200) NOT NULL,
  `Certificated` SMALLINT NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`QuoteID`),
  INDEX `fk_Quote_User1_idx` (`UserID` ASC),
  INDEX `fk_Quote_Book1_idx` (`BookID` ASC),
  INDEX `fk_Quote_Chapter1_idx` (`ChapterID` ASC),
  INDEX `fk_Quote_Author1_idx` (`AuthorID` ASC),
  CONSTRAINT `fk_Quote_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quote_Book1`
    FOREIGN KEY (`BookID`)
    REFERENCES `BookDB`.`Book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quote_Chapter1`
    FOREIGN KEY (`ChapterID`)
    REFERENCES `BookDB`.`Chapter` (`ChapterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quote_Author1`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `BookDB`.`Author` (`AuthorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Post` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Post` (
  `PostID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `BookID` INT UNSIGNED NULL,
  `ChapterID` INT UNSIGNED NULL,
  `QuoteID` INT UNSIGNED NULL,
  `PostTitle` VARCHAR(45) NOT NULL,
  `language` VARCHAR(15) NOT NULL DEFAULT 'Vietnamese',
  `ViewCount` INT NOT NULL,
  `State` INT NOT NULL,
  `ReviewStar` INT NULL,
  `PostContent` VARCHAR(200) NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  `DateUpdated` DATETIME NOT NULL,
  PRIMARY KEY (`PostID`),
  INDEX `fk_Post_User1_idx` (`UserID` ASC),
  INDEX `fk_Post_Book1_idx` (`BookID` ASC),
  INDEX `fk_Post_Chapter1_idx` (`ChapterID` ASC),
  INDEX `fk_Post_Quote1_idx` (`QuoteID` ASC),
  CONSTRAINT `fk_Post_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Book1`
    FOREIGN KEY (`BookID`)
    REFERENCES `BookDB`.`Book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Chapter1`
    FOREIGN KEY (`ChapterID`)
    REFERENCES `BookDB`.`Chapter` (`ChapterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Quote1`
    FOREIGN KEY (`QuoteID`)
    REFERENCES `BookDB`.`Quote` (`QuoteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Reply` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Reply` (
  `ReplyID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `PostID` INT UNSIGNED NOT NULL,
  `ParentReplyID` INT UNSIGNED NULL,
  `UserID` INT UNSIGNED NOT NULL,
  `ViewCount` INT NOT NULL,
  `ReviewStar` INT NOT NULL,
  `ReplyContent` INT NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  `DateUpdated` DATETIME NOT NULL,
  PRIMARY KEY (`ReplyID`),
  INDEX `fk_Reply_Post1_idx` (`PostID` ASC),
  INDEX `fk_Reply_Reply1_idx` (`ParentReplyID` ASC),
  INDEX `fk_Reply_User1_idx` (`UserID` ASC),
  CONSTRAINT `fk_Reply_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reply_Reply1`
    FOREIGN KEY (`ParentReplyID`)
    REFERENCES `BookDB`.`Reply` (`ReplyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reply_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`FavoriteReading`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`FavoriteReading` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`FavoriteReading` (
  `FavoriteReadingID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NULL,
  `ReplyID` INT UNSIGNED NULL,
  PRIMARY KEY (`FavoriteReadingID`),
  INDEX `fk_ReadingList_User1_idx` (`UserID` ASC),
  INDEX `fk_FavoriteReading_Post1_idx` (`PostID` ASC),
  INDEX `fk_FavoriteReading_Reply1_idx` (`ReplyID` ASC),
  CONSTRAINT `fk_ReadingList_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FavoriteReading_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FavoriteReading_Reply1`
    FOREIGN KEY (`ReplyID`)
    REFERENCES `BookDB`.`Reply` (`ReplyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Vote` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Vote` (
  `VoteID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NULL,
  `ReplyID` INT UNSIGNED NULL,
  `QuoteID` INT UNSIGNED NULL,
  `BookID` INT UNSIGNED NULL,
  `ChapterID` INT UNSIGNED NULL,
  `VoteType` SMALLINT NULL,
  `DateCreated` VARCHAR(45) NULL,
  PRIMARY KEY (`VoteID`),
  INDEX `fk_Vote_User1_idx` (`UserID` ASC),
  INDEX `fk_Vote_Post1_idx` (`PostID` ASC),
  INDEX `fk_Vote_Reply1_idx` (`ReplyID` ASC),
  INDEX `fk_Vote_Quote1_idx` (`QuoteID` ASC),
  INDEX `fk_Vote_Book1_idx` (`BookID` ASC),
  INDEX `fk_Vote_Chapter1_idx` (`ChapterID` ASC),
  CONSTRAINT `fk_Vote_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_Reply1`
    FOREIGN KEY (`ReplyID`)
    REFERENCES `BookDB`.`Reply` (`ReplyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_Quote1`
    FOREIGN KEY (`QuoteID`)
    REFERENCES `BookDB`.`Quote` (`QuoteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_Book1`
    FOREIGN KEY (`BookID`)
    REFERENCES `BookDB`.`Book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_Chapter1`
    FOREIGN KEY (`ChapterID`)
    REFERENCES `BookDB`.`Chapter` (`ChapterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`ReadBook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`ReadBook` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`ReadBook` (
  `ReadBookID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `BookID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ReadBookID`),
  INDEX `fk_ReadBook_Book1_idx` (`BookID` ASC),
  INDEX `fk_ReadBook_User1_idx` (`UserID` ASC),
  CONSTRAINT `fk_ReadBook_Book1`
    FOREIGN KEY (`BookID`)
    REFERENCES `BookDB`.`Book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReadBook_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Tag` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Tag` (
  `TagID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ParentTagID` INT UNSIGNED NULL,
  `CreatedTagUserID` INT UNSIGNED NOT NULL,
  `TagName` VARCHAR(45) NOT NULL,
  `TagDescription` VARCHAR(100) NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`TagID`),
  INDEX `fk_Tag_User1_idx` (`CreatedTagUserID` ASC),
  CONSTRAINT `fk_Tag_User1`
    FOREIGN KEY (`CreatedTagUserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Genre` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Genre` (
  `GenreID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ParentGenreID` INT UNSIGNED NULL,
  `CreatedGenreUserID` INT UNSIGNED NOT NULL,
  `GenreName` VARCHAR(45) NOT NULL COMMENT 'for example: truyện thiếu nhi, truyện cổ tích, truyện nguyễn nhật ánh, truyện khoa học …',
  `GenreDescription` VARCHAR(100) NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`GenreID`),
  INDEX `fk_Category_User1_idx` (`CreatedGenreUserID` ASC),
  CONSTRAINT `fk_Category_User1`
    FOREIGN KEY (`CreatedGenreUserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Notification` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Notification` (
  `NotificationID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NULL,
  `ReplyID` INT UNSIGNED NULL COMMENT 'notification. state includes two states: read and not read.\nif postID != null. jump to head of page\nif replyID != null. jump to this reply ….',
  `NotificationMessage` VARCHAR(150) NOT NULL,
  `State` SMALLINT NULL,
  PRIMARY KEY (`NotificationID`),
  INDEX `fk_Notification_User1_idx` (`UserID` ASC),
  INDEX `fk_Notification_Post1_idx` (`PostID` ASC),
  INDEX `fk_Notification_Reply1_idx` (`ReplyID` ASC),
  CONSTRAINT `fk_Notification_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notification_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notification_Reply1`
    FOREIGN KEY (`ReplyID`)
    REFERENCES `BookDB`.`Reply` (`ReplyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Share`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Share` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Share` (
  `ShareID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NULL,
  `ReplyID` INT UNSIGNED NULL,
  `QuoteID` INT UNSIGNED NULL,
  `SocialProviderID` INT UNSIGNED NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`ShareID`),
  INDEX `fk_Share_User1_idx` (`UserID` ASC),
  INDEX `fk_Share_SocialProvider1_idx` (`SocialProviderID` ASC),
  INDEX `fk_Share_Post1_idx` (`PostID` ASC),
  INDEX `fk_Share_Reply1_idx` (`ReplyID` ASC),
  INDEX `fk_Share_Quote1_idx` (`QuoteID` ASC),
  CONSTRAINT `fk_Share_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Share_SocialProvider1`
    FOREIGN KEY (`SocialProviderID`)
    REFERENCES `BookDB`.`SocialProvider` (`SocialProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Share_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Share_Reply1`
    FOREIGN KEY (`ReplyID`)
    REFERENCES `BookDB`.`Reply` (`ReplyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Share_Quote1`
    FOREIGN KEY (`QuoteID`)
    REFERENCES `BookDB`.`Quote` (`QuoteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`SubscribePost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`SubscribePost` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`SubscribePost` (
  `SubscribePostID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NOT NULL,
  `ReplyID` INT UNSIGNED NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`SubscribePostID`),
  INDEX `fk_SubscribePost_User1_idx` (`UserID` ASC),
  INDEX `fk_SubscribePost_Post1_idx` (`PostID` ASC),
  INDEX `fk_SubscribePost_Reply1_idx` (`ReplyID` ASC),
  CONSTRAINT `fk_SubscribePost_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SubscribePost_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SubscribePost_Reply1`
    FOREIGN KEY (`ReplyID`)
    REFERENCES `BookDB`.`Reply` (`ReplyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`SubscribeUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`SubscribeUser` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`SubscribeUser` (
  `SubscribeUserID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `MainUserID` INT UNSIGNED NOT NULL,
  `FollowingUserID` INT UNSIGNED NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`SubscribeUserID`),
  INDEX `fk_SubcribeUser_User1_idx` (`MainUserID` ASC),
  INDEX `fk_SubcribeUser_User2_idx` (`FollowingUserID` ASC),
  CONSTRAINT `fk_SubcribeUser_User1`
    FOREIGN KEY (`MainUserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SubcribeUser_User2`
    FOREIGN KEY (`FollowingUserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`BlogPost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`BlogPost` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`BlogPost` (
  `BlogPostID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `BlogTitle` VARCHAR(45) NOT NULL,
  `BlogContent` VARCHAR(500) NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  `DateUpdated` DATETIME NOT NULL,
  PRIMARY KEY (`BlogPostID`),
  INDEX `fk_BlogPost_User1_idx` (`UserID` ASC),
  CONSTRAINT `fk_BlogPost_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`SubscribeGenre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`SubscribeGenre` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`SubscribeGenre` (
  `SubscribeGenreID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `GenreID` INT UNSIGNED NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  PRIMARY KEY (`SubscribeGenreID`),
  INDEX `fk_SubscribeCategory_User1_idx` (`UserID` ASC),
  INDEX `fk_SubscribeCategory_Category1_idx` (`GenreID` ASC),
  CONSTRAINT `fk_SubscribeCategory_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SubscribeCategory_Category1`
    FOREIGN KEY (`GenreID`)
    REFERENCES `BookDB`.`Genre` (`GenreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Activity` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Activity` (
  `ActivityID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `ProfileView` INT NOT NULL,
  `LastLoginIP` INT NOT NULL,
  PRIMARY KEY (`ActivityID`),
  INDEX `fk_Activity_User1_idx` (`UserID` ASC),
  CONSTRAINT `fk_Activity_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Song` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Song` (
  `SongID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `AuthorID` INT UNSIGNED NOT NULL,
  `SongName` VARCHAR(45) NOT NULL,
  `SongContent` VARCHAR(200) NOT NULL,
  `SongPublishYear` DATETIME NOT NULL,
  PRIMARY KEY (`SongID`),
  INDEX `fk_Song_Author1_idx` (`AuthorID` ASC),
  CONSTRAINT `fk_Song_Author1`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `BookDB`.`Author` (`AuthorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`PostTag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`PostTag` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`PostTag` (
  `PostTagID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `TagID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`PostTagID`),
  INDEX `fk_PostTag_Post1_idx` (`PostID` ASC),
  INDEX `fk_PostTag_Tag1_idx` (`TagID` ASC),
  CONSTRAINT `fk_PostTag_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PostTag_Tag1`
    FOREIGN KEY (`TagID`)
    REFERENCES `BookDB`.`Tag` (`TagID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`PostGenre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`PostGenre` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`PostGenre` (
  `PostGenreID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `GenreID` INT UNSIGNED NOT NULL,
  `PostID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`PostGenreID`),
  INDEX `fk_PostGenre_Post1_idx` (`PostID` ASC),
  INDEX `fk_PostGenre_Genre1_idx` (`GenreID` ASC),
  CONSTRAINT `fk_PostGenre_Post1`
    FOREIGN KEY (`PostID`)
    REFERENCES `BookDB`.`Post` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PostGenre_Genre1`
    FOREIGN KEY (`GenreID`)
    REFERENCES `BookDB`.`Genre` (`GenreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`TopicCoverImage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`TopicCoverImage` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`TopicCoverImage` (
  `TopicCoverImageID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `BookID` INT UNSIGNED NULL,
  `ChapterID` INT UNSIGNED NULL,
  `ImageURL` VARCHAR(50) NOT NULL,
  `DateCreated` DATETIME NULL,
  PRIMARY KEY (`TopicCoverImageID`),
  INDEX `fk_TopicCoverImage_User1_idx` (`UserID` ASC),
  INDEX `fk_TopicCoverImage_Book1_idx` (`BookID` ASC),
  INDEX `fk_TopicCoverImage_Chapter1_idx` (`ChapterID` ASC),
  CONSTRAINT `fk_TopicCoverImage_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TopicCoverImage_Book1`
    FOREIGN KEY (`BookID`)
    REFERENCES `BookDB`.`Book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TopicCoverImage_Chapter1`
    FOREIGN KEY (`ChapterID`)
    REFERENCES `BookDB`.`Chapter` (`ChapterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookDB`.`Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookDB`.`Profile` ;

CREATE TABLE IF NOT EXISTS `BookDB`.`Profile` (
  `ProfileID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` INT UNSIGNED NOT NULL,
  `Quote` VARCHAR(200) NULL,
  `About` VARCHAR(200) NULL,
  `HomePage` VARCHAR(45) NULL,
  `DateCreated` DATETIME NOT NULL,
  `DateUpdated` DATETIME NOT NULL,
  PRIMARY KEY (`ProfileID`),
  INDEX `fk_Profile_User1_idx` (`UserID` ASC),
  CONSTRAINT `fk_Profile_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `BookDB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
