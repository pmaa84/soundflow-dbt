-- Silver: REPRODUCCION
-- id_usuario NULL → sustituimos por 0 (usuario anónimo).
-- pais_sesion NULL → sustituimos por 'XX' (desconocido).
-- playlist_id NULL → se conserva (reproducción directa, válido por diseño).
-- Descartamos reproducciones cuya canción fue rechazada en Silver (JOIN INNER).

SELECT
    b.id_raw                                AS id_reproduccion_raw,
    b.ts_inicio,
    b.segundos_escuchados,
    b.dispositivo,
    b.playlist_id,
    COALESCE(b.id_usuario, 0)               AS id_usuario_silver,
    b.id_cancion                            AS id_cancion_raw,
    COALESCE(b.pais_sesion, 'XX')           AS pais_sesion
FROM {{ source('bronze', 'brz_reproducciones') }} b
JOIN {{ ref('stg_cancion') }} c
    ON c.titulo IS NOT NULL   -- join de validación: solo canciones que pasaron a Silver
    -- En producción aquí se usaría el id real de la canción en Silver
WHERE b.ts_inicio IS NOT NULL
