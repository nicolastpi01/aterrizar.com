package ar.edu.unq.epers.mongoDB

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

class PerfilServiceTest {
	List<Perfil> perfiles
	MongoHome<Perfil> homePerfil
	PerfilService perfilService
	Perfil pepe
	Destiny dest
	
	
	@Before
	def void setUp() {
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
	
	@After
	def void cleanDB() {
		homePerfil.mongoCollection.drop
	}
	 
}