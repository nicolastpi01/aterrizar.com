package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import java.util.ArrayList
import ar.edu.unq.epers.aterrizar.model.Like

class PerfilService {
	MongoHome<Perfil> perfilHome
	SocialNetworkingService networkService
	

	new(MongoHome<Perfil> c, SocialNetworkingService networkService) {
		this.perfilHome = c
		this.networkService = networkService
	}
	
	def Perfil getPerfil(Usuario u) {
		perfilHome.getPerfil(u)
	}
	
	def addPerfil(Usuario u) {
		var perfil = new Perfil
		perfil.username = u.nombreDeUsuario
		perfil.destinations = new ArrayList()
		perfilHome.insert(perfil)
	}
	
	def void addDestiny(Usuario u, Destiny d) {
		var u_perfil = getPerfil(u)
		u_perfil.addDestiny(d)
		perfilHome.updatePerfil(u_perfil, u_perfil)		
	}
	
	def void addComment(Usuario u, Destiny d, Comment c) {
		var u_perfil = getPerfil(u)
		if(!u_perfil.exist(d)) u_perfil.addDestiny(d)
		d.addComment(c)
		perfilHome.updatePerfil(u_perfil, u_perfil)
	} 
	
	def void addlike(Usuario u, Destiny d, Like like) {
		var u_perfil = getPerfil(u)
		if(!u_perfil.exist(d)) u_perfil.addDestiny(d)
		d.addLike(u, like)
		perfilHome.updatePerfil(u_perfil, u_perfil)
	}
	
	/* 
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
	
	
	def Perfil stalkear(Usuario mi_usuario, Usuario a_stalkear) {
		if(mi_usuario.nombreDeUsuario == a_stalkear.nombreDeUsuario) return commentHome.stalkearme(a_stalkear)
		if(networkService.theyAreFriends(mi_usuario, a_stalkear)) return commentHome.stalkearAmigo(a_stalkear)			
		else return commentHome.stalkearNoAmigo(a_stalkear)	
	}
	*/
}
				

	
	