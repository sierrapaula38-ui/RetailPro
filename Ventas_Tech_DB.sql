-- Ventas_Tech_DB — Script de Creación e Inventario
-- Autor: Paula Sierra
-- Fecha: 2026-07-18

--CREAR BASE 
--CREATE DATEBASE Ventas_Tech_DB;

--Seccion DDL
--DROP TABLES (Orden inverso por FK)
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

--Creacion de las tablas
-- 1. Categorías (Sin dependencias)
CREATE TABLE categorias(
id_categoria INT PRIMARY KEY NOT NULL, 
nombre_categoria VARCHAR(50) NOT NULL,
descripcion VARCHAR(200)
);

-- 2. Clientes (Sin dependencias)
CREATE TABLE clientes(
id_cliente INT PRIMARY KEY NOT NULL,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) unique,
ciudad VARCHAR(50),
fecha_registro DATE NOT NULL,
);

-- 3. Productos (Depende de Categorías)
CREATE TABLE productos(
id_producto INT PRIMARY KEY NOT NULL,
nombre_producto VARCHAR(100) NOT NULL,
id_categoria INT,
precio DECIMAL(10,2) NOT NULL,
stock INT DEFAULT 0,
activo TINYINT DEFAULT 1,
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 4. Ventas (Depende de Clientes y Productos)
CREATE TABLE ventas(
id_venta INT PRIMARY KEY NOT NULL,
id_cliente INT,
id_producto INT,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
fecha_venta DATE NOT NULL
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

--Seccion DML
--Insertamos datos a las tablas

--Categorias
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) 
VALUES
(1, 'Computación', 'Laptops, PCs y monitores'),
(2, 'Accesorios', 'Periféricos y complementos'),
(3, 'Audio', 'Auriculares y parlantes'),
(4, 'Almacenamiento', 'Discos y memorias');

--Clientes
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro)
VALUES
(1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05'),
(2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10'),
(3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01'),
(4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15'),
(5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

--Productos
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES
(1, 'Laptop Pro 15',       1, 1200.00, 15, 1),
(2, 'Mouse Inalámbrico',   2,   28.00, 80, 1),
(3, 'Monitor 4K 27"',      1,  450.00, 12, 1),
(4, 'Auriculares BT Pro',  3,  120.00, 35, 1),
(5, 'SSD Externo 1TB',     4,  130.00, 18, 1),
(6, 'Teclado Mecánico',    2,   95.00, 40, 1);

--Ventas
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
VALUES 
(1,  1, 1, 2, 1200.00, '2024-03-05'),
(2,  2, 2, 5,   28.00, '2024-03-06'),
(3,  3, 3, 1,  450.00, '2024-03-07'),
(4,  1, 4, 2,  120.00, '2024-03-08'),
(5,  4, 5, 3,  130.00, '2024-03-10'),
(6,  2, 6, 4,   95.00, '2024-03-11'),
(7,  5, 1, 1, 1200.00, '2024-03-12'),
(8,  3, 2, 8,   28.00, '2024-03-13'),
(9,  4, 4, 1,  120.00, '2024-03-14'),
(10, 5, 3, 2,  450.00, '2024-03-15');

--Verificacion de integridad
--confirmar que cada tabla se cargó correctamente
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;



