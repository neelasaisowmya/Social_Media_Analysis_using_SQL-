# Social Media Analytics Dataset

A relational dataset simulating a social media platform — users, posts, comments, likes, followers, and hashtags — designed for SQL practice, analytics projects, and database design learning.

**Author:** Saisowmya Neela

---

## 📁 Repository Structure

```
social-media-analytics-dataset/
│
├── social_media_analytics_dataset.sql   # Full schema + seed data (CREATE TABLE + INSERT statements)
├── social_media_analytics_erd.png       # Entity-Relationship Diagram
└── README.md                            # Project documentation (this file)
```

---

## 🗂️ Database: `Social_Media`

| Table            | Rows (approx.) | Description                                  |
|-------------------|---------------|-----------------------------------------------|
| `users`           | 1,000         | Registered platform users                     |
| `posts`           | 1,000         | Posts created by users                         |
| `comments`        | —             | Comments made on posts                         |
| `likes`           | —             | Likes on posts                                 |
| `followers`       | —             | Follow relationships between users (self-join) |
| `hashtags`        | —             | Hashtag catalog                                |
| `post_hashtags`   | —             | Many-to-many link between posts and hashtags   |

---

## 🔗 Entity-Relationship Diagram

![Social Media Analytics ERD](social_media_analytics_erd.png)

**Relationships:**
- `posts.user_id` → `users.user_id`
- `comments.post_id` → `posts.post_id`, `comments.user_id` → `users.user_id`
- `likes.post_id` → `posts.post_id`, `likes.user_id` → `users.user_id`
- `followers.user_id` → `users.user_id`, `followers.follower_user_id` → `users.user_id` *(self-referencing)*
- `post_hashtags.post_id` → `posts.post_id`, `post_hashtags.hashtag_id` → `hashtags.hashtag_id`

---

## 🧱 Schema Details

### `users`
| Column      | Type          | Notes         |
|-------------|---------------|---------------|
| user_id     | INT           | PK            |
| username    | VARCHAR(50)   | NOT NULL      |
| join_date   | DATE          |               |
| country     | VARCHAR(150)  |               |

### `posts`
| Column      | Type      | Notes                  |
|-------------|-----------|-------------------------|
| post_id     | INT       | PK                      |
| user_id     | INT       | FK → users.user_id      |
| content     | TEXT      |                         |
| created_at  | DATETIME  |                         |

### `comments`
| Column        | Type      | Notes                  |
|---------------|-----------|-------------------------|
| comment_id    | INT       | PK                      |
| post_id       | INT       | FK → posts.post_id      |
| user_id       | INT       | FK → users.user_id      |
| comment_text  | TEXT      |                         |
| created_at    | DATETIME  |                         |

### `likes`
| Column      | Type      | Notes                  |
|-------------|-----------|-------------------------|
| like_id     | INT       | PK                      |
| post_id     | INT       | FK → posts.post_id      |
| user_id     | INT       | FK → users.user_id      |
| created_at  | DATETIME  |                         |

### `followers`
| Column            | Type  | Notes                          |
|--------------------|-------|--------------------------------|
| follower_id        | INT   | PK                              |
| user_id            | INT   | FK → users.user_id (being followed) |
| follower_user_id   | INT   | FK → users.user_id (the follower)   |
| follow_date        | DATE  |                                 |

### `hashtags`
| Column      | Type         | Notes |
|-------------|--------------|-------|
| hashtag_id  | INT          | PK    |
| tag_name    | VARCHAR(50)  |       |
| category    | VARCHAR(50)  |       |

### `post_hashtags`
| Column      | Type | Notes                     |
|-------------|------|-----------------------------|
| id          | INT  | PK                          |
| post_id     | INT  | FK → posts.post_id          |
| hashtag_id  | INT  | FK → hashtags.hashtag_id    |

---

## 🚀 How to Use

1. Clone the repo:
   ```bash
   https://github.com/neelasaisowmya/Social_Media_Analysis_using_SQL-/tree/main
   ```
2. Import the SQL file into MySQL:
   ```bash
   mysql -u root -p < social_media_analytics_dataset.sql
   ```
3. Explore with sample queries, e.g. most-liked posts, top hashtag categories, or follower growth over time.

---

## 📄 License

Add a license of your choice (e.g. MIT) if you plan to share this publicly.# Social_Media_Analysis_using_SQL-
