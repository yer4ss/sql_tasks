CREATE TABLE Musical_genre (
    musical_genre_id INT PRIMARY KEY,
    musical_genre VARCHAR(100) NOT NULL
);

CREATE TABLE Recording_artist (
    recording_artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL
);

CREATE TABLE Album (
    album_id INT PRIMARY KEY,
    musical_genre_id INT NOT NULL,
    recording_artist_id INT NOT NULL,
    album_name VARCHAR(100) NOT NULL,
    suggested_price DECIMAL(4,2)
);

CREATE TABLE Song (
    song_id INT PRIMARY KEY,
    album_id INT NOT NULL,
    song_name VARCHAR(100) NOT NULL,
    song_length_minutes INT NOT NULL,
    song_length_seconds INT NOT NULL
);




ALTER TABLE Album
ADD CONSTRAINT fk_album_genre FOREIGN KEY (musical_genre_id)
REFERENCES Musical_genre(musical_genre_id);

ALTER TABLE Album
ADD CONSTRAINT fk_album_artist FOREIGN KEY (recording_artist_id)
REFERENCES Recording_artist(recording_artist_id);

ALTER TABLE Song
ADD CONSTRAINT fk_song_album FOREIGN KEY (album_id)
REFERENCES Album(album_id);




INSERT INTO Musical_genre (musical_genre_id, musical_genre)
VALUES
(1, 'big band'),
(2, 'rock'),
(3, 'world'),
(4, 'wountry'),
(5, 'new age'),
(6, 'heavy metal');

INSERT INTO Recording_artist (recording_artist_id, artist_name)
VALUES
(1, 'april wine'),
(2, 'enya'),
(3, 'elvis costello');

INSERT INTO Album (album_id, musical_genre_id, recording_artist_id, album_name, suggested_price)
VALUES
(1, 2, 1, 'power play', 15.99),
(2, 5, 2, 'a day without rain', 13.75),
(3, 2, 3, 'armed forces', 12.99),
(4, 2, 1, 'nature of the beast', NULL);

INSERT INTO Song (song_id, album_id, song_name, song_length_minutes, song_length_seconds)
VALUES
(1, 1, 'doin it right', 3, 42),
(2, 1, 'aint got your love', 4, 33),
(3, 1, 'if you see kay', 3, 59),
(4, 1, 'tell me why', 3, 59),
(5, 2, 'fairytaly', 3, 03),
(6, 2, 'sun steram', 2, 55),
(7, 2, 'deiradh jkahfhgr', 3, 50),
(8, 3, 'olivers army', 2, 55),
(9, 3, 'peace love', 3, 31),
(10, 3, 'moods for moders', 3, 50),
(11, 4, 'all over town', 3, 50),
(12, 4, 'tellin me liers', 3, 50);



SELECT COUNT(song_id) FROM Song;


SELECT MIN(suggested_price), MAX(suggested_price) FROM Album;


SELECT a.album_name, COUNT(s.song_id)
FROM Album a
LEFT JOIN Song s ON a.album_id = s.album_id
GROUP BY a.album_name;


SELECT mg.musical_genre, COUNT(s.song_id)
FROM Musical_genre mg
JOIN Album a ON mg.musical_genre_id = a.musical_genre_id
JOIN Song s ON a.album_id = s.album_id
GROUP BY mg.musical_genre;


SELECT ra.artist_name, COUNT(s.song_id)
FROM Recording_artist ra
JOIN Album a ON ra.recording_artist_id = a.recording_artist_id
JOIN Musical_genre mg ON a.musical_genre_id = mg.musical_genre_id
JOIN Song s ON a.album_id = s.album_id
WHERE mg.musical_genre = 'Rock'
GROUP BY ra.artist_name
HAVING COUNT(s.song_id) > 1





CREATE TABLE resort_type (
    resort_type_id INT PRIMARY KEY, 
    resort_type VARCHAR(100) NOT NULL
);

CREATE TABLE resort (
    resort_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    resort_type_id INT NOT NULL
);

CREATE TABLE accommodations (
    accommodations_id INT PRIMARY KEY,
    resort_id INT NOT NULL,
    description VARCHAR(100) NOT NULL,
    cost_per_night DECIMAL(10,2) 
);




ALTER TABLE resort
ADD CONSTRAINT fk_resort_type FOREIGN KEY (resort_type_id)
REFERENCES resort_type(resort_type_id);

ALTER TABLE accommodations
ADD CONSTRAINT fk_accommodations_resort FOREIGN KEY (resort_id)
REFERENCES resort(resort_id);




INSERT INTO resort_type (resort_type_id, resort_type) VALUES 
(1, 'ocean'),
(2, 'lakeside'),
(3, 'mountaintop'),
(4, 'country');

INSERT INTO resort (resort_id, resort_type_id, name) VALUES 
(1, 1, 'light of the ocean'),
(2, 1, 'breathtaking bahamas'),
(3, 2, 'greater lakes'),
(4, 3, 'mountainous mexico');

INSERT INTO accommodations (accommodations_id, resort_id, description, cost_per_night) VALUES 
(1, 1, 'bungalow 1', 289),
(2, 1, 'bungalow 2', 289),
(3, 1, 'bungalow 3', 325),
(4, 2, 'suite 101', 199),
(5, 2, 'suite 102', 199),
(6, 2, 'suite 201', 250),
(7, 2, 'suite 202', 250),
(8, 4, 'room 10', 150),
(9, 4, 'room 20', 150),
(10, 3, 'cabin a', 300),
(11, 3, 'cabin b', 300),
(12, 3, 'cabin c', 350);

SELECT COUNT(accommodations_id) COUNT
FROM accommodations;

SELECT MIN(cost_per_night) MIN
FROM accommodations;

SELECT SUM(cost_per_night) SUM
FROM accommodations;

SELECT resort_type.resort_type_id, resort_type.resort_type,
  COUNT(resort.resort_id) AS nr_resorts
FROM resort_type
JOIN resort ON resort_type.resort_type_id = resort.resort_type_id
GROUP BY resort_type.resort_type_id, resort_type.resort_type
ORDER BY nr_resorts DESC;

SELECT resort_type.resort_type_id, resort_type.resort_type,
  COUNT(accommodations.accommodations_id) AS nr_accommodations
FROM resort_type
JOIN resort ON resort_type.resort_type_id = resort.resort_type_id
JOIN accommodations ON accommodations.resort_id = resort.resort_id
GROUP BY resort_type.resort_type_id, resort_type.resort_type
HAVING COUNT(accommodations.accommodations_id) < 3;