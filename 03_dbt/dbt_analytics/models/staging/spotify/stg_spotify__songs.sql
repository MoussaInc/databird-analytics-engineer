SELECT  
    song_id,
    UPPER(title) as title,
    UPPER(artist) as artist,
    album,
    release_year,
    coalesce(genre, "unknown") as genre
FROM {{ source('spotify', 'songs') }}