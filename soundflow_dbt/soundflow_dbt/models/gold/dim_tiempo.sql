-- Gold: DIM_TIEMPO
-- Generada sintéticamente, no viene de Silver.
-- Cubre el rango de fechas del proyecto.

SELECT
    CAST(TO_CHAR(d.fecha, 'YYYYMMDD') AS INT)   AS id_tiempo,
    d.fecha::DATE                                AS fecha,
    EXTRACT(YEAR  FROM d.fecha)::INT             AS anio,
    EXTRACT(MONTH FROM d.fecha)::INT             AS mes,
    EXTRACT(WEEK  FROM d.fecha)::INT             AS semana,
    TO_CHAR(d.fecha, 'Day')                      AS dia_semana,
    EXTRACT(DOW FROM d.fecha) IN (0, 6)          AS es_fin_semana
FROM (
    SELECT generate_series(
        '2024-01-01'::DATE,
        '2026-12-31'::DATE,
        '1 day'::INTERVAL
    ) AS fecha
) d
