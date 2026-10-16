
package servicio_autenticacion.controlador;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import servicio_autenticacion.modelo.Credenciales;
import servicio_autenticacion.servicio.AutenticacionService;

/**
 * Controlador que expone los servicios web de registro e inicio de sesión.
 */
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AutenticacionService autenticacionService;

    // Spring Boot proporciona automáticamente el servicio necesario.
    public AuthController(AutenticacionService autenticacionService) {
        this.autenticacionService = autenticacionService;
    }

    /**
     * Recibe los datos y registra un usuario nuevo.
     */
    @PostMapping("/registro")
    public ResponseEntity<Map<String, String>> registrar(
            @RequestBody Credenciales credenciales) {

        String mensaje = autenticacionService.registrar(
                credenciales.getUsuario(),
                credenciales.getContrasena());

        // Devuelve 201 si se registró; de lo contrario, devuelve un error.
        if ("Registro satisfactorio.".equals(mensaje)) {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(Map.of("mensaje", mensaje));
        }

        return ResponseEntity.badRequest()
                .body(Map.of("mensaje", mensaje));
    }

    /**
     * Comprueba las credenciales enviadas para iniciar sesión.
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> iniciarSesion(
            @RequestBody Credenciales credenciales) {

        String mensaje = autenticacionService.iniciarSesion(
                credenciales.getUsuario(),
                credenciales.getContrasena());

        // Devuelve 200 cuando la autenticación es correcta.
        if ("Autenticacion satisfactoria.".equals(mensaje)) {
            return ResponseEntity.ok(Map.of("mensaje", mensaje));
        }

        // Devuelve 401 cuando las credenciales son incorrectas.
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("mensaje", mensaje));
    }
}
