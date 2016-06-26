package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.home.CacheHome
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.model.Usuario

@Accessors
class CacheService {
	private CacheHome cacheHome
	
	new() {}
	
	new(CacheHome cacheHome) {
		this.cacheHome = cacheHome 
	}
	
	def guardar(Perfil p) {
		cacheHome.save(p)
	}
	
	def verPerfil(Usuario u) {
		cacheHome.get(u)
	}
	
	def borrar(Usuario u) {
		cacheHome.delete(u)
	}
	 
	def estaPerfil(Usuario u) {
		this.verPerfil(u) != null
	}
	
	def deleteKeyspace() {
		cacheHome.dropKeyspace
	}
	
	def deleteTable() {
		cacheHome.dropTable
	}
		
}