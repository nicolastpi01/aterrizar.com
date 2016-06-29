package ar.edu.unq.epers.cassandra

import ar.edu.unq.epers.aterrizar.servicios.CassandraServiceRunner
import ar.edu.unq.epers.aterrizar.home.CacheHome
import ar.edu.unq.epers.aterrizar.servicios.CacheService
import ar.edu.unq.epers.aterrizar.model.Perfil
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.PerfilCacheado
import ar.edu.unq.epers.aterrizar.model.Destiny

class CacheServiceTest { 
	CassandraServiceRunner runner
	CacheHome home
	CacheService service
	Perfil perfilPepe
	PerfilCacheado perfilCacheadoPepe
	Usuario usuarioPepe
	Destiny destinyMarDelPlata
	
	
	@Before
	def void setUp() {
		runner = new CassandraServiceRunner
		runner.addPoint("127.0.0.1")
		runner.getSession
		runner.initializeModel
		usuarioPepe = new Usuario
    	usuarioPepe.nombreDeUsuario = "pepe"
		perfilPepe = new Perfil("pepe")
 		perfilPepe.id = "111"
 		destinyMarDelPlata = new Destiny
    	destinyMarDelPlata.nombre = "Mar del plata"
		perfilCacheadoPepe = new PerfilCacheado
		perfilCacheadoPepe.perfil = perfilPepe
		perfilCacheadoPepe.visibility = Visibility.PUBLICO
		perfilCacheadoPepe.username = "pepe"			
    	runner.initializeMapper
    	home = new CacheHome
    	home.perfilmapper = runner.perfilmapper
    	home.runner = runner
    	service = new CacheService
    	service.cacheHome = home 	
	}
	
	@Test
	def void verPerfilCacheTest() {
		service.guardar(perfilCacheadoPepe)
		var pepe = service.verPerfilCache(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(usuarioPepe.nombreDeUsuario, pepe.username)
	}
	
	@Test
	def void verPerfilAndDoSomething() {
		service.guardar(perfilCacheadoPepe)
		var pepePerfil = service.verPerfilCache(usuarioPepe, Visibility.PUBLICO).perfil
		pepePerfil.addDestiny(destinyMarDelPlata)
		Assert.assertEquals(pepePerfil.destinations.size, 1)
		Assert.assertEquals(pepePerfil.destinations.get(0).nombre, "Mar del plata")		
	}
	
	@Test
	def void verPerfilTest() {
		service.guardar(perfilCacheadoPepe)
		var pepePerfil = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(pepePerfil.username, "pepe")
	}
	
	@Test
	def void borrarTest() {
		service.guardar(perfilCacheadoPepe)
		service.borrarPerfilCache(usuarioPepe, Visibility.PUBLICO)
		var pepe = service.verPerfilCache(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(pepe, null)
	}
	
	@Test
	def void estaPerfilTest() {
		service.guardar(perfilCacheadoPepe)
		var estaPepe = service.estaPerfilCache(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(true, estaPepe)
	}
	     
	@After
	def void afterSetUp() {
		service.deleteTable
		service.deleteKeyspace
	}
	 
}