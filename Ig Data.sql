Use ig_clone;
-- Finding 5 oldest users
SELECT 
    *
FROM
    users
ORDER BY created_at DESC
LIMIT 5;
-- What day of the week do most users register on?
SELECT 
   DAYNAME(created_at) AS Day,
   count(username) as no_signed_up
FROM
    users
GROUP BY Day
ORDER BY no_signed_up DESC;
-- Find users who never posted a photo
SELECT 
    username, image_url
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.image_url IS NULL;
-- Most liked photo
SELECT 
    users.username, photos.id, photos.image_url, COUNT(*) AS most_liked
FROM
    photos
        INNER JOIN
    likes ON likes.photo_id = photos.id
        INNER JOIN
    users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY most_liked DESC
LIMIT 1;
-- How many times does an average user post?
SELECT 
    ((SELECT 
            COUNT(*)
        FROM
            photos) / (SELECT 
            COUNT(*)
        FROM
            users)) as Avg;
-- Most popular hashtags
SELECT 
    tags.tag_name, COUNT(*) AS most_tagged
FROM
    photo_tag
        INNER JOIN
    tags ON photo_tag.tag_id = tags.id
GROUP BY tags.id
ORDER BY most_tagged DESC
LIMIT 6;
-- Find users who have liked every single photo on the site
SELECT 
    username, COUNT(*) AS num_likes
FROM
    users
        INNER JOIN
    likes ON users.id = likes.user_id
GROUP BY users.id
HAVING num_likes = (SELECT 
        COUNT(*)
    FROM
        photos);