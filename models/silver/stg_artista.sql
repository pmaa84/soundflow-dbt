-- Silver: ARTISTA
-- Extraemos artistas únicos de brz_canciones.
-- Descartamos filas donde artista_nombre es NULL.

SELECT DISTINCT
    artista_nombre AS nombre
FROM {{ source('bronze', 'brz_canciones') }}
WHERE artista_nombre IS NOT NULL
