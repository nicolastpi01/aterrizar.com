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
import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.servicios.BaseService
import org.hibernate.SessionFactory
import org.hibernate.Session
import java.sql.Date
import ar.edu.unq.epers.aterrizar.model.Primera
import java.util.List
import ar.edu.unq.epers.aterrizar.servicios.ReservaService
import java.util.ArrayList
import ar.edu.unq.epers.aterrizar.model.Reserva
import java.util.Calendar
import ar.edu.unq.epers.aterrizar.servicios.CompraService

class PerfilServiceTest {
	
	PerfilService service
	CacheService cacheService
	SocialNetworkingService socialService
	CacheHome cacheHome
	Home<Perfil> home
	CassandraServiceRunner cassandraRunner
	Usuario usuarioPepe
	Usuario usuarioJuan
	Usuario usuarioNoAmigoDePepe
	Usuario usuarioLuis
	Like likePepe
	Dislike dislikePepe
	Visibility visibilityPrivado
	Visibility visibilityPublico
	Visibility visibilityAmigos
	Comment queCalor
	Comment queAburrido
	Comment queFrio
	Destiny barilocheDestiny
	Destiny bahiaBlancaDestiny
	Destiny marDelPlataDestiny

	/*  Hibernate   */
	CompraService compraService
	ReservaService reservaService 
    Asiento asiento0
    Asiento asiento1
    Asiento asiento2
    Reserva reservaBuenosAiresMarDelPlata
    Reserva reservaBuenosAiresBariloche
    Reserva reservaBuenosAiresBahiaBlanca
    Tramo tramo
    BaseHome baseHome
     
	
	def void setUpHibernate() {
		
		compraService = new CompraService
        reservaService = new ReservaService
		baseHome = new BaseHome
		SessionManager::getSessionFactory().openSession()
		
		usuarioPepe = new Usuario => [
            nombreDeUsuario = "usuarioPepe"
            nombreYApellido = "usuarioPepe apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        asiento0 = new Asiento => [
                    nombre = "a0"
                    categoria = new Primera(1000)
                    user = usuarioPepe
                ]
                
        asiento1 = new Asiento => [
                    nombre = "a1"
                    categoria = new Primera(1000)
                    user = usuarioPepe
                ]
                
        asiento2 = new Asiento => [
                    nombre = "a2"
                    categoria = new Primera(1000)
                    user = usuarioPepe
                ]
                
		
		reservaBuenosAiresMarDelPlata = new Reserva => [
            user = usuarioPepe
            asiento = asiento0
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Mar del plata"
         
        ]
        
        reservaBuenosAiresBariloche = new Reserva => [
            user = usuarioPepe
            asiento = asiento1
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Bariloche"
         
        ]
        
        reservaBuenosAiresBahiaBlanca = new Reserva => [
            user = usuarioPepe
            asiento = asiento2
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Bahia Blanca"
         
        ]
        
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Mar del plata"
            llegada = new Date(2000)
            salida = new Date(1500)
            reservas = new ArrayList
            compras = new ArrayList
        ]
        
        tramo.agregarReserva(reservaBuenosAiresMarDelPlata)
        tramo.agregarReserva(reservaBuenosAiresBariloche)
        tramo.agregarReserva(reservaBuenosAiresBahiaBlanca)					

    }
	
	@Before
	def void setUp() {
		
		this.setUpHibernate()
		home = DocumentsServiceRunner.instance().collection(Perfil)
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
		service = new PerfilService(home, socialService, cacheService, compraService)
		usuarioJuan = new Usuario
		usuarioJuan.nombreDeUsuario = "juan"
		usuarioNoAmigoDePepe = new Usuario
		usuarioNoAmigoDePepe.nombreDeUsuario = "usuarioNoAmigoDePepe"
		usuarioNoAmigoDePepe.nombreYApellido = "usuarioNoAmigoPepeDominguez"
		usuarioLuis = new Usuario()
		usuarioLuis.nombreDeUsuario = "luis"
		usuarioLuis.nombreYApellido = "luis berterame"
		marDelPlataDestiny = new Destiny
		marDelPlataDestiny.nombre = "Mar del plata"
		barilocheDestiny = new Destiny
		barilocheDestiny.nombre = "bariloche"
		bahiaBlancaDestiny = new Destiny
		bahiaBlancaDestiny.nombre = "bahia blanca"
		likePepe = new Like("pepe")
		dislikePepe = new Dislike("pepe")
		queFrio = new Comment("que frio")
		queCalor = new Comment("que calor")
		queAburrido = new Comment("que aburrido")
		visibilityPublico = Visibility.PUBLICO
		visibilityAmigos = Visibility.AMIGOS
		visibilityPrivado = Visibility.PRIVADO		
	}
	 
	@Test
	def void verPerfil() {
		service.addPerfil(usuarioPepe)
		var perfilPepeMongo = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepeMongo.username, "usuarioPepe")
		var perfilPepeCache = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepeCache.username, "usuarioPepe")
	}
		 
	@Test
	def void addDestinyTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)					
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")
	}
	    
	@Test
	def void addCommentTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).description, "que frio")
	}
	
	 
	@Test
	def void addLikeTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addlike(usuarioPepe, marDelPlataDestiny, likePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.get(0).username, "usuarioPepe")
	}
	 
	
	@Test
	def void addDislikeTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDislike(usuarioPepe, marDelPlataDestiny, dislikePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.get(0).username, "usuarioPepe")
	}
	  
	   
	@Test
	def void addVisibilityDestinyTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PUBLICO")
	}
	
	@Test
	def void addVisibilityCommentTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearYoMismoTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.stalkear(usuarioPepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PRIVADO")
	}
	   
	@Test
	def void stalkearNoAmigoConDestinoMarDelPlataPublicoTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		socialService.agregarPersona(usuarioNoAmigoDePepe)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioNoAmigoDePepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioNoAmigoDePepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")
	}
	
	@Test
	def void stalkearNoAmigoConDestinoBarilochePrivadoTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresBariloche, usuarioPepe, tramo, asiento1)
		socialService.agregarPersona(usuarioNoAmigoDePepe)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioNoAmigoDePepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, barilocheDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, barilocheDestiny, visibilityPrivado, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioNoAmigoDePepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.size, 0)
	}
	
	@Test
	def void stalkearNoAmigoConDestinoBahiaBlancaAmigosTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresBahiaBlanca, usuarioPepe, tramo, asiento2)
		socialService.agregarPersona(usuarioNoAmigoDePepe)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioNoAmigoDePepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, bahiaBlancaDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, bahiaBlancaDestiny, visibilityAmigos, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioNoAmigoDePepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.size, 0)
	}
	
	
	@Test
	def void stalkearAmigoConDestinoMarDelPlataPublico() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresMarDelPlata, usuarioPepe, tramo, asiento0)
		socialService.agregarPersona(usuarioLuis)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioLuis)
		service.addPerfil(usuarioPepe)
		socialService.amigoDe(usuarioPepe, usuarioLuis)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioLuis, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")
	}
	
	@Test
	def void stalkearAmigoConDestinoBarilochePrivadoTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresBariloche, usuarioPepe, tramo, asiento1)
		socialService.agregarPersona(usuarioLuis)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioLuis)
		service.addPerfil(usuarioPepe)
		socialService.amigoDe(usuarioPepe, usuarioLuis)
		service.addDestiny(usuarioPepe, barilocheDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, barilocheDestiny, visibilityPrivado, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioLuis, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.size, 0)
	}
	
	@Test
	def void stalkearAmigoConDestinoBahiaBlancaAmigosTest() {
		reservaService.guardar(tramo)
		reservaService.comprarReserva(reservaBuenosAiresBahiaBlanca, usuarioPepe, tramo, asiento2)
		socialService.agregarPersona(usuarioLuis)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioLuis)
		service.addPerfil(usuarioPepe)
		socialService.amigoDe(usuarioPepe, usuarioLuis)
		service.addDestiny(usuarioPepe, bahiaBlancaDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, bahiaBlancaDestiny, visibilityAmigos, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioLuis, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "bahia blanca")
	}
	
	@After
	def void cleanDB() {
		cacheService.deleteTable
		cacheService.deleteKeyspace
		home.mongoCollection.drop
		baseHome.hqlTruncate('compra')
       	baseHome.hqlTruncate('reserva')
       	baseHome.hqlTruncate('tramo')
        baseHome.hqlTruncate('asiento')
        baseHome.hqlTruncate('usuario')		
	}	
}