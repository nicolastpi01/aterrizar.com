package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.model.PerfilDocument
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.model.Visibility

class PerfilDocService {
	MongoHome<PerfilDocument> commentHome
	
	def void addDestiny(Usuario u, Destiny d) {
		var perfildoc = new PerfilDocument(u.nombreDeUsuario, d)
		commentHome.insert(perfildoc)
	}
	
	def void addComment(Usuario u, Destiny d, String comment) {
		var perfildoc = new PerfilDocument(u.nombreDeUsuario, d, comment)
		//la query debe ver el destino tmb
		var query = DBQuery.is("username", u.nombreDeUsuario)
		// el update deberia actualizar todos los perfilDocuments con usuario y destino igual a los parametros
		commentHome.update(query, perfildoc)
	}
	
	def void addlike(Usuario u, Destiny d) {
		var perfildoc = new PerfilDocument(u.nombreDeUsuario, d)
		perfildoc.addlike
		//la query debe ver el destino tmb
		var query = DBQuery.is("username", u.nombreDeUsuario)
		// el update deberia actualizar todos los perfilDocuments con usuario y destino igual a los parametros
		commentHome.update(query, perfildoc)
	}
	
	def void addVisibility(Usuario u,  Destiny d, String comment, Visibility visibility) {
		var perfildoc = new PerfilDocument(u.nombreDeUsuario, d, comment, visibility)
		//la query debe ver el destino tmb
		var query = DBQuery.is("username", u.nombreDeUsuario)
		// el update deberia actualizar todos los perfilDocuments con usuario y destino igual a los parametros
		commentHome.update(query, perfildoc)
	}
	
	def verPerfil(Usuario mi_usuario, Usuario a_stalkear) { 
		var socialService = new SocialNetworkingService()
		if(mi_usuario.nombreDeUsuario.equals(a_stalkear.nombreDeUsuario)) { 
			return commentHome.find(DBQuery.is("username", mi_usuario.nombreDeUsuario))	
	    }
		if(socialService.theyAreFriends(mi_usuario, a_stalkear)) {
			return commentHome.find(DBQuery.in("visibility", Visibility.PUBLICO, Visibility.AMIGOS).and (DBQuery.is("username", a_stalkear.nombreDeUsuario)))
			
		}
		if(!socialService.theyAreFriends(mi_usuario, a_stalkear)) {
			return commentHome.find(DBQuery.is("visibility", Visibility.PUBLICO)).and (DBQuery.is("username", a_stalkear.nombreDeUsuario))	
		}	
	}
}