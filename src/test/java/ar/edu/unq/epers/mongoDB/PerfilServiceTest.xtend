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
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.servicios.BaseService
import org.hibernate.SessionFactory
import org.hibernate.Session
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.sql.Date
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Business

class PerfilServiceTest {
	PerfilService service
	TramoService tramoService
	Home<Perfil> home
	CacheService cacheService
	CacheHome cacheHome
	CassandraServiceRunner cassandraRunner
	SocialNetworkingService socialService
	Usuario usuarioPepe
	Usuario usuarioJuan
	Usuario usuarioNoAmigoDePepe
	Destiny marDelPlataDestiny
	Comment queFrio
	Like likePepe
	Dislike dislikePepe
	Visibility visibilityPrivado
	Visibility visibilityPublico
	Visibility visibilityAmigos
	Usuario usuarioLuis
	Comment queCalor
	Comment queAburrido
	Destiny barilocheDestiny
	Destiny bahiaBlancaDestiny
	AsientoService asientoService
	BaseHome homeBase
	Asiento asiento
	Tramo tramo
	
		/*  Hibernate   */
	 
    var Usuario user
    var TramoService serviceTramo
    var AsientoService serviceAsiento
    var BaseService servicioBase = new BaseService

    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Tramo tramo3
    VueloOfertado vuelo1
    VueloOfertado vuelo2
    VueloOfertado vuelo3
    VueloOfertado vuelo4
    VueloOfertado vuelo5
	
		 def void setUpHibernate(){

        homeBase = new BaseHome()

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan1000"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        serviceTramo = new TramoService
        serviceAsiento = new AsientoService




        tramo = new Tramo => [

            origen = "Buenos Aires"
            destino = "Mar del plata"
            llegada = new Date(116,07,01)
            salida = new Date(1500)
            
            asiento1 = new Asiento => [
                    nombre = "c 1"
                    categoria = new Primera(1000)
                ]
               
            asiento2 =  new Asiento => [
                    nombre = "c 2"
                    categoria = new Primera(1000)
                ]

            asiento3 = new Asiento => [
                nombre = "c 3"
                categoria = new Primera(1000)
            ]

            asientos = #[
                asiento1,
                asiento2,
                asiento3
            ]
        ]


        tramo3 = new Tramo => [

            origen = "Brasil"
            destino = "Mexico"
            llegada = new Date(1000)
            salida = new Date(116,6,16)
            
            asientos = #[
                new Asiento => [
                    nombre = "c 1"
                    categoria = new Business(500)
                ],
                new Asiento => [
                    nombre = "c 2"
                    categoria = new Business(500)
                ]
            ]
        ]



        vuelo1 = new VueloOfertado (#[new Tramo("Paris", "Italia"),tramo], 1000)
        vuelo2 = new VueloOfertado (#[tramo3, new Tramo("Mexico", "España")] ,2500)
        vuelo3 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Grecia")],1600)
        vuelo4 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela")] ,800)
        vuelo5 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela"), new Tramo("Venezuela", "Peru")] , 8800)

    }
	
	@Before
	def void setUp() {
		
		this.setUpHibernate()
		home = DocumentsServiceRunner.instance().collection(Perfil)
		tramoService = new TramoService
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
		service = new PerfilService(home, socialService, cacheService, tramoService)
		usuarioPepe = new Usuario
		usuarioPepe.nombreDeUsuario = "pepe"
		usuarioJuan = new Usuario
		usuarioJuan.nombreDeUsuario = "juan"
		usuarioNoAmigoDePepe = new Usuario
		usuarioNoAmigoDePepe.nombreDeUsuario = "usuarioNoAmigoDePepe"
		marDelPlataDestiny = new Destiny
		marDelPlataDestiny.nombre = "Mar del plata"
		barilocheDestiny = new Destiny
		barilocheDestiny.nombre = "bariloche"
		bahiaBlancaDestiny = new Destiny
		bahiaBlancaDestiny.nombre = "bahia blanca"
		queFrio = new Comment("que frio")
		likePepe = new Like("pepe")
		dislikePepe = new Dislike("pepe")
		visibilityPrivado = Visibility.PRIVADO
		usuarioLuis = new Usuario()
		usuarioLuis.nombreDeUsuario = "luis"
		queCalor = new Comment("que calor")
		queAburrido = new Comment("que aburrido")
		visibilityPublico = Visibility.PUBLICO		
	}
	 
	@Test
	def void verPerfil() {
		service.addPerfil(usuarioPepe)
		var perfilPepeMongo = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepeMongo.username, "pepe")
		var perfilPepeCache = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepeCache.username, "pepe")
	}
	  
	@Test
	def void addDestinyTest() {
		//serviceAsiento.reservarAsientoParaUsuario(tramo.asientos.get(0), usuarioPepe)
		service.addPerfil(usuarioPepe)
		//asientoService.guardar(asiento)
		//asientoService.reservarAsientoParaUsuario(asiento, usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")	
	}
	    
	@Test
	def void addCommentTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).description, "que frio")
		service.addComment(usuarioPepe, marDelPlataDestiny, queCalor, Visibility.PUBLICO)
		perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 2)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(1).description, "que calor")
	}
	
	 
	@Test
	def void addLikeTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addlike(usuarioPepe, marDelPlataDestiny, likePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.get(0).username, "pepe")
		service.addlike(usuarioPepe, marDelPlataDestiny, likePepe, Visibility.PUBLICO)
		perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.get(0).username, "pepe")
	}
	 
	
	@Test
	def void addDislikeTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDislike(usuarioPepe, marDelPlataDestiny, dislikePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.get(0).username, "pepe")
		service.addDislike(usuarioPepe, marDelPlataDestiny, dislikePepe, Visibility.PUBLICO)
		perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.get(0).username, "pepe")
	}
	  
	   
	@Test
	def void addVisibilityDestinyTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PUBLICO")
	}
	
	@Test
	def void addVisibilityCommentTest() {
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearYoMismoTest() {
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.stalkear(usuarioPepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearNoAmigoTest() {
		socialService.agregarPersona(usuarioNoAmigoDePepe)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioNoAmigoDePepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioPepe, barilocheDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioPepe, bahiaBlancaDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, barilocheDestiny, visibilityPrivado, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, bahiaBlancaDestiny, visibilityAmigos, Visibility.PUBLICO)
		var perfilPepe = service.stalkear(usuarioNoAmigoDePepe, usuarioPepe)
		//Assert.assertEquals(perfilPepe.destinations.size, 1)
		//Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(perfilPepe.destinations.get(1).nombre, "bariloche")
	}
	
	@Test
	def void stalkearAmigoTest() {
		socialService.agregarPersona(usuarioPepe)
		socialService.agregarPersona(usuarioLuis)
		service.addPerfil(usuarioPepe)
		service.addPerfil(usuarioLuis)
		socialService.amigoDe(usuarioPepe, usuarioLuis)
		service.addDestiny(usuarioLuis, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioLuis, bahiaBlancaDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioLuis, barilocheDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioLuis, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		service.addVisibility(usuarioLuis, bahiaBlancaDestiny, visibilityPrivado, Visibility.PUBLICO)
		service.addVisibility(usuarioLuis, barilocheDestiny, visibilityAmigos, Visibility.PUBLICO)
		var perfilLuis = service.stalkear(usuarioPepe, usuarioLuis)
		//Assert.assertEquals(perfilLuis.destinations.size, 2)
		//Assert.assertEquals(perfilLuis.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(perfilLuis.destinations.get(1).nombre, "bariloche")
	}
	
	
	@After
	def void cleanDB(){
		cacheService.deleteTable
		cacheService.deleteKeyspace
		home.mongoCollection.drop		
	}
}