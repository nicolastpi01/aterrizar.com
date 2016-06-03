package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.PerfilDocument


class PerfilDocService {
	MongoHome<PerfilDocument> commentHome
	

	new(MongoHome<PerfilDocument> c){
		commentHome = c
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
	
	//falta testear
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
	
	def void addVisibility(Usuario u,  Destiny d, Comment c, Visibility visibility) {
		val perfil_documents = commentHome.find(DBQuery.is("username", u.nombreDeUsuario)).and (DBQuery.is("destiny.nombre", d.nombre))
		var perfil_doc = new PerfilDocument(u.nombreDeUsuario, d)
		if(perfil_documents.size() != 0) perfil_doc = perfil_documents.get(0)
		if(perfil_documents.size() != 0 && this.tiene_coment(perfil_doc, c)) perfil_doc.comments.remove(this.getPosition(perfil_doc, c)) 
		var comment_add = c
		comment_add.setVisibility(visibility)
		perfil_doc.add(comment_add)
		var query = DBQuery.is("username", u.nombreDeUsuario).and (DBQuery.is("destiny.nombre", d.nombre))
		commentHome.update(query, perfil_doc)
	}
	
	def tiene_coment(PerfilDocument pd, Comment c) {
		var ret = false
		for (Comment co : pd.comments) {
			ret = ret || co.description == c.description
		}
			ret
	}
	
	def getPosition(PerfilDocument pd, Comment c) {
		var pos = 0
				for (Comment co : pd.comments) {
				if(co.description != c.description) pos++
		}
			pos	
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
				

	
	