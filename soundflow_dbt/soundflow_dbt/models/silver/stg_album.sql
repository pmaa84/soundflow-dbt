-- Silver: ALBUM
-- Álbumes únicos extraídos de brz_canciones.
-- FK a ARTISTA resuelta por nombre.

SELECT DISTINCT
    b.album_nombre          AS nombre,
    b.fecha_lanzamiento,
    b.artista_nombre        AS nombre_artista
FROM {{ source('bronze', 'brz_canciones') }} b
WHERE b.album_nombre   IS NOT NULL
  AND b.artista_nombre IS NOT NULL
