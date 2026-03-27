-- Silver: PAIS
-- Catálogo de países extraído de brz_usuarios.
-- Incluimos 'XX' como código para sesiones con país desconocido.

SELECT 'XX' AS id_pais, 'Desconocido' AS nombre

UNION ALL

SELECT DISTINCT
    pais        AS id_pais,
    pais        AS nombre
FROM {{ source('bronze', 'brz_usuarios') }}
WHERE pais IS NOT NULL
