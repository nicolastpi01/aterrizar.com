package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.CacheHome
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.PerfilCacheado
import ar.edu.unq.epers.aterrizar.model.Visibility

@Accessors
class CacheService {
	private CacheHome cacheHome
	
	new() {}
	
	new(CacheHome cacheHome) {
		this.cacheHome = cacheHome 
	}
	
	def guardar(PerfilCacheado p) {
		cacheHome.save(p)
	}
	
	def verPerfilCache(Usuario u, Visibility v) {
		cacheHome.get(u, v)
	}
	
	def borrarPerfilCache(Usuario u, Visibility v) {
		cacheHome.delete(u, v)
	}
	 
	def estaPerfilCache(Usuario u, Visibility v) {
		this.verPerfilCache(u, v) != null
	}
	
	def verPerfil(Usuario u, Visibility v) {
		this.verPerfilCache(u, v).perfil
	}
	
	def deleteKeyspace() {
		cacheHome.dropKeyspace
	}
	
	def deleteTable() {
		cacheHome.dropTable
	}
		
}