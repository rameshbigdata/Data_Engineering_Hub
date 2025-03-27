### Problem Statement

You have three tables:

1. **Movies**:
   - **`movie_id`**: Unique ID for each movie.
   - **`title`**: Title of the movie.

2. **Users**:
   - **`user_id`**: Unique ID for each user.
   - **`name`**: Name of the user.

3. **MovieRating**:
   - **`movie_id`**: ID of the movie being rated.
   - **`user_id`**: ID of the user who rated the movie.
   - **`rating`**: Rating given by the user (presumably on a scale from 1 to 5).
   - **`created_at`**: Date when the rating was given.

You need to find:

1. **The name of the user who has rated the greatest number of movies**. If there is a tie (i.e., multiple users have rated the same maximum number of movies), return the lexicographically smaller user name.

2. **The movie with the highest average rating in February 2020**. If there is a tie (i.e., multiple movies have the same highest average rating), return the lexicographically smaller movie name.

### Solution

The solution involves two main queries combined with a `UNION` to produce the final result.

#### Detailed Explanation

1. **Finding the User with the Most Ratings**:

   - **Subquery `TopUser`**:
     ```sql
     WITH TopUser AS (
         SELECT name
         FROM Users
         JOIN MovieRating ON Users.user_id = MovieRating.user_id
         GROUP BY Users.user_id, name
         ORDER BY COUNT(DISTINCT MovieRating.movie_id) DESC, name
         LIMIT 1
     )
     ```
     - **`JOIN Users` with `MovieRating`**: Join these tables to connect users with their ratings.
     - **`GROUP BY Users.user_id, name`**: Group the results by user to aggregate their movie ratings.
     - **`ORDER BY COUNT(DISTINCT MovieRating.movie_id) DESC, name`**: Order users by the count of distinct movies they have rated in descending order. In case of ties (i.e., users with the same number of rated movies), order them lexicographically by `name`.
     - **`LIMIT 1`**: Select only the top user (with the highest count or lexicographically smallest name in case of a tie).

2. **Finding the Movie with the Highest Average Rating in February 2020**:

   - **Subquery `TopMovie`**:
     ```sql
     WITH TopMovie AS (
         SELECT title
         FROM Movies
         JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
         WHERE MovieRating.created_at >= '2020-02-01' AND MovieRating.created_at < '2020-03-01'
         GROUP BY Movies.movie_id, title
         ORDER BY AVG(MovieRating.rating) DESC, title
         LIMIT 1
     )
     ```
     - **`JOIN Movies` with `MovieRating`**: Join these tables to connect movies with their ratings.
     - **`WHERE MovieRating.created_at >= '2020-02-01' AND MovieRating.created_at < '2020-03-01'`**: Filter ratings to include only those given in February 2020.
     - **`GROUP BY Movies.movie_id, title`**: Group the results by movie to compute average ratings.
     - **`ORDER BY AVG(MovieRating.rating) DESC, title`**: Order movies by their average rating in descending order. In case of ties, order them lexicographically by `title`.
     - **`LIMIT 1`**: Select only the top movie (with the highest average rating or lexicographically smallest title in case of a tie).

3. **Combining Results**:

   - **Final Query**:
     ```sql
     SELECT name AS results FROM TopUser
     UNION ALL
     SELECT title AS results FROM TopMovie;
     ```
     - **`UNION ALL`**: Combine the results from both subqueries. The first result will be the name of the user with the highest number of ratings, and the second result will be the title of the movie with the highest average rating in February 2020.

### Result Format

The result table should contain a single column `results` with two rows:

1. The name of the user who has rated the greatest number of movies.
2. The title of the movie with the highest average rating in February 2020.

### Example Result

Given the example input:

- **User with the most ratings**: `Daniel` (rated 3 movies).
- **Movie with the highest average rating in February 2020**: `Frozen 2` (average rating is 3.5).

The output should be:

```sql
+--------------+
| results      |
+--------------+
| Daniel       |
| Frozen 2     |
+--------------+
```