package ar.edu.unq.epers.aterrizar.home

import com.datastax.driver.mapping.Mapper
import ar.edu.unq.epers.aterrizar.model.Perfil
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.servicios.CassandraServiceRunner
import ar.edu.unq.epers.aterrizar.model.Usuario

@Accessors
class CacheHome {
	//private Session session
	private Mapper<Perfil> perfilmapper
	private CassandraServiceRunner runner
	
	new() {}
	/* 
	new(Session session) {
		this.session = session
		this.perfilmapper = new MappingManager(session).mapper(Perfil)
	}
	 
	def getSession() {
		return this.session
	}
	*/
	
	def save(Perfil p) {
		perfilmapper.save(p)
	}
	
	def get(Usuario u) {
		perfilmapper.get(u.nombreDeUsuario)
	}
	
	def delete(Usuario u) {
		perfilmapper.delete(u.nombreDeUsuario)
	}
	
	def dropKeyspace() {
		runner.dropKeyspace
	}
	
	def dropTable() {
		runner.dropTable
	}
	
	
	
}