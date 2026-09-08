-- ==============================================================
-- SQL + GenAI Mini Project : Social Media Analytics
-- Dataset : Social_Media
-- Student Name : Saisowmya Neela

-- ==============================================================

-- 🚀 SETUP INSTRUCTIONS (MUST DO FIRST)
-- ==============================================================
-- Before solving this project, make sure you create and load the dataset.
--
-- STEP 1: Open your SQL client (MySQL Workbench, DBeaver, or SQLite Studio).
-- STEP 2: Run the provided dataset file:
--         social_media_analytics_dataset.sql
--
-- This script will:
--   ✅ Create a new database named `Social_Media`
--   ✅ Create all 7 tables (users, posts, comments, likes, followers, hashtags, post_hashtags)
--   ✅ Insert ~7,000 synthetic rows for analysis
CREATE DATABASE Social_Media;
-- STEP 3: After successful execution, Your Code the database:
--         USE Social_Media;
Use Social_Media;
-- ---------------------------------------------------------
-- USERS TABLE
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    join_date DATE,
    country VARCHAR(150)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;
-- STEP 4: Verify the tables:
--         SHOW TABLES;
show tables;
--         Your Code COUNT(*) FROM users;
--         Your Code COUNT(*) FROM posts;
select count(*) from followers;
select count(*) from comments;
select count(*) from hashtags;
select count(*) from likes;
select count(*) from post_hashtags;
select count(*) from posts;
select count(*) from users;
-- Once you confirm the data is loaded, you can proceed to attempt all project queries.
-- ==============================================================

-- ==============================================================
-- IMPORTANT: BEFORE USING GenAI FOR QUERY GENERATION
-- ==============================================================
-- To help the AI generate accurate SQL, you MUST first share your schema.
-- Paste the following context into ChatGPT (or any GenAI tool) BEFORE you ask your prompts:

/*
You are an expert SQL assistant.  
Before answering any question, refer strictly to the database schema provided below.  
All SQL queries, joins, and analyses must be based ONLY on this schema — table names, column names, and relationships mentioned here.  
Do not assume any extra tables or columns unless explicitly stated.  
If a question is ambiguous, clarify it using the schema context rather than inventing new fields.  
Once you understand the schema, wait for my analytical question and generate the most accurate SQL query for it.

Tables and Key Columns:
  1. users(user_id, username, join_date, country)
  2. posts(post_id, user_id, content, created_at)
  3. comments(comment_id, post_id, user_id, comment_text, created_at)
  4. likes(like_id, post_id, user_id, created_at)
  5. followers(follower_id, user_id, follower_user_id, follow_date)
  6. hashtags(hashtag_id, tag_name, category)
  7. post_hashtags(id, post_id, hashtag_id)

Relationships:
  • Each user can create multiple posts.
  • Each post can have multiple likes and comments.
  • Users can follow each other (self-join in followers table).
  • Posts can be tagged with multiple hashtags (many-to-many via post_hashtags).
*/

-- Once you paste the schema, THEN use prompts like:
--   "Generate SQL to find top 10 active users combining posts and comments."
SELECT
    u.user_id,
    u.username,
    COUNT(DISTINCT p.post_id) AS total_posts,
    COUNT(DISTINCT c.comment_id) AS total_comments,
    COUNT(DISTINCT p.post_id) + COUNT(DISTINCT c.comment_id) AS total_activity
FROM users u
LEFT JOIN posts p
    ON u.user_id = p.user_id
LEFT JOIN comments c
    ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
ORDER BY total_activity DESC
LIMIT 10;
--   "Find trending hashtags used in more than 20 posts."
SELECT
    h.hashtag_id,
    h.tag_name,
    COUNT(DISTINCT ph.post_id) AS total_posts
FROM hashtags h
JOIN post_hashtags ph
    ON h.hashtag_id = ph.hashtag_id
GROUP BY h.hashtag_id, h.tag_name
HAVING COUNT(DISTINCT ph.post_id) > 20
ORDER BY total_posts DESC;

-- ==============================================================




-- ==============================================================
-- Q1. Most Active Users (Posts + Comments)
-- ==============================================================
-- Objective : Find top 10 users based on combined number of posts and comments.
-- Example GenAI Prompt :
--   "Write SQL to find top 10 active users combining posts and comments count."
-- Write your query below 👇
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    u.user_id,
    u.username,
    COUNT(DISTINCT p.post_id) AS total_posts,
    COUNT(DISTINCT c.comment_id) AS total_comments,
    COUNT(DISTINCT p.post_id) + COUNT(DISTINCT c.comment_id) AS total_activity
FROM users u
LEFT JOIN posts p
    ON u.user_id = p.user_id
LEFT JOIN comments c
    ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
ORDER BY total_activity DESC
LIMIT 10;



-- Solution Summary -- 
-- LEFT JOIN includes users even if they have no posts or comments.
-- COUNT(DISTINCT p.post_id) counts the number of posts made by each user.
-- COUNT(DISTINCT c.comment_id) counts the number of comments made by each user.
-- total_activity is the sum of posts and comments.
-- ORDER BY total_activity DESC sorts users from most to least active.
-- LIMIT 10 returns the top 10 active users.

-- ==============================================================
-- Q2. Most Liked Posts and Creators
-- ==============================================================
-- Objective : Identify posts with maximum likes along with their creator.
-- Example GenAI Prompt :
--   "Show top 10 posts with most likes and username."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    p.post_id,
    u.username,
    COUNT(l.like_id) AS total_likes
FROM posts p
JOIN users u
    ON p.user_id = u.user_id
LEFT JOIN likes l
    ON p.post_id = l.post_id
GROUP BY p.post_id, u.username
ORDER BY total_likes DESC
LIMIT 10;
-- Solution Summary -- 
-- • Joined the posts table with the users table to get the creator's username.
-- • Joined the likes table to count the number of likes for each post.
-- • Used GROUP BY to aggregate likes for each post.
-- • Sorted the posts in descending order of total likes.
-- • Displayed the top 10 most liked posts using LIMIT 10.

-- ==============================================================
-- Q3. Top Countries by Average Engagement
-- ==============================================================
-- Objective : Find countries with the highest average likes per post.
-- Example GenAI Prompt :
--   "Which countries have highest average likes per post?"
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    u.country,
    ROUND(AVG(COALESCE(l.like_count, 0)), 2) AS avg_likes_per_post
FROM users u
JOIN posts p
    ON u.user_id = p.user_id
LEFT JOIN (
    SELECT
        post_id,
        COUNT(*) AS like_count
    FROM likes
    GROUP BY post_id
) l
    ON p.post_id = l.post_id
GROUP BY u.country
ORDER BY avg_likes_per_post DESC;

-- Solution Summary -- 
-- • Joined the users and posts tables to associate each post with its creator's country.
-- • Calculated the number of likes for each post using a subquery.
-- • Used LEFT JOIN so posts with zero likes were also included.
-- • Computed the average likes per post for each country using AVG().
-- • Rounded the average to two decimal places.
-- • Sorted the results in descending order to identify the countries with the highest average engagement.

-- ==============================================================
-- Q4. Trending Hashtags (Used in >20 Posts)
-- ==============================================================
-- Objective : Find hashtags that appear in more than 20 posts.
-- Example GenAI Prompt :
--   "Find hashtags used in more than 20 posts."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    h.hashtag_id,
    h.tag_name,
    COUNT(DISTINCT ph.post_id) AS total_posts
FROM hashtags h
JOIN post_hashtags ph
    ON h.hashtag_id = ph.hashtag_id
GROUP BY h.hashtag_id, h.tag_name
HAVING COUNT(DISTINCT ph.post_id) > 20
ORDER BY total_posts DESC;


-- Solution Summary -- 
-- • Joined the hashtags and post_hashtags tables.
-- • Counted the number of distinct posts associated with each hashtag.
-- • Used GROUP BY to aggregate data for each hashtag.
-- • Filtered hashtags appearing in more than 20 posts using the HAVING clause.
-- • Sorted the hashtags in descending order of usage to identify trending hashtags.

-- ==============================================================
-- Q5. Top Influencers (Users with Most Followers)
-- ==============================================================
-- Objective : List users with the highest follower count.
-- Example GenAI Prompt :
--   "Find users with maximum followers."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    u.user_id,
    u.username,
    COUNT(f.follower_user_id) AS follower_count
FROM users u
LEFT JOIN followers f
    ON u.user_id = f.user_id
GROUP BY u.user_id, u.username
ORDER BY follower_count DESC
LIMIT 10;



-- Solution Summary -- 
-- • Joined the users table with the followers table.
-- • Counted the number of followers for each user using COUNT().
-- • Used LEFT JOIN to include users with zero followers.
-- • Grouped the results by user_id and username.
-- • Sorted the results in descending order of follower count.
-- • Displayed the top 10 users with the highest number of followers using LIMIT 10.

-- ==============================================================
-- Q6. Followers Who Never Interacted
-- ==============================================================
-- Objective : Identify users who follow others but have never liked or commented.
-- Example GenAI Prompt :
--   "Show users who follow others but never interacted."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    u.user_id,
    u.username
FROM users u
JOIN followers f
    ON u.user_id = f.follower_user_id
LEFT JOIN likes l
    ON u.user_id = l.user_id
LEFT JOIN comments c
    ON u.user_id = c.user_id
WHERE l.user_id IS NULL
  AND c.user_id IS NULL
GROUP BY u.user_id, u.username
ORDER BY u.user_id;



-- Solution Summary -- 
-- • Joined the users table with the followers table to identify users who follow others.
-- • Used LEFT JOIN with the likes and comments tables to check for user interactions.
-- • Filtered users who have no likes and no comments using IS NULL.
-- • Grouped the results to avoid duplicate users.
-- • Returned the list of followers who have never interacted with any post.

-- ==============================================================
-- Q7. Hashtags with Highest Engagement
-- ==============================================================
-- Objective : Calculate total engagement (likes + comments) for each hashtag.
-- Example GenAI Prompt :
--   "Calculate engagement score per hashtag."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    h.hashtag_id,
    h.tag_name,
    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments,
    COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS engagement_score
FROM hashtags h
JOIN post_hashtags ph
    ON h.hashtag_id = ph.hashtag_id
LEFT JOIN likes l
    ON ph.post_id = l.post_id
LEFT JOIN comments c
    ON ph.post_id = c.post_id
GROUP BY h.hashtag_id, h.tag_name
ORDER BY engagement_score DESC;



-- Solution Summary -- 
-- • Joined the hashtags table with post_hashtags to identify posts containing each hashtag.
-- • Joined the likes and comments tables to retrieve interactions for those posts.
-- • Counted the total number of likes and comments for each hashtag.
-- • Calculated the engagement score as:
--       Engagement Score = Total Likes + Total Comments.
-- • Grouped the results by hashtag.
-- • Sorted the hashtags in descending order of engagement score.

-- ==============================================================
-- Q8. Busiest Posting Hours or Days
-- ==============================================================
-- Objective : Find which hour/day sees most posting activity.
-- Example GenAI Prompt :
--   "Write SQL to show which hour or weekday sees most posts."
-- --------------------------------------------------------------
-- Your Code ...

SELECT
    HOUR(created_at) AS posting_hour,
    COUNT(post_id) AS total_posts
FROM posts
GROUP BY posting_hour
ORDER BY total_posts DESC;
SELECT
    DAYNAME(created_at) AS posting_day,
    COUNT(post_id) AS total_posts
FROM posts
GROUP BY posting_day
ORDER BY total_posts DESC;

-- Solution Summary -- 
-- • Used the HOUR() function to extract the posting hour from the created_at column.
-- • Used the DAYNAME() function to extract the weekday from the created_at column.
-- • Counted the number of posts for each hour and each day using COUNT().
-- • Grouped the results by hour and weekday.
-- • Sorted the results in descending order to identify the busiest posting hours and days.

-- ==============================================================
-- Q9. Inactive Users
-- ==============================================================
-- Objective : Find users who have never posted, liked, or commented.
-- Example GenAI Prompt :
--   "Find users who have never posted, liked, or commented."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    u.user_id,
    u.username,
    u.country
FROM users u
LEFT JOIN posts p
    ON u.user_id = p.user_id
LEFT JOIN likes l
    ON u.user_id = l.user_id
LEFT JOIN comments c
    ON u.user_id = c.user_id
WHERE p.post_id IS NULL
  AND l.like_id IS NULL
  AND c.comment_id IS NULL
ORDER BY u.user_id;


-- Solution Summary -- 
-- • Joined the users table with the posts, likes, and comments tables using LEFT JOIN.
-- • Checked for users who have no matching records in any of these tables.
-- • Used IS NULL to identify users who have never posted, liked, or commented.
-- • Displayed the inactive users along with their user ID, username, and country.
-- • Sorted the results by user ID.

-- ==============================================================
-- Q10. Top Countries with Most Influencers
-- ==============================================================
-- Objective : Identify countries with the highest number of influencers.
-- Example GenAI Prompt :
--   "Generate SQL to find countries that have the most followed users."
-- --------------------------------------------------------------
-- Your Code ...
SELECT
    u.country,
    COUNT(f.follower_user_id) AS total_followers
FROM users u
LEFT JOIN followers f
    ON u.user_id = f.user_id
GROUP BY u.country
ORDER BY total_followers DESC;



-- Solution Summary -- 
-- • Joined the users table with the followers table.
-- • Counted the total followers received by users from each country.
-- • Grouped the results by country.
-- • Used COUNT() to calculate the total number of followers.
-- • Sorted the countries in descending order of follower count.
-- • Identified the countries with the highest number of influencers based on follower counts.

-- ==============================================================
-- BONUS CHALLENGES
-- ==============================================================
-- 1. Engagement rate = (likes + comments) / posts
SELECT
    u.user_id,
    u.username,
    COUNT(DISTINCT p.post_id) AS total_posts,
    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments,
    ROUND(
        (COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id))
        / NULLIF(COUNT(DISTINCT p.post_id),0),
        2
    ) AS engagement_rate
FROM users u
LEFT JOIN posts p
    ON u.user_id = p.user_id
LEFT JOIN likes l
    ON p.post_id = l.post_id
LEFT JOIN comments c
    ON p.post_id = c.post_id
GROUP BY u.user_id, u.username
ORDER BY engagement_rate DESC;
-- Solution Summary
-- Calculated total posts created by each user.
-- Counted likes and comments received on their posts.
-- Computed engagement rate as:
-- (Likes + Comments) / Total Posts
-- Used NULLIF() to avoid division by zero.
-- Ranked users by engagement rate.
-- -- 2. Mutual followers
SELECT
    f1.user_id,
    f1.follower_user_id
FROM followers f1
JOIN followers f2
ON f1.user_id = f2.follower_user_id
AND f1.follower_user_id = f2.user_id;
-- Solution Summary
-- Self-joined the followers table.
-- Identified pairs where User A follows User B and User B follows User A.
-- Displayed mutual follower relationships.
-- 3. Most used hashtags by top 5 influencers--
WITH top_influencers AS
(
    SELECT
        user_id
    FROM followers
    GROUP BY user_id
    ORDER BY COUNT(*) DESC
    LIMIT 5
)

SELECT
    h.tag_name,
    COUNT(*) AS usage_count
FROM top_influencers ti
JOIN posts p
    ON ti.user_id = p.user_id
JOIN post_hashtags ph
    ON p.post_id = ph.post_id
JOIN hashtags h
    ON ph.hashtag_id = h.hashtag_id
GROUP BY h.tag_name
ORDER BY usage_count DESC;
-- Solution Summary
-- Identified the top 5 users with the most followers.
-- Retrieved posts created by those users.
-- Counted hashtag usage in their posts.
-- Ranked hashtags by frequency.
-- 4. Country-wise engagement leaderboard
SELECT
    u.country,
    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments,
    COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS total_engagement
FROM users u
JOIN posts p
    ON u.user_id = p.user_id
LEFT JOIN likes l
    ON p.post_id = l.post_id
LEFT JOIN comments c
    ON p.post_id = c.post_id
GROUP BY u.country
ORDER BY total_engagement DESC;
-- Solution Summary
-- Joined users with their posts.
-- Counted likes and comments received by posts from each country.
-- Calculated total engagement as:
-- Likes + Comments
-- Ranked countries by total engagement.
-- --------------------------------------------------------------

-- ==============================================================
-- REFLECTION
-- ==============================================================
-- 1. How did GenAI assist you in solving these queries?
GenAI helped me understand the database schema and generate SQL queries for different analytical problems. It suggested appropriate JOINs, aggregate functions, GROUP BY, HAVING, subqueries, and CTEs. It also explained the logic behind each query, which helped me learn SQL concepts, debug errors, and improve query accuracy.
 I verified and refined the generated queries before using them.
-- 2. What optimization tips did you learn?
• Use INNER JOIN only when matching records are required and LEFT JOIN when all records from one table should be included.
• Use COUNT(DISTINCT ...) to avoid duplicate counts.
• Apply WHERE before GROUP BY whenever possible to reduce processed rows.
• Use HAVING to filter aggregated results.
• Create indexes on frequently joined columns such as user_id, post_id, and hashtag_id for better performance.
• Avoid unnecessary columns in the SELECT statement to improve query efficiency.
-- 3. What business insights stood out to you?
• A small number of users generate most of the content and engagement.
• Highly followed users (influencers) contribute significantly to platform activity.
• Trending hashtags help identify popular topics and user interests.
• Countries with higher engagement can be targeted for marketing campaigns.
• Identifying inactive users helps in planning re-engagement strategies.
• Analyzing posting hours and days can help schedule content for maximum reach and engagement.
-- ==============================================================
