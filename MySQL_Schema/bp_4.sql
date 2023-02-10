/*

create a mysql schema for user that takes first name, last name, username, created_at, and password. 
Then, each user can posts as many as they want, each post takes images or videos, description. 
Also, users can follow other users, if a user follows other user, then the user can comment other user's post and other user can reply to the user's comment.
Each posts can contains tags, user cannot able to add more than 5 tags. 
Tags can have the name, text link (that navigates to the specific site link), and color. Color only contains either blue, red, or green.

Note: 

A trigger is a special type of stored procedure in a database management system that automatically executes whenever a specific event occurs, such as an INSERT, UPDATE, or DELETE operation on a table. Triggers are used to enforce complex business rules and constraints on data, to maintain data integrity and consistency, and to automate various tasks, such as auditing and data history tracking.
Triggers are executed automatically and transparently, without the need for explicit invocation. They are defined using a special syntax in the database management system, and are associated with a specific table or view in the database. When the triggering event occurs, the trigger is executed and its code is executed.
In MySQL, triggers are defined using the CREATE TRIGGER statement, and can be specified to be executed either before (BEFORE trigger) or after (AFTER trigger) the triggering event occurs. Triggers can also be defined to execute for each row affected by the triggering event (FOR EACH ROW trigger), or just once for the entire operation (FOR EACH STATEMENT trigger).

*/

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    media LONGBLOB,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE followings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

CREATE TABLE replies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    reply TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    link TEXT NOT NULL,
    color ENUM('blue', 'red', 'green') NOT NULL
);

CREATE TABLE post_tags (
    post_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
    UNIQUE (post_id, tag_id)
);

DELIMITER $$
CREATE TRIGGER check_post_tags_limit
BEFORE INSERT ON post_tags
FOR EACH ROW
BEGIN
    DECLARE tag_count INT;
    SET tag_count = (SELECT COUNT(*) FROM post_tags WHERE post_id = NEW.post_id);
    IF tag_count >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot create more than 5 tags for a post';
    END IF;
END $$
DELIMITER ;


