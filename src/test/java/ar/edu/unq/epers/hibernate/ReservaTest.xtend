package ar.edu.unq.epers.hibernate

import org.junit.Before
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.servicios.ReservaService
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Tramo
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.aterrizar.home.ReservaHome
import ar.edu.unq.epers.aterrizar.servicios.BaseService
import java.sql.Date
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import org.hibernate.Session
import org.hibernate.SessionFactory
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.home.AsientoHome

class ReservaTest{
	BaseHome baseHome
	BaseService baseService
    Usuario user
    ReservaService service = new ReservaService
    ReservaHome reservaHome
    AsientoHome asientoHome

    SessionFactory sessionFactory
    Session session = null
    Asiento asiento
    Tramo tramo
    VueloOfertado vuelo
   
	 
	@Before
	def void setUp() {
		baseHome = new BaseHome
		service = new ReservaService
		baseService = new BaseService
		reservaHome = new ReservaHome
		asientoHome = new AsientoHome
		
        SessionManager::getSessionFactory().openSession()
        
        user = new Usuario => [
            nombreDeUsuario = "nicolas"
            nombreYApellido = "nicolas garcia"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(116,07,01)
            salida = new Date(1500)
            
            asiento = new Asiento => [
                    nombre = "asiento"
                    categoria = new Primera(1000)
                ]
            
            asientos = #[
                asiento
            ]
        ]

        vuelo = new VueloOfertado (#[new Tramo("Paris", "Italia"), tramo], 1000)
	}
	
	@Test
	def void hacerReservaTest() {
		
		baseService.guardar(asiento)
		baseService.guardar(user)
		service.hacerReserva(user, asiento)
		var reserva = asientoHome.buscarReservas()
		//Assert.assertEquals(reserva.asiento.nombre, "un asiento")
	}
	
	@After
    def void limpiar() {
   
        baseHome.hqlTruncate("asiento")
        baseHome.hqlTruncate("criterioCompuesto")
        baseHome.hqlTruncate("ordenVacio")
        baseHome.hqlTruncate("MenorCosto")
        baseHome.hqlTruncate("MenorDuracion")
        baseHome.hqlTruncate("MenorCantidadDeEscalas")
        baseHome.hqlTruncate("busqueda")
        baseHome.hqlTruncate("criterioCompuesto")
        baseHome.hqlTruncate("criterioVacio")
        baseHome.hqlTruncate("criterioPorAerolinea")
        baseHome.hqlTruncate("criterioPorCategoriaDeAsiento")
        baseHome.hqlTruncate("criterioPorFechaDeLlegada")
        baseHome.hqlTruncate("criterioPorFechaDeSalida")
        baseHome.hqlTruncate("criterioPorOrigen")
        baseHome.hqlTruncate("criterioPorDestino")
        baseHome.hqlTruncate("primera")
        baseHome.hqlTruncate("turista")
        baseHome.hqlTruncate("business")
        baseHome.hqlTruncate("categoria")
        baseHome.hqlTruncate("criterio")
        baseHome.hqlTruncate("tramo")
        baseHome.hqlTruncate("usuario")
        baseHome.hqlTruncate("vueloOfertado")
        
    }
	
}