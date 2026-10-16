
package servicio_autenticacion.servicio;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

/**
 * Gestiona el registro de usuarios y la validación
 * de las credenciales de inicio de sesión.
 */
@Service
public class AutenticacionService {

    // Almacena los usuarios y sus contraseñas cifradas mediante hash.
    // Los datos se pierden cuando se reinicia la aplicación.
    private final Map<String, String> usuarios = new ConcurrentHashMap<>();

    /**
     * Registra un usuario nuevo si cumple las condiciones.
     */
    public synchronized String registrar(String usuario, String contrasena) {

        if (usuario == null || usuario.isBlank()
                || contrasena == null || contrasena.isBlank()) {
            return "El usuario y la contrasena son obligatorios.";
        }

        if (usuarios.containsKey(usuario)) {
            return "Error: el usuario ya se encuentra registrado.";
        }

        // Guarda el hash de la contraseña, no la contraseña original.
        usuarios.put(usuario, calcularHash(contrasena));

        return "Registro satisfactorio.";
    }

    /**
     * Comprueba si el usuario existe y la contraseña es correcta.
     */
    public String iniciarSesion(String usuario, String contrasena) {

        if (usuario == null || contrasena == null) {
            return "Error en la autenticacion.";
        }

        String hashGuardado = usuarios.get(usuario);

        if (hashGuardado != null
                && hashGuardado.equals(calcularHash(contrasena))) {
            return "Autenticacion satisfactoria.";
        }

        return "Error en la autenticacion.";
    }

    /**
     * Convierte la contraseña en una huella digital SHA-256.
     */
    private String calcularHash(String contrasena) {

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] resultado = digest.digest(
                    contrasena.getBytes(StandardCharsets.UTF_8));

            // Convierte el resultado binario a texto hexadecimal.
            StringBuilder hexadecimal = new StringBuilder();

            for (byte b : resultado) {
                hexadecimal.append(String.format("%02x", b & 0xff));
            }

            return hexadecimal.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(
                    "No fue posible procesar la contrasena.", e);
        }
    }
}
