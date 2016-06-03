package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.model.PerfilDocument
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.model.Visibility
import org.mongojack.internal.stream.JacksonDBObject
import com.mongodb.QueryBuilder
import ar.edu.unq.epers.aterrizar.model.Comment

class PerfilDocService {
	MongoHome<PerfilDocument> commentHome
	
	new(MongoHome<PerfilDocument> commentHome) {
		this.commentHome = commentHome
	}
	
	def void addDestiny(Usuario u, Destiny d) {
		var perfildoc = new PerfilDocument(u.nombreDeUsuario, d)
		commentHome.insert(perfildoc)
	}
	
	def void addComment(Usuario u, Destiny d, Comment comment) {
		val perfil_documents = commentHome.find(DBQuery.is("username", u.nombreDeUsuario)).and (DBQuery.is("destiny.nombre", d.nombre))
		var perfil_doc = new PerfilDocument(u.nombreDeUsuario, d)
		if(perfil_documents.size() != 0) perfil_doc = perfil_documents.get(0) 
		perfil_doc.add(comment)
		var query = DBQuery.is("username", u.nombreDeUsuario).and (DBQuery.is("destiny.nombre", d.nombre))
		commentHome.update(query, perfil_doc)
	}
	
	def void addlike(Usuario u, Destiny d) {
		val perfil_documents = commentHome.find(DBQuery.is("username", u.nombreDeUsuario)).and (DBQuery.is("destiny.nombre", d.nombre))
		var perfil_doc = new PerfilDocument(u.nombreDeUsuario, d)
		if(perfil_documents.size() != 0) perfil_doc = perfil_documents.get(0) 
		perfil_doc.addlike
		var query = DBQuery.is("username", u.nombreDeUsuario).and (DBQuery.is("destiny.nombre", d.nombre))
		commentHome.update(query, perfil_doc)
	}
	
	def void addDislike(Usuario u, Destiny d) {
		val perfil_documents = commentHome.find(DBQuery.is("username", u.nombreDeUsuario)).and (DBQuery.is("destiny.nombre", d.nombre))
		var perfil_doc = new PerfilDocument(u.nombreDeUsuario, d)
		if(perfil_documents.size() != 0) perfil_doc = perfil_documents.get(0) 
		perfil_doc.addDislike
		var query = DBQuery.is("username", u.nombreDeUsuario).and (DBQuery.is("destiny.nombre", d.nombre))
		commentHome.update(query, perfil_doc)
	}
	  
	def void addVisibility(Usuario u,  Destiny d, Visibility visibility) {
		val perfil_documents = commentHome.find(DBQuery.is("username", u.nombreDeUsuario)).and (DBQuery.is("destiny.nombre", d.nombre))
		var perfil_doc = new PerfilDocument(u.nombreDeUsuario, d)
		if(perfil_documents.size() != 0) perfil_doc = perfil_documents.get(0) 
		perfil_doc.setVisibility(visibility)
		var query = DBQuery.is("username", u.nombreDeUsuario).and (DBQuery.is("destiny.nombre", d.nombre))
		commentHome.update(query, perfil_doc)
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	 

	/* 
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
	*/
	
}