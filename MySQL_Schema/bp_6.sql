/* 
create a mysql schema that user contains username, password, and role. 
Role either a user is an admin, operator, or ceo. 
If a user is an admin, then a user creates many posts. 
Each posts contains videos and description. Admin cannot post videos more than 5 from a specific post. 


*/

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'operator', 'ceo') NOT NULL
);

CREATE TABLE posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE videos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  url VARCHAR(255) NOT NULL,
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- limit the number of videos per post to 5
ALTER TABLE posts ADD CONSTRAINT max_videos_per_post
  CHECK (
    (SELECT COUNT(*) FROM videos WHERE videos.post_id = posts.id) <= 5
  );