-- SELECCIONAR LA BASE DE DATOS (sin crear si ya existe)
USE sistema_invitaciones;

-- ELIMINAR TABLAS EXISTENTES EN ORDEN CORRECTO (debido a restricciones de claves foráneas)
DROP TABLE IF EXISTS confirmaciones;
DROP TABLE IF EXISTS invitados;
DROP TABLE IF EXISTS mascotas;
DROP TABLE IF EXISTS propietarios;
DROP TABLE IF EXISTS personas;

-- CREACIÓN DE TABLAS

-- Tabla personas (30 registros)
CREATE TABLE personas (
    id_persona INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

-- Tabla invitados (30 registros)
CREATE TABLE invitados (
    id_invitado INT PRIMARY KEY AUTO_INCREMENT,
    id_persona INT,
    metodo_invitacion VARCHAR(20),
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

-- Tabla confirmaciones (30 registros)
CREATE TABLE confirmaciones (
    id_confirmacion INT PRIMARY KEY AUTO_INCREMENT,
    id_persona INT,
    estado VARCHAR(20),
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

-- Tabla propietarios
CREATE TABLE propietarios (
    id_propietario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion TEXT,
    fecha_registro DATE
);

-- Tabla mascotas
CREATE TABLE mascotas (
    id_mascota INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    especie VARCHAR(30),
    raza VARCHAR(50),
    edad INT,
    peso DECIMAL(5,2),
    color VARCHAR(30),
    id_propietario INT,
    fecha_registro DATE,
    FOREIGN KEY (id_propietario) REFERENCES propietarios(id_propietario)
);

-- INSERTAR 30 REGISTROS EN CADA TABLA PRINCIPAL

-- 30 personas
INSERT INTO personas (nombre, apellido) VALUES
('Miguel', 'González'), ('María', 'López'), ('José', 'Martínez'),
('Ana', 'Hernández'), ('Carlos', 'García'), ('Laura', 'Rodríguez'),
('Roberto', 'Pérez'), ('Sofía', 'Sánchez'), ('Diego', 'Ramírez'),
('Valentina', 'Torres'), ('Alejandro', 'Flores'), ('Camila', 'Morales'),
('Fernando', 'Jiménez'), ('Isabella', 'Vargas'), ('Javier', 'Díaz'),
('Daniela', 'Romero'), ('Ricardo', 'Álvarez'), ('Gabriela', 'Rojas'),
('Andrés', 'Mendoza'), ('Natalia', 'Guerrero'), ('Luis', 'Herrera'),
('Paula', 'Silva'), ('Juan', 'Ortega'), ('Carolina', 'Navarro'),
('Pedro', 'Castillo'), ('Marcela', 'Peña'), ('Sergio', 'Cortés'),
('Elena', 'Ríos'), ('Raúl', 'Delgado'), ('Verónica', 'Vega');

-- 30 invitados (uno por persona)
INSERT INTO invitados (id_persona, metodo_invitacion) VALUES
(1, 'WhatsApp'), (2, 'WhatsApp'), (3, 'Email'), (4, 'WhatsApp'),
(5, 'Llamada'), (6, 'WhatsApp'), (7, 'En persona'), (8, 'Email'),
(9, 'WhatsApp'), (10, 'Email'), (11, 'WhatsApp'), (12, 'Llamada'),
(13, 'Email'), (14, 'WhatsApp'), (15, 'En persona'), (16, 'WhatsApp'),
(17, 'Email'), (18, 'Llamada'), (19, 'WhatsApp'), (20, 'Email'),
(21, 'WhatsApp'), (22, 'En persona'), (23, 'WhatsApp'), (24, 'Email'),
(25, 'Llamada'), (26, 'WhatsApp'), (27, 'Email'), (28, 'WhatsApp'),
(29, 'En persona'), (30, 'WhatsApp');

-- 30 confirmaciones (una por persona)
INSERT INTO confirmaciones (id_persona, estado) VALUES
(1, 'Confirma'), (2, 'Confirma'), (3, 'No puede'), (4, 'Confirma'),
(5, 'Tal vez'), (6, 'Confirma'), (7, 'Confirma'), (8, 'No puede'),
(9, 'Tal vez'), (10, 'Confirma'), (11, 'No puede'), (12, 'Confirma'),
(13, 'Tal vez'), (14, 'Confirma'), (15, 'No puede'), (16, 'Confirma'),
(17, 'Tal vez'), (18, 'Confirma'), (19, 'No puede'), (20, 'Confirma'),
(21, 'Tal vez'), (22, 'Confirma'), (23, 'No puede'), (24, 'Confirma'),
(25, 'Tal vez'), (26, 'Confirma'), (27, 'No puede'), (28, 'Confirma'),
(29, 'Tal vez'), (30, 'Confirma');

-- Insertar datos adicionales para las otras tablas
INSERT INTO propietarios (nombre, apellido, telefono, email, direccion, fecha_registro) VALUES
('Juan', 'Pérez', '555-1234', 'juan@email.com', 'Calle 123, Ciudad', '2024-01-15'),
('María', 'González', '555-5678', 'maria@email.com', 'Avenida 456, Ciudad', '2024-02-20'),
('Carlos', 'López', '555-9012', 'carlos@email.com', 'Boulevard 789, Ciudad', '2024-03-10');

INSERT INTO mascotas (nombre, especie, raza, edad, peso, color, id_propietario, fecha_registro) VALUES
('Max', 'Perro', 'Labrador', 3, 25.50, 'Dorado', 1, '2024-01-20'),
('Luna', 'Gato', 'Siamés', 2, 4.20, 'Blanco', 1, '2024-02-15'),
('Rocky', 'Perro', 'Bulldog', 5, 18.00, 'Marrón', 2, '2024-03-05'),
('Mimi', 'Gato', 'Persa', 1, 3.80, 'Gris', 3, '2024-04-10');

-- EJERCICIOS CASE (CONSULTAS SOLICITADAS)

-- EJERCICIO 1: CASE SIMPLE
SELECT 
    p.nombre, 
    p.apellido, 
    i.metodo_invitacion,
    CASE i.metodo_invitacion
        WHEN 'WhatsApp' THEN '🟢 Mensaje'
        WHEN 'Email' THEN '🟣 Correo'
        WHEN 'Llamada' THEN '🟤 Teléfono'
        WHEN 'En persona' THEN '🟥 Cara a cara'
        ELSE '❓ Desconocido'
    END as tipo_invitacion
FROM personas p
JOIN invitados i ON p.id_persona = i.id_persona;

-- EJERCICIO 2: CASE SEARCHED
SELECT 
    p.nombre,
    p.apellido,
    c.estado as confirmacion,
    CASE
        WHEN c.estado = 'Confirma' THEN '☑ Viene seguro'
        WHEN c.estado = 'No puede' THEN '✗ No puede venir'
        WHEN c.estado = 'Tal vez' THEN '🟩 Tal vez viene'
        WHEN c.estado IS NULL THEN '🟪 Sin respuesta'
        ELSE '💡 Estado raro'
    END as situacion
FROM personas p
LEFT JOIN confirmaciones c ON p.id_persona = c.id_persona
WHERE p.id_persona IN (SELECT id_persona FROM invitados);

-- EJERCICIO 3: CASE SEARCHED en WHERE
SELECT 
    p.nombre,
    p.apellido,
    i.metodo_invitacion,
    c.estado
FROM personas p
LEFT JOIN invitados i ON p.id_persona = i.id_persona
LEFT JOIN confirmaciones c ON p.id_persona = c.id_persona
WHERE 
    CASE
        WHEN i.metodo_invitacion = 'WhatsApp' THEN c.estado = 'Confirma'
        WHEN i.metodo_invitacion = 'Email' THEN c.estado IN ('Confirma', 'Tal vez')
        ELSE TRUE
    END;

-- ELIMINAR PROCEDIMIENTOS EXISTENTES PRIMERO (para evitar errores)
DROP PROCEDURE IF EXISTS mostrar_todas_mascotas;
DROP PROCEDURE IF EXISTS buscar_mascota_por_id;
DROP PROCEDURE IF EXISTS contar_mascotas;
DROP PROCEDURE IF EXISTS actualizar_peso_mascota;
DROP PROCEDURE IF EXISTS agregar_nueva_mascota;
DROP PROCEDURE IF EXISTS validar_edad_mascota;

-- PROCEDIMIENTOS ALMACENADOS

-- EJERCICIO 4: Procedimiento sin parámetros
DELIMITER //
CREATE PROCEDURE mostrar_todas_mascotas()
BEGIN
    SELECT
        m.id_mascota as 'ID Mascota',
        m.nombre as 'Nombre Mascota',
        m.especie as 'Especie',
        m.raza as 'Raza',
        m.edad as 'Edad',
        m.peso as 'Peso (kg)',
        CONCAT(p.nombre, ' ', p.apellido) as 'Propietario',
        p.telefono as 'Teléfono Propietario'
    FROM mascotas m
    INNER JOIN propietarios p ON m.id_propietario = p.id_propietario
    ORDER BY m.nombre;
END //
DELIMITER ;

-- EJERCICIO 5: Procedimiento con IN
DELIMITER //
CREATE PROCEDURE buscar_mascota_por_id(IN p_id INT)
BEGIN
    IF p_id <= 0 THEN
        SELECT 'Error: El ID debe ser mayor a 0' as Mensaje;
    ELSE
        SELECT
            id_mascota as 'ID',
            nombre as 'Nombre',
            especie as 'Especie',
            raza as 'Raza',
            edad as 'Edad años',
            peso as 'Peso kg'
        FROM mascotas
        WHERE id_mascota = p_id;
    END IF;
END //
DELIMITER ;

-- EJERCICIO 6: Procedimiento con OUT
DELIMITER //
CREATE PROCEDURE contar_mascotas(OUT p_total INT)
BEGIN
    SELECT COUNT(*) INTO p_total FROM mascotas;
END //
DELIMITER ;

-- EJERCICIO 7: Procedimiento con IN y OUT
DELIMITER //
CREATE PROCEDURE actualizar_peso_mascota(IN p_id INT, INOUT p_peso DECIMAL(5,2))
BEGIN
    DECLARE peso_anterior DECIMAL(5,2);
    DECLARE mascota_existe INT;

    SELECT COUNT(*) INTO mascota_existe
    FROM mascotas
    WHERE id_mascota = p_id;

    IF mascota_existe = 0 THEN
        SET p_peso = -1;
    ELSE
        SELECT peso INTO peso_anterior
        FROM mascotas
        WHERE id_mascota = p_id;

        UPDATE mascotas
        SET peso = p_peso
        WHERE id_mascota = p_id;

        SET p_peso = peso_anterior;
    END IF;
END //
DELIMITER ;

-- EJERCICIO 8: Procedimiento de mantenimiento
DELIMITER //
CREATE PROCEDURE agregar_nueva_mascota(
    IN p_nombre VARCHAR(50),
    IN p_especie VARCHAR(30),
    IN p_raza VARCHAR(50),
    IN p_edad INT,
    IN p_peso DECIMAL(5,2),
    IN p_color VARCHAR(30),
    IN p_id_propietario INT
)
BEGIN
    DECLARE propietario_existe INT;

    SELECT COUNT(*) INTO propietario_existe
    FROM propietarios
    WHERE id_propietario = p_id_propietario;

    IF propietario_existe = 0 THEN
        SELECT 'Error: El propietario no existe' as Mensaje;
    ELSE
        INSERT INTO mascotas (nombre, especie, raza, edad, peso, color, id_propietario, fecha_registro)
        VALUES (p_nombre, p_especie, p_raza, p_edad, p_peso, p_color, p_id_propietario, CURDATE());
        
        SELECT 'Mascota agregada exitosamente' as Mensaje;
    END IF;
END //
DELIMITER ;

-- EJERCICIO 9: Procedimiento de validación
DELIMITER //
CREATE PROCEDURE validar_edad_mascota(IN p_id_mascota INT, OUT p_es_valida VARCHAR(50))
BEGIN
    DECLARE v_edad INT;
    DECLARE mascota_existe INT;

    SELECT COUNT(*) INTO mascota_existe
    FROM mascotas
    WHERE id_mascota = p_id_mascota;

    IF mascota_existe > 0 THEN
        SELECT edad INTO v_edad
        FROM mascotas
        WHERE id_mascota = p_id_mascota;
    END IF;

    IF mascota_existe = 0 THEN
        SET p_es_valida = 'Error: Mascota no encontrada';
    ELSEIF v_edad <= 0 THEN
        SET p_es_valida = 'Error: Edad inválida';
    ELSE
        IF v_edad <= 25 THEN
            SET p_es_valida = 'Edad válida';
        ELSE
            SET p_es_valida = 'Edad muy alta (máximo 25 años)';
        END IF;
    END IF;
END //
DELIMITER ;