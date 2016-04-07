package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.UsuarioHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.home.SessionManager

class UsuarioService {
	
	def crearUsuario(Usuario usuario) {
		SessionManager.runInSession([
			new UsuarioHome().guardarUsuario(usuario)
			Usuario
		]);
		
		}
		
		def consultarUsuario(String user) {
		SessionManager.runInSession([
			new UsuarioHome().getUsuario(user)
			Usuario
		]);
	
}

}