DROP DATABASE IF EXISTS newtube;

CREATE DATABASE newtube;
USE newtube;

-- CREATING TABLES
-- User

CREATE TABLE `user` (
  `id_user` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `email` varchar(15),
  `password` varchar(15),
  `birth_date` date,
  `genre` varchar(15),
  `address` varchar(100),
  `country` varchar(15),
  `zipcode` int
);

-- Video

CREATE TABLE `video` (
  `id_video` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_creator` int NOT NULL,
  `id_channel` int,
  `id_playlist` int,
  `title` varchar(25),
  `status` enum('public', 'private', 'hidden'),
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(255),
  `views` int,
  `dimension` varchar(15),
  `filetype` varchar(15),
  `length` time,
  `thumbnail` varchar(255)
);

-- Channel

CREATE TABLE `channel` (
  `id_channel` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(25),
  `description` varchar(255),
  `id_creator` int NOT NULL
);

-- Playlist

CREATE TABLE `playlist` (
  `id_playlist` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(25),
  `status` enum('public', 'private'),
  `id_creator` int NOT NULL
);

-- Tag

CREATE TABLE `tag` (
  `id_tag` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(15),
  `description` varchar(255)
);

-- Comment

CREATE TABLE `comment` (
  `id_comment` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_video` int NOT NULL,
  `id_creator` int NOT NULL,
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `text` varchar(255),
  `likes` int,
  `replies_to` int
);


-- Video_has_tag

CREATE TABLE `video_has_tag` (
  `id_video` int NOT NULL,
  `id_tag` int NOT NULL,
  PRIMARY KEY (`id_video`, `id_tag`)
);

-- Playlist_has_video

CREATE TABLE `playlist_has_video` (
  `id_playlist` int NOT NULL,
  `id_video` int NOT NULL,
  PRIMARY KEY (`id_playlist`, `id_video`)
);

-- User_follows_channel

CREATE TABLE `user_follows_channel` (
  `id_user` int NOT NULL,
  `id_channel` int NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (`id_user`, `id_channel`)
);

-- Video Like_dislike

CREATE TABLE `video_like_dislike` (
  `id_user` int NOT NULL,
  `id_video` int NOT NULL,
  `type` enum('like', 'dislike') NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`, `id_video`, `type`)
);

-- Comment Like_dislike

CREATE TABLE `comment_like_dislike` (
  `id_user` int NOT NULL,
  `id_comment` int NOT NULL,
  `type` enum('like', 'dislike') NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`, `id_comment`, `type`)
);


-- ADDING FOREIGN KEYS


ALTER TABLE `user_follows_channel` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

ALTER TABLE `user_follows_channel` ADD FOREIGN KEY (`id_channel`) REFERENCES `channel` (`id_channel`);

ALTER TABLE `video_like_dislike` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

ALTER TABLE `video_like_dislike` ADD FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`);

ALTER TABLE `comment_like_dislike` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

ALTER TABLE `comment_like_dislike` ADD FOREIGN KEY (`id_comment`) REFERENCES `comment` (`id_comment`);

ALTER TABLE `channel` ADD FOREIGN KEY (`id_creator`) REFERENCES `user` (`id_user`);

ALTER TABLE `playlist` ADD FOREIGN KEY (`id_creator`) REFERENCES `user` (`id_user`);

ALTER TABLE `video` ADD FOREIGN KEY (`id_creator`) REFERENCES `user` (`id_user`);

ALTER TABLE `video` ADD FOREIGN KEY (`id_channel`) REFERENCES `channel` (`id_channel`);

ALTER TABLE `video` ADD FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id_playlist`);

ALTER TABLE `video_has_tag` ADD FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`);

ALTER TABLE `video_has_tag` ADD FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id_tag`);

ALTER TABLE `playlist_has_video` ADD FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id_playlist`);

ALTER TABLE `playlist_has_video` ADD FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`);

ALTER TABLE `comment` ADD FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`);

ALTER TABLE `comment` ADD FOREIGN KEY (`id_creator`) REFERENCES `user` (`id_user`);

ALTER TABLE `comment` ADD FOREIGN KEY (`replies_to`) REFERENCES `comment` (`id_comment`);



-- INSERTING DATA

-- User

INSERT INTO user(email, password, genre, address, country, zipcode) VALUES 
('tomas@gmail.com', '12345', 'male', 'c/Vallirana 5', 'Spain', 08024),
('maria@gmail.com', '34565', 'female', 'c/Vallirana 5', 'Spain', 08024),
('elena@gmail.com', '345sg5', 'female', 'c/Asturies 5', 'Spain', 08024),
('oriol@gmail.com', 're565', 'male', 'plaça Llibertat 5', 'Spain', 08024);

-- Channel

INSERT INTO channel(name, description, id_creator) VALUES('Code with me', 'Follow me to learn to code and become a web dev', 1);

-- Playlist

INSERT INTO playlist(name, status, id_creator) VALUES ('MySQL for beginners', 'public', 1);

-- Tag

INSERT INTO tag(name, description) VALUES ('tech', 'Technology-related topics'), ('programming', 'Programming-related topics'), ('Education', 'Resources for learning');

-- Video

INSERT INTO video(title, status, id_creator, id_channel, id_playlist, description, views, dimension, filetype, length, thumbnail ) VALUES 
('MySQL Crash Course', 'public', 1, 1, 1, 'Learn how to create MySQL databases', 255, '325x1080', 'mp4', '01:30:10', 'www.someUrl.com'),
('How to install MySQL', 'public', 1, 1, 1, 'Learn how to install MySQL', 155, '325x1080', 'mp4', '00:30:10', 'www.someUrl.com'),
('Advanced Queries in MySQL', 'private', 1, 1, 1, 'Learn advanced MySQL queries', 0, '325x1080', 'mp4', '00:55:10', 'www.someUrl.com');

-- Video_has_tag

INSERT INTO video_has_tag(id_video, id_tag) VALUES(1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), (3, 3);

-- Playlist_has_video

INSERT INTO playlist_has_video(id_playlist, id_video) VALUES(1, 1), (1, 2), (1, 3);

-- Comments

INSERT INTO comment(id_video, id_creator, text, likes) VALUES 
(1, 2, 'Thanks for this awesome video', 45),
(1, 4, 'Gret work', 15);

-- Replies
INSERT INTO comment(id_video, id_creator, text, likes, replies_to) VALUES 
(1, 3, 'Totally agree with you', 25, 1),
(1, 3, 'Indeed', 10, 2);

-- User_follows_channel

INSERT INTO user_follows_channel(id_user, id_channel) VALUES(2,1), (3,1);

-- video_like_dislike

INSERT INTO video_like_dislike(id_user, id_video, type) VALUES (2, 1, 'like'), (3, 1, 'like'), (4, 1, 'like'), (2, 2, 'dislike'), (3, 2, 'dislike'), (4, 2, 'dislike'), (2, 3, 'like'), (3, 3, 'dislike'), (4, 3, 'like'); 

INSERT INTO comment_like_dislike(id_user, id_comment, type) VALUES (1, 1, 'dislike'), (3, 2, 'like');