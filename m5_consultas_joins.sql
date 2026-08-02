-- ══════════════════════════════════════════
-- M5: Consultas con JOINs y Unión 
-- Autor: Paula Sierra
-- Fecha: 2026-08-02
-- ══════════════════════════════════════════

-- ── CONSULTA 1 — Vista base del proyecto (INNER JOIN) ─────────────────
-- Combiná ventas, clientes, productos y territorios para obtener en una sola fila: fecha, nombre
-- del cliente, segmento, región, nombre del producto, categoría, cantidad, precio unitario, total de venta y canal. 
-- Esta consulta será la fuente de datos principal en Power BI.

SELECT 
v.fecha_venta AS fecha,
c.nombre AS nombre_cliente, 
    -- segmento: retail vs mayorista
  CASE
    WHEN v.cantidad >= 4 THEN 'Mayorista'
    ELSE 'Retail'
  END AS segmento,
-- region derivada de ciudad 
CASE
    WHEN c.ciudad IN ('Buenos Aires','Rosario','Córdoba') THEN 'Centro'
    WHEN c.ciudad IN ('Mendoza') THEN 'Cuyo'
    WHEN c.ciudad IN ('Tucumán') THEN 'Norte'
    ELSE 'Interior'
END AS región,
p.nombre_producto,
cat.nombre_categoria AS categoria,
v.cantidad,
v.precio_unitario,
(v.cantidad * v.precio_unitario) AS total_venta,
  -- canal derivado 
CASE
    WHEN v.precio_unitario >= 120 THEN 'Online'
    ELSE 'Presencial'
END AS canal
FROM ventas AS v
INNER JOIN productos AS p  ON p.id_producto = v.id_producto
INNER JOIN clientes AS c ON c.id_cliente = v.id_cliente
INNER JOIN categorias AS cat ON cat.id_categoria = p.id_categoria


/*
 ANÁLISIS:
  Esta vista consolida de manera relacional el 100% de las operaciones registradas,
  permitiendo relacionar dimensiones clave (cliente, categoría, región) con métricas transaccionales 
  exactas para el modelado dimensional en Power BI.
*/

-- ── Consulta 2 — Clientes sin ventas (LEFT JOIN) ─────────────────
--  Identificá clientes registrados que aún no han realizado ninguna compra.
-- Mostrá su nombre, email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.

SELECT 
c.nombre,
c.email,
c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

/*
 ANÁLISIS:
  En el estado actual de la base de datos de prueba, la consulta no arroja filas vacías 
  porque todos los clientes registrados poseen al menos una compra asociada. Sin embargo, 
  técnicamente garantiza la auditoría para la detección oportuna de clientes inactivos o sin conversión.
*/

-- ── CONSULTA 3 — Productos sin ventas  (LEFT JOIN) ────
--Identificá productos del catálogo que no tienen ninguna venta registrada.
--Mostrá nombre del producto, categoría y precio. Usá WHERE ... IS NULL.

SELECT 
p.nombre_producto,
cat.nombre_categoria AS categoria,
p.precio
FROM productos AS p
INNER JOIN categorias AS cat 
ON cat.id_categoria = p.id_categoria
LEFT JOIN ventas AS v
ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

/*
 ANÁLISIS:
  Permite aislar aquellos productos del catálogo sin venta registrada (como productos 
  recientemente agregados o sin demanda), aportando métricas clave para el control de inventario de producto.
*/

-- ── CONSULTA 4 — Consolidado por canal (UNION ALL)  ────
--  Usá UNION ALL para combinar en un solo resultado las ventas Online y Presencial,
-- agregando una columna canal que identifique el origen de cada fila.
-- Al final calculá el total por canal con un GROUP BY.


SELECT 
  canal,
  COUNT(id_venta) AS total_operaciones,
  SUM(cantidad * precio_unitario) AS facturacion_total
FROM (
  SELECT id_venta, cantidad, precio_unitario, 'Online' AS canal 
  FROM ventas 
  WHERE precio_unitario >= 120

  UNION ALL

  SELECT id_venta, cantidad, precio_unitario, 'Presencial' AS canal 
  FROM ventas 
  WHERE precio_unitario < 120
) AS ventas_por_canal
GROUP BY canal;


/* ANÁLISIS:  
   Permite auditar el volumen de operaciones y la recaudación total segmentada de forma coherente 
   por canal operativo utilizando UNION ALL para preservar la totalidad de los registros.
*/