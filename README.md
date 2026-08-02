# RetailPro — Análisis de Datos y Consultas SQL

Repositorio oficial del proyecto **RetailPro**.

## Estructura del Repositorio

```text
RetailPro/
├── README.md                   # Documentación principal del proyecto
├── Ventas_Tech_DB.sql          # Script DDL y DML (Creación de tablas, relaciones e inserciones) (Módulo 3)[cite: 2]
├── m4_consultas_negocio.sql    # Consultas SQL de negocio y métricas clave (Módulo 4)[cite: 1]
└── m5_consultas_joins.sql      # Consultas con JOINs, operadores relacionales y uniones (Módulo 5)
```

## Descripción de Archivos
```text
1. Ventas_Tech_DB.sql (Módulo 3)
Contiene la arquitectura relacional de la base de datos Ventas_Tech_DB, compuesta por cuatro tablas principales con sus respectivas claves primarias y foráneas:

categorias: Clasificación de los productos.

clientes: Registro y datos de contacto de los compradores.

productos: Catálogo de artículos con control de stock y precios.

ventas: Transacciones comerciales vinculadas a clientes y productos.

2. m4_consultas_negocio.sql (Módulo 4)
Diseñado para dar respuestas rápidas al equipo comercial mediante el uso de funciones de agregación (SUM, COUNT, AVG), ordenamientos, filtros avanzados (GROUP BY / HAVING) y lógica condicional (CASE WHEN):

Resumen ejecutivo mensual: Facturación total, cantidad de pedidos y ticket promedio agrupados por mes.

Ranking de productos: Top 5 de artículos más vendidos por facturación y volumen de unidades.

Clientes recurrentes: Identificación de compradores con más de un pedido registrado.

Performance mensual: Análisis comparativo de los meses respecto al promedio general de ventas.

3. m5_consultas_joins.sql (Módulo 5)
Enfocado en el cruce de tablas y la integración relacional para alimentar tableros en Power BI y realizar auditorías de negocio:

Vista base (INNER JOIN): Cruce integral de ventas, clientes, productos y categorías incorporando dimensiones derivadas (segmento, región y canal mediante expresiones condicionales).

Clientes sin ventas (LEFT JOIN): Auditoría para identificar registros de clientes inactivos mediante la cláusula WHERE ... IS NULL.

Productos sin ventas (LEFT JOIN): Aislamiento de artículos del catálogo sin ventas registradas.

Consolidado por canal (UNION ALL): Integración estructurada de operaciones diferenciadas por canal con agregación final mediante GROUP BY.
```

--Autor
Paula Sierra - 2026
