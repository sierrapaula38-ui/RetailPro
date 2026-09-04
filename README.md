# RetailPro — Análisis de Datos, Consultas SQL y Modelado en Powe Bi

Repositorio oficial del proyecto **RetailPro**.

## Estructura del Repositorio

```text
RetailPro/
├── README.md                           # Documentación principal del proyecto
├── Ventas_Tech_DB.sql                  # Script DDL y DML - Creación y carga de datos (Módulo 3)
├── m4_consultas_negocio.sql            # Consultas SQL de negocio y métricas clave (Módulo 4)
├── m5_consultas_joins.sql              # Consultas con JOINs y operadores relacionales (Módulo 5)
├── Modulo 6/                           # Carpeta de entregable del Pipeline ETL
│   └── Pipeline_ETL_Sierra_Paula.pbix  # Pipeline ETL y limpieza de datos en Power Query
└── Modulo 8/                           # Carpeta de pre-entrega de IA y modelado avanzado
    ├── Sierra_Paula_Checkpoint2.pbix   # Modelo en estrella, tabla calendario y medidas DAX
  ```

## Descripción de Archivos
```text
### 1. Ventas_Tech_DB.sql (Módulo 3)
Contiene la arquitectura relacional de la base de datos, compuesta por cuatro tablas principales con sus respectivas claves primarias y foráneas:
* **categorias:** Clasificación de los productos.
* **clientes:** Registro y datos de contacto de los compradores.
* **productos:** Catálogo de artículos con control de stock y precios.
* **ventas:** Transacciones comerciales vinculadas a clientes y productos.

### 2. m4_consultas_negocio.sql (Módulo 4)
Diseñado para dar respuestas rápidas al equipo comercial mediante el uso de funciones de agregación (`SUM`, `COUNT`, `AVG`), ordenamientos, filtros avanzados (`GROUP BY` / `HAVING`) y lógica condicional (`CASE WHEN`):
* **Resumen ejecutivo mensual:** Facturación total, cantidad de pedidos y ticket promedio agrupados por mes.
* **Ranking de productos:** Top 5 de artículos más vendidos por facturación y volumen.
* **Clientes recurrentes:** Identificación de compradores con más de un pedido registrado.

### 3. m5_consultas_joins.sql (Módulo 5)
Enfocado en el cruce de tablas y la integración relacional para alimentar tableros:
* **Vista base (`INNER JOIN`):** Cruce integral de ventas, clientes, productos y categorías incorporando dimensiones derivadas.
* **Auditorías de inactividad (`LEFT JOIN`):** Identificación de clientes y productos sin ventas registradas.
* **Consolidado (`UNION ALL`):** Integración estructurada de operaciones diferenciadas por canal.

### 4. Módulo 6 — Pipeline ETL y Limpieza de Datos
Desarrollo del pipeline ETL en Power Query (Lenguaje M) para procesar datos crudos y resolver problemas de calidad (`Pipeline_ETL_Sierra_Paula.pbix`):
* **Dim_Clientes:** Promoción de encabezados, eliminación de duplicados por clave primaria y tratamiento de nulos (correos por defecto y ciudades como "Sin Especificar").
* **Dim_Productos:** Tipado de datos, limpieza de nulos en precios (aplicando margen estándar del 60% al costo del ítem 109) y corrección de categorías faltantes.
* **Fact_Ventas:** Extracción de transacciones y enriquecimiento mediante *Left Outer Join* con productos.

### 5. Módulo 8 — Modelo de Datos y Medidas DAX (Checkpoint 2)
Implementación del modelo semántico avanzado (`Sierra_Paula_Checkpoint2.pbix`):
* **Esquema en estrella:** Relaciones activas `1:N` con dirección de filtro única.
* **Tabla Calendario (`Dim_Fechas`):** Generada mediante DAX (`CALENDAR`), con columnas de apoyo (Año, Mes, Trimestre), marcada formalmente como tabla de tiempo y con orden cronológico configurado.
* **Librería de Medidas (`_Medidas`):** 
  * `Total Ventas` y `Ventas Online` (`CALCULATE`)
  * Inteligencia temporal: `Ventas YTD`, `Ventas LY` (comparativa anual paralela) y `% Crecimiento Anual` (`VAR` y `DIVIDE`).
```

--Autor
Paula Sierra - 2026
