-- ============================================================
-- TechDesk - Script de instalacion para la API de autenticacion
-- Archivo: techdesk_entrega.sql
--
-- Uso:
-- 1. Ejecutar este script en MySQL Workbench.
-- 2. Crea el esquema techdesk y sus seis tablas.
-- 3. Inserta datos iniciales en roles, estados, categorias y prioridades.
-- 4. No incluye usuarios de prueba; registre usuarios mediante la API
--    para que las contrasenas se almacenen con bcrypt.
--
-- Nota: este script esta pensado para una instalacion inicial.
-- No elimina tablas ni datos existentes.
-- ============================================================

CREATE DATABASE IF NOT EXISTS techdesk
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE techdesk;

CREATE TABLE IF NOT EXISTS roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_usuarios_rol
        FOREIGN KEY (id_rol)
        REFERENCES roles (id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS estados (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS prioridades (
    id_prioridad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tickets (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_tecnico INT DEFAULT NULL,
    id_categoria INT NOT NULL,
    id_prioridad INT NOT NULL,
    id_estado INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME NULL,
    fecha_cierre DATETIME NULL,

    CONSTRAINT fk_ticket_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios (id_usuario),

    CONSTRAINT fk_ticket_tecnico
        FOREIGN KEY (id_tecnico)
        REFERENCES usuarios (id_usuario),

    CONSTRAINT fk_ticket_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias (id_categoria),

    CONSTRAINT fk_ticket_prioridad
        FOREIGN KEY (id_prioridad)
        REFERENCES prioridades (id_prioridad),

    CONSTRAINT fk_ticket_estado
        FOREIGN KEY (id_estado)
        REFERENCES estados (id_estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS historial_tickets (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_ticket INT NOT NULL,
    id_usuario INT NOT NULL,
    accion VARCHAR(100) NOT NULL,
    observacion TEXT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historial_ticket
        FOREIGN KEY (id_ticket)
        REFERENCES tickets (id_ticket),

    CONSTRAINT fk_historial_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Datos iniciales: roles
INSERT IGNORE INTO roles (nombre, descripcion) VALUES
    ('Usuario', 'Usuario solicitante'),
    ('Tecnico', 'Tecnico de soporte'),
    ('Administrador', 'Administrador del sistema');

-- Datos iniciales: estados de los tickets
INSERT IGNORE INTO estados (nombre, descripcion) VALUES
    ('Abierto', 'Ticket creado por un usuario que aun no ha sido atendido'),
    ('En proceso', 'Ticket que esta siendo gestionado por un tecnico'),
    ('Cerrado', 'Ticket gestionado y solucionado por un tecnico');

-- Datos iniciales: categorias
INSERT IGNORE INTO categorias (nombre, descripcion) VALUES
    ('Hardware', 'Fallas en equipos, perifericos, componentes o cableado'),
    ('Software y Aplicaciones', 'Errores o reinstalacion de programas y sistemas'),
    ('Redes y Conectividad', 'Problemas con WiFi, VPN o acceso a internet'),
    ('Cuentas y Accesos', 'Gestion de usuarios, contrasenas y permisos'),
    ('Seguridad Informatica', 'Alertas de virus, phishing o incidentes de seguridad'),
    ('Solicitudes de Servicio', 'Solicitudes de software, hardware o configuraciones');

-- Datos iniciales: prioridades
INSERT IGNORE INTO prioridades (nombre, descripcion) VALUES
    ('Critica', 'Impacto total en la operacion; requiere atencion inmediata'),
    ('Alta', 'Afecta funciones clave sin detener por completo el servicio'),
    ('Media', 'Incidencia moderada con impacto parcial'),
    ('Baja', 'Consultas o solicitudes menores sin urgencia');

-- Verificacion opcional de tablas creadas:
SHOW TABLES;
