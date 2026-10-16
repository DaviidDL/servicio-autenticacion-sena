package servicio_autenticacion.modelo;

/**
 * Representa los datos que el usuario envía
 * al registrarse o iniciar sesión.
 */
public class Credenciales {

    private String usuario;
    private String contrasena;

    // Constructor vacío necesario para convertir JSON en un objeto Java.
    public Credenciales() {
    }

    // Devuelve el nombre de usuario.
    public String getUsuario() {
        return usuario;
    }

    // Permite asignar el nombre de usuario.
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    // Devuelve la contraseña recibida.
    public String getContrasena() {
        return contrasena;
    }

    // Permite asignar la contraseña recibida.
    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
}
