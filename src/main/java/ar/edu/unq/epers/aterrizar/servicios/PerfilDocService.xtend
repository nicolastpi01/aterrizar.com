package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.model.PerfilDocument
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Usuario
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
	/* 
	def verPerfil(Usuario yo, Usuario aVer){
		val homeComentario = SistemDB.instance().collection(Comentario);
		var servicioAmigos= new ServicioAmigos
		if(yo.userName.equals(aVer.userName)){ 
			return homeComentario.mongoCollection.find(DBQuery.is("nombreUsuario", yo.userName) )	
	    }
		if(servicioAmigos.esAmigoDe(yo, aVer)){
			return homeComentario.mongoCollection.find(DBQuery.in("visibilidad", Visibilidad.PUBLICO,Visibilidad.SOLO_AMIGOS).and (DBQuery.is("nombreUsuario", aVer.userName)))
			
		}
		if (!servicioAmigos.esAmigoDe(yo, aVer)){
			return homeComentario.mongoCollection.find(DBQuery.is("visibilidad", Visibilidad.PUBLICO)).and (DBQuery.is("nombreUsuario", aVer.userName))
			
		}
		
	}*/

}