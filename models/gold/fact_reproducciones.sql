-- Gold: FACT_REPRODUCCIONES
-- Grano: una fila por evento de reproducción.
-- Medidas aditivas: segundos_escuchados, duracion_cancion_seg.
-- Medidas semi-aditivas (flags): es_escucha_completa, es_desde_playlist.
-- La tabla de hechos se carga al final, cuando todas las dims están disponibles.

SELECT
    CAST(TO_CHAR(r.ts_inicio, 'YYYYMMDD') AS INT)                           AS id_tiempo,
    c.titulo                                                                 AS cancion_titulo,
    COALESCE(r.id_usuario_silver, 0)                                        AS id_usuario_silver,
    COALESCE(r.pais_sesion, 'XX')                                           AS pais_sesion,
    LOWER(TRIM(r.dispositivo))                                              AS dispositivo,
    r.id_reproduccion_raw,
    r.playlist_id,
    CASE WHEN r.playlist_id IS NOT NULL THEN TRUE ELSE FALSE END            AS es_desde_playlist,
    r.segundos_escuchados,
    c.duracion_seg                                                           AS duracion_cancion_seg,
    CASE
        WHEN r.segundos_escuchados >= c.duracion_seg THEN TRUE
        ELSE FALSE
    END                                                                      AS es_escucha_completa
FROM {{ ref('stg_reproduccion') }} r
JOIN {{ ref('stg_cancion') }} c
    ON c.titulo = r.id_cancion_raw::TEXT   -- en producción se usaría el id numérico
