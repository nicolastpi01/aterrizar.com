package ar.edu.unq.epers.mongoDB

<<<<<<< HEAD
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import org.junit.Test
import java.util.ArrayList
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import org.junit.After
import org.junit.Assert
import org.junit.Before
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Visibility

class PerfilServiceTest {
	List<Perfil> perfiles
	MongoHome<Perfil> homePerfil
	PerfilService perfilService
	Perfil pepe
	Destiny dest
=======
import ar.edu.unq.epers.aterrizar.home.Collection
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class PerfilServiceTest {
	
	//DestinyService service;
	Usuario u
	Usuario u2
	Usuario u3
	
	
	
	Destiny destinoMarDelPlata;
	Collection<Perfil> home;
	final String CODIGO = "111";
	PerfilService service;
	
	
	Perfil perfil
	
>>>>>>> 7b8790167417d92155243835f4bc0a5a7e6f7300
	Comment comentario
	
	
	@Before
	def void setUp() {
<<<<<<< HEAD
		pepe = new Perfil("pepe")
		perfiles = new ArrayList
		perfiles.add(pepe)
		homePerfil = DocumentsServiceRunner.instance().collection(Perfil)
		perfilService = new PerfilService(homePerfil)
	}
	
	@Test
	def void findPerfilTest() {
		perfilService.perfilHome.mongoCollection.insert(pepe)
		var perfilRet = perfilService.findPerfil(pepe)
		Assert.assertEquals(perfilRet.userName, "pepe")
		//Assert.assertEquals(perfilRet.id, "111")
	}
	
	@Test
	def void addDestinyTest() {
		perfilService.perfilHome.mongoCollection.insert(pepe)
		var marDelPlata = new Destiny("Mar del plata")
		var iguazu = new Destiny("Iguazu")
		perfilService.addDestiny(pepe, marDelPlata)
		perfilService.addDestiny(pepe, iguazu)
		var pepeNuevo = perfilService.findPerfil(pepe)
		Assert.assertEquals(pepeNuevo.destinys.size, 2)
		Assert.assertEquals(pepeNuevo.destinys.get(0).nombre, ("Mar del plata"))
		Assert.assertEquals(pepeNuevo.destinys.get(1).nombre, ("Iguazu"))
	}
	
	@Test
	def void addCommentTest() {
		comentario = new Comment("mongodb")
		perfilService.perfilHome.mongoCollection.insert(pepe)
		var marDelPlata = new Destiny("Mar del plata")
		perfilService.addDestiny(pepe, marDelPlata)
		perfilService.addComment(pepe, marDelPlata, comentario)
		var destinoNuevo = perfilService.findDestiny(pepe, marDelPlata)
		Assert.assertEquals(destinoNuevo.comments.size, 1)
		Assert.assertEquals(destinoNuevo.comments.get(0).description, ("mongodb"))
	}
	
	
	@Test
	def void addVisibilityToDestinyTest() {
		perfilService.perfilHome.mongoCollection.insert(pepe)
		var marDelPlata = new Destiny("Mar del plata")
		perfilService.addDestiny(pepe, marDelPlata)
		perfilService.addVisibilityTo(pepe, marDelPlata, Visibility.PRIVADO)
		var destinoNuevo = perfilService.findDestiny(pepe, marDelPlata)
		Assert.assertEquals(destinoNuevo.getVisibility, "PRIVADO")
	}
	
	@After
	def void cleanDB() {
		homePerfil.mongoCollection.drop
	}
	 
=======
		
		
		destinoMarDelPlata = new Destiny => [
			comments = newArrayList
			visibility = Visibility.PUBLICO
//			id = CODIGO
			nombre = "Mar del Plata" 
		]
		
		//home = new MongoHome()
		home = DocumentsServiceRunner.instance().collection(Perfil)
		service = new PerfilService(home)
		
		
		perfil = new Perfil => [
			
			userName = "usuario"
			//Recordar: los id no se inicializan para mongoDB
//			id = "unId"
			destinys = newArrayList
		]
		
		
		
		 comentario = new Comment => [
			description = "me gusta"
			visibility = Visibility.PUBLICO 
			
		]
		
	}
	
	
	@Test 
	def void agregarUnPerfil(){
		service.insertPerfil(perfil)
		
		var perfilEncontrado = service.findPerfil(perfil)
		Assert.assertEquals(perfil.userName, perfilEncontrado.userName)
		
		
	}
	
	@Test
	def void agregarUnDestino(){
		service.insertPerfil(perfil)
		
		var p = service.findPerfil(perfil)
		
		service.addDestiny(p, destinoMarDelPlata)
		
		var newP = service.findPerfil(p) 
		Assert.assertEquals(p.destinys.size, 1)
		
		Assert.assertEquals(p.destinys.get(0).nombre, "Mar del Plata")
	}
	
	@Test
	def void agregarComentario(){
		service.insertPerfil(perfil)
		var p = service.findPerfil(perfil)
		service.addDestiny(p, destinoMarDelPlata)
		service.addDestiny(p, destinoMarDelPlata)
		
		
		
		
		var unPerfil = service.findPerfil(p)
		var unDestino = service.findDestiny(perfil, destinoMarDelPlata)
		
		service.addComment(perfil, destinoMarDelPlata, comentario)
		
		
		var comentario = service.findComment(perfil, destinoMarDelPlata, comentario)
		
		var destinoConComentario = service.findDestiny(perfil, destinoMarDelPlata)
		
		
		Assert.assertEquals(comentario.description, "me gusta")
		Assert.assertEquals(destinoConComentario.comments.size, 1)
		
	}


	
	
	
		
		@After
		def void tearDown(){
			home.mongoCollection.drop
		
		}
>>>>>>> 7b8790167417d92155243835f4bc0a5a7e6f7300
}