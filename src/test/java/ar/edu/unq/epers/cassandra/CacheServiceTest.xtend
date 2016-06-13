package ar.edu.unq.epers.cassandra

import ar.edu.unq.epers.aterrizar.servicios.CacheService
import ar.edu.unq.epers.aterrizar.home.CassandraHome
import ar.edu.unq.epers.aterrizar.servicios.CassandraServiceRunner
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.model.Perfil
import org.junit.Assert
import org.junit.After

class CacheServiceTest {
	CacheService service
	CassandraHome home
	CassandraServiceRunner runner
	Usuario usuario_pepe
	
	@Before
	def setUp() {
		runner = new CassandraServiceRunner()
		runner.getSession
		runner.createCacheSchema
		home = new CassandraHome(runner)
		service = new CacheService(home)
		usuario_pepe = new Usuario()
		usuario_pepe.nombreDeUsuario = "pepe"
		 
	}
	
	@Test
	def verPerfilTest() {
		var perfil_pepe = new Perfil("pepe")
		service.guardar(perfil_pepe)
		var pepe = service.verPerfil(perfil_pepe)
		Assert.assertEquals(pepe.username, perfil_pepe.username)
	}
	
	
	
	@After
	def after() {
		runner.close
	}
}