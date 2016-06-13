package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.home.CassandraHome

class CacheService {
	CassandraHome home
	
	new(CassandraHome home) {
		this.home = home
	}
	
	def verPerfil(Perfil p) {
		this.home.getPerfil(p)
	}
	
	def guardar(Perfil p) {
		home.save(p)
	}
	
	def borrar(Perfil p) {
		home.delete(p)
	}
	
	
	
	/* 
	def estaPerfil(Perfil p) {
		this.home.isInPerfil(p)
	}
	
	
	
	
	*/
	
}