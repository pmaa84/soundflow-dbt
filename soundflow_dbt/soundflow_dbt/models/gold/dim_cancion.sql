-- Gold: DIM_CANCION
-- Desnormalizamos artista y album directamente en la dimensión
-- para evitar JOINs en las consultas analíticas.

SELECT
    c.titulo,
    c.duracion_seg,
    c.genero_musical,
    c.explicit,
    c.fecha_lanzamiento,
    c.nombre_artista,
    c.nombre_album,
    c.sello_discografico
FROM {{ ref('stg_cancion') }} c
