CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    email VARCHAR(100),
    fecha_registro DATE
);

-- Crear la tabla de pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    producto VARCHAR(100),
    cantidad INT,
    fecha_pedido DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);

-- Crear la tabla de productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    stock INT
);

-- ============================================================

-- Usuarios
INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Luis Ramírez', 'luis@example.com', '2022-04-10');

INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Ana Sánchez', 'ana@example.com', '2022-05-12');

INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Pedro Gómez', 'pedro@example.com', '2022-06-18');

INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Matias Emilio', 'matias@example.com', '2022-05-21');

INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Mia Sanchez', 'mia@example.com', '2022-08-02');

INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Gladis Yela', 'gladis@example.com', '2022-12-10');

INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('Json Json', 'json@example.com', '2022-06-18');

-- Productos
INSERT INTO productos (nombre, precio, stock)
VALUES ('Blusa', 29.99, 40);

INSERT INTO productos (nombre, precio, stock)
VALUES ('Gorra', 9.99, 60);

INSERT INTO productos (nombre, precio, stock)
VALUES ('Chaqueta', 59.99, 25);

INSERT INTO productos (nombre, precio, stock)
VALUES ('Camiseta', 19.99, 50);

INSERT INTO productos (nombre, precio, stock)
VALUES ('Zapatos', 79.99, 20);

INSERT INTO productos (nombre, precio, stock)
VALUES ('Medias', 2.99, 0);

--Pedidos
INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (1, 'Camiseta', 2, '2022-01-20');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (1, 'Gorra', 3, '2022-01-04');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (5, 'Blusa', 1, '2022-04-20');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (2, 'Zapatos', 1, '2022-06-02');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (7, 'Gorra', 2, '2022-09-21');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (4, 'Comiseta', 5, '2022-01-20');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (7, 'Zapatos', 2, '2022-05-22');

INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (5, 'Zapatos', 1, '2022-06-25');

-- ============================================================
select * from usuarios;
select * from pedidos;
select * from productos;

-- Actualizar el nombre y el email de un usuario
UPDATE usuarios
SET nombre = 'Camilo Milo', email = 'camilo@email.com'
WHERE id = 1;

-- Eliminar un pedido
DELETE FROM pedidos
WHERE id = 1;

-- Renombrar una columna
ALTER TABLE nombre_tabla RENAME COLUMN nombre_columna_actual TO nombre_columna_nueva;
-- Renombrar una tabla
ALTER TABLE nombre_tabla_actual RENAME TO nombre_tabla_nueva;
-- Cambiar las propiedades de una columna
ALTER TABLE nombre_tabla ALTER COLUMN nombre_columna tipo_dato;


-- ============================================================
-- SQL AVANZADO
-- ============================================================

-- SUBCONSULTAS
select nombre, precio
from productos
where precio < (
	select AVG(precio)
	from productos
);

-- CONSULTAS ANIDADAS
select u.nombre, p.producto
FROM (
	SELECT id, nombre
	FROM usuarios
	WHERE fecha_registro > '2022-05-01' -- usuarios registrados despues de esa fecha
) AS u
JOIN pedidos AS p ON u.id = p.usuario_id;

-- -------------------------------------------------------------------

-- UNION
-- Obtener todos los nombres de productos y usuarios
SELECT nombre AS resultado FROM productos
UNION
SELECT nombre FROM usuarios;

-- INTERSECT
-- Obtener los usuarios que también han realizado pedidos
SELECT nombre FROM usuarios
INTERSECT
SELECT DISTINCT u.nombre FROM usuarios u
JOIN pedidos p ON u.id = p.usuario_id;

-- EXCEPT
-- Obtener los productos que no se han pedido aún
SELECT nombre FROM productos
EXCEPT
SELECT producto FROM pedidos;

-- -------------------------------------------------------------------
-- COUNT
-- Contar el número de usuarios en la tabla "usuarios"
SELECT COUNT(*) AS total_usuarios FROM usuarios;
-- Contar el número de pedidos realizados por cada usuario
SELECT u.nombre, (SELECT COUNT(*) FROM pedidos WHERE usuario_id = u.id) AS total_pedidos
FROM usuarios u;


-- Contar el número de productos con stock disponible
SELECT COUNT(*) AS total_productos_disponibles FROM productos WHERE stock > 0;

-- SUM
-- Calcular la suma total de los precios de los productos
SELECT SUM(precio) AS suma_precios_productos FROM productos;

-- Calcular la suma de las cantidades de los pedidos realizados por un usuario específico
SELECT SUM(cantidad) AS suma_cantidades_pedidos FROM pedidos WHERE usuario_id = 1;

-- AVG
-- Calcular el promedio de precios de los productos
SELECT AVG(precio) AS promedio_precios_productos FROM productos;

-- MAX y MIN
-- Encontrar el precio máximo de los productos
SELECT MAX(precio) AS precio_maximo FROM productos;

-- Encontrar la fecha de registro más reciente de los usuarios
SELECT MAX(fecha_registro) AS ultima_fecha_registro FROM usuarios;

-- Encontrar el precio mínimo de los productos
SELECT MIN(precio) AS precio_minimo FROM productos;

-- Encontrar la fecha de registro más antigua de los usuarios
SELECT MIN(fecha_registro) AS primera_fecha_registro FROM usuarios;

-- -------------------------------------------------------------------

-- INNER JOIN
-- Obtener los pedidos junto con la información del usuario que los realizó
SELECT p.producto, p.cantidad, u.nombre, u.email
FROM pedidos p
JOIN usuarios u ON p.usuario_id = u.id;

-- LEFT JOIN
-- Obtener todos los usuarios y, si tienen, los pedidos realizados por ellos
SELECT u.nombre AS usuario, p.producto, p.cantidad
FROM usuarios u
LEFT JOIN pedidos p ON u.id = p.usuario_id;

-- Obtener todos los pedidos y, si hay, los usuarios que los realizaron
SELECT p.*, u.nombre AS nombre_usuario
FROM pedidos p
RIGHT JOIN usuarios u ON p.usuario_id = u.id;

-- Obtener todos los usuarios y todos los pedidos, combinando los resultados
SELECT u.*, p.producto, p.cantidad
FROM usuarios u
FULL JOIN pedidos p ON u.id = p.usuario_id;

-- -------------------------------------------------------------------

-- WHERE
-- Obtener los usuarios que se registraron antes de una fecha específica
SELECT * FROM usuarios
WHERE fecha_registro < '2023-01-01';

-- Obtener los productos con un precio mayor o igual a $50
SELECT * FROM productos
WHERE precio >= 50.0;

-- Obtener los pedidos con una cantidad entre 2 y 5 (ambos inclusive)
SELECT * FROM pedidos
WHERE cantidad BETWEEN 2 AND 5;

-- Obtener los usuarios que se registraron en Madrid o Barcelona
SELECT * FROM productos
WHERE nombre = 'Gorra' AND precio =  9.99;

-- Obtener los productos que están agotados o tienen un precio mayor a $100
SELECT * FROM productos
WHERE stock = 0 OR precio > 100.0;

-- Obtener los pedidos que no han sido entregados
-- SELECT * FROM pedidos
-- WHERE NOT 'type boolean';

-- Obtener los usuarios que se registraron antes de una fecha específica y son mayores de 18 años
SELECT * FROM usuarios
WHERE fecha_registro < '2022-11-01' AND email LIKE '%example.com';

-- Obtener los productos con un precio mayor a $50 y una cantidad disponible mayor a 10
SELECT * FROM productos
WHERE precio > 50.0 AND stock > 10;

-- Obtener los pedidos con una cantidad entre 2 y 5 (ambos inclusive) y que no hayan sido entregados
SELECT * FROM pedidos
WHERE cantidad BETWEEN 2 AND 5 AND NOT entregado;

-- -------------------------------------------------------------------

-- FECHAS Y HORAS
SELECT CURRENT_DATE; -- Obtener la fecha actual
SELECT CURRENT_TIME; -- Obtener la hora actual
SELECT CURRENT_TIMESTAMP; -- Obtener la fecha y hora actual

SELECT EXTRACT(YEAR FROM fecha_registro) FROM usuarios; -- Extraer el año de una columna de fecha
SELECT EXTRACT(MONTH FROM fecha_columna); -- Extraer el mes de una columna de fecha
SELECT EXTRACT(DAY FROM fecha_columna); -- Extraer el día de una columna de fecha
SELECT EXTRACT(HOUR FROM hora_columna); -- Extraer la hora de una columna de hora
SELECT EXTRACT(MINUTE FROM hora_columna); -- Extraer los minutos de una columna de hora
SELECT EXTRACT(SECOND FROM hora_columna); -- Extraer los segundos de una columna de hora

SELECT fecha_columna + INTERVAL '1 day'; -- Sumar un día a una columna de fecha
SELECT fecha_columna - INTERVAL '1 week'; -- Restar una semana a una columna de fecha
SELECT hora_columna + INTERVAL '1 hour'; -- Sumar una hora a una columna de hora
SELECT hora_columna - INTERVAL '30 minutes'; -- Restar 30 minutos a una columna de hora

SELECT TO_CHAR(fecha_columna, 'YYYY-MM-DD'); -- Convertir una fecha a una cadena en formato "YYYY-MM-DD"
SELECT TO_CHAR(hora_columna, 'HH12:MI:SS AM'); -- Convertir una hora a una cadena en formato "HH:MI:SS AM/PM"

-- -------------------------------------------------------------------

-- TRANSACCIONES Y CONTROL DE CONCURRENCIA
-- Iniciar una transacción
BEGIN;

-- Insertar un nuevo usuario
INSERT INTO usuarios (nombre, email, fecha_registro)
VALUES ('John Doe', 'john@example.com', '2023-01-01');

-- Insertar un nuevo pedido asociado al usuario
INSERT INTO pedidos (usuario_id, producto, cantidad, fecha_pedido)
VALUES (1, 'Medias', 2, '2023-01-02');

-- Confirmar la transacción
-- COMMIT;
-- Deshacer transaccion
ROLLBACK;


-- Iniciar una transacción
BEGIN;

-- Leer el stock actual de un producto
SELECT stock FROM productos WHERE id = 1;

-- Realizar un update en el stock del producto
UPDATE productos SET stock = stock - 5 WHERE id = 1;

-- Confirmar la transacción
COMMIT;
-- Deshacer transaccion
--ROLLBACK;

-- -------------------------------------------------------------------

-- Índices y optimización de consultas
-- Crear un índice en la columna usuario_id de la tabla pedidos
CREATE INDEX idx_pedidos_usuario_id ON pedidos (usuario_id);

-- Analizar la consulta utilizando EXPLAIN
EXPLAIN SELECT * FROM pedidos WHERE usuario_id = 1;

-- -------------------------------------------------------------------
-- VISTAS Y SUBCONSULTAS
CREATE VIEW vista_usuarios_pedidos AS
SELECT u.nombre, u.email, p.producto, p.cantidad
FROM usuarios u
JOIN pedidos p ON u.id = p.usuario_id;

-- Consultar la vista creada
SELECT * FROM vista_usuarios_pedidos;

-- -------------------------------------------------------------------

--Procedimientos almacenados y funciones de usuario
-- Crear un procedimiento almacenado para obtener los pedidos de un usuario
CREATE OR REPLACE PROCEDURE obtener_pedidos_usuario(
    usuario_id INT
)
AS
$$
BEGIN
    SELECT producto, cantidad, fecha_pedido
    FROM pedidos
    WHERE usuario_id = obtener_pedidos_usuario.usuario_id;
END;
$$
LANGUAGE plpgsql;

-- Llamar al procedimiento almacenado para obtener los pedidos de un usuario
CALL obtener_pedidos_usuario(1);

-- Crear una función de usuario para calcular el total de ventas de un producto
CREATE OR REPLACE FUNCTION calcular_total_ventas_producto(
    producto_id INT
)
RETURNS DECIMAL
AS
$$
DECLARE
    total DECIMAL;
BEGIN
    SELECT SUM(cantidad) INTO total
    FROM pedidos
    WHERE producto = (SELECT nombre FROM productos WHERE id = calcular_total_ventas_producto.producto_id);
    
    RETURN total;
END;
$$
LANGUAGE plpgsql;

-- Utilizar la función de usuario para calcular el total de ventas de un producto
SELECT calcular_total_ventas_producto(1);

-- -------------------------------------------------------------------

-- TRIGGERS Y EVENTOS

