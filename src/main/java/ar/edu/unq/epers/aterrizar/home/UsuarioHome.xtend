package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import ar.edu.unq.epers.aterrizar.model.Usuario

class UsuarioHome {
	
	def getUsuario(String us){
		var q = "select from usuario as u where u.nombreDeUsuario = :us"
		var query = SessionManager.getSession().createQuery(q) as Query
		
		query.setString("us", us)
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