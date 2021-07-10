-- Finding 5 oldest users
SELECT * 
FROM Users
ORDER BY created_at 
LIMIT 5;

-- Most Popular Registration Date
SELECT 
	username,
    DAYNAME(created_at) AS Days,
    COUNT(created_at) AS Count
FROM Users
GROUP BY Days
ORDER BY count
LIMIT 2;

-- Identify Inactive Users (user with no photos)
SELECT username, image_url
FROM Users    
LEFT JOIN Photos
	ON Users.id = Photos.user_id
WHERE image_url is NULL;

-- Identify most popular photo (and user who created it)
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

-- Five most popular hashtags
SELECT image_url, photo_id, tag_id,tag_name, count(tag_id)as count from photos
JOIN phototags
ON photos.id = phototags.photo_id
JOIN tags
ON tags.id = phototags.tag_id
GROUP BY tag_id
ORDER BY count desc
LIMIT 5;

-- or
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 


-- Users who have liked every single photos
SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 