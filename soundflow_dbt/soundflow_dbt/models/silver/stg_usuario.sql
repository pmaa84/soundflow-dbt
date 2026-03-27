-- Silver: USUARIO
-- Descartamos filas sin email (campo obligatorio e identificador).
-- fecha_registro NULL → fallback a fecha actual.
-- nombre NULL → 'Desconocido' (campo degradado, no error crítico).
-- Incluimos la fila especial Anónimo (id=0) para reproducciones sin sesión.

SELECT
    0                                               AS id_usuario_silver,
    'Anónimo'                                       AS nombre,
    'anonimo@internal'                              AS email,
    CURRENT_DATE                                    AS fecha_registro,
    NULL::DATE                                      AS fecha_nacimiento,
    NULL::CHAR(1)                                   AS genero,
    'free'                                          AS plan_suscripcion,
    NULL                                            AS pais,
    TRUE                                            AS es_anonimo

UNION ALL

SELECT
    id_raw                                          AS id_usuario_silver,
    COALESCE(nombre, 'Desconocido')                 AS nombre,
    email,
    COALESCE(fecha_registro, CURRENT_DATE)          AS fecha_registro,
    fecha_nacimiento,
    genero,
    plan_suscripcion,
    pais,
    FALSE                                           AS es_anonimo
FROM {{ source('bronze', 'brz_usuarios') }}
WHERE email IS NOT NULL
