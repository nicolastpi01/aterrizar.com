package ar.edu.unq.epers.aterrizar.home

import com.datastax.driver.mapping.Mapper
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.servicios.CassandraServiceRunner
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.PerfilCacheado
import ar.edu.unq.epers.aterrizar.model.Visibility

@Accessors
class CacheHome {
	private Mapper<PerfilCacheado> perfilmapper
	private CassandraServiceRunner runner
	
	new() {}
	
	def save(PerfilCacheado p) {
		perfilmapper.save(p)
	}
	
	def get(Usuario u, Visibility v) {
		perfilmapper.get(u.nombreDeUsuario, v)
	}
	
	def delete(Usuario u, Visibility v) {
		perfilmapper.delete(u.nombreDeUsuario, v)
	}
	
	def dropKeyspace() {
		runner.dropKeyspace
	}
	
	def dropTable() {
		runner.dropTable
	}
	
}