package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.Home
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import java.util.ArrayList
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.servicios.CacheService
import ar.edu.unq.epers.aterrizar.exceptions.UsuarioNoTieneAsientoEnDestinoException
import ar.edu.unq.epers.aterrizar.exceptions.UsuarioNoTienePermisoParaMGoNMGException
import ar.edu.unq.epers.aterrizar.model.PerfilCacheado

class PerfilService {
	Home<Perfil> perfilHome
	SocialNetworkingService networkService
	CacheService cacheService
	TramoService tramoService
	

	new(Home<Perfil> MongoHome, SocialNetworkingService networkService, CacheService cacheService, TramoService tramoService) {
		this.perfilHome = MongoHome
		this.networkService = networkService
		this.cacheService = cacheService
		this.tramoService = tramoService
	}
	 
	def private getPerfil(Usuario u) {
		perfilHome.getPerfil(u)
	}
	
	def verPerfil(Usuario u, Visibility v) {
		if(cacheService.estaPerfilCache(u, v)) return cacheService.verPerfil(u, v)
		else {
			var perfil = this.getPerfil(u)
			cacheService.guardar(new PerfilCacheado(perfil.username, v, perfil))
			perfil
		} 		
	}
	
	def addPerfil(Usuario u) {
		var perfil = new Perfil
		perfil.username = u.nombreDeUsuario
		perfil.destinations = new ArrayList
		perfilHome.insert(perfil)
	}
	
	def private verPerfilAux(Usuario u, Visibility v) {
		if(cacheService.estaPerfilCache(u, v)) return cacheService.verPerfil(u, v)
		else return getPerfil(u)	
	}
	  
	def addDestiny(Usuario u, Destiny d, Visibility v) {
		var perfil = verPerfilAux(u, v) 
		// DESCOMENTAR CUANDO MYSQLDB FUNCIONE
		if(tramoService.tieneReservadoAsiento(u, d)) perfil.addDestiny(d) 
		else new UsuarioNoTieneAsientoEnDestinoException
		if(cacheService.estaPerfilCache(u, v)) cacheService.borrarPerfilCache(u, v)
		else cacheService.guardar(new PerfilCacheado(perfil.username, v, perfil))
		perfilHome.updatePerfil(perfil, perfil) 			   		
	}
	
	 
	def addComment(Usuario u, Destiny d, Comment c, Visibility v) {
		var perfil = verPerfilAux(u, v)
		perfil.addComment(d, c)
		perfilHome.updatePerfil(perfil, perfil)
		if(cacheService.estaPerfilCache(u, v)) cacheService.borrarPerfilCache(u, v)
		else cacheService.guardar(new PerfilCacheado(perfil.username, v, perfil)) 		
	}
	
	def metodoprueb() {} 
	   
	def addlike(Usuario u, Destiny d, Like like, Visibility v) {
		var perfil = verPerfilAux(u, v)
		var meGusta = new Like(perfil.username)
		if(d.puedoAgregarLikeODislike(u)) perfil.addLike(d, meGusta, u)
		else new UsuarioNoTienePermisoParaMGoNMGException
		perfilHome.updatePerfil(perfil, perfil)
		if(cacheService.estaPerfilCache(u, v)) cacheService.borrarPerfilCache(u, v)
		else cacheService.guardar(new PerfilCacheado(perfil.username, v, perfil)) 		
	}
	
	def void addDislike(Usuario u, Destiny d, Dislike dislike, Visibility v) {
		var perfil = verPerfilAux(u, v)
		var nmg = new Dislike(perfil.username)
		if(d.puedoAgregarLikeODislike(u)) perfil.addDislike(d, nmg, u)
		else new UsuarioNoTienePermisoParaMGoNMGException
		perfilHome.updatePerfil(perfil, perfil)
		if(cacheService.estaPerfilCache(u, v)) cacheService.borrarPerfilCache(u, v)
		else cacheService.guardar(new PerfilCacheado(perfil.username, v, perfil))
	}
	  
	def void addVisibility(Usuario u, Destiny d, Visibility v, Visibility vCache) {
		var perfil = verPerfilAux(u, vCache)
		perfil.addVisibility(d, v)
		perfilHome.updatePerfil(perfil, perfil)
		if(cacheService.estaPerfilCache(u, vCache)) cacheService.borrarPerfilCache(u, v)
		else cacheService.guardar(new PerfilCacheado(perfil.username, vCache, perfil)) 		
	}
	 
	def void addVisibility(Usuario u, Destiny d, Comment c, Visibility v, Visibility vCache) {
		var perfil = verPerfilAux(u, vCache)
		perfil.addVisibility(d, c, v)
		perfilHome.updatePerfil(perfil, perfil)
		if(!cacheService.estaPerfilCache(u, vCache)) cacheService.borrarPerfilCache(u, v)
		else cacheService.guardar(new PerfilCacheado(perfil.username, vCache, perfil)) 	
	}
	
	
	def private verPerfilSiEsPosibleEnCache(Usuario yo) {
		var perfil = verPerfil(yo, Visibility.PUBLICO)
		if(perfil == null) perfil = verPerfil(yo, Visibility.PRIVADO)
		else if(perfil == null) perfil = verPerfil(yo, Visibility.AMIGOS)
			else perfil = this.getPerfil(yo)
	}
	
	def private stalkearme(Usuario yo) {
			var perfil = this.verPerfilSiEsPosibleEnCache(yo)
			if(!cacheService.estaPerfilCache(yo, Visibility.PUBLICO) || !cacheService.estaPerfilCache(yo, Visibility.PRIVADO) || !cacheService.estaPerfilCache(yo, Visibility.AMIGOS)) cacheService.guardar(new PerfilCacheado(perfil.username, Visibility.PRIVADO, perfil))
			return perfil
	}
	 	
	def private stalkearNoAmigo(Usuario i, Usuario another) {
		if (cacheService.estaPerfilCache(another, Visibility.PUBLICO)) return cacheService.verPerfil(another, Visibility.PUBLICO)
		else {
			var perfil = perfilHome.stalkearNoAmigo(another)
			cacheService.guardar(new PerfilCacheado(perfil.username, Visibility.PUBLICO, perfil))
			return perfil
		}
	}
	
	def private stalkearAmigo(Usuario i, Usuario another) {
		if (cacheService.estaPerfilCache(another, Visibility.PUBLICO)) return cacheService.verPerfil(another, Visibility.PUBLICO)
		else if (cacheService.estaPerfilCache(another, Visibility.AMIGOS)) return cacheService.verPerfil(another, Visibility.AMIGOS)
		else {
			var perfil = perfilHome.stalkearAmigo(another)
			cacheService.guardar(new PerfilCacheado(perfil.username, Visibility.AMIGOS, perfil))
			return perfil
		}
	}
	
	def stalkear(Usuario miUsuario, Usuario aStalkear) {
		if(miUsuario.nombreDeUsuario == aStalkear.nombreDeUsuario) return stalkearme(miUsuario)
		if(networkService.theyAreFriends(miUsuario, aStalkear)) return stalkearAmigo(miUsuario, aStalkear)
		else stalkearNoAmigo(miUsuario, aStalkear)
	}
	
}	