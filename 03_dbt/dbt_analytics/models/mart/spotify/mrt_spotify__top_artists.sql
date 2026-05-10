{{ config(materialized='table') }}

with minutes_listened_agg as (
    select
        artist,
        sum(minutes_listened) as minutes_listened_by_artist
    from {{ ref('int_spotify__song_listening') }}
    group by artist
)

, rank_artist as (
    select
        artist,
        minutes_listened_by_artist,
        dense_rank() over (order by minutes_listened_by_artist desc) as rang
    from minutes_listened_agg
)

select
    artist,
    minutes_listened_by_artist,
    rang
from rank_artist
where rang <= 20
order by rang asc