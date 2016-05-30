package ar.edu.unq.epers.mongoDB

import org.junit.Test
import ar.edu.unq.epers.aterrizar.servicios.DestinyService
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.home.DestinyHome
import org.junit.Before
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import org.mongojack.DBQuery
import org.junit.Assert
import org.junit.After

class DestServiceTest {
	DestinyService service;
	Destiny destiny;
	DestinyHome<Destiny> home;
	final String CODIGO = "111";

	@Before
	def void setUp() {
		destiny = new Destiny(CODIGO)
		home = DocumentsServiceRunner.instance().collection(Destiny)
		service = new DestinyService(home)
	}
	@Test
	def void addDestinyTest() {
		service.addDestiny(destiny)
		val destinos = home.find(DBQuery.is("codigo", CODIGO))
		Assert.assertEquals(destinos.size(), 1)
		//val destiny = destinos.get(0)
		//Assert.assertEquals(destiny.nombre, "Mar del plata");
		//Assert.assertEquals(destiny.precioEstadia, 5000);
	}
	
	@After
	def void cleanDB(){
		home.mongoCollection.drop
	}
	
}