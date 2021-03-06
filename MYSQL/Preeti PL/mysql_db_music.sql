-- COUNTRIES

CREATE TABLE Countries(
		CountryID INT AUTO_INCREMENT,
		CountryName VARCHAR(30) NOT NULL,
		CONSTRAINT PK_Countries_CountyID PRIMARY KEY(CountryID), 	
		CONSTRAINT UQ_Countries_CountryName UNIQUE(CountryName)
);


-- STATES

CREATE TABLE States(
		StateID INT AUTO_INCREMENT,
		StateName VARCHAR(30) NOT NULL,
		CountryID INT NOT NULL,
		CONSTRAINT PK_States_StateID PRIMARY KEY(StateID), 	
		CONSTRAINT FK_Countries_States_CountyID FOREIGN KEY(CountryID) REFERENCES Countries(CountryID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- CITIES

CREATE TABLE Cities(
		CityID INT AUTO_INCREMENT,
		CityName VARCHAR(30) NOT NULL,
		StateID INT NOT NULL,
		CONSTRAINT PK_Cities_CityID PRIMARY KEY(CityID), 	
		CONSTRAINT FK_States_Cities_StateID FOREIGN KEY(StateID) REFERENCES States(StateID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- LANGUAGES

CREATE TABLE Languages(
		LanguageID INT AUTO_INCREMENT,
		LanguageName VARCHAR(30) NOT NULL,
		CONSTRAINT PK_Languages_LanguageID PRIMARY KEY(LanguageID), 	
		CONSTRAINT UQ_Languages_LanguageName UNIQUE(LanguageName)
);

-- USERS 

CREATE TABLE Users(
		UserId INT NOT NULL AUTO_INCREMENT,
		FirstName VARCHAR(30) NOT NULL,
		LastName VARCHAR(30) NOT NULL,
		UserName VARCHAR(30) NOT NULL,
		Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%_@__%.__%'),
		Password VARCHAR(20) NOT NULL, 
		Active BIT DEFAULT 1,
		Premium BIT DEFAULT 0,
		CONSTRAINT PK_Users_UserID PRIMARY KEY(UserID),	
		CONSTRAINT UQ_Users_Email UNIQUE(Email)
		 
);


-- PROFILE

CREATE TABLE Profile(
		ProfileID INT NOT NULL AUTO_INCREMENT,
		UserID INT NOT NULL,
		DOB DATE, 
		Bio TEXT,  
		Picture VARCHAR(50),
		Gender CHAR(1) NOT NULL CHECK (Gender IN('M', 'F', 'O')),
		CityID INT, 
		CONSTRAINT PK_Pofile_ProfileID PRIMARY KEY(ProfileID), 
		CONSTRAINT FK_Users_Profile FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_Cities_Profile_StateID FOREIGN KEY(CityID) REFERENCES Cities(CityID),
		CONSTRAINT UQ_Profile_UserID UNIQUE(UserID)
);

-- ARTISTS

CREATE TABLE Artists(
		ArtistId INT NOT NULL AUTO_INCREMENT,
		UserID INT NOT NULL,
		Name VARCHAR(30) NOT NULL,
		DOJ DATE NOT NULL,
		Active BIT DEFAULT 1,
		CONSTRAINT PK_Artists_ArtistID PRIMARY KEY(ArtistId),
		CONSTRAINT FK_Users_Artists FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT UQ_Artists_UserID UNIQUE(UserID)	
		
);


-- USERLANGUAGES

CREATE TABLE UserLanguages(
		UserId INT NOT NULL,
		LanguageID INT NOT NULL,
		CONSTRAINT PK_UserLanguages PRIMARY KEY(UserId, LanguageID),  
		CONSTRAINT FK_Users_UserLanguages_UserId FOREIGN KEY(UserID) REFERENCES Users(UserID)  ON DELETE NO ACTION ON UPDATE NO ACTION, 
		CONSTRAINT FK_Languages_UserLanguages_LanguageID FOREIGN KEY(LanguageID) REFERENCES Languages(LanguageID)  ON DELETE NO ACTION ON UPDATE NO ACTION 
);



-- ALBUMS

CREATE TABLE Albums(
		AlbumID INT NOT NULL AUTO_INCREMENT,
		ArtistId INT NOT NULL,
		Name VARCHAR(30) NOT NULL,
		Picture VARCHAR(30) NOT NULL,
		CountryID INT, 
		PublishedON DATE NOT NULL DEFAULT CURDATE(),
		Premium BIT DEFAULT 0,
		Active BIT DEFAULT 1,
		CONSTRAINT PK_Albums_AlbumID PRIMARY KEY(AlbumID),
		CONSTRAINT FK_Artists_Albums FOREIGN KEY(ArtistId) REFERENCES Artists(ArtistId) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_Albums_States_CountryID FOREIGN KEY(CountryID) REFERENCES Countries(CountryID) ON DELETE SET NULL ON UPDATE CASCADE
		
);


-- GENRES

CREATE TABLE Genres(
		GenreId INT NOT NULL AUTO_INCREMENT,
		Genre VARCHAR(30) NOT NULL,		
		CONSTRAINT PK_Genres_GenresId PRIMARY KEY(GenreId) 	
);


-- SONGS

CREATE TABLE Songs(
		SongID INT NOT NULL AUTO_INCREMENT,
		AlbumID INT NOT NULL,
		GenreId INT NOT NULL,
		Name VARCHAR(30) NOT NULL,
		LanguageID INT NOT NULL,
		SongFile VARCHAR(30) NOT NULL,
		SongFileType VARCHAR(5) NOT NULL CHECK (SongFileType IN('mp3', 'wav', 'm3u')),
		Duration TIME NOT NULL,
		PublishedON DATE NOT NULL DEFAULT CURDATE(),
		Active BIT DEFAULT 1,
		CONSTRAINT PK_Songs_SongID PRIMARY KEY(SongID),
		CONSTRAINT FK_Albums_Songs FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_Genres_Songs FOREIGN KEY(GenreId) REFERENCES Genres(GenreId) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_Languages_Songs_LanguageID FOREIGN KEY(LanguageID) REFERENCES Languages(LanguageID) ON DELETE CASCADE ON UPDATE CASCADE
		
);


-- PODCAST

CREATE TABLE Podcasts(
		PodcastID INT NOT NULL AUTO_INCREMENT,
		AlbumID INT NOT NULL,
		GenreId INT NOT NULL,
		Name VARCHAR(30) NOT NULL,
		LanguageID INT NOT NULL,
		PodcastFile VARCHAR(30) NOT NULL,
		PodcastFileType VARCHAR(5) NOT NULL CHECK (PodcastFileType IN('mp3', 'wav', 'm3u')),
		StreamedON DATE DEFAULT CURDATE(),
		Duration TIME NOT NULL,
		Active BIT DEFAULT 1,
		CONSTRAINT PK_Podcasts_PodcastID PRIMARY KEY(PodcastID),
		CONSTRAINT FK_Albums_Podcasts FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_Genres_Podcasts FOREIGN KEY(GenreId) REFERENCES Genres(GenreId) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_Languages_Podcasts_LanguageID FOREIGN KEY(LanguageID) REFERENCES Languages(LanguageID) ON DELETE CASCADE ON UPDATE CASCADE	
		
); 

CREATE TABLE SongLike(
		UserId INT NOT NULL,
		SongID INT NOT NULL,
		CONSTRAINT PK_SongLike PRIMARY KEY(UserId, SongID),   
		CONSTRAINT FK_Users_SongLike FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE NO ACTION ON UPDATE NO ACTION, 
		CONSTRAINT FK_Songs_SongLike FOREIGN KEY(SongID) REFERENCES Songs(SongID) ON DELETE NO ACTION ON UPDATE NO ACTION 
);


CREATE TABLE PodcastLike(
		UserId INT NOT NULL,
		PodcastID INT NOT NULL,
		CONSTRAINT PK_PodcastLike PRIMARY KEY(UserId, PodcastID),   
		CONSTRAINT FK_Users_PodcastLike FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE NO ACTION ON UPDATE NO ACTION, 
		CONSTRAINT FK_Podcasts_PodcastLike FOREIGN KEY(PodcastID) REFERENCES Podcasts(PodcastID) ON DELETE NO ACTION ON UPDATE NO ACTION 
);


CREATE TABLE AlbumLike(
		UserId INT, 
		AlbumID INT, 
		CONSTRAINT PK_AlbumLike PRIMARY KEY(UserId, AlbumID),   
		CONSTRAINT FK_Users_AlbumLike FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE NO ACTION ON UPDATE NO ACTION, 
		CONSTRAINT FK_Albums_AlbumLike FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID) ON DELETE NO ACTION ON  UPDATE NO ACTION 
);


-- PLAYLIST

CREATE TABLE Playlists(
		PlaylistID INT NOT NULL AUTO_INCREMENT,
		UserID INT NOT NULL,
		Title VARCHAR(30) NOT NULL DEFAULT 'unknown',
		CONSTRAINT PK_Playlists_PlaylistID PRIMARY KEY(PlaylistID),
		CONSTRAINT FK_Users_Playlists FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE

);


CREATE TABLE PlaylistSongs(
		PlaylistID INT NOT NULL,
		SongID INT NOT NULL,
		CONSTRAINT PK_PlaylistSongs PRIMARY KEY(PlaylistID, SongID), 
		CONSTRAINT FK_Playlists_PlaylistSongs FOREIGN KEY(PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE NO ACTION ON UPDATE NO ACTION, 
		CONSTRAINT FK_Songs_PlaylistSongs FOREIGN KEY(SongID) REFERENCES Songs(SongID) ON DELETE NO ACTION  ON UPDATE NO ACTION 
);


-- SONGSTATS

CREATE TABLE Songstats(
		SongID INT NOT NULL,
		ViewCount INT NOT NULL DEFAULT 0,
		Downloads INT NOT NULL DEFAULT 0,
		CONSTRAINT FK_Songs_Songstats FOREIGN KEY(SongID) REFERENCES Songs(SongID) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT UQ_Songstats_SongID UNIQUE(SongID)
);


-- PODCASTSTATS

CREATE TABLE Podcaststats(
		PodcastID INT NOT NULL,
		ViewCount INT NOT NULL DEFAULT 0,
		Downloads INT NOT NULL DEFAULT 0,
		CONSTRAINT FK_Podcasts_Songstats FOREIGN KEY(PodcastID) REFERENCES Podcasts(PodcastID) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT UQ_Podcaststats_SongID UNIQUE(PodcastID)
);

