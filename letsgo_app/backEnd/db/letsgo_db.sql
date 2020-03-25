
DROP DATABASE IF EXISTS letsgo_db;
CREATE DATABASE letsgo_db;

\c letsgo_db;

DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Hashtags;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Likes;

CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR UNIQUE,
    password TEXT,
    bio TEXT,
    profilePic VARCHAR,
    email TEXT UNIQUE
);

CREATE TABLE Posts (
    id SERIAL PRIMARY KEY,
    poster_id INT REFERENCES Users(id) ON DELETE CASCADE,
    imageURL VARCHAR,
    content TEXT,
    time_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Hashtags (
    id SERIAL PRIMARY KEY,
    poster_id INT REFERENCES Users(id),
    post_id  INT REFERENCES Posts(id),
    tag_name TEXT
);

CREATE TABLE Likes (
    id SERIAL PRIMARY KEY,
    liker_id INT REFERENCES Users(id),
    post_id  INT REFERENCES Posts(id),
    CONSTRAINT UC_like UNIQUE (liker_id, post_id)
);

INSERT INTO Users (username, password, bio, profilePic, email)
    VALUES ('darsu', 'admin123', 'Yuurrrrr', 'https://ca.slack-edge.com/TCVA3PF24-UN3UXSZMY-e20128673daa-512','darsu@gmail.com' ),
           ('henry', 'admin123', 'Hey party people, its ya boy', 'https://files.slack.com/files-pri/TCVA3PF24-FV2268GQY/screenshot_2020-01-14_at_4.35.20_pm.png','henry@gmail.com'),
           ('sam', 'admin123', 'Heeeey now', 'https://files.slack.com/files-pri/TCVA3PF24-FV3TUKXC7/image_from_ios.jpg', 'sam@gmail.com'),
           ('kong', 'admin123', 'PokemonGo ayeeeee', 'https://static1.squarespace.com/static/5b50ebb7e749401857e16f2f/t/5d7bbf0ef00cb05d84180599/1568390933661/CONGSONG%2C+YANG+-+Cong+Song+Yang.png', 'kong@gmail.com');

INSERT INTO Posts (poster_id, imageURL, content)
    VALUES (1, '../../assets/singapore-skyline.jpg', 'Check me out in Singapore Skyline.'),
           (2, '../../assets/grand-canyon-south-rim-view.jpg', 'Deff looking forward to running out here'),
           (3, '../../assets/london-kensington-palace.jpg', 'Walk in Lodon...magnifique'),
           (4, '../../assets/new-york-gay-pride-2018.jpg', 'Gay Pride in New York, with my main man Henry'),
           (3, '../../assets/moon-apollo-11-moon-moments-still-3.jpg', 'Moon walk'),
           (1, '../../assets/rwanda.jpg', 'Zoo.... NO'),
           (4, '../../assets/maldives-img.jpg', 'beachs' ),
           (2, '../../assets/las-vegas.jpg', 'Views from Vegas'),
           (1, '../../assets/singapore-skyline.jpg', 'Views from singapore'),
           (1, '../../assets/maldives-img.jpg', 'last post without any hastags');


INSERT INTO Hashtags (poster_id, post_id, tag_name)
    VALUES (1, 1, 'Singapore'),
           (1, 1, 'Skyline'),
           (2, 2, 'RunnersHigh'),
           (2, 2, 'Grand Canyon'),
           (3, 3, 'London'),
           (3, 3, 'City'),
           (3, 3, 'Europe'),
           (4, 4, 'New York City'),
           (4, 4, 'Pride'),
           (3, 5, 'Moon'),
           (3, 5, 'OutSpace'),
           (1, 6, 'Rwanda'),
           (1, 6, 'Wild'),
           (4, 7, 'Maldives'),
           (4, 7, 'Ocean'),
           (4, 7, 'Foodie'),
           (4, 7, 'Real'),
           (2, 8, 'Las Vegas'),
           (2, 8, 'US'),
           (1, 9, 'Singapore'),
           (1, 9, 'City');

INSERT INTO Likes (liker_id, post_id)
    VALUES (1, 1),
           (2, 2),
           (3, 3),
           (2, 3),
           (4, 4),
           (3, 4),
           (2, 4),
           (1, 5),
           (1, 6),
           (1, 7),
           (1, 8),
           (1, 9),
           (2, 10),
           (2, 9),
           (3, 8),
           (2, 7),
           (1, 4),
           (3, 5);