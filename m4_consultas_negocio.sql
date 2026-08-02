-- ══════════════════════════════════════════
-- Consultas SQL de negocio (M4)
-- Autor: Paula Sierra
-- Fecha: 24-07-2026
-- ══════════════════════════════════════════


--Consulta 1 — Resumen ejecutivo mensual. 
--Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 

SELECT 
MONTH (fecha_venta) AS mes,   -- SQL Server (T-SQL) no soporta la función estándar EXTRACT: reemplazo Reemplaza EXTRACT(MONTH FROM fecha_venta) por MONTH(fecha_venta)
SUM (precio_unitario * cantidad) as total_facturado,
COUNT (id_venta) as cantidad_pedidos,
AVG(precio_unitario * cantidad) as ticket_promedio
FROM ventas
GROUP BY MONTH (fecha_venta);

--Consulta 2 — Ranking de productos 

SELECT TOP (5) id_producto,
SUM (cantidad) as unidades_vendidas,
SUM (precio_unitario * cantidad) as total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3 — Clientes recurrentes 

SELECT id_cliente, 
COUNT (id_venta) as cantidad_pedidos,
SUM (precio_unitario * cantidad) as total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1;

--Consulta 4 — Meses por encima/por debajo del promedio
SELECT 
    sub.mes,
    sub.total_mes,
    (SELECT AVG(total_mensual) FROM (
        SELECT MONTH(fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_mensual 
        FROM ventas GROUP BY MONTH(fecha_venta)
    ) AS promedio_general) AS promedio_general,
    CASE 
        WHEN sub.total_mes >= (SELECT AVG(total_mensual) FROM (
            SELECT MONTH(fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_mensual 
            FROM ventas GROUP BY MONTH(fecha_venta)
        ) AS promedio_general) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_mes
FROM (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS sub;

-- ==========================================================
-- Hallazgos concretos, específicos y accionables para RetailPro.
-- ==========================================================
/*
  HALLAZGOS COMERCIALES Y ACCIONABLES:
  
  1. Concentración de ingresos por productos: El producto con id 1 (Laptop Pro 15) lidera 
     ampliamente la facturación total del periodo: 3660, mas de la mitad de los 6444 totales del mes,lo que demuestra una 
     alta dependencia de este artículo de gama alta frente a productos de mayor volumen en unidades 
     como el producto 2 (13 unidades vendidas pero menor recaudación).
  
  2. Base de clientes recurrentes identificada: El 100% de los clientes registrados (IDs 1, 2, 3, 4 y 5) 
     realizaron exactamente 2 pedidos cada uno en el periodo, evidenciando una base de clientes 
     completamente activa y recurrente sobre la cual aplicar estrategias de retención.
  
  3. Desempeño mensual consolidado: El mes 3 concentró la totalidad de las operaciones evaluadas 
     con un total facturado de 6444.00 y un ticket promedio de 644.40 por pedido, estableciendo 
     una sólida línea de base estacional para la futura comparación de trimestres en Power BI.
*/
