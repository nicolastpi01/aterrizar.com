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
import ar.edu.unq.epers.aterrizar.servicios.CacheService

class PerfilService {
	MongoHome<Perfil> perfilHome
	SocialNetworkingService networkService
	CacheService cacheService
	

	new(MongoHome<Perfil> c, SocialNetworkingService networkService, CacheService cacheService) {
		this.perfilHome = c
		this.networkService = networkService
		this.cacheService = cacheService
	}
	
	def Perfil getPerfil(Usuario u) {
		perfilHome.getPerfil(u)
	}
	
	def verPerfil(Usuario u) {
		if(cacheService.estaPerfil(u)) return cacheService.verPerfil(u)
		else {
			var perfil = this.getPerfil(u)
			cacheService.guardar(perfil)
			return perfil
			}
	}
	
	def addPerfil(Usuario u) {
		var perfil = new Perfil
		perfil.username = u.nombreDeUsuario
		perfil.destinations = new ArrayList()
		perfilHome.insert(perfil)
		cacheService.guardar(perfil)
	}
	
	def void addDestiny(Usuario u, Destiny d) {
		var u_perfil = getPerfil(u)
		u_perfil.addDestiny(d)
		perfilHome.updatePerfil(u_perfil, u_perfil)
		if(cacheService.estaPerfil(u)) cacheService.borrar(u_perfil)		
	}
	
	def void addComment(Usuario u, Destiny d, Comment c) {
		var u_perfil = getPerfil(u)
		u_perfil.addComment(d, c)
		perfilHome.updatePerfil(u_perfil, u_perfil)
		if(cacheService.estaPerfil(u)) cacheService.borrar(u_perfil)
	} 
	
	def void addlike(Usuario u, Destiny d, Like like) {
		var u_perfil = getPerfil(u)
		u_perfil.addLike(d, like, u)
		perfilHome.updatePerfil(u_perfil, u_perfil)
		if(cacheService.estaPerfil(u)) cacheService.borrar(u_perfil)
	}

	def void addDislike(Usuario u, Destiny d, Dislike dislike) {
		var u_perfil = getPerfil(u)
		u_perfil.addDislike(d, dislike, u)
		perfilHome.updatePerfil(u_perfil, u_perfil)
		if(cacheService.estaPerfil(u)) cacheService.borrar(u_perfil)
	}
	  
	def void addVisibility(Usuario u, Destiny d, Visibility visibility) {
		var u_perfil = getPerfil(u)
		u_perfil.addVisibility(d, visibility)
		perfilHome.updatePerfil(u_perfil, u_perfil)
		if(cacheService.estaPerfil(u)) cacheService.borrar(u_perfil)
	}
	 
	def void addVisibility(Usuario u, Destiny d, Comment c, Visibility visibility) {
		var u_perfil = getPerfil(u)
		u_perfil.addVisibility(d, c, visibility)
		perfilHome.updatePerfil(u_perfil, u_perfil)
		if(cacheService.estaPerfil(u)) cacheService.borrar(u_perfil)
	}

	def stalkear(Usuario mi_usuario, Usuario a_stalkear) {
		if(mi_usuario.nombreDeUsuario == a_stalkear.nombreDeUsuario) return perfilHome.getPerfil(a_stalkear)
		if(networkService.theyAreFriends(mi_usuario, a_stalkear)) return perfilHome.stalkearAmigo(a_stalkear)			
		else return perfilHome.stalkearNoAmigo(a_stalkear)	
	}
	
}
				

	
	