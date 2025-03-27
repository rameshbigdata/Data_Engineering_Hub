WITH TopUser AS (
    SELECT name
    FROM Users
    JOIN MovieRating ON Users.user_id = MovieRating.user_id
    GROUP BY Users.user_id, name
    ORDER BY COUNT(DISTINCT MovieRating.movie_id) DESC, name
    LIMIT 1
),
TopMovie AS (
    SELECT title
    FROM Movies
    JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
    WHERE MovieRating.created_at >= '2020-02-01' AND MovieRating.created_at < '2020-03-01'
    GROUP BY Movies.movie_id, title
    ORDER BY AVG(MovieRating.rating) DESC, title
    LIMIT 1
)
SELECT name AS results FROM TopUser
UNION ALL
SELECT title AS results FROM TopMovie;
