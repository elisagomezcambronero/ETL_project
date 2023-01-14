-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ETL_Spotify
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lab_mysql
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema publications
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema etl_spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema etl_spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `etl_spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `etl_spotify` ;

-- -----------------------------------------------------
-- Table `etl_spotify`.`artists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`artists` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`artists` (
  `idArtist` INT NOT NULL,
  `Artist_name` VARCHAR(45) NULL DEFAULT NULL,
  `Artist_Followers` VARCHAR(45) NULL DEFAULT NULL,
  `Gender` VARCHAR(45) NULL DEFAULT NULL,
  `Artist_Generation` VARCHAR(45) NULL DEFAULT NULL,
  `Artist_Type` VARCHAR(45) NULL DEFAULT NULL,
  `Artist_Country` VARCHAR(45) NULL DEFAULT NULL,
  `Event_Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idArtist`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`event_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`event_location` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`event_location` (
  `idEventLocation` INT NOT NULL,
  `Event_Country` VARCHAR(45) NULL DEFAULT NULL,
  `Event_City` VARCHAR(45) NULL DEFAULT NULL,
  `Event_Longitude` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEventLocation`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`event_coordenates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`event_coordenates` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`event_coordenates` (
  `idEvent_Coordenates` INT NOT NULL,
  `Event_Latitude` VARCHAR(45) NULL DEFAULT NULL,
  `Event_Longitude` VARCHAR(45) NULL DEFAULT NULL,
  `event_location_idEventLocation` INT NOT NULL,
  PRIMARY KEY (`idEvent_Coordenates`, `event_location_idEventLocation`),
  INDEX `fk_event_coordenates_event_location1_idx` (`event_location_idEventLocation` ASC) VISIBLE,
  CONSTRAINT `fk_event_coordenates_event_location1`
    FOREIGN KEY (`event_location_idEventLocation`)
    REFERENCES `etl_spotify`.`event_location` (`idEventLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`events` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`events` (
  `idEvents` INT NOT NULL,
  `Event_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Url` VARCHAR(200) NULL DEFAULT NULL,
  `event_location_idEventLocation` INT NOT NULL,
  PRIMARY KEY (`idEvents`, `event_location_idEventLocation`),
  INDEX `fk_events_event_location1_idx` (`event_location_idEventLocation` ASC) VISIBLE,
  CONSTRAINT `fk_events_event_location1`
    FOREIGN KEY (`event_location_idEventLocation`)
    REFERENCES `etl_spotify`.`event_location` (`idEventLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`song_characteristics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`song_characteristics` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`song_characteristics` (
  `idSong_Characteristics` INT NOT NULL,
  `Danceability` FLOAT NULL DEFAULT NULL,
  `Energy` FLOAT NULL DEFAULT NULL,
  `Loudness` FLOAT NULL DEFAULT NULL,
  `Speechiness` FLOAT NULL DEFAULT NULL,
  `Acousticness` FLOAT NULL DEFAULT NULL,
  `Liveness` FLOAT NULL DEFAULT NULL,
  `Tempo` FLOAT NULL DEFAULT NULL,
  `Duration` FLOAT NULL DEFAULT NULL,
  `Valence` FLOAT NULL DEFAULT NULL,
  `Chord` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSong_Characteristics`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`song_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`song_genre` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`song_genre` (
  `idSong_Genre` INT NOT NULL,
  `Genre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSong_Genre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`song_popularity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`song_popularity` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`song_popularity` (
  `idTop_Song` INT NOT NULL,
  `Streams` VARCHAR(45) NULL DEFAULT NULL,
  `Top_Chart_Week` VARCHAR(45) NULL DEFAULT NULL,
  `Top_Chart_Month` VARCHAR(45) NULL DEFAULT NULL,
  `Top_Chart_Season` VARCHAR(45) NULL DEFAULT NULL,
  `Top_Chart_Year` INT NULL DEFAULT NULL,
  `Popularity_Rate` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`idTop_Song`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`song_subgenres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`song_subgenres` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`song_subgenres` (
  `idsong_subgenres` INT NOT NULL,
  `Subgenre` VARCHAR(45) NULL DEFAULT NULL,
  `Subgenre2` VARCHAR(45) NULL DEFAULT NULL,
  `song_genre_idSong_Genre` INT NOT NULL,
  PRIMARY KEY (`idsong_subgenres`, `song_genre_idSong_Genre`),
  INDEX `fk_song_subgenres_song_genre_idx` (`song_genre_idSong_Genre` ASC) VISIBLE,
  CONSTRAINT `fk_song_subgenres_song_genre`
    FOREIGN KEY (`song_genre_idSong_Genre`)
    REFERENCES `etl_spotify`.`song_genre` (`idSong_Genre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl_spotify`.`songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `etl_spotify`.`songs` ;

CREATE TABLE IF NOT EXISTS `etl_spotify`.`songs` (
  `idSongs` INT NOT NULL,
  `Song_Name` VARCHAR(200) NULL DEFAULT NULL,
  `Artist` VARCHAR(45) NULL DEFAULT NULL,
  `Release_Date` VARCHAR(45) NULL DEFAULT NULL,
  `Song_Decade` VARCHAR(45) NULL DEFAULT NULL,
  `song_genre_idSong_Genre` INT NOT NULL,
  PRIMARY KEY (`idSongs`, `song_genre_idSong_Genre`),
  INDEX `fk_songs_song_genre1_idx` (`song_genre_idSong_Genre` ASC) VISIBLE,
  CONSTRAINT `fk_songs_song_genre1`
    FOREIGN KEY (`song_genre_idSong_Genre`)
    REFERENCES `etl_spotify`.`song_genre` (`idSong_Genre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
