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
import java.util.List

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
	BaseHome homeBase
	Asiento asiento
	Tramo tramo
	
	/*  Hibernate   */
	 
    var Usuario user
    var TramoService serviceTramo
    var BaseService servicioBase = new BaseService
	var AsientoService asientoService = new AsientoService
    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Asiento asiento4
    Asiento asiento5
    Asiento asiento6
    Asiento asiento7
    Tramo tramo3
    Tramo tramo4
    Tramo tramo5
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
        
        tramo4 = new Tramo => [

            origen = "Brasil"
            destino = "bahia blanca"
            llegada = new Date(1000)
            salida = new Date(116,6,16)
            
            asientos = #[
                asiento4 = new Asiento => [
                    nombre = "c 4"
                    categoria = new Business(500)
                ],
                asiento5 = new Asiento => [
                    nombre = "c 5"
                    categoria = new Business(500)
                ]
            ]
        ]
        
        
        tramo5 = new Tramo => [

            origen = "Brasil"
            destino = "bariloche"
            llegada = new Date(1000)
            salida = new Date(116,6,16)
            
            asientos = #[
                asiento6 = new Asiento => [
                    nombre = "c 6"
                    categoria = new Business(500)
                ],
                asiento7 = new Asiento => [
                    nombre = "c 7"
                    categoria = new Business(500)
                ]
            ]
        ]
        
        vuelo1 = new VueloOfertado (#[new Tramo("Paris", "Italia"),tramo], 1000)
        vuelo2 = new VueloOfertado (#[tramo3, new Tramo("Mexico", "España")] ,2500)
        vuelo3 = new VueloOfertado (#[tramo4, tramo5],2000)
        vuelo4 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela")] ,800)
        vuelo5 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela"), new Tramo("Venezuela", "Peru")] , 8800)
        servicioBase.guardar(vuelo1)
        servicioBase.guardar(vuelo3)					

    }
	/*
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
		usuarioPepe.nombreYApellido = "pepeGarcia"
		usuarioJuan = new Usuario
		usuarioJuan.nombreDeUsuario = "juan"
		usuarioNoAmigoDePepe = new Usuario
		usuarioNoAmigoDePepe.nombreDeUsuario = "usuarioNoAmigoDePepe"
		usuarioNoAmigoDePepe.nombreYApellido = "usuarioNoAmigoPepeDominguez"
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
		usuarioLuis.nombreYApellido = "luis berterame"
		queCalor = new Comment("que calor")
		queAburrido = new Comment("que aburrido")
		visibilityPublico = Visibility.PUBLICO
		visibilityAmigos = Visibility.AMIGOS		
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
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		Assert.assertEquals(servicioBase.buscar(asiento1, asiento1.id).reservadoPorUsuario.nombreDeUsuario, usuarioPepe.nombreDeUsuario)
		Assert.assertEquals(servicioBase.buscar(asiento2, asiento2.id).reservadoPorUsuario.nombreDeUsuario, usuarioPepe.nombreDeUsuario)
		Assert.assertEquals(servicioBase.buscar(asiento3, asiento3.id).reservadoPorUsuario.nombreDeUsuario, usuarioPepe.nombreDeUsuario)					
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).nombre, "Mar del plata")
 
	}
	    
	@Test
	def void addCommentTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).description, "que frio")
	}
	
	 
	@Test
	def void addLikeTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addlike(usuarioPepe, marDelPlataDestiny, likePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).likes.get(0).username, "pepe")
	}
	 
	
	@Test
	def void addDislikeTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDislike(usuarioPepe, marDelPlataDestiny, dislikePepe, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.size, 1)
		Assert.assertEquals(perfilPepe.destinations.get(0).dislikes.get(0).username, "pepe")
	}
	  
	   
	@Test
	def void addVisibilityDestinyTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		var perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PUBLICO")
	}
	
	@Test
	def void addVisibilityCommentTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.verPerfil(usuarioPepe, Visibility.PUBLICO)
		Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearYoMismoTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioPepe)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPrivado, Visibility.PUBLICO)
		val perfilPepe = service.stalkear(usuarioPepe, usuarioPepe)
		Assert.assertEquals(perfilPepe.destinations.get(0).visibility.toString, "PRIVADO")
	}
	 
	  
	@Test
	def void stalkearNoAmigoTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioNoAmigoDePepe)
		val List<Asiento> listaAReservarDestinoBahia = #[asiento4,asiento5]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservarDestinoBahia, usuarioNoAmigoDePepe)
		val List<Asiento> listaAReservarDestinoBariloche = #[asiento6,asiento7]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservarDestinoBariloche, usuarioNoAmigoDePepe)
		socialService.agregarPersona(usuarioNoAmigoDePepe)
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioNoAmigoDePepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioNoAmigoDePepe, marDelPlataDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioNoAmigoDePepe, barilocheDestiny, Visibility.PUBLICO)
		service.addDestiny(usuarioNoAmigoDePepe, bahiaBlancaDestiny, Visibility.PUBLICO)
		service.addVisibility(usuarioNoAmigoDePepe, marDelPlataDestiny, visibilityPublico, Visibility.PUBLICO)
		service.addVisibility(usuarioNoAmigoDePepe, barilocheDestiny, visibilityPrivado, Visibility.PUBLICO)
		service.addVisibility(usuarioNoAmigoDePepe, bahiaBlancaDestiny, visibilityAmigos, Visibility.PUBLICO)
		var perfilNoAmigoPepe = service.stalkear(usuarioPepe, usuarioNoAmigoDePepe)
		Assert.assertEquals(perfilNoAmigoPepe.destinations.size, 1)
		Assert.assertEquals(perfilNoAmigoPepe.destinations.get(0).nombre, "Mar del plata")
	}
	
	@Test
	def void stalkearAmigoTest() {
		val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, usuarioLuis)
		val List<Asiento> listaAReservarDestinoBahia = #[asiento4,asiento5]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservarDestinoBahia, usuarioLuis)
		val List<Asiento> listaAReservarDestinoBariloche = #[asiento6,asiento7]						
		asientoService.reservarUnConjuntoDeAsientosParaUsuario(listaAReservarDestinoBariloche, usuarioLuis)
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
		Assert.assertEquals(perfilLuis.destinations.size, 2)
		Assert.assertEquals(perfilLuis.destinations.get(0).nombre, "Mar del plata")
		Assert.assertEquals(perfilLuis.destinations.get(1).nombre, "bariloche")
	}
	
	*/
	@After
	def void cleanDB() {
		cacheService.deleteTable
		cacheService.deleteKeyspace
		home.mongoCollection.drop
		homeBase.hqlTruncate("asiento")
        homeBase.hqlTruncate("criterioCompuesto")
        homeBase.hqlTruncate("ordenVacio")
        homeBase.hqlTruncate("MenorCosto")
        homeBase.hqlTruncate("MenorDuracion")
        homeBase.hqlTruncate("MenorCantidadDeEscalas")
        homeBase.hqlTruncate("busqueda")
        homeBase.hqlTruncate("criterioCompuesto")
        homeBase.hqlTruncate("criterioVacio")
        homeBase.hqlTruncate("criterioPorAerolinea")
        homeBase.hqlTruncate("criterioPorCategoriaDeAsiento")
        homeBase.hqlTruncate("criterioPorFechaDeLlegada")
        homeBase.hqlTruncate("criterioPorFechaDeSalida")
        homeBase.hqlTruncate("criterioPorOrigen")
        homeBase.hqlTruncate("criterioPorDestino")
        homeBase.hqlTruncate("primera")
        homeBase.hqlTruncate("turista")
        homeBase.hqlTruncate("business")
        homeBase.hqlTruncate("categoria")
        homeBase.hqlTruncate("criterio")
        homeBase.hqlTruncate("tramo")
        homeBase.hqlTruncate("usuario")
        homeBase.hqlTruncate("vueloOfertado")		
	}
}