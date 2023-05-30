USE social_network;

INSERT INTO User (username, email, password, registration_date) VALUES ('john_doe', 'john@example.com', 'password123', '2023-05-29');
INSERT INTO User (username, email, password, registration_date) VALUES ('jane_smith', 'jane@example.com', 'p@ssw0rd', '2023-05-30');

INSERT INTO Profile (user_id, full_name, date_of_birth, gender, bio)
VALUES (1, 'John Doe', '1990-01-01', 'Male', 'Tech enthusiast');
INSERT INTO Profile (user_id, full_name, date_of_birth, gender, bio)
VALUES (2, 'Jane Smith', '1995-08-10', 'Female', 'Fitness enthusiast');


INSERT INTO Post (profile_id, content, created_date) VALUES (1, 'Hello, everyone!', '2023-05-29 10:00:00');
INSERT INTO Post (profile_id, content, created_date) VALUES (2, 'Excited to join this network!', '2023-05-30 12:00:00');

INSERT INTO Comment (post_id, profile_id, content, created_date) VALUES (1, 2, 'Welcome, Jane!', '2023-05-29 11:00:00');
INSERT INTO Comment (post_id, profile_id, content, created_date) VALUES (2, 1, 'Glad to have you here, John!', '2023-05-30 13:00:00');

INSERT INTO Group (group_name, description) VALUES ('Technology Enthusiasts', 'A group for tech lovers');
INSERT INTO Group (group_name, description) VALUES ('Fitness Fanatics', 'A group for fitness enthusiasts');

INSERT INTO GroupMembership (group_id, profile_id, role) VALUES (1, 1, 'admin');
INSERT INTO GroupMembership (group_id, profile_id, role) VALUES (1, 2, 'member');

UPDATE User SET username = 'john_doe_updated' WHERE profile_id = 1;
UPDATE Post SET content = 'Hello, everyone! Updated' WHERE post_id = 1;
UPDATE Comment SET content = 'Welcome, Jane! Updated' WHERE comment_id = 1;
UPDATE Group SET group_name = 'Technology Enthusiasts Updated' WHERE group_id = 1;
UPDATE GroupMembership SET role = 'admin' WHERE membership_id = 1;
UPDATE Profile SET full_name = 'John Doe', date_of_birth = '1990-01-01', gender = 'Male', bio = 'Tech enthusiast' WHERE profile_id = 1;
UPDATE Post SET content = 'Check out this amazing article!' WHERE post_id = 2;
UPDATE GroupMembership SET role = 'admin' WHERE profile_id = 2 AND group_id = 1;
UPDATE User SET email = 'jane_newemail@example.com' WHERE profile_id = 2;
UPDATE Group SET description = 'A group for health and wellness enthusiasts' WHERE group_id = 2;

DELETE FROM User WHERE user_id = 1;
DELETE FROM Post WHERE post_id = 1;
DELETE FROM Comment WHERE comment_id = 1;
DELETE FROM Group WHERE group_id = 1;
DELETE FROM GroupMembership WHERE membership_id = 1;
DELETE FROM Post WHERE post_id = 2;
DELETE FROM Comment WHERE post_id = 2;

ALTER TABLE User ADD COLUMN last_login_date DATETIME;
ALTER TABLE Post MODIFY COLUMN content VARCHAR(500);
ALTER TABLE Comment CHANGE COLUMN created_date commented_date DATETIME;
ALTER TABLE Photo DROP COLUMN content;
ALTER TABLE Group ALTER COLUMN description SET DEFAULT 'No description provided';

SELECT *
FROM Profile AS p
JOIN User AS u ON p.profile_id = u.profile_id
LEFT JOIN Friendship_has_Profile AS fhp ON p.profile_id = fhp.Profile_profile_id
LEFT JOIN Friendship AS f ON fhp.Friendship_friendship_id = f.friendship_id
LEFT JOIN Profile_has_Friendship AS phf ON p.profile_id = phf.profile_id
LEFT JOIN Photo_Album AS pa ON p.profile_id = pa.profile_id
LEFT JOIN Photo AS ph ON pa.photo_album_id = ph.photo_album_id AND pa.profile_id = ph.profile_id
LEFT JOIN Post AS ps ON p.profile_id = ps.profile_id
LEFT JOIN Comment AS c ON ps.post_id = c.post_id AND ps.profile_id = c.author_profile_id
LEFT JOIN `Like` AS l ON ps.post_id = l.post_id AND ps.profile_id = l.profile_id
LEFT JOIN `Group_Membership` AS gm ON p.profile_id = gm.profile_id
LEFT JOIN `Group` AS g ON gm.group_id = g.group_id
LEFT JOIN `Message` AS m ON p.profile_id = m.receiver_profile_id
LEFT JOIN `Profile_has_Message` AS phm ON p.profile_id = phm.profile_id
LEFT JOIN `Profile_Tag` AS pt ON p.profile_id = pt.tagged_profile_id;

SELECT *
FROM Profile
LEFT JOIN User ON Profile.profile_id = User.profile_id;

SELECT *
FROM Profile
RIGHT JOIN User ON Profile.profile_id = User.profile_id;

SELECT *
FROM Profile
INNER JOIN User ON Profile.profile_id = User.profile_id;

SELECT *
FROM Profile
LEFT JOIN User ON Profile.profile_id = User.profile_id
UNION
SELECT *
FROM Profile
RIGHT JOIN User ON Profile.profile_id = User.profile_id;


SELECT gender, COUNT(*) AS profile_count
FROM Profile
GROUP BY gender;

SELECT gender, AVG(YEAR(CURDATE()) - YEAR(date_of_birth)) AS average_age
FROM Profile
GROUP BY gender;

SELECT user_id, MAX(registration_date) AS max_registration_date
FROM User
GROUP BY user_id;

SELECT friend_profile_id, COUNT(*) AS friendship_count
FROM Friendship
GROUP BY friend_profile_id;

SELECT photo_album_id, MIN(date_created) AS earliest_date, MAX(date_created) AS latest_date
FROM Photo_Album
GROUP BY photo_album_id;

SELECT post_id, AVG((SELECT COUNT(*) FROM `Like` WHERE `Like`.post_id = Post.post_id)) AS average_likes
FROM Post
GROUP BY post_id;

SELECT profile_id, COUNT(*) AS message_count
FROM Profile_has_Message
GROUP BY profile_id;

SELECT gender, COUNT(*) AS profile_count
FROM Profile
INNER JOIN Friendship ON Profile.profile_id = Friendship.friend_profile_id
GROUP BY gender
HAVING COUNT(*) > 100;

SELECT gender, AVG(YEAR(CURDATE()) - YEAR(date_of_birth)) AS average_age
FROM Profile
GROUP BY gender
HAVING AVG(YEAR(CURDATE()) - YEAR(date_of_birth)) > 30;

SELECT user_id, MAX(registration_date) AS max_registration_date
FROM User
GROUP BY user_id
HAVING YEAR(MAX(registration_date)) = 2023;

SELECT friend_profile_id, COUNT(*) AS friendship_count
FROM Friendship
GROUP BY friend_profile_id
HAVING COUNT(*) > 50;

SELECT photo_album_id, MIN(date_created) AS earliest_date, MAX(date_created) AS latest_date
FROM Photo_Album
GROUP BY photo_album_id
HAVING DATEDIFF(MAX(date_created), MIN(date_created)) > 30;

SELECT post_id, AVG((SELECT COUNT(*) FROM `Like` WHERE `Like`.post_id = Post.post_id)) AS average_likes
FROM Post
GROUP BY post_id
HAVING AVG((SELECT COUNT(*) FROM `Like` WHERE `Like`.post_id = Post.post_id)) > 10;

SELECT profile_id, COUNT(*) AS message_count
FROM Profile_has_Message
GROUP BY profile_id
HAVING COUNT(*) > 500;
