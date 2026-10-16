package servicio_autenticacion.controlador;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controlador inicial para comprobar que el servicio web funciona.
 */
@RestController
public class InicioController {

    // Ruta de prueba que devuelve un mensaje al usuario.
    @GetMapping("/api/inicio")
    public String inicio() {
        return "El servicio web de autenticacion funciona correctamente.";
    }
}
