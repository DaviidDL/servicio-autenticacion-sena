
require('dotenv').config();

const express = require('express');
const authRoutes = require('./routes/auth');

const app = express();
const PORT = process.env.PORT || 3000;

// Permite recibir datos en formato JSON
app.use(express.json());
app.use('/api/auth', authRoutes);

// Ruta principal para comprobar que la API funciona
app.get('/', (req, res) => {
    res.status(200).json({
        mensaje: 'API de autenticacion funcionando correctamente'
    });
});

// Iniciar el servidor
app.listen(PORT, () => {
    console.log(`Servidor iniciado en http://localhost:${PORT}`);
});
