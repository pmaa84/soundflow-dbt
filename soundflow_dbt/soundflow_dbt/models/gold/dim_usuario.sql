-- Gold: DIM_USUARIO
-- Incluye segmento_edad calculado desde fecha_nacimiento.
-- La fila especial Anónimo (id=0 en Silver) se convierte en id=-1 en Gold.

SELECT
    u.id_usuario_silver,
    u.nombre,
    u.pais,
    u.plan_suscripcion,
    u.es_anonimo,
    CASE
        WHEN u.fecha_nacimiento IS NULL                                      THEN 'Desconocido'
        WHEN EXTRACT(YEAR FROM AGE(u.fecha_nacimiento)) < 18                THEN '<18'
        WHEN EXTRACT(YEAR FROM AGE(u.fecha_nacimiento)) < 25                THEN '18-24'
        WHEN EXTRACT(YEAR FROM AGE(u.fecha_nacimiento)) < 35                THEN '25-34'
        WHEN EXTRACT(YEAR FROM AGE(u.fecha_nacimiento)) < 45                THEN '35-44'
        ELSE '45+'
    END                                                                      AS segmento_edad,
    EXTRACT(YEAR FROM u.fecha_registro)::INT                                 AS anio_registro
FROM {{ ref('stg_usuario') }} u
