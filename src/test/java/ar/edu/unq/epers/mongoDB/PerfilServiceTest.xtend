package ar.edu.unq.epers.mongoDB

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
	
	Comment comentario
	
	
	@Before
	def void setUp() {
		
		
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
		
		
		service.addComment(p,  destinoMarDelPlata,  comentario)
		
		var unPerfil = service.findPerfil(p)
		var unDestino = service.findDestiny(p, destinoMarDelPlata)
		var comentario = service.findComment(unDestino, comentario)
		
		Assert.assertEquals(comentario.description, null)
		
	}


	
	
	
		
		@After
		def void tearDown(){
			home.mongoCollection.drop
		
		}
}