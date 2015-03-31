CREATE TABLE `user` (
  `username` varchar(15) NOT NULL COMMENT 'Unique username of 15 characters.',
  `password` varchar(45) NOT NULL COMMENT 'Hashed with MD5',
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A table for users containing their usernames and passwords.';
CREATE TABLE `player` (
  `name` varchar(30) NOT NULL,
  `team` varchar(20) DEFAULT NULL,
  `age` date DEFAULT NULL,
  `hometown` varchar(30) DEFAULT NULL,
  `height` decimal(10,0) DEFAULT NULL COMMENT 'Inches',
  `weight` decimal(10,0) DEFAULT NULL COMMENT 'LBS',
  `yearsOfExp` int(11) DEFAULT NULL,
  `playerID` int(10) NOT NULL AUTO_INCREMENT,
  `jerseyNumber` int(11) DEFAULT NULL,
  `position` varchar(20) DEFAULT NULL,
  `createdBy` varchar(15) NOT NULL,
  PRIMARY KEY (`playerID`),
  KEY `userName_idx` (`createdBy`),
  CONSTRAINT `createdBy` FOREIGN KEY (`createdBy`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table of player records.';
CREATE TABLE `favorite` (
  `fv_username` varchar(15) NOT NULL,
  `fv_playerID` int(10) NOT NULL,
  KEY `username_idx` (`fv_username`),
  KEY `playerID_idx` (`fv_playerID`),
  CONSTRAINT `fv_playerID` FOREIGN KEY (`fv_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fv_username` FOREIGN KEY (`fv_username`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A table the holds the relationship of users and their favorited player statistics.';
CREATE TABLE `football` (
  `touchDown` int(11) DEFAULT NULL,
  `interception` int(11) DEFAULT NULL,
  `yardsRun` int(11) DEFAULT NULL,
  `fb_playerID` int(10) NOT NULL,
  KEY `playerID_idx` (`fb_playerID`),
  CONSTRAINT `fb_playerID` FOREIGN KEY (`fb_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='football career stats table.';
CREATE TABLE `basketball` (
  `pointsPerGame` int(11) DEFAULT NULL,
  `assistsPerGame` int(11) DEFAULT NULL,
  `reboundsPerGame` int(11) DEFAULT NULL,
  `bk_playerID` int(10) NOT NULL,
  KEY `playerID_idx` (`bk_playerID`),
  CONSTRAINT `bk_playerID` FOREIGN KEY (`bk_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Basketball stats.';
CREATE TABLE `baseball` (
  `batHand` varchar(1) DEFAULT NULL,
  `pitchHand` varchar(1) DEFAULT NULL,
  `average` int(11) DEFAULT NULL,
  `homerun` int(11) DEFAULT NULL,
  `runBattedIn` int(11) DEFAULT NULL,
  `onBasePercent` int(11) DEFAULT NULL,
  `bs_playerID` int(10) NOT NULL,
  KEY `bs_playerID_idx` (`bs_playerID`),
  CONSTRAINT `bs_playerID` FOREIGN KEY (`bs_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Baseball stats.';
