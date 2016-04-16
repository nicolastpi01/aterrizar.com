package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.UsuarioHome
import ar.edu.unq.epers.aterrizar.model.Usuario

class UsuarioService {

    def guardarUsuario(Usuario usuario) {
        SessionManager.runInSession([
            new UsuarioHome().guardarUsuario(usuario)
            Usuario
        ]);

    }

    def consultarUsuario(String user) {
        SessionManager.runInSession([
            new UsuarioHome().getUsuario(user)
        ]);

    }

}