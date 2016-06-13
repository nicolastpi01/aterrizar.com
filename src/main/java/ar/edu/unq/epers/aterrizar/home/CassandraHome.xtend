package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.servicios.CassandraServiceRunner
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Usuario

class CassandraHome {
	private CassandraServiceRunner cassandraRunner
	
	new(){ }
	
	new(CassandraServiceRunner cassandraRunner) {
		this.cassandraRunner = cassandraRunner
	}
	
	def save(Perfil p) {
		cassandraRunner.mapper.save(p)
	}
	
	def getPerfil(Perfil p) {
		cassandraRunner.mapper.get(p)
	}
	
	def delete(Perfil p) {
		cassandraRunner.mapper.delete(p)
	}
	
	/* 
	def isInPerfil(Perfil p) {
		
	}
	*/
	
	
}