# Servicio web de autenticación

## Descripción

Este proyecto es un servicio web desarrollado en Java con Spring Boot. Permite registrar usuarios y validar sus credenciales para iniciar sesión.

El proyecto se realiza como parte de la evidencia GA7-220501096-AA5-EV01 del programa de Análisis y Desarrollo de Software del SENA.

## Tecnologías utilizadas

- Java
- Spring Boot
- Maven
- API REST
- Postman para las pruebas

## Funcionalidades

- Registrar usuarios.
- Validar las credenciales de inicio de sesión.
- Responder con un mensaje de éxito cuando los datos son correctos.
- Responder con un error cuando las credenciales son incorrectas.
- Evitar el registro de usuarios duplicados.

## Servicios disponibles

| Método | Ruta | Función |
|---|---|---|
| GET | `/api/inicio` | Verificar que el servicio funciona |
| POST | `/api/auth/registro` | Registrar un usuario |
| POST | `/api/auth/login` | Iniciar sesión |

## Ejecución del proyecto

1. Abrir una terminal en la carpeta raíz del proyecto.
2. Ejecutar el comando `.\mvnw.cmd spring-boot:run`.
3. Esperar a que Spring Boot inicie el servidor en el puerto 8080.
4. Enviar las peticiones a `http://localhost:8080`.

## Ejemplo de registro o inicio de sesión

Enviar una petición POST a la ruta correspondiente con un cuerpo JSON como el siguiente:

```json
{
  "usuario": "kevin",
  "contrasena": "ClavePrueba123"
}
```

## Resultados de las pruebas

- Registro correcto: `201 Created`.
- Inicio de sesión correcto: `200 OK`.
- Credenciales incorrectas: `401 Unauthorized`.

## Limitaciones

Los usuarios se almacenan temporalmente en memoria y se eliminan al reiniciar la aplicación. El almacenamiento de contraseñas mediante SHA-256 se utiliza como una implementación de aprendizaje; para un sistema real se recomienda un mecanismo especializado para contraseñas, como BCrypt o Argon2.

## Autor

Aprendiz del programa de Análisis y Desarrollo de Software del SENA.