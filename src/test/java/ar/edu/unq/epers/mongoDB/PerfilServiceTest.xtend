package ar.edu.unq.epers.mongoDB


import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.servicios.DestinyService
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import org.junit.After
import org.junit.Before
import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import ar.edu.unq.epers.aterrizar.home.Collection
import org.junit.Test
import org.junit.Assert

class PerfilServiceTest {
	
	//DestinyService service;
	Usuario u
	Usuario u2
	Usuario u3
	
	
	
	Destiny destiny;
	Collection<Perfil> home;
	final String CODIGO = "111";
	PerfilService service;
	
	
	Perfil perfil
	
	
	
	@Before
	def void setUp() {
		destiny = new Destiny => [
			comments = newArrayList
			visibility = Visibility.PUBLICO
			id = CODIGO
			nombre = "Venecia" 
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
	}
	
	
	@Test 
	def void agregarUnPerfil(){
		service.insertPerfil(perfil)
		
		var perfilEncontrado = service.findPerfil(perfil)
		Assert.assertEquals(perfil.userName, perfilEncontrado.userName)
		
		
	}
	




	
	
	
		
		@After
		def void tearDown(){
			home.mongoCollection.drop
		
		}
}