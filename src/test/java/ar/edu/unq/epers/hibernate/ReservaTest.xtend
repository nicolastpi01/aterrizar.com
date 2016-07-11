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
import ar.edu.unq.epers.aterrizar.model.Primera

class ReservaTest {
	
	ReservaService service
	Reserva reserva0
	Reserva reserva1
	Reserva reserva2
	BaseHome baseHome
	Tramo tramo
    Usuario usuario0
    Usuario usuario1
    Usuario usuario2
    Asiento asiento0
    Asiento asiento1
    Asiento asiento2
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
        
        usuario1 = new Usuario => [
            nombreDeUsuario = "usuario1"
            nombreYApellido = "usuario1 apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        usuario2 = new Usuario => [
            nombreDeUsuario = "usuario2"
            nombreYApellido = "usuario2 apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        asiento0 = new Asiento => [
                    nombre = "a0"
                    categoria = new Primera(1000)
                ]
                
        asiento1 = new Asiento => [
                    nombre = "a1"
                    categoria = new Primera(1000)
                ]
                
        asiento2 = new Asiento => [
                    nombre = "a2"
                    categoria = new Primera(1000)
                ]
		
		reserva0 = new Reserva => [
            user = usuario0
            asiento = asiento0
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Brasil"
         
        ]
        
        reserva1 = new Reserva => [
            user = usuario1
            asiento = asiento1
            tramoOrigen = "Brasil"
            tramoDestino = "Paraguay"
           
           
        ]
        
        reserva2 = new Reserva => [
            user = usuario2
            asiento = asiento2
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
		Assert.assertEquals(reserva0.user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(reserva0.asiento.nombre, "a0")
		Assert.assertEquals(reserva0.tramoOrigen, "Buenos Aires")
		Assert.assertEquals(reserva0.tramoDestino, "Brasil")
		Assert.assertEquals(reserva1.user.nombreDeUsuario, "usuario1")
		Assert.assertEquals(reserva2.user.nombreDeUsuario, "usuario2")
	}
	
	@Test
	def void reservasValidasTest() {
		service.guardar(tramo)
		var reservasValidas = service.todasLasReservasValidas
		Assert.assertEquals(reservasValidas.size, 3)
	}
	
	@Test
	def void todasLasReservasDeUsuarioTest() {	
		service.guardar(tramo)
		var reservasDeUsuario = service.todasReservasValidasDeUsuario(usuario0)
		Assert.assertEquals(reservasDeUsuario.size, 1)
		Assert.assertEquals(reservasDeUsuario.get(0).user.nombreDeUsuario, "usuario0")
	}
	
	@Test
	def void esReservaValidaTest() {
		service.guardar(tramo)
		Assert.assertTrue(service.esReservaValida(reserva0))
	}
	
	@Test
	def void comprarReservaTest() {
		service.guardar(tramo)
		var compraUsuario0 = service.comprarReserva(reserva0, usuario0)
		var comprasUsuario0Aux = service.buscar(compraUsuario0, compraUsuario0.id)
		Assert.assertEquals(comprasUsuario0Aux.user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(comprasUsuario0Aux.origenTramo, "Buenos Aires")
	}
	
	@Test
	def void eliminarReserva() {
		service.guardar(reserva0)
		Assert.assertEquals(service.todasLasReservas.size, 1)
		service.eliminarReserva(reserva0)
		Assert.assertEquals(service.todasLasReservas.size, 0)	
	}
	
	
	@After
    def void limpiar() {
        baseHome.hqlTruncate('reserva')
        baseHome.hqlTruncate('usuario')
        baseHome.hqlTruncate('tramo')
        baseHome.hqlTruncate('compra')
        baseHome.hqlTruncate('asiento')
       
    }
    
	
}