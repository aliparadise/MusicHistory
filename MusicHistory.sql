--Using the SQL Server Object Explorer in Visual Studio, examine the tables, columns, and foreign keys of the database.
--Using the dbdiagram.io site, create an ERD for the database.
--For each of the following exercises, provide the appropriate query. Yes, even the ones that are expressed in the form of questions. Everything from class and the references listed above is fair game.

--NOTE: Remember that it's not always wrong for a query to return no results. Sometimes there simply isn't data that matches some particular criteria.

--Query all of the entries in the Genre table

SELECT * FROM Genre;

--Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords

SELECT ArtistName FROM Artist ORDER BY ArtistName 

--Write a SELECT query that lists all the songs in the Song table and include the Artist name

SELECT Title, ArtistName
FROM Song AS s
JOIN Artist AS a
ON s.ArtistId = a.Id

--Write a SELECT query that lists all the Artists that have a Soul Album

SELECT * FROM Artist AS a 
JOIN Album AS b
ON a.Id = b.ArtistId
WHERE GenreId = 1

--Write a SELECT query that lists all the Artists that have a Jazz or Rock Album

SELECT * FROM Artist AS a 
JOIN Album AS b
ON a.Id = b.ArtistId
WHERE GenreId = 4 OR GenreId = 2

--Write a SELECT statement that lists the Albums with no songs


SELECT * FROM Album AS b
LEFT JOIN Song AS s
ON s.AlbumId = b.Id
WHERE s.Id is NULL

--Using the INSERT statement, add one of your favorite artists to the Artist table.

INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Modest Mouse', 1993);
SELECT * FROM Artist

--Using the INSERT statement, add one, or more, albums by your artist to the Album table.

INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('The Lonesome Crowded West', '11/18/1997', 4438, 'Up Records', 28 , 2);
SELECT * FROM Album

--Using the INSERT statement, add some songs that are on that album to the Song table.

INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Trailer Trash', 349, '11/18/1997', 2, 28, 23);
SELECT * FROM Song

--Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

SELECT Song.Title, Album.Title, Artist.ArtistName
FROM Song
LEFT JOIN Album
ON Song.AlbumId = Album.Id
LEFT JOIN Artist
ON Song.ArtistId = Artist.Id
WHERE Artist.ArtistName = 'Modest Mouse'

--NOTE: Direction of join matters. Try the following statements and see the difference in results.

--SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id;

SELECT a.Title, s.Title
FROM Album AS a
LEFT JOIN Song AS s
ON s.AlbumId = a.Id;

--SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id;

SELECT a.Title, s.Title
FROM Song AS s 
LEFT JOIN Album AS a
ON s.AlbumId = a.Id;

--Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(Song.Id) AS 'Number of Songs'
FROM Song
JOIN Artist ON Song.ArtistId = Artist.Id
GROUP BY Artist.Id

--Class Example (easy query)

SELECT *
FROM Album a
LEFT JOIN Song s ON a.Id = s.AlbumId

--adding more
--using id on count bc it has unique constraint

SELECT a.Title, Count(s.Id) as NumberOfSongs
FROM Album a
LEFT JOIN Song s ON a.Id = s.AlbumId
GROUP BY a.Id, a.Title


--Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

--Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

--Write a SELECT query that lists the Artists that have put out records on more than one record label. Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword

--FIRST basic setup (Class Example)

SELECT * 
FROM Artist
JOIN Album ON Album.ArtistId = Artist.Id

--This is artsits with albums

SELECT Artist.ArtistName 
FROM Artist
JOIN Album ON Album.ArtistId = Artist.Id
GROUP BY Artist.Id, Artist.ArtistName

--added having count

SELECT Artist.ArtistName 
FROM Artist
JOIN Album ON Album.ArtistId = Artist.Id
GROUP BY Artist.Id, Artist.ArtistName 
--(include primary key in query to guarentee unuiqeness)
HAVING Count(Distinct Album.Label) > 1




--Using ORDER BY and TOP 1, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

Select TOP 1 *
FROM Song
ORDER BY Song.SongLength DESC;

--Example of MAX with subqueries
SELECT s.*
FROM Song s
WHERE s.SongLength = (Select MAX(Song.SongLength)From Song);



--Using ORDER BY and TOP 1, write a select statement to find the song with the longest duration. The result should display the song title and the duration.

--Modify the previous query to also display the title of the album.