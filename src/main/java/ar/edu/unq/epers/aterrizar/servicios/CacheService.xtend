package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.home.CassandraHome

class CacheService {
	CassandraHome home
	
	
	new(CassandraHome home) {
		this.home = home
	}
	
	def verPerfil(Usuario u) {
		// buscar el perfil en la cache, papa!!!!!
	}
	
	def estaPerfil(Perfil p) {
		// devuelve un booleano
	}
	
	def guardar(Perfil p) {
		// guardo un perfil en la cache
	}
	
	def borrar(Perfil p) {
		// borra el prefil de la cache
	}
}