SELECT 
    unit_price
FROM {{ ref('stg_airbnb__listings') }}
WHERE unit_price < 0 OR unit_price IS NULL