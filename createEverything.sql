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

INSERT INTO `user`(`username`, `password`) VALUES ('Admin',md5('password'));

INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Joel Anthony', 'Boston Celtics', '32', 'Montreal, Canada', '6-9', '245', '6', '50', 'C', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Chris Babb', 'Boston Celtics', '25', 'Arlington, Texas', '6-5', '225', '1', '52', 'SG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Brandon Bass', 'Boston Celtics', '30', 'Baton Rouge, Lousiana', '6-8', '240', '8', '30', 'PF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jerryd Bayless', 'Boston Celtics', '27', 'Phoenix, Arizona', '6-3', '200', '5', '11', 'PG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Vander Blue', 'Boston Celtics', '23', 'Milwaukee, Wisconsin', '6-4', '200', '1', '13', 'SG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Keith Bogans', 'Boston Celtics', '35', 'Alexandria, Virginia', '6-5', '215', '10', '4', 'SG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Avery Bradley', 'Boston Celtics', '25', 'Tacoma, Washington', '6-2', '180', '3', '0', 'PG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('MarShon Brooks', 'Boston Celtics', '26', 'Long Branch, New Jersey', '6-5', '200', '2', '12', 'SG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jordan Crawford', 'Boston Celtics', '27', 'Detroit, Michigan', '6-4', '195', '3', '27', 'SG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Vitor Faverani', 'Boston Celtics', '27', 'Porto, Alegre', '6-11', '260', '1', '38', 'C', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jeff Green', 'Boston Celtics', '29', 'Cheverly, Maryland', '6-9', '235', '5', '8', 'SF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Kris Humphries', 'Boston Celtics', '30', 'Minneapolis, Minnesota', '6-9', '235', '9', '43', 'PF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Chris Johnson', 'Boston Celtics', '25', 'Orlando, Florida', '6-6', '201', '1', '12', 'SF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Courtney Lee', 'Boston Celtics', '30', 'Indianapolis, Indiana', '6-5', '200', '5', '11', 'SG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Kelly Olynyk', 'Boston Celtics', '24', 'Toronto, Canada', '7-0', '238', '1', '41', 'C', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Phil Pressey', 'Boston Celtics', '24', 'Dallas, Texas', '5-11', '175', '1', '26', 'PG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Rajon Rondo', 'Boston Celtics', '29', 'Louisville, Kentucky', '6-1', '171', '7', '9', 'PG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jared Sullinger', 'Boston Celtics', '22', 'Columbus, Ohio', '6-9', '280', '1', '7', 'PF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Gerald Wallace', 'Boston Celtics', '32', 'Sylacauga, Alabama', '6-7', '215', '12', '45', 'SF', 'Admin');

INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('1', '0.1', '1.5', '1');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('1.6', '0.2', '1.2', '2');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('11.1', '1.1', '5.7', '3');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('10.1', '3.1', '2.1', '4');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('1.7', '0.3', '1', '5');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('2', '0.5', '0.5', '6');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('14.9', '1.4', '3.8', '7');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('3.1', '0.4', '1.9', '8');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('13.7', '5.7', '3.1', '9');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('4.4', '0.4', '3.5', '10');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('16.9', '1.7', '4.6', '11');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('8.4', '1', '5.9', '12');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('6.3', '0.8', '2.4', '13');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('7.4', '1.1', '1.6', '14');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('8.7', '1.6', '5.2', '15');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('2.8', '3.2', '1.4', '16');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('11.7', '9.8', '5.5', '17');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('13.3', '1.6', '8.1', '18');
INSERT INTO basketball (`pointsPerGame`, `assistsPerGame`, `reboundsPerGame`, `bk_playerID`) VALUES ('5.1', '2.5', '3.7', '19');

INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('A.J. Pierzynski', 'Boston Red Sox', '37', 'Bridgehampton, NY', '6-3', '235', '17', '35', 'C', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Mike Napoli', 'Boston Red Sox', '32', 'Hollywood, FL', '6-1', '225', '8', '12', '1B', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Dustin Pedroia', 'Boston Red Sox', '30', 'Woodland, CA', '5-9', '175', '8', '15', '2B', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Xander Bogaerts', 'Boston Red Sox', '21', 'Oranjestad, Aruba', '6-1', '210', '2', '2', 'SS', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Will Middlebrooks', 'Boston Red Sox', '25', 'Greenville, Texas', '6-3', '220', '2', '16', '3B', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jonny Gomes', 'Boston Red Sox', '33', 'Petaluma, CA', '6-1', '230', '11', '5', 'LF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jackie Bradley', 'Boston Red Sox', '24', 'Richmond, VA', '5-10', '200', '2', '25', 'CF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Daniel Nava', 'Boston Red Sox', '31', 'Redwood City, CA', '5-11', '200', '4', '29', 'RF', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('David Ortiz', 'Boston Red Sox', '38', 'Santo, DR', '6-3', '230', '12', '34', 'DH', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Clay Buchholz', 'Boston Red Sox', '29', 'Nederland, TX', '6-3', '190', '7', '11', 'SP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jon Lester', 'Boston Red Sox', '30', 'Tacoma, WA', '6-3', '240', '8', '31', 'SP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('John Lackey', 'Boston Red Sox', '35', 'Abilene, TX', '6-6', '235', '12', '41', 'SP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jake Peavy', 'Boston Red Sox', '33', 'Mobile, AL', '6-1', '195', '12', '44', 'SP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Rubby De La Rosa', 'Boston Red Sox', '25', 'Santo, DR', '6-1', '225', '3', '62', 'SP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Brandon Workman', 'Boston Red Sox', '25', 'Arlington, TX', '6-5', '235', '4', '67', 'SP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Koji Uehara', 'Boston Red Sox', '39', 'Osaka, Japan', '6-2', '195', '5', '19', 'CL', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Burke Badenhop', 'Boston Red Sox', '31', 'Atlanta, GA', '6-5', '210', '6', '35', 'RP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Junichi Tazawa', 'Boston Red Sox', '28', 'Yokohama, Japan', '5-11', '200', '3', '36', 'RP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Edward Mujica', 'Boston Red Sox', '30', 'Valencia, Venezuela', '6-3', '220', '6', '54', 'RP', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Craig Breslow', 'Boston Red Sox', '33', 'New Haven, CT', '6-1', '185', '6', '32', 'RP', 'Admin');

INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('L', '', '0.254', '4', '31', '0.286', '', '', '', '', '20');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('R', '', '0.248', '17', '55', '0.37', '', '', '', '', '21');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('R', '', '0.278', '7', '53', '0.337', '', '', '', '', '22');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('R', '', '0.24', '12', '46', '0.297', '', '', '', '', '23');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('R', '', '0.191', '2', '19', '0.256', '', '', '', '', '24');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('R', '', '0.234', '6', '32', '0.329', '', '', '', '', '25');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('L', '', '0.198', '1', '30', '0.265', '', '', '', '', '26');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('L', '', '0.27', '4', '37', '0.346', '', '', '', '', '27');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('L', '', '0.263', '35', '104', '0.355', '', '', '', '', '28');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '8', '11', '0.421', '5.34', '29');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'L', '', '', '', '', '10', '7', '0.588', '2.52', '30');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '11', '7', '0.611', '3.6', '31');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '1', '9', '0.1', '4.72', '32');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '4', '8', '0.333', '4.43', '33');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '1', '10', '0.091', '5.17', '34');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '6', '5', '0.545', '2.52', '35');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '0', '3', '0', '2.29', '36');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '4', '3', '0.571', '2.86', '37');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'R', '', '', '', '', '2', '4', '0.333', '3.9', '38');
INSERT INTO baseball (`batHand`, `pitchHand`, `average`, `homerun`, `runBattedIn`, `onBasePercent`, `W`, `L`, `WLPER`, `ERA`, `bs_playerID`) VALUES ('', 'L', '', '', '', '', '2', '4', '0.333', '5.96', '39');

INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Tom Brady', 'New England Patriots', '37', 'San Mateo, CA', '6-4', '225', '14', '12', 'QB', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('LeGarrette Blount', 'New England Patriots', '29', 'Madison, FL', '6-1', '245', '5', '29', 'RB', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Julian Edelman', 'New England Patriots', '28', 'Redwood City, CA', '6-0', '198', '5', '11', 'WR', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Brandon LaFell', 'New England Patriots', '28', 'Houston, TX', '6-2', '208', '4', '19', 'WR', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Rob Gronkowski', 'New England Patriots', '25', 'Amherst, NY', '6-6', '265', '4', '87', 'TE', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Michael Hoomanawanui', 'New England Patriots', '26', 'Bloomington, IL', '6-3', '271', '4', '44', 'TE', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Nate Solder', 'New England Patriots', '26', 'Denver, CO', '6-8', '314', '3', '77', 'LT', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Daniel Connolly', 'New England Patriots', '32', 'St. Louis, MO', '6-4', '311', '9', '63', 'LG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Bryan Stork', 'New England Patriots', '24', 'Vero Beach, FL', '6-5', '315', '1', '66', 'C', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Ryan Wendell', 'New England Patriots', '28', 'Pomona, TX', '6-2', '275', '5', '62', 'RG', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Sebastian Vollmer', 'New England Patriots', '30', 'Dusseldorf, Germany', '6-8', '315', '5', '76', 'RT', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Rob Ninkovich', 'New England Patriots', '30', 'New Lenox, IL', '6-3', '251', '8', '50', 'LDE', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Vince Wilfork', 'New England Patriots', '33', 'Boynton Beach, FL', '6-2', '325', '10', '75', 'DT', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Jamie Collins', 'New England Patriots', '24', 'McCall Creek, MS', '6-4', '250', '1', '91', 'LB', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Donta Hightower', 'New England Patriots', '24', 'Lewisburg, TN', '6-2', '266', '2', '54', 'LB', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Darrelle Revis', 'New England Patriots', '29', 'Aliquippa, PA', '6-0', '205', '7', '24', 'LCB', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Patrick Chung', 'New England Patriots', '27', 'Kingston, Jamaica', '5-11', '207', '5', '23', 'S', 'Admin');
INSERT INTO player (`name`, `team`, `age`, `hometown`, `height`, `weight`, `yearsOfExp`, `jerseyNumber`, `position`, `createdBy`) VALUES ('Devin McCourty', 'New England Patriots', '27', 'Nanuet, NY', '5-10', '186', '4', '32', 'S', 'Admin');

INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('33', '9', '4109', '57', '', '', '', '40');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('3', '', '', '281', '18', '', '', '41');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('4', '', '', '94', '972', '', '', '42');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('7', '', '', '13', '953', '', '', '43');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('12', '', '', '', '1124', '', '', '44');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '44', '', '', '45');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '46');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '47');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '48');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '49');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '1', '', '', '', '', '8', '50');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '51');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '52');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '53');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '', '', '', '', '', '', '54');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '2', '', '', '', '', '', '55');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '1', '', '', '', '', '', '56');
INSERT INTO football (`touchDown`, `interception`, `yardsPassing`, `yardsRun`, `yardsRecieved`, `fumbles`, `sacks`, `fb_playerID`) VALUES ('', '2', '', '', '', '', '', '57');
