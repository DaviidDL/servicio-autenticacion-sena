

const express = require('express');
const bcrypt = require('bcrypt');
const pool = require('../config/db');

const router = express.Router();

// POST /api/auth/registro
router.post('/registro', async (req, res) => {
    try {
        const { nombre, apellido, email, contrasena, telefono } = req.body;

        // Validar los campos obligatorios.
        if (
            typeof nombre !== 'string' ||
            typeof apellido !== 'string' ||
            typeof email !== 'string' ||
            typeof contrasena !== 'string' ||
            !nombre.trim() ||
            !apellido.trim() ||
            !email.trim() ||
            !contrasena
        ) {
            return res.status(400).json({
                mensaje: 'Nombre, apellido, correo y contrasena son obligatorios.'
            });
        }

        if (contrasena.length < 8) {
            return res.status(400).json({
                mensaje: 'La contrasena debe tener al menos 8 caracteres.'
            });
        }

        const nombreUsuario = nombre.trim();
        const apellidoUsuario = apellido.trim();
        const correo = email.trim().toLowerCase();

        // Comprobar si el correo ya está registrado.
        const [usuariosExistentes] = await pool.execute(
            'SELECT id_usuario FROM usuarios WHERE email = ?',
            [correo]
        );

        if (usuariosExistentes.length > 0) {
            return res.status(409).json({
                mensaje: 'El correo electronico ya se encuentra registrado.'
            });
        }

        // Proteger la contrasena antes de guardarla.
        const passwordHash = await bcrypt.hash(contrasena, 10);

        // El rol 1 corresponde a Usuario.
        await pool.execute(
            `INSERT INTO usuarios
            (id_rol, nombre, apellido, email, password_hash, telefono)
            VALUES (?, ?, ?, ?, ?, ?)`,
            [
                1,
                nombreUsuario,
                apellidoUsuario,
                correo,
                passwordHash,
                typeof telefono === 'string' && telefono.trim()
                    ? telefono.trim()
                    : null
            ]
        );

        return res.status(201).json({
            mensaje: 'Registro satisfactorio.'
        });
    } catch (error) {
        console.error('Error en registro:', error.message);

        return res.status(500).json({
            mensaje: 'Error interno al registrar el usuario.'
        });
    }
});

// POST /api/auth/login
router.post('/login', async (req, res) => {
    try {
        const { email, contrasena } = req.body;

        if (
            typeof email !== 'string' ||
            typeof contrasena !== 'string' ||
            !email.trim() ||
            !contrasena
        ) {
            return res.status(400).json({
                mensaje: 'El correo y la contrasena son obligatorios.'
            });
        }

        const correo = email.trim().toLowerCase();

        // Buscar al usuario por correo.
        const [usuarios] = await pool.execute(
            `SELECT id_usuario, nombre, apellido, email,
                    password_hash, id_rol, activo
             FROM usuarios
             WHERE email = ?`,
            [correo]
        );

        if (usuarios.length === 0) {
            return res.status(401).json({
                mensaje: 'Error en la autenticacion.'
            });
        }

        const usuario = usuarios[0];

        // Impedir el acceso a cuentas inactivas.
        if (usuario.activo !== 1) {
            return res.status(403).json({
                mensaje: 'La cuenta se encuentra inactiva.'
            });
        }

        // Comparar la contrasena con su hash almacenado.
        const contrasenaValida = await bcrypt.compare(
            contrasena,
            usuario.password_hash
        );

        if (!contrasenaValida) {
            return res.status(401).json({
                mensaje: 'Error en la autenticacion.'
            });
        }

        return res.status(200).json({
            mensaje: 'Autenticacion satisfactoria.',
            usuario: {
                id_usuario: usuario.id_usuario,
                nombre: usuario.nombre,
                apellido: usuario.apellido,
                email: usuario.email,
                id_rol: usuario.id_rol
            }
        });
    } catch (error) {
        console.error('Error en login:', error.message);

        return res.status(500).json({
            mensaje: 'Error interno al iniciar sesion.'
        });
    }
});

module.exports = router;
