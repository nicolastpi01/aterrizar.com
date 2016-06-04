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
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Visibility

class PerfilDocServiceTest {
	PerfilDocService service
	MongoHome<PerfilDocument> home
	Usuario usuario_pepe
	Usuario usuario_luis
	Usuario usuario1
	Usuario usuario2
	Destiny marDelPlata_destiny
	Destiny cancun_destiny
	Destiny bariloche_destiny
	SocialNetworkingService networkService
	
	
	@Before
	def void setUp() {
		networkService = new SocialNetworkingService
		home = DocumentsServiceRunner.instance().collection(PerfilDocument)
		service = new PerfilDocService(home, networkService)
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
	}
	
	@Test
	def void addDestinyTest() {
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		val perfil_documents = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents.size, 1)
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
	 
	//happy road
	@Test
	def void addlike_No_User_and_Destiny_in_mongodb_Test() {
		service.addlike(usuario_pepe, marDelPlata_destiny)
		val perfil_documents_si_pepe_si_mardel_1like = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_1like.size(), 1)
		var perfilDoc_pepe_mardel_1like = perfil_documents_si_pepe_si_mardel_1like.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_1like.likes, 1)
	}
	 
	// hard road
	@Test
	def void addlike_yes_User_and_yes_Destiny_in_mongodb_Test() {
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		val perfil_documents_si_pepe_si_mardel_0like = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_0like.size(), 1)
		var perfilDoc_pepe_mardel_0like = perfil_documents_si_pepe_si_mardel_0like.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_0like.likes, 0)
		service.addlike(usuario_pepe, marDelPlata_destiny)
		val perfil_documents_si_pepe_si_mardel_1like = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_1like.size(), 1)
		var perfilDoc_pepe_mardel_1like = perfil_documents_si_pepe_si_mardel_1like.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_1like.likes, 1)
		service.addlike(usuario_pepe, marDelPlata_destiny)
		service.addlike(usuario_pepe, marDelPlata_destiny)
		service.addlike(usuario_pepe, marDelPlata_destiny)
		val perfil_documents_si_pepe_si_mardel_4like = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_4like.size(), 1)
		var perfilDoc_pepe_mardel_4like = perfil_documents_si_pepe_si_mardel_4like.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_4like.likes, 4)
	}
	
	@Test
	def void addDislikeTest() {
		service.addDislike(usuario_pepe, marDelPlata_destiny)
		val perfil_documents_si_pepe_si_mardel_1dislike = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_1dislike.size(), 1)
		var perfilDoc_pepe_mardel_1dislike = perfil_documents_si_pepe_si_mardel_1dislike.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_1dislike.dislikes, 1)
		service.addDislike(usuario_pepe, marDelPlata_destiny)
		val perfil_documents_si_pepe_si_mardel_2dislike = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_2dislike.size(), 1)
		var perfilDoc_pepe_mardel_2dislike = perfil_documents_si_pepe_si_mardel_2dislike.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_2dislike.dislikes, 2)
	}  
	  
	@Test
	//happy road
	def void addVisibility_No_User_and_Destiny_in_mongodb_Test() {
		val perfil_documents_si_pepe_si_mardel_no_amigos = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata").and (DBQuery.is("visibility", Visibility.AMIGOS)))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_no_amigos.size(), 0)
		service.addVisibility(usuario_pepe, marDelPlata_destiny, Visibility.AMIGOS)
		val perfil_documents_si_pepe_si_mardel_si_amigos = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata").and (DBQuery.is("visibility", Visibility.AMIGOS)))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_si_amigos.size(), 1)
		var perfilDoc_pepe_mardel_amigos = perfil_documents_si_pepe_si_mardel_si_amigos.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_amigos.visibility.toString, "AMIGOS")
		Assert.assertNotEquals(perfilDoc_pepe_mardel_amigos.visibility.toString, "PUBLICO")
		Assert.assertNotEquals(perfilDoc_pepe_mardel_amigos.visibility.toString, "PRIVADO")
	}
	 
	@Test
	//hard road
	def void addVisibility_yes_User_and_Destiny_in_mongodb_Test() {
		service.addDestiny(usuario_pepe, marDelPlata_destiny)
		service.addVisibility(usuario_pepe, marDelPlata_destiny, Visibility.AMIGOS)
		val perfil_documents_si_pepe_si_mardel_si_amigos = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata").and (DBQuery.is("visibility", Visibility.AMIGOS)))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_si_amigos.size(), 1)
		var perfilDoc_pepe_mardel_amigos = perfil_documents_si_pepe_si_mardel_si_amigos.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_amigos.visibility.toString, "AMIGOS")
		service.addVisibility(usuario_pepe, marDelPlata_destiny, Visibility.PUBLICO)
		val perfil_documents_si_pepe_si_mardel_si_publico = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata").and (DBQuery.is("visibility", Visibility.PUBLICO)))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_si_publico.size(), 1)
		var perfilDoc_pepe_mardel_publico = perfil_documents_si_pepe_si_mardel_si_publico.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_publico.visibility.toString, "PUBLICO")
	}
	
	@Test
	//happy road
	def void addVisibility_No_User_and_Destiny_and_Comment_in_mongodb_Test() {
		val perfil_documents_no_pepe_no_mardel = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_no_pepe_no_mardel.size(), 0)
		var comment_en_mardel = new Comment("en mardel")
		service.addVisibility(usuario_pepe, marDelPlata_destiny, comment_en_mardel, Visibility.PUBLICO)
		val perfil_documents_si_pepe_si_mardel = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel.size(), 1)
		var perfilDoc_pepe_mardel = perfil_documents_si_pepe_si_mardel.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel.comments.size, 1)
		Assert.assertEquals(perfilDoc_pepe_mardel.comments.get(0).description, "en mardel")
		Assert.assertEquals(perfilDoc_pepe_mardel.comments.get(0).visibility.toString, "PUBLICO")
	}
	
	@Test
	//hard road
	def void addVisibility_yes_User_and_Destiny_and_Comment_in_mongodb_Test() {
		var comment_en_mardel = new Comment("en mardel")
		service.addComment(usuario_pepe, marDelPlata_destiny, comment_en_mardel)
		val perfil_documents_si_pepe_si_mardel = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel.size(), 1)
		service.addVisibility(usuario_pepe, marDelPlata_destiny, comment_en_mardel, Visibility.PRIVADO)
		val perfil_documents_si_pepe_si_mardel_con_comment_privado = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_con_comment_privado.size(), 1)
		var perfilDoc_pepe_mardel_con_comment_privado = perfil_documents_si_pepe_si_mardel_con_comment_privado.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_con_comment_privado.comments.size, 1)
		Assert.assertEquals(perfilDoc_pepe_mardel_con_comment_privado.comments.get(0).description, "en mardel")
		Assert.assertEquals(perfilDoc_pepe_mardel_con_comment_privado.comments.get(0).visibility.toString, "PRIVADO")
		service.addVisibility(usuario_pepe, marDelPlata_destiny, comment_en_mardel, Visibility.AMIGOS)
		val perfil_documents_si_pepe_si_mardel_con_comment_amigos = home.find(DBQuery.is("username", "pepe")).and (DBQuery.is("destiny.nombre", "Mar del plata"))
		Assert.assertEquals(perfil_documents_si_pepe_si_mardel_con_comment_amigos.size(), 1)
		var perfilDoc_pepe_mardel_con_comment_amigos = perfil_documents_si_pepe_si_mardel_con_comment_amigos.get(0)
		Assert.assertEquals(perfilDoc_pepe_mardel_con_comment_amigos.comments.size, 1)
		Assert.assertEquals(perfilDoc_pepe_mardel_con_comment_amigos.comments.get(0).description, "en mardel")
		Assert.assertEquals(perfilDoc_pepe_mardel_con_comment_amigos.comments.get(0).visibility.toString, "AMIGOS")
	} 
	  
	@Test
	def void stalkear_No_friend() {
		val perfil_documents_luis_no_amigos_no_documents = service.stalkear(usuario_pepe, usuario_luis)
		Assert.assertEquals(perfil_documents_luis_no_amigos_no_documents.size, 0)
		service.addVisibility(usuario_luis, marDelPlata_destiny, Visibility.AMIGOS)
		service.addVisibility(usuario_luis, cancun_destiny, Visibility.PRIVADO)
		service.addVisibility(usuario_luis, cancun_destiny, Visibility.PUBLICO)
		val perfil_documents_luis_no_amigos = service.stalkear(usuario_pepe, usuario_luis)
		Assert.assertEquals(perfil_documents_luis_no_amigos.size, 1)
	}
	
	/* 
	@Test
	def void stalkear_yes_friend() {
		val perfil_documents_luis_yes_amigos_no_documents = service.stalkear(usuario_pepe, usuario_luis)
		Assert.assertEquals(perfil_documents_luis_yes_amigos_no_documents.size, 0)
		service.addVisibility(usuario_luis, marDelPlata_destiny, Visibility.AMIGOS)
		service.addVisibility(usuario_luis, cancun_destiny, Visibility.PRIVADO)
		service.addVisibility(usuario_luis, cancun_destiny, Visibility.PUBLICO)
		service.addVisibility(usuario_luis, bariloche_destiny, Visibility.AMIGOS)
		val perfil_documents_luis_yes_amigos = service.stalkear(usuario_pepe, usuario_luis)
		Assert.assertEquals(perfil_documents_luis_yes_amigos.size, 3)
	}
	*/
	@After
	def void cleanDB(){
		home.mongoCollection.drop
	}
}