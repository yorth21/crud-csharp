-- CREAR TABLAS

CREATE TABLE categorias (
	categoria_id SERIAL PRIMARY KEY,
	nombre_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE productos(
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR(50) NOT NULL,
	precio_unitario DECIMAL(10,2) NOT NULL,
	stock INT NOT NULL,
	categoria_id INT NOT NULL,
	FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

CREATE TABLE clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre_cliente VARCHAR(50) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	pais VARCHAR(20) NOT NULL
);

CREATE TABLE pedidos (
	pedido_id SERIAL PRIMARY KEY,
	cliente_id INT NOT NULL,
	fecha_pedido DATE NOT NULL,
	monto_total DECIMAL(10,2),
	FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id) 
);

ALTER TABLE pedidos
ADD COLUMN producto_id INTEGER REFERENCES productos(producto_id);

ALTER TABLE pedidos ADD COLUMN cantidad INT NOT NULL;
ALTER TABLE pedidos DROP COLUMN monto_total;

-- =================================================================================================
-- INSERTAR DATOS
-- =================================================================================================
INSERT INTO clientes (nombre_cliente, ciudad, pais) VALUES
('Matias', 'Pasto', 'Colombia'),
('Mia', 'New York', 'Usa'),
('Camilo', 'Cali', 'Colombia'),
('Sebastian', 'Bogota', 'Colombia'),
('Malisa', 'Moscu', 'Rusia'),
('Martha', 'Pasto', 'Colombia');

INSERT INTO categorias(nombre_categoria) VALUES
('Verduras'),
('Frutas'),
('Cereales'),
('Aseo');

INSERT INTO productos (nombre_producto, precio_unitario, stock, categoria_id)
VALUES
    ('Tomate', 1.99, 50, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Verduras')),
    ('Zanahoria', 0.99, 100, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Verduras')),
    ('Manzana', 2.49, 80, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Frutas')),
    ('Plátano', 1.49, 0, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Frutas')),
    ('Arroz', 3.99, 120, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Cereales')),
    ('Maíz', 2.99, 90, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Cereales')),
    ('Pasta dental', 4.99, 60, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Aseo')),
    ('Jabón de manos', 2.49, 50, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Aseo')),
    ('Lechuga', 1.49, 30, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Verduras')),
    ('Naranja', 2.99, 70, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Frutas')),
    ('Trigo', 4.99, 100, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Cereales')),
    ('Pasta de dientes', 3.99, 40, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Aseo')),
    ('Cebolla', 0.99, 60, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Verduras')),
    ('Uva', 3.49, 45, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Frutas')),
    ('Avena', 2.49, 80, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Cereales')),
    ('Champú', 5.99, 30, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Aseo')),
    ('Espinaca', 1.79, 0, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Verduras')),
    ('Pera', 2.99, 60, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Frutas')),
    ('Arroz integral', 4.49, 70, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Cereales')),
    ('Papel higiénico', 6.99, 50, (SELECT categoria_id FROM categorias WHERE nombre_categoria = 'Aseo'));


INSERT INTO pedidos (cliente_id, fecha_pedido, producto_id, cantidad)
VALUES
(1, '2023-06-15', 1, 5),
(2, '2023-06-16', 7, 6),
(3, '2023-06-17', 10, 5),
(4, '2023-06-18', 15, 3),
(5, '2023-06-19', 18, 4),
(1, '2023-06-15', 3, 3),
(2, '2023-06-16', 6, 4),
(3, '2023-06-17', 12, 1),
(4, '2023-06-18', 16, 2),
(5, '2023-06-19', 20, 1),
(1, '2023-06-15', 2, 10),
(2, '2023-06-16', 5, 8),
(3, '2023-06-17', 9, 3),
(4, '2023-06-18', 13, 4),
(5, '2023-06-19', 17, 2),
(1, '2023-06-15', 4, 2),
(2, '2023-06-16', 8, 3),
(3, '2023-06-17', 11, 2),
(4, '2023-06-18', 14, 6),
(5, '2023-06-19', 19, 3),
(1, '2023-06-15', 6, 7),
(2, '2023-06-16', 9, 5),
(3, '2023-06-17', 13, 3),
(4, '2023-06-18', 16, 2),
(5, '2023-06-19', 20, 1),
(1, '2023-06-15', 8, 4),
(2, '2023-06-16', 10, 2),
(3, '2023-06-17', 14, 5),
(4, '2023-06-18', 17, 3),
(5, '2023-06-19', 19, 2),
(1, '2023-06-15', 9, 3);

-- Listar los productos que nadie pidio
select nombre_producto, producto_id from productos
except
select p.nombre_producto, p.producto_id from pedidos pd
join productos p on pd.producto_id = p.producto_id;
-- Listar los clientes con pedidos
select nombre_cliente from clientes
intersect
select c.nombre_cliente from pedidos p
join clientes c on p.cliente_id = c.cliente_id;
-- Mostrar los clientes sin pedidos
select c.nombre_cliente from clientes c
left join pedidos p on c.cliente_id = p.cliente_id where p.producto_id IS NULL;

-- ======================================================================================================
-- Crea una consulta que muestre el nombre del cliente y el total de pedidos realizados por cada cliente. ✅
-- ======================================================================================================
select c.nombre_cliente, (select count(*) 
from pedidos p where c.cliente_id = p.cliente_id) as num_pedidos from clientes c;

-- ======================================================================================================
-- Encuentra el nombre del producto más caro en cada categoría. ✅
-- ======================================================================================================
SELECT c.nombre_categoria, p.nombre_producto, p.precio_unitario
FROM productos p
JOIN categorias c ON p.categoria_id = c.categoria_id
WHERE (p.categoria_id, p.precio_unitario) IN (
  SELECT categoria_id, MAX(precio_unitario)
  FROM productos
  GROUP BY categoria_id
);

-- ======================================================================================================
-- Calcula el total de ventas por país para los clientes que tienen al menos un pedido. ✅
-- ======================================================================================================
select c.pais, sum(p.precio_unitario * pd.cantidad) from pedidos pd
join clientes c on pd.cliente_id = c.cliente_id
join productos p on pd.producto_id = p.producto_id
group by 1 order by 2;

-- ======================================================================================================
-- Actualiza el precio unitario de los productos en base a un porcentaje de descuento. ✅
-- ======================================================================================================
UPDATE productos
SET precio_unitario = precio_unitario * (1 - 0.20)
WHERE producto_id IN (SELECT producto_id FROM pedidos);

-- ======================================================================================================
-- Crea una vista que muestre los productos junto con su categoría y el nombre del cliente que ha realizado más pedidos de ese producto.
-- ======================================================================================================












