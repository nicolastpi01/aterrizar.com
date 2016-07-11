package ar.edu.unq.epers.hibernate

import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.servicios.ReservaService
import org.junit.Assert
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.home.BaseHome
import org.junit.After
import java.sql.Date
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import org.hibernate.SessionFactory
import org.hibernate.Session
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.CompraService

class ReservaTest {
	
	ReservaService service
	Reserva reserva0
	Reserva reserva1
	Reserva reserva2
	BaseHome baseHome
	Tramo tramo
    Usuario usuario0
    CompraService serviceCompra
	
	
	@Before
	def void setUp() {
		service = new ReservaService
		serviceCompra = new CompraService
		baseHome = new BaseHome
		SessionManager::getSessionFactory().openSession()
		
		usuario0 = new Usuario => [
            nombreDeUsuario = "usuario0"
            nombreYApellido = "usuario0 apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
		
		reserva0 = new Reserva => [
            username = "usuario0"
            nombreAsiento = "asiento0"
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Brasil"
         
        ]
        
        reserva1 = new Reserva => [
            username = "usuario1"
            nombreAsiento = "asiento1"
            tramoOrigen = "Brasil"
            tramoDestino = "Paraguay"
           
        ]
        
        reserva2 = new Reserva => [
            username = "usuario2"
            nombreAsiento = "asiento2"
            tramoOrigen = "Paraguay"
            tramoDestino = "Mexico"
            
        ]
        
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(2000)
            salida = new Date(1500)
            reservas = #[reserva0, reserva1, reserva2]
            
        ]
	}
	
	
	@Test
	def void hacerReservaTest() {
		
		service.guardar(reserva0)
		service.guardar(reserva1)
		service.guardar(reserva2)
		var reserva0 = service.buscar(reserva0, reserva0.id)
		var reserva1 = service.buscar(reserva1, reserva1.id)
		var reserva2 = service.buscar(reserva2, reserva2.id)
		Assert.assertEquals(reserva0.username, "usuario0")
		Assert.assertEquals(reserva0.nombreAsiento, "asiento0")
		Assert.assertEquals(reserva0.tramoOrigen, "Buenos Aires")
		Assert.assertEquals(reserva0.tramoDestino, "Brasil")
		Assert.assertEquals(reserva1.username, "usuario1")
		Assert.assertEquals(reserva2.username, "usuario2")
	}
	
	@Test
	def void reservasValidasTest() {
		service.guardar(tramo)
		var reservasValidas = service.todasReservasValidas
		Assert.assertEquals(reservasValidas.size, 3)
	}
	
	@Test
	def void todasLasReservasDeUsuarioTest() {	
		service.guardar(tramo)
		var reservasDeUsuario = service.todasReservasValidasDeUsuario(usuario0)
		Assert.assertEquals(reservasDeUsuario.size, 1)
		Assert.assertEquals(reservasDeUsuario.get(0).username, "usuario0")
	}
	
	@Test
	def void esReservaValidaTest() {
		service.guardar(tramo)
		Assert.assertTrue(service.esReservaValida(reserva0))
	}
	
	@Test
	def void comprarReservaTest() {
		service.guardar(tramo)
		service.comprarReserva(reserva0, usuario0)
		var comprasUsuario0 = serviceCompra.todasLasComprasDeUsuario(usuario0)
		Assert.assertEquals(comprasUsuario0.size, 1)
	}
	
	@After
    def void limpiar() {
        baseHome.hqlTruncate('reserva')
        baseHome.hqlTruncate('tramo')
        baseHome.hqlTruncate('compra')
       
    }
	
}