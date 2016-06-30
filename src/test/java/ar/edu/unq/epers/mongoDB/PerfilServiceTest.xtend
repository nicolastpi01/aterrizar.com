package ar.edu.unq.epers.mongoDB

import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import ar.edu.unq.epers.aterrizar.home.Home
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.servicios.CacheService
import ar.edu.unq.epers.aterrizar.home.CacheHome
import ar.edu.unq.epers.aterrizar.servicios.CassandraServiceRunner
import ar.edu.unq.epers.aterrizar.servicios.TramoService

class PerfilServiceTest {
	PerfilService service
	TramoService tramoService
	Home<Perfil> home
	CacheService cacheService
	CacheHome cacheHome
	CassandraServiceRunner cassandraRunner
	SocialNetworkingService socialService
	Usuario usuarioPepe
	Usuario usuarioJuan
	Destiny marDelPlataDestiny
	Comment queFrio
	Like likePepe
	Dislike dislikePepe
	Visibility visibilityPrivado
	Visibility visibilityPublico
	Visibility visibilityAmigos
	Usuario usuarioLuis
	Comment queCalor
	Comment queAburrido
	Destiny barilocheDestiny
	Destiny bahiaBlancaDestiny
	
	
	@Before
	def void setUp() {
		
		home = DocumentsServiceRunner.instance().collection(Perfil)
		tramoService = new TramoService
		socialService = new SocialNetworkingService
		cassandraRunner = new CassandraServiceRunner
		cassandraRunner.addPoint("127.0.0.1")
		cassandraRunner.getSession
		cassandraRunner.initializeModel
		cassandraRunner.initializeMapper
		cacheHome = new CacheHome
		cacheHome.perfilmapper = cassandraRunner.perfilmapper
		cacheHome.runner = cassandraRunner
		cacheService = new CacheService
		cacheService.cacheHome = cacheHome
		service = new PerfilService(home, socialService, cacheService, tramoService)
		usuarioPepe = new Usuario
		usuarioPepe.nombreDeUsuario = "pepe"
		usuarioJuan = new Usuario
		usuarioJuan.nombreDeUsuario = "juan"
		marDelPlataDestiny = new Destiny
		marDelPlataDestiny.nombre = "Mar del plata"
		queFrio = new Comment("que frio")
		likePepe = new Like("pepe")
		dislikePepe = new Dislike("pepe")
		visibilityPrivado = Visibility.PRIVADO
		usuarioLuis = new Usuario()
		usuarioLuis.nombreDeUsuario = "luis"
		queCalor = new Comment("que calor")
		queAburrido = new Comment("que aburrido")
		visibilityPublico = Visibility.PUBLICO		
	}
	 
	@Test
	def void verPerfil() {
		service.addPerfil(usuarioPepe)
		var perfilPepeMongo = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepeMongo.username, "pepe")
		var perfilPepeCache = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepeCache.username, "pepe")
	}
	  
	@Test
	def void addDestinyTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")	
	}
	    
	@Test
	def void addCommentTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).description, "que frio")
		service.addComment(usuarioPepe, marDelPlataDestiny, queCalor, Visibility.PUBLICO)
		perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 2)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(1).description, "que calor")
	}
	
	 
	@Test
	def void addLikeTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addlike(usuarioPepe, marDelPlataDestiny, likePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.get(0).username, "pepe")
		service.addlike(usuarioPepe, marDelPlataDestiny, likePepe, Visibility.PUBLICO)
		perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.get(0).username, "pepe")
	}
	 
	
	@Test
	def void addDislikeTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDislike(usuarioPepe, marDelPlataDestiny, dislikePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.get(0).username, "pepe")
		service.addDislike(usuarioPepe, marDelPlataDestiny, dislikePepe, Visibility.PUBLICO)
		perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.get(0).username, "pepe")
	}
	  
	   
	@Test
	def void addVisibilityDestinyTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PUBLICO")
	}
	
	@Test
	def void addVisibilityCommentTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearYoMismoTest() {
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPrivado, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.stalkear(usuarioPepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PRIVADO")
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearNoAmigoTest() {
		socialService.agregarPersona(usuarioJuan)
		socialService.agregarPersona(usuarioLuis)
		service.addPerfil(usuarioPepe)
		service.addPerfil(usuarioJuan)
		service.addDestiny(usuarioJuan, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioJuan, barilocheDestiny, Visibility.PUBLICO)
		//service.addDestiny(usuarioJuan, bahiaBlancaDestiny, Visibility.PUBLICO)
		//service.addComment(usuarioJuan, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		//service.addComment(usuarioJuan, marDelPlataDestiny, queCalor, Visibility.PUBLICO)
		//service.addComment(usuarioJuan, marDelPlataDestiny, queAburrido, Visibility.PUBLICO)
		//service.addVisibility(usuarioJuan, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		//service.addVisibility(usuarioJuan, barilocheDestiny, visibilityPrivado, Visibility.PUBLICO)
		//service.addVisibility(usuarioJuan, bahiaBlancaDestiny, visibilityAmigos, Visibility.PUBLICO)
		//service.addVisibility(usuarioJuan, marDelPlataDestiny, queFrio, visibilityPublico, Visibility.PUBLICO)
		//service.addVisibility(usuarioJuan, marDelPlataDestiny, queCalor, visibilityAmigos, Visibility.PUBLICO)
		//service.addVisibility(usuarioJuan, marDelPlataDestiny, queAburrido, visibilityPrivado, Visibility.PUBLICO)
		//var perfilJuan = service.stalkear(usuarioLuis, usuarioJuan)
		//Assert.assertEquals(perfilJuan.destinations.size, 1)
		//Assert.assertEquals(perfilJuan.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(perfilJuan.destinations.get(1).nombre, "bariloche")
		//Assert.assertEquals(perfilJuan.destinations.get(0).comments.size, 1)
		//Assert.assertEquals(perfilJuan.destinations.get(0).comments.get(0).description, "que frio")
	}
	
	@Test
	def void stalkearAmigoTest() {
		socialService.agregarPersona(usuarioPepe)
		socialService.agregarPersona(usuarioLuis)
		service.addPerfil(usuarioPepe)
		service.addPerfil(usuarioLuis)
		socialService.amigoDe(usuarioPepe, usuarioLuis)
		service.addDestiny(usuarioLuis, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioLuis, bahiaBlancaDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioLuis, barilocheDestiny, Visibility.PUBLICO)
		//service.addComment(usuarioLuis, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		//service.addComment(usuarioLuis, marDelPlataDestiny, queCalor, Visibility.PUBLICO)
		//service.addComment(usuarioLuis, marDelPlataDestiny, queAburrido, Visibility.PUBLICO)
		//service.addVisibility(usuarioLuis, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		//service.addVisibility(usuarioLuis, bahiaBlancaDestiny, visibilityPrivado, Visibility.PUBLICO)
		//service.addVisibility(usuarioLuis, barilocheDestiny, visibilityAmigos, Visibility.PUBLICO)
		//service.addVisibility(usuarioLuis, marDelPlataDestiny, queFrio, visibilityPublico, Visibility.PUBLICO)
		//service.addVisibility(usuarioLuis, marDelPlataDestiny, queCalor, visibilityPrivado, Visibility.PUBLICO)
		//service.addVisibility(usuarioLuis, marDelPlataDestiny, queAburrido, visibilityAmigos, Visibility.PUBLICO)
		//var perfilLuis = service.stalkear(usuarioPepe, usuarioLuis)
		//Assert.assertEquals(perfilLuis.destinations.size, 2)
		//Assert.assertEquals(perfilLuis.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(perfilLuis.destinations.get(1).nombre, "bariloche")
		//Assert.assertEquals(perfilLuis.destinations.get(0).comments.size, 2)
		//Assert.assertEquals(perfilLuis.destinations.get(0).comments.get(0).description, "que frio")
		//Assert.assertEquals(perfilLuis.destinations.get(0).comments.get(1).description, "que aburrido")
	}
	
	
	@After
	def void cleanDB(){
		cacheService.deleteTable
		cacheService.deleteKeyspace
		home.mongoCollection.drop		
	}
}