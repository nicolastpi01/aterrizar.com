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
import ar.edu.unq.epers.aterrizar.model.Dislike

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

	def void addDislike(Usuario u, Destiny d, Dislike dislike) {
		var u_perfil = getPerfil(u)
		if(!u_perfil.exist(d)) u_perfil.addDestiny(d)
		d.addDisLike(u, dislike)
		perfilHome.updatePerfil(u_perfil, u_perfil)
	}
	  
	def void addVisibility(Usuario u, Destiny d, Visibility visibility) {
		var u_perfil = getPerfil(u)
		if(!u_perfil.exist(d)) u_perfil.addDestiny(d)
		d.setVisibility(visibility)
		perfilHome.updatePerfil(u_perfil, u_perfil)
	}
	 
	def void addVisibility(Usuario u, Destiny d, Comment c, Visibility visibility) {
		var u_perfil = getPerfil(u)
		if(!u_perfil.exist(d)) u_perfil.addDestiny(d)
		c.setVisibility(visibility)
		perfilHome.updatePerfil(u_perfil, u_perfil)
	}
	
	
	
	
	/*

	def Perfil stalkear(Usuario mi_usuario, Usuario a_stalkear) {
		if(mi_usuario.nombreDeUsuario == a_stalkear.nombreDeUsuario) return commentHome.stalkearme(a_stalkear)
		if(networkService.theyAreFriends(mi_usuario, a_stalkear)) return commentHome.stalkearAmigo(a_stalkear)			
		else return commentHome.stalkearNoAmigo(a_stalkear)	
	}
	*/
}
				

	
	