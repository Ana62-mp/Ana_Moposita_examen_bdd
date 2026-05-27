-------------------------------------------------------
-- PARTE 1: POSTGRESQL BASICO Y MANIPULACION DE DATOS
-- Archivo: parte1_vuelos.sql
-- Tabla: vuelos

DROP TABLE IF EXISTS vuelos;

CREATE TABLE vuelos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    precio_boleto NUMERIC(10,2) NOT NULL CHECK (precio_boleto >= 0),
    asientos_disponibles INTEGER NOT NULL CHECK (asientos_disponibles >= 0)
);

-------------------------------------------------------
-- INSERTS: 20 VUELOS

INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES
('AA-123', 250.00, 45),
('LA-456', 320.50, 12),
('IB-789', 580.75, 3),
('AV-101', 210.00, 0),
('CM-202', 430.99, 8),
('DL-303', 390.00, 25),
('UA-404', 610.25, 2),
('AF-505', 750.00, 18),
('KL-606', 680.40, 0),
('AM-707', 290.99, 33),
('BA-808', 820.00, 4),
('QR-909', 950.75, 20),
('EK-111', 1100.00, 7),
('TA-222', 175.50, 50),
('NK-333', 120.00, 1),
('G3-444', 260.80, 15),
('AR-555', 310.25, 6),
('UX-666', 540.00, 0),
('AC-777', 720.60, 9),
('AZ-888', 455.35, 28);

-------------------------------------------------------
-- CONSULTA 1: ALERTA DE VUELO LLENO
-- Obtener vuelos con menos de 5 asientos disponibles

SELECT * FROM vuelos
WHERE asientos_disponibles < 5;

-------------------------------------------------------
-- CONSULTA 2: INCREMENTO DE TARIFAS
-- Incrementar el precio del boleto en 15% para un vuelo especifico
-- Ejemplo: vuelo con id = 1

UPDATE vuelos
SET precio_boleto = precio_boleto * 1.15
WHERE id = 1;

-- Verificar actualizción
SELECT * FROM vuelos 
WHERE id = 1;

-------------------------------------------------------
-- CONSULTA 3: DEPURACION DE RUTAS CANCELADAS
-- Elimiinar vuelos con exactamente 0 asientos disponibles

DELETE FROM vuelos
WHERE asientos_disponibles = 0;

-- Verificar datos restantes
SELECT * FROM vuelos;