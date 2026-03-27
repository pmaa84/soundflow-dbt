-- Gold: DIM_DISPOSITIVO
-- Catálogo de tipos de dispositivo extraído de Silver.
-- Incluimos fila 'desconocido' para reproducciones sin dispositivo.

SELECT 99 AS id_dispositivo_seed, 'desconocido' AS tipo, 'otro' AS categoria

UNION ALL

SELECT
    ROW_NUMBER() OVER (ORDER BY dispositivo)    AS id_dispositivo_seed,
    LOWER(TRIM(dispositivo))                    AS tipo,
    CASE LOWER(TRIM(dispositivo))
        WHEN 'mobile'    THEN 'movil'
        WHEN 'web'       THEN 'escritorio'
        WHEN 'smart_tv'  THEN 'tv'
        ELSE 'otro'
    END                                         AS categoria
FROM (
    SELECT DISTINCT dispositivo
    FROM {{ ref('stg_reproduccion') }}
    WHERE dispositivo IS NOT NULL
) d
