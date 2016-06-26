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
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.Comment

class CacheServiceTest { 
	CassandraServiceRunner runner
	CacheHome home
	CacheService service
	Perfil perfilPepe
	Perfil perfilLuis
	Perfil perfilBeto
	Perfil perfilJuan
	Usuario usuarioPepe
	Usuario usuarioJuan
	Usuario usuarioLuis
	Usuario usuarioBeto
	Destiny marDelPlata_destiny
	Destiny pinamar_destiny
	Like like
	Dislike dislike
	Visibility visibilityPublico
	Comment queFrio_comment
	
	
	@Before
	def void setUp() {
		runner = new CassandraServiceRunner
		runner.addPoint("127.0.0.1")
		runner.getSession
		runner.initializeModel
		perfilJuan = new Perfil("juan")
		perfilJuan.id = "333"		
 		perfilPepe = new Perfil("pepe")
 		perfilPepe.id = "111"
 		perfilLuis = new Perfil("luis")
 		perfilBeto = new Perfil("beto")
 		perfilBeto.id = "222"
    	runner.initializeMapper
    	home = new CacheHome
    	home.perfilmapper = runner.perfilmapper
    	home.runner = runner
    	service = new CacheService
    	service.cacheHome = home
    	usuarioJuan = new Usuario
    	usuarioJuan.nombreDeUsuario = "juan"
    	usuarioPepe = new Usuario
    	usuarioPepe.nombreDeUsuario = "pepe"
    	usuarioLuis = new Usuario
    	usuarioLuis.nombreDeUsuario = "luis"
    	usuarioBeto = new Usuario
    	usuarioBeto.nombreDeUsuario = "beto"
    	marDelPlata_destiny = new Destiny()
		marDelPlata_destiny.nombre = "Mar del plata"
		pinamar_destiny = new Destiny()
		pinamar_destiny.nombre = "pinamar"
		like = new Like("pepe")
		dislike = new Dislike("pepe")
		visibilityPublico = Visibility.PUBLICO
		queFrio_comment = new Comment("que frio")
	}
	
	@Test
	def void verPerfilTest() {
		service.guardar(perfilPepe)
		var pepe = service.verPerfil(usuarioPepe)
		Assert.assertEquals(usuarioPepe.nombreDeUsuario, pepe.username)
		Assert.assertEquals("111", pepe.id)
		perfilLuis.addDestiny(marDelPlata_destiny)
		service.guardar(perfilLuis)
		var luis = service.verPerfil(usuarioLuis)
		Assert.assertEquals(usuarioLuis.nombreDeUsuario, luis.username)
		Assert.assertEquals(luis.destinations.size, 1)
		Assert.assertEquals(luis.destinations.get(0).nombre, "Mar del plata")
		pinamar_destiny.addLike(usuarioBeto,like)
		pinamar_destiny.addDisLike(usuarioBeto,dislike)
		pinamar_destiny.visibility = visibilityPublico
		perfilBeto.addDestiny(pinamar_destiny)
		service.guardar(perfilBeto)
		var beto = service.verPerfil(usuarioBeto)
		Assert.assertEquals(beto.destinations.get(0).likes.size, 1)
		Assert.assertEquals(beto.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(beto.destinations.get(0).visibility.toString, "PUBLICO")
		pinamar_destiny.add(queFrio_comment)
		queFrio_comment.visibility = visibilityPublico
		perfilJuan.addDestiny(pinamar_destiny)
		service.guardar(perfilJuan)
		var juan = service.verPerfil(usuarioJuan)
		Assert.assertEquals(juan.destinations.get(0).comments.get(0).description, "que frio")
		Assert.assertEquals(juan.destinations.get(0).comments.get(0).visibility.toString, "PUBLICO")		
	}
	
	@Test
	def void borrarTest() {
		service.guardar(perfilPepe)
		service.borrar(usuarioPepe)
		var pepe = service.verPerfil(usuarioPepe)
		Assert.assertEquals(pepe, null)
	}
	
	@Test
	def void estaPerfilTest() {
		service.guardar(perfilPepe)
		var estaPepe = service.estaPerfil(usuarioPepe)
		var estaLuis = service.estaPerfil(usuarioLuis)
		Assert.assertEquals(true, estaPepe)
		Assert.assertEquals(false, estaLuis)
	}
	
	    
	@After
	def void afterSetUp() {
		service.deleteTable
		service.deleteKeyspace
	}
	 
}