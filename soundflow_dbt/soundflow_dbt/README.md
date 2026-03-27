# SoundFlow — Proyecto dbt

Arquitectura Medallion completa: Bronze → Silver → Gold.

## Estructura

```
models/
├── bronze/
│   └── sources.yml          ← declaración de las tablas Bronze (brz_*)
├── silver/
│   ├── stg_pais.sql
│   ├── stg_artista.sql
│   ├── stg_album.sql
│   ├── stg_cancion.sql
│   ├── stg_usuario.sql
│   ├── stg_reproduccion.sql
│   └── schema.yml           ← tests de calidad Silver
└── gold/
    ├── dim_tiempo.sql
    ├── dim_cancion.sql
    ├── dim_usuario.sql
    ├── dim_dispositivo.sql
    └── fact_reproducciones.sql
```

## Orden de ejecución (dbt respeta el linaje automáticamente)

1. `stg_pais`
2. `stg_artista`
3. `stg_album`
4. `stg_cancion`
5. `stg_usuario`
6. `stg_reproduccion`
7. `dim_tiempo`, `dim_cancion`, `dim_usuario`, `dim_dispositivo`
8. `fact_reproducciones`

## Comandos útiles

```bash
# Ejecutar todo el proyecto
dbt run

# Ejecutar solo Silver
dbt run --select silver

# Ejecutar solo Gold
dbt run --select gold

# Ejecutar un modelo concreto y sus dependencias
dbt run --select +fact_reproducciones

# Lanzar los tests de calidad
dbt test

# Ver el linaje en el navegador
dbt docs generate
dbt docs serve
```

## Decisiones de diseño clave

- **Bronze nunca se modifica.** Los modelos Silver leen de `source()`, no de tablas físicas editadas.
- **`stg_usuario` incluye la fila Anónimo (id=0)** para que `stg_reproduccion` nunca tenga FK nula.
- **`stg_cancion` descarta titulo=NULL** con `WHERE titulo IS NOT NULL`.
- **`dim_tiempo` es sintética** — se genera con `generate_series`, no viene de Bronze.
- **`fact_reproducciones` se materializa al final** porque depende de todas las dimensiones.
