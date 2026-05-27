-- PARTE 4: RELACIONES MUCHOS A MUCHOS EN POSTGRESQL

DROP TABLE IF EXISTS proyectos_tecnologias;
DROP TABLE IF EXISTS tecnologias;
DROP TABLE IF EXISTS proyectos;

-- TABLA PROYECTOS

CREATE TABLE proyectos (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	dias_estimados INTEGER NOT NULL CHECK (dias_estimados > 0)
);

-- TABLA TECNOLOGIAS

CREATE TABLE tecnologias (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	categoria VARCHAR(30) NOT NULL
);

-- TABLA DE ROMPIMIENTO: PROYECTOS_TECNOLOGIAS
-- Relacion muchos a muchos entre proyectos y tecnologias

CREATE TABLE proyectos_tecnologias (
	id_proyecto INTEGER NOT NULL,
	id_tecnologia INTEGER NOT NULL,
	version VARCHAR(20) NOT NULL,

	PRIMARY KEY (id_proyecto, id_tecnologia),

	CONSTRAINT fk_proyecto FOREIGN KEY (id_proyecto) REFERENCES proyectos(id) ON DELETE CASCADE,
	CONSTRAINT fk_tecnologia FOREIGN KEY (id_tecnologia) REFERENCES tecnologias(id) ON DELETE CASCADE
);

-- INSERTS DE PRUEBA
-- Estos datos sirven para probar los JOINs

INSERT INTO proyectos (nombre, dias_estimados) VALUES
('Sistema de Reservas de Vuelos', 60),
('Plataforma Educativa Virtual', 90),
('Aplicacion de Inventario', 45),
('Sistema de Gestion de Clientes', 50);

INSERT INTO tecnologias (nombre, categoria) VALUES
('Java', 'Backend'),
('Spring Boot', 'Backend'),
('PostgreSQL', 'Base de Datos'),
('React', 'Frontend'),
('HTML', 'Frontend'),
('CSS', 'Frontend'),
('Docker', 'DevOps');

INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia, version) VALUES
(1, 1, '21'),
(1, 2, '3.5'),
(1, 3, '16'),
(2, 1, '17'),
(2, 2, '3.4'),
(2, 3, '15'),
(2, 4, '18'),
(3, 1, '21'),
(3, 3, '16'),
(4, 1, '17'),
(4, 2, '3.3'),
(4, 3, '15');

-- CONSULTA 1:
-- Tecnologias por Proyecto
-- Obtener todas las tecnologias utilizadas en un proyecto especifico
-- filtrando por el nombre del proyecto.

SELECT p.nombre AS proyecto, t.nombre AS tecnologia, t.categoria AS categoria, pt.version AS version
FROM proyectos p
INNER JOIN proyectos_tecnologias pt ON p.id = pt.id_proyecto
INNER JOIN tecnologias t ON t.id = pt.id_tecnologia
WHERE p.nombre = 'Sistema de Reservas de Vuelos';

-- CONSULTA 2:
-- Proyectos por Tecnologia
-- Obtener la lista de proyectos junto con la version utilizada
-- de una tecnologia especifica filtrando por su id.
-- USO: id_tecnologia = 1

SELECT t.nombre AS tecnologia, p.nombre AS proyecto, p.dias_estimados, pt.version AS version_utilizada
FROM tecnologias t
INNER JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
INNER JOIN proyectos p ON p.id = pt.id_proyecto
WHERE t.id = 1;

-- CONSULTA 3:
-- Reporte de Uso Tecnologico
-- Nombre de cada tecnologia y numero total de proyectos que la utilizan,
-- ordenado de mayor a menor uso.

SELECT t.nombre AS tecnologia, t.categoria AS categoria, COUNT(pt.id_proyecto) AS total_proyectos
FROM tecnologias t
INNER JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
GROUP BY t.id, t.nombre, t.categoria
ORDER BY total_proyectos DESC;