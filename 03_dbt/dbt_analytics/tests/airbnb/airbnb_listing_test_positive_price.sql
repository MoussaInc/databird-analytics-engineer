SELECT 
    id
FROM {{ ref('stg_airbnb__listings') }}
WHERE price < 0 OR price IS NULL