package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import ar.edu.unq.epers.aterrizar.model.Usuario

class UsuarioHome {
	
	def getUsuario(String us){
		var q = "from Usuario as usuario where usuario.nombreDeUsuario = :unUsuario"
		var query = SessionManager.getSession().createQuery(q) as Query
		
		query.setString("unUsuario", us)
		var usuarios = query.list
		if(usuarios.size == 0)
			null
			else 
		return usuarios.get(0) as Usuario
	}

	def guardarUsuario(Usuario a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
}