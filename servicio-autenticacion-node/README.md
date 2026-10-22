# API de autenticación — TechDesk

## Descripción

API REST desarrollada con Node.js y Express para el registro de usuarios y la autenticación mediante correo electrónico y contraseña. Utiliza MySQL para almacenar los usuarios y bcrypt para proteger las contraseñas.

## Tecnologías utilizadas

- Node.js
- Express
- MySQL
- mysql2
- bcrypt
- dotenv
- Postman para las pruebas

## Requisitos

- Node.js y npm instalados.
- Servidor MySQL disponible.
- Base de datos `techdesk` con la tabla `usuarios` y la tabla `roles`.

## Instalación

1. Descargar o clonar el repositorio.
2. Abrir una terminal en la carpeta `servicio-autenticacion-node`.
3. Instalar las dependencias:

   ```bash
   npm install
   ```

4. Crear un archivo `.env` a partir de `.env.example`.
5. Configurar las credenciales de conexión a MySQL.
6. Iniciar el servidor:

   ```bash
   node server.js
   ```

Por defecto, la API utiliza el puerto `3000`.

## Endpoints

### Comprobar el funcionamiento

- Método: `GET`
- Ruta: `/`
- Respuesta esperada: mensaje que indica que la API está funcionando.

### Registrar usuario

- Método: `POST`
- Ruta: `/api/auth/registro`
- Campos obligatorios: `nombre`, `apellido`, `email` y `contrasena`.
- Campo opcional: `telefono`.
- El sistema asigna el rol `1` (Usuario).

Ejemplo de solicitud:

```json
{
  "nombre": "Usuario",
  "apellido": "Prueba",
  "email": "prueba@example.com",
  "contrasena": "Prueba12345",
  "telefono": "3001234567"
}
```

Respuestas principales: `201 Created`, `400 Bad Request`, `409 Conflict` y `500 Internal Server Error`.

### Iniciar sesión

- Método: `POST`
- Ruta: `/api/auth/login`
- Campos obligatorios: `email` y `contrasena`.

Ejemplo de solicitud:

```json
{
  "email": "prueba@example.com",
  "contrasena": "Prueba12345"
}
```

Respuestas principales: `200 OK`, `400 Bad Request`, `401 Unauthorized`, `403 Forbidden` y `500 Internal Server Error`.

## Base de datos

La API utiliza la tabla `techdesk.usuarios`. Las contraseñas se almacenan como hashes generados con bcrypt. El archivo `.env` contiene las variables de conexión y no debe publicarse.

## Pruebas realizadas

Se probaron en Postman los siguientes casos:

- Registro exitoso.
- Inicio de sesión con contraseña correcta.
- Rechazo de contraseña incorrecta.
- Rechazo de correo electrónico duplicado.
- Validación de campos obligatorios.

## Estado del despliegue

Estado del proyecto

La API de autenticación fue desarrollada con Node.js y Express, integrada localmente con MySQL y desplegada en Render.

URL pública: https://servicio-autenticacion-sena.onrender.com/

Repositorio: https://github.com/DaviidDL/servicio-autenticacion-sena

Base de datos: MySQL, esquema techdesk.

Script SQL de instalación: techdesk_entrega.sql.

Funcionalidades implementadas

Registro de usuarios.

Inicio de sesión.

Validación de campos obligatorios.

Verificación de correos duplicados.

Almacenamiento de contraseñas mediante hashes bcrypt.

Consulta de usuarios y validación de cuentas activas.

Estado de las pruebas

Las pruebas de registro e inicio de sesión se realizaron localmente con MySQL y obtuvieron las respuestas esperadas.

La API está desplegada en Render y su ruta principal responde correctamente. La conexión de la instancia pública con una base de datos remota queda pendiente de configuración.

Instalación local

Instalar Node.js y MySQL.

Ejecutar techdesk_entrega.sql en MySQL Workbench para crear el esquema y las tablas.

Instalar las dependencias con npm install.

Crear un archivo .env con las variables de conexión a MySQL.

Iniciar la API con npm start.

No publicar el archivo .env, ya que contiene credenciales privadas.
