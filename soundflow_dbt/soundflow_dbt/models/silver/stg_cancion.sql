-- Silver: CANCION
-- Descartamos fila 104 (titulo NULL = error crítico del feed).
-- sello_discografico se conserva NULL cuando no viene del distribuidor.
-- explicit se convierte de 'Y'/'N' a booleano.

SELECT
    b.titulo,
    b.duracion_seg,
    b.genero_musical,
    CASE WHEN b.explicit = 'Y' THEN TRUE ELSE FALSE END  AS explicit,
    b.sello_discografico,
    b.artista_nombre                                      AS nombre_artista,
    b.album_nombre                                        AS nombre_album,
    b.fecha_lanzamiento
FROM {{ source('bronze', 'brz_canciones') }} b
WHERE b.titulo          IS NOT NULL
  AND b.artista_nombre  IS NOT NULL
