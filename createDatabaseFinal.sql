CREATE TABLE `user` (
  `username` varchar(15) NOT NULL COMMENT 'Unique username of 15 characters.',
  `password` varchar(45) NOT NULL COMMENT 'Hashed with MD5',
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A table for users containing their usernames and passwords.';
CREATE TABLE `player` (
  `name` varchar(30) NOT NULL,
  `team` varchar(20) DEFAULT NULL,
  `age` varchar(30) DEFAULT NULL,
  `hometown` varchar(30) DEFAULT NULL,
  `height` varchar(30) DEFAULT NULL COMMENT 'Inches',
  `weight` decimal(10,0) DEFAULT NULL COMMENT 'LBS',
  `yearsOfExp` int(11) DEFAULT NULL,
  `playerID` int(10) NOT NULL AUTO_INCREMENT,
  `jerseyNumber` int(11) DEFAULT NULL,
  `position` varchar(20) DEFAULT NULL,
  `createdBy` varchar(15) NOT NULL,
  PRIMARY KEY (`playerID`),
  KEY `userName_idx` (`createdBy`),
  CONSTRAINT `createdBy` FOREIGN KEY (`createdBy`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Table of player records.';
CREATE TABLE `favorite` (
  `fv_username` varchar(15) NOT NULL,
  `fv_playerID` int(10) NOT NULL,
  KEY `username_idx` (`fv_username`),
  KEY `playerID_idx` (`fv_playerID`),
  CONSTRAINT `fv_playerID` FOREIGN KEY (`fv_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fv_username` FOREIGN KEY (`fv_username`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A table the holds the relationship of users and their favorited player statistics.';
CREATE TABLE `basketball` (
  `pointsPerGame` mediumtext,
  `assistsPerGame` mediumtext,
  `reboundsPerGame` mediumtext,
  `bk_playerID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Basketball stats.';
CREATE TABLE `baseball` (
  `batHand` varchar(1) DEFAULT NULL,
  `pitchHand` varchar(1) DEFAULT NULL,
  `average` varchar(11) DEFAULT NULL,
  `homerun` varchar(11) DEFAULT NULL,
  `runBattedIn` varchar(11) DEFAULT NULL,
  `onBasePercent` varchar(11) DEFAULT NULL,
  `W` varchar(11) DEFAULT NULL,
  `L` varchar(11) DEFAULT NULL,
  `WLPER` varchar(45) DEFAULT NULL,
  `ERA` varchar(10) DEFAULT NULL,
  `bs_playerID` int(10) NOT NULL,
  KEY `bs_playerID_idx` (`bs_playerID`),
  CONSTRAINT `bs_playerID` FOREIGN KEY (`bs_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Baseball stats.';
CREATE TABLE `football` (
  `touchDown` varchar(11) DEFAULT NULL,
  `interception` varchar(11) DEFAULT NULL,
  `yardsPassing` varchar(11) DEFAULT NULL,
  `yardsRun` varchar(11) DEFAULT NULL,
  `yardsRecieved` varchar(11) DEFAULT NULL,
  `fumbles` varchar(11) DEFAULT NULL,
  `sacks` varchar(11) DEFAULT NULL,
  `fb_playerID` int(10) NOT NULL,
  KEY `playerID_idx` (`fb_playerID`),
  CONSTRAINT `fb_playerID` FOREIGN KEY (`fb_playerID`) REFERENCES `player` (`playerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='football career stats table.';
