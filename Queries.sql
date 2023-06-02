use social_network;

-- 10 Insert statements
INSERT INTO Profile (id, full_name, date_of_birth, gender, bio)
VALUES (1, 'Jane Smith', '1990-05-15', 'Female', 'Welcome to my profile!');

INSERT INTO User (id, email, password, registration_date, user_profile_id)
VALUES (1, 'janesmith@example.com', 'mypassword', '2023-05-01 12:00:00', 1);

INSERT INTO Profile (id, full_name, date_of_birth, gender, bio)
VALUES (2, 'Michael Johnson', '1992-09-28', 'Male', 'Lover of sports and music.');

INSERT INTO User (id, email, password, registration_date, user_profile_id)
VALUES (2, 'michaeljohnson@example.com', 'securepassword', '2023-05-02 09:30:00', 2);

INSERT INTO Friendship (id, friend_profile_id, status)
VALUES (1, 2, 'pending');

INSERT INTO Post (id, date_created, poster_profile_id, content)
VALUES (1, '2023-06-01 10:00:00', 1, 'Hello, everyone! This is my first post.');

INSERT INTO Profile_Tag (id, tagged_profile_id)
VALUES (1, 2);

INSERT INTO Comment (id, commented_post_id, author_profile_id, content, date_created)
VALUES (1, 1, 2, 'Nice post!', '2023-06-01 10:05:00');

INSERT INTO `Like` (id, liked_post_id, liker_profile_id)
VALUES (1, 1, 2);

INSERT INTO `Group` (id, group_name, description)
VALUES (1, 'Tech Enthusiasts', 'Discussing the latest tech trends.');

INSERT INTO Group_Membership (id, member_profile_id, role, group_id)
VALUES (1, 1, 'moderator', 1);

INSERT INTO Message (id, receiver_profile_id, content, date_sent)
VALUES (1, 2, 'Hi there! How are you?', '2023-06-01 11:00:00');

-- 10 update statements
UPDATE Friendship
SET status = 'accepted'
WHERE id = 1;

UPDATE `Group`
SET group_name = 'Tech Enthusiasts Club'
WHERE id = 1;

UPDATE Group_Membership
SET role = 'admin'
WHERE id = 1;

UPDATE Profile
SET bio = 'Passionate about photography and nature.'
WHERE id = 1;

UPDATE User
SET password = 'newpassword'
WHERE id = 2;

UPDATE Profile
SET full_name = 'Jane Williams'
WHERE id = 1;

UPDATE User
SET email = 'janewilliams@example.com'
WHERE id = 1;

UPDATE Post
SET content = 'Hello, everyone! This is an updated post.'
WHERE id = 1;

UPDATE Comment
SET content = 'Great post!'
WHERE id = 1;

UPDATE Message
SET content = 'Hey! How have you been?'
WHERE id = 1;

-- 10 delete statements
DELETE FROM Profile 
WHERE id = 1;

DELETE FROM User 
WHERE id = 1;

DELETE FROM Profile 
WHERE id = 2;

DELETE FROM User 
WHERE id = 2;

DELETE FROM Friendship 
WHERE id = 1;

DELETE FROM Post 
WHERE id = 1;

DELETE FROM Comment 
WHERE id = 1;

DELETE FROM `Group` 
WHERE id = 1;

DELETE FROM Group_Membership 
WHERE id = 1;

DELETE FROM Message 
WHERE id = 1;

-- 5 alter table statements
ALTER TABLE Profile
ADD COLUMN city VARCHAR(45) NULL;

ALTER TABLE Post
CHANGE COLUMN date_created creation_date DATETIME NOT NULL;

ALTER TABLE `Group`
MODIFY COLUMN description VARCHAR(1000) NULL;

ALTER TABLE Profile
ADD COLUMN profile_picture_id INT NULL,
ADD CONSTRAINT fk_Profile_Photo
FOREIGN KEY (profile_picture_id)
REFERENCES Photo (id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE User
ADD COLUMN last_login DATETIME NULL;

-- 1 big statement to join all tables
SELECT 
    p.id AS profile_id,
    p.full_name,
    p.date_of_birth,
    p.gender AS profile_gender,
    p.bio AS profile_bio,
    u.id AS user_id,
    u.email AS user_email,
    u.password AS user_password,
    u.registration_date AS user_registration_date,
    u.user_profile_id AS user_profile_id,
    f.id AS friendship_id,
    f.friend_profile_id,
    f.status AS friendship_status,
    pst.id AS post_id,
    pst.date_created AS post_date_created,
    pst.poster_profile_id AS post_profile_id,
    pst.content AS post_content,
    c.id AS comment_id,
    c.commented_post_id,
    c.author_profile_id AS comment_author_id,
    c.content AS comment_content,
    c.date_created AS comment_date_created,
    l.id AS like_id,
    l.liked_post_id,
    l.liker_profile_id AS like_liker_id,
    gm.id AS group_membership_id,
    gm.member_profile_id,
    gm.role AS group_membership_role,
    g.id AS group_id,
    g.group_name,
    g.description AS group_description,
    m.id AS message_id,
    m.receiver_profile_id,
    m.content AS message_content,
    m.date_sent AS message_date_sent,
    pa.id AS photo_album_id,
    pa.album_profile_id,
    pa.photo_album_name,
    pa.date_created AS photo_album_date_created,
    ph.id AS photo_id,
    ph.photo_album_id AS photo_album_id,
    ph.owner_profile_id AS photo_owner_id,
    ph.content AS photo_content,
    ph.caption AS photo_caption,
    ph.upload_date AS photo_upload_date,
    pp.post_id AS post_photo_post_id,
    pp.photo_id AS post_photo_id,
    pp.photo_id AS post_photo_id,
    pp.post_id AS post_photo_post_id,
    pp.photo_id AS post_photo_id,
    ph2.id AS post_photo_id,
    ph2.photo_album_id AS post_photo_album_id,
    ph2.owner_profile_id AS post_photo_owner_id,
    ph2.content AS post_photo_content,
    ph2.caption AS post_photo_caption,
    ph2.upload_date AS post_photo_upload_date,
    pt.id AS profile_tag_id,
    pt.tagged_profile_id
FROM 
    Profile p
LEFT JOIN 
    User u ON p.id = u.user_profile_id
LEFT JOIN 
    Friendship f ON p.id = f.friend_profile_id
LEFT JOIN 
    Post pst ON p.id = pst.poster_profile_id
LEFT JOIN 
    Comment c ON p.id = c.author_profile_id
LEFT JOIN 
    `Like` l ON p.id = l.liker_profile_id
LEFT JOIN 
    Group_Membership gm ON p.id = gm.member_profile_id
LEFT JOIN 
    `Group` g ON gm.group_id = g.id
LEFT JOIN 
    Message m ON p.id = m.receiver_profile_id
LEFT JOIN 
    Photo_Album pa ON p.id = pa.album_profile_id
LEFT JOIN 
    Photo ph ON pa.id = ph.photo_album_id
LEFT JOIN 
    Post_Photo pp ON pst.id = pp.post_id
LEFT JOIN 
    Photo ph2 ON pp.photo_id = ph2.id
LEFT JOIN 
    Profile_Tag pt ON p.id = pt.tagged_profile_id;

-- 5 statements with left, right, inner, outer joins
SELECT *
FROM Profile
LEFT JOIN Post
    ON Profile.id = Post.poster_profile_id;

SELECT *
FROM Profile
RIGHT JOIN Friendship
    ON Profile.id = Friendship.friend_profile_id;
    
SELECT *
FROM Post
INNER JOIN Comment
    ON Post.id = Comment.commented_post_id;

SELECT *
FROM Comment
LEFT JOIN `Like`
    ON Comment.id = `Like`.id
UNION
SELECT *
FROM Comment
RIGHT JOIN `Like`
    ON Comment.id = `Like`.id
WHERE Comment.id IS NULL;

SELECT *
FROM Photo
JOIN Post
    ON Photo.id = Post.id;

-- 7 statements with aggregate functions and group by and without having
SELECT gender, COUNT(*) AS profile_count
FROM Profile
GROUP BY gender;

SELECT liked_post_id, COUNT(*) AS like_count
FROM `Like`
GROUP BY liked_post_id;

SELECT MAX(date_of_birth) AS max_date_of_birth
FROM Profile;

SELECT MIN(registration_date) AS min_registration_date
FROM User;

SELECT AVG(LENGTH(content)) AS average_content_length
FROM Post;

SELECT commented_post_id, COUNT(*) AS comment_count
FROM Comment
GROUP BY commented_post_id;

SELECT MIN(date_created) AS earliest_date_created
FROM Post;

-- 7 statements with aggregate functions and group by and with having
SELECT commented_post_id, COUNT(*) AS comment_count
FROM Comment
GROUP BY commented_post_id
HAVING COUNT(*) > 10;

SELECT liker_profile_id, COUNT(*) AS like_count
FROM `Like`
GROUP BY liker_profile_id
HAVING COUNT(*) >= 100;

SELECT commented_post_id, COUNT(*) AS comment_count
FROM Comment
GROUP BY commented_post_id
HAVING COUNT(*) > 0
ORDER BY comment_count DESC;

SELECT friend_profile_id, COUNT(*) AS friend_count
FROM Friendship
GROUP BY friend_profile_id
HAVING COUNT(*) > 5;

SELECT photo_album_id, COUNT(*) AS photo_count
FROM Photo
GROUP BY photo_album_id
HAVING COUNT(*) > 50;

SELECT liked_post_id, COUNT(*) AS like_count
FROM `Like`
GROUP BY liked_post_id
HAVING like_count = (SELECT MAX(like_count) FROM (SELECT COUNT(*) AS like_count FROM `Like` GROUP BY liked_post_id) AS subquery);

SELECT user_profile_id, COUNT(*) AS user_count
FROM User
WHERE registration_date >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
GROUP BY user_profile_id;