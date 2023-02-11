/* 
create mysql schema that user can post either blue card, red card, or green card. 
If it is a blue card, then it contains images, name, and description. 
If it is a red card, then it contains only a video. 
If it is a greed card, then it contains blue card and red card, if blue or/and red card exist, if not then it contains a text saying "NONE". 
When the user got deleted, then blue card gets deleted, but not red card and green card. 
*/


CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  is_deleted TINYINT(1) DEFAULT 0
);

CREATE TABLE blue_cards (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  image BLOB,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE red_cards (
  id INT AUTO_INCREMENT PRIMARY KEY,
  video BLOB NOT NULL
);

CREATE TABLE green_cards (
  id INT AUTO_INCREMENT PRIMARY KEY,
  blue_card_id INT,
  red_card_id INT,
  text VARCHAR(255) DEFAULT 'NONE',
  FOREIGN KEY (blue_card_id) REFERENCES blue_cards (id) ON DELETE SET NULL,
  FOREIGN KEY (red_card_id) REFERENCES red_cards (id) ON DELETE SET NULL
);
