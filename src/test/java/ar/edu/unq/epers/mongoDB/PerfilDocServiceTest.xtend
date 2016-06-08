package ar.edu.unq.epers.mongoDB

import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.model.Visibility

class PerfilDocServiceTest {
	PerfilService service
	MongoHome<Perfil> home
	Usuario usuario_pepe
	Usuario usuario_luis
	Destiny marDelPlata_destiny
	Destiny cancun_destiny
	Destiny bariloche_destiny
	Destiny bahiaBlanca_destiny
	Comment que_frio
	Like like_pepe
	Dislike dislike_pepe
	SocialNetworkingService socialService
	Visibility visibility_privado
	Visibility visibility_publico
	
	
	@Before
	def void setUp() {
		
		home = DocumentsServiceRunner.instance().collection(Perfil)
		socialService = new SocialNetworkingService
		service = new PerfilService(home, socialService)
		usuario_pepe = new Usuario()
		usuario_pepe.nombreDeUsuario = "pepe"
		usuario_luis = new Usuario()
		usuario_luis.nombreDeUsuario = "luis"
		marDelPlata_destiny = new Destiny()
		marDelPlata_destiny.nombre = "Mar del plata"
		cancun_destiny = new Destiny()
		cancun_destiny.nombre = "cancun"
		bariloche_destiny = new Destiny()
		bariloche_destiny.nombre = "bariloche"
		bahiaBlanca_destiny = new Destiny()
		bahiaBlanca_destiny.nombre = "bahiaBlanca"
		que_frio = new Comment("que frio")
		like_pepe = new Like("pepe")
		dislike_pepe = new Dislike("pepe")
		visibility_privado = Visibility.PRIVADO
		visibility_publico = Visibility.PUBLICO
	}
	
	@Test
	def void getPerfil() {
		service.addPerfil(usuario_pepe)
		var perfil_pepe = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe.username, "pepe")
		service.addPerfil(usuario_luis)
		var perfil_luis = service.getPerfil(usuario_luis)
		Assert.assertEquals(perfil_luis.username, "luis")
	}
	
	@Test
	def void addDestinyTest() {
		service.addPerfil(usuario_pepe)
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		var perfil_pepe = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe.destinations.size, 1)
		Assert.assertEquals(perfil_pepe.destinations.get(0).nombre, "Mar del plata")	
	}
	  
	@Test
	def void addCommentTest() {
		service.addPerfil(usuario_pepe)
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addComment(usuario_pepe, marDelPlata_destiny, que_frio)
		val perfil_pepe = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe.destinations.get(0).comments.size, 1)
		Assert.assertEquals(perfil_pepe.destinations.get(0).comments.get(0).description, "que frio")
	}
	
	 
	@Test
	def void addLikeTest() {
		service.addPerfil(usuario_pepe)
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addlike(usuario_pepe, marDelPlata_destiny, like_pepe)
		val perfil_pepe = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfil_pepe.destinations.get(0).likes.get(0).username, "pepe")
		service.addlike(usuario_pepe, marDelPlata_destiny, like_pepe)
		Assert.assertEquals(perfil_pepe.destinations.get(0).likes.size, 1)
	}
	 
	
	@Test
	def void addDislikeTest() {
		service.addPerfil(usuario_pepe)
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addDislike(usuario_pepe, marDelPlata_destiny, dislike_pepe)
		val perfil_pepe = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfil_pepe.destinations.get(0).dislikes.get(0).username, "pepe")
		service.addDislike(usuario_pepe, marDelPlata_destiny, dislike_pepe)
		Assert.assertEquals(perfil_pepe.destinations.get(0).dislikes.size, 1)
		service.addlike(usuario_pepe, marDelPlata_destiny, like_pepe)
		Assert.assertEquals(perfil_pepe.destinations.get(0).likes.size, 0)
		Assert.assertEquals(perfil_pepe.destinations.get(0).dislikes.size, 1)
	}
	  
	   
	@Test
	def void addVisibilityDestinyTest() {
		service.addPerfil(usuario_pepe)
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addVisibility(usuario_pepe, marDelPlata_destiny, visibility_privado)
		val perfil_pepe_privado = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe_privado.destinations.get(0).visibility.toString, "PRIVADO")
		service.addVisibility(usuario_pepe, marDelPlata_destiny, visibility_publico)
		val perfil_pepe_publico = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe_publico.destinations.get(0).visibility.toString, "PUBLICO")
	}
	
	@Test
	def void addVisibilityCommentTest() {
		service.addPerfil(usuario_pepe)
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addComment(usuario_pepe, marDelPlata_destiny, que_frio)
		service.addVisibility(usuario_pepe, marDelPlata_destiny, que_frio, visibility_privado)
		val perfil_pepe_privado = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe_privado.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
		service.addVisibility(usuario_pepe, marDelPlata_destiny, que_frio, visibility_privado)
		val perfil_pepe_publico = service.getPerfil(usuario_pepe)
		Assert.assertEquals(perfil_pepe_publico.destinations.get(0).comments.get(0).visibility.toString, "PUBLICO")
	}
	 
	/*  
	@Test
	def void stalkear_yes_friend() {
		socialService.agregarPersona(usuario_pepe)
		socialService.agregarPersona(usuario_luis)
		socialService.amigoDe(usuario_pepe, usuario_luis)
		val perfil_null = service.stalkear(usuario_pepe, usuario_luis)
		service.addVisibility(usuario_luis, marDelPlata_destiny, Visibility.AMIGOS)
		service.addVisibility(usuario_luis, cancun_destiny, Visibility.PRIVADO)
		service.addVisibility(usuario_luis, cancun_destiny, Visibility.PUBLICO)
		val perfil_documents_luis_si_amigos_si_documents = service.stalkear(usuario_pepe, usuario_luis)
		Assert.assertEquals(perfil_documents_luis_si_amigos_si_documents, "un perfil aqui")
	}
	*/
	
	@After
	def void cleanDB(){
		home.mongoCollection.drop
	}
}