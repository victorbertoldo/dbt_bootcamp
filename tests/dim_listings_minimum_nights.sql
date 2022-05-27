-- To work it out, we have to write a query that will return zero rows. So if some day it returns one or more, the tests will fail.
SELECT
 *
FROM
 {{ ref('dim_listings_cleansed') }}
WHERE minimum_nights < 1
LIMIT 10
