package ar.edu.unq.epers.mongoDB

import ar.edu.unq.epers.aterrizar.home.MongoHome
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

class PerfilServiceTest {
	
	//DestinyService service;
	Usuario u
	Usuario u2
	Usuario u3
	
	
	
	Destiny destiny;
	Collection<Perfil> home;
	final String CODIGO = "111";
	PerfilService service;
	
	
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
	}




	
	
	
		
		@After
		def void tearDown(){
			
		
		}
}