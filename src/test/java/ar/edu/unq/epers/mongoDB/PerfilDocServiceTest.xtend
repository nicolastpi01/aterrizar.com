package ar.edu.unq.epers.mongoDB

import ar.edu.unq.epers.aterrizar.servicios.PerfilDocService
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import ar.edu.unq.epers.aterrizar.model.PerfilDocument
import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.model.Comment

class PerfilDocServiceTest {
	PerfilDocService service
	MongoHome<PerfilDocument> home
	Usuario usuario_pepe
	Destiny marDelPlata_destiny
	
	@Before
	def void setUp() {
		home = DocumentsServiceRunner.instance().collection(PerfilDocument)
		service = new PerfilDocService(home)
		usuario_pepe = new Usuario()
		usuario_pepe.nombreDeUsuario = "pepe"
		marDelPlata_destiny = new Destiny()
		marDelPlata_destiny.nombre = "Mar del plata"
	}
	
	@Test
	def void addDestinyTest() {
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		val perfil_documents = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents.size(), 1)
		var perfilDoc = perfil_documents.get(0)
		Assert.assertEquals(perfilDoc.username, "pepe")
		Assert.assertEquals(perfilDoc.destiny.nombre,"Mar del plata");	
	}
	 
	// happy road
	@Test
	def void addComment_No_user_and_destiny_in_mongobd_Test() {
		var comment = new Comment("en mardel")
		val perfil_documents_no_mardel = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_no_mardel.size(), 0)
		service.addComment(usuario_pepe, marDelPlata_destiny, comment)
		val perfil_documents_si_mardel = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_mardel.size(), 1)
		var perfilDoc = perfil_documents_si_mardel.get(0)
		Assert.assertEquals(perfilDoc.comments.get(0).description, "en mardel")
	}
	
	// hard road
	@Test
	def void addComment_yes_user_and_destiny_in_mongobd_Test() {
		var comment = new Comment("en mardel")
		var comment_enIguazu = new Comment("en Iguazu")
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addComment(usuario_pepe, marDelPlata_destiny, comment)
		val perfil_documents_si_mardel = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_mardel.size(), 1)
		var perfilDoc = perfil_documents_si_mardel.get(0)
		Assert.assertEquals(perfilDoc.comments.get(0).description, "en mardel")
		service.addComment(usuario_pepe, marDelPlata_destiny, comment_enIguazu)
		val perfil_documents_si_mardel_si_Iguazu = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_mardel.size(), 1)
		var perfilDoc_2 = perfil_documents_si_mardel_si_Iguazu.get(0)
		Assert.assertEquals(perfilDoc_2.comments.get(0).description, "en mardel")
		var perfilDoc_3 = perfil_documents_si_mardel_si_Iguazu.get(0)
		Assert.assertEquals(perfilDoc_3.comments.get(1).description, "en Iguazu")	
	}
	
	
	
	
	
	
	
	
	@After
	def void cleanDB(){
		home.mongoCollection.drop
	}
}