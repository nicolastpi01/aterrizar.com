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
	Destiny bariloche_destiny
	Like like
	Dislike dislike
	Visibility visibilityPublico
	Visibility visibilityPrivado
	Visibility visibilityAmigos
	Comment queFrio_comment
	Comment commentQueCalor
	Comment commentQueLindoDia
	Comment	commentVoyALaPlaya
	
	
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
		bariloche_destiny = new Destiny
		bariloche_destiny.nombre = "bariloche"
		like = new Like("pepe")
		dislike = new Dislike("pepe")
		visibilityPublico = Visibility.PUBLICO
		visibilityPrivado = Visibility.PRIVADO
		visibilityAmigos = Visibility.AMIGOS
		queFrio_comment = new Comment("que frio")
		commentQueCalor = new Comment("que calor")
		commentQueLindoDia = new Comment("que lindo dia")
		commentVoyALaPlaya = new Comment("voy a la playa")
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
	
	@Test
	def void stalkearAmigoTest() {
		
		commentQueCalor.visibility = visibilityPublico
		commentQueLindoDia.visibility = visibilityAmigos
		commentVoyALaPlaya.visibility = visibilityPrivado
		marDelPlata_destiny.add(commentQueCalor)
		marDelPlata_destiny.add(commentQueLindoDia)
		marDelPlata_destiny.add(commentVoyALaPlaya)
		marDelPlata_destiny.visibility = visibilityPublico
		pinamar_destiny.visibility = visibilityPrivado
		bariloche_destiny.visibility = visibilityAmigos
		perfilPepe.addDestiny(marDelPlata_destiny)
		perfilPepe.addDestiny(pinamar_destiny)
		perfilPepe.addDestiny(bariloche_destiny)
		service.guardar(perfilPepe)
		//var pepe = service.stalkearAmigo(usuarioPepe)
		//Assert.assertEquals(pepe.destinations.size, 2)
		//Assert.assertEquals(pepe.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(pepe.destinations.get(1).nombre, "bariloche")
		//Assert.assertEquals(pepe.destinations.get(0).comments.size, 2)
		//Assert.assertEquals(pepe.destinations.get(0).comments.get(0).description, "que calor")
		//Assert.assertEquals(pepe.destinations.get(0).comments.get(1).description, "que lindo dia")		
	}
	
	@Test
	def void stalkearNoAmigoTest() {
		
		commentQueCalor.visibility = visibilityPublico
		commentQueLindoDia.visibility = visibilityAmigos
		commentVoyALaPlaya.visibility = visibilityPrivado
		marDelPlata_destiny.add(commentQueCalor)
		marDelPlata_destiny.add(commentQueLindoDia)
		marDelPlata_destiny.add(commentVoyALaPlaya)
		marDelPlata_destiny.visibility = visibilityPublico
		pinamar_destiny.visibility = visibilityPrivado
		bariloche_destiny.visibility = visibilityAmigos
		perfilPepe.addDestiny(marDelPlata_destiny)
		perfilPepe.addDestiny(pinamar_destiny)
		perfilPepe.addDestiny(bariloche_destiny)
		service.guardar(perfilPepe)
		var pepe = service.stalkearAmigo(usuarioPepe)
		//Assert.assertEquals(pepe.destinations.size, 1)
		//Assert.assertEquals(pepe.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(pepe.destinations.get(0).comments.size, 1)
		//Assert.assertEquals(pepe.destinations.get(0).comments.get(0).description, "que calor")		
	}
	
	/*     
	@After
	def void afterSetUp() {
		service.deleteTable
		service.deleteKeyspace
	}
	 */
}