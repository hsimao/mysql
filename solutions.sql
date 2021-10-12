-- 找出前五位最早註冊的用戶
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- 找出一週之中最多用戶註冊的日期
SELECT DAYNAME(created_at) AS day, count(*) AS total FROM users GROUP BY day ORDER BY total DESC;

-- 找出每天之中最多用戶註冊的小時
SELECT HOUR(created_at) AS hour, count(*) AS total FROM users GROUP BY hour ORDER BY total DESC LIMIT 1;

-- 依據每天的每個小時註冊人數
SELECT CONCAT(DAYNAME(created_at), '-', HOUR(created_at)) AS dayTime, count(*) AS total FROM users GROUP BY dayTime ORDER BY
DAYNAME(created_at), HOUR(created_at) DESC;

-- 找出沒有發過照片的用戶
SELECT users.id AS userID, username FROM users LEFT JOIN photos ON users.id = photos.user_id WHERE photos.id IS NULL;

-- 找到最受歡迎的照片, 最多人 likes
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;


-- 查出每位用戶平均發布幾張照片
-- 所有照片張數 / 所有用戶張數
SELECT
  ((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users)) AS avg;