package ar.edu.unq.epers.hibernate

import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.servicios.ReservaService
import org.junit.Assert
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.home.BaseHome
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.CompraService
import ar.edu.unq.epers.aterrizar.model.Primera
import java.sql.Date
import java.util.Calendar
import java.util.ArrayList

class ReservaTest {
	
	ReservaService service
	Reserva reservaBuenosAiresBrasil
	Reserva reservaValida
	Reserva reservaValida2
	Reserva reservaInvalida
	Reserva reservaInvalida2
	BaseHome baseHome
	Tramo tramo
	Tramo tramoParaHacerReserva
    Usuario usuario0
    Usuario usuario1
    Usuario usuario2
    Asiento asiento0
    Asiento asiento1
    Asiento asientoReservable
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
        
        asientoReservable = new Asiento => [
        			nombre = "reservable"
        			categoria = new Primera(1000)
      			]
                
		
		reservaBuenosAiresBrasil = new Reserva => [
            user = usuario0
            asiento = asiento0
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Brasil"
         
        ]
        
        reservaInvalida = new Reserva => [
            user = usuario0
            asiento = asiento0
            tramoOrigen = "Mexico"
            tramoDestino = "EEUU"
            var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -10)
            fechaReserva = calendar.getTime
          
        ]
        
        reservaInvalida2 = new Reserva => [
            user = usuario0
            asiento = asiento0
            tramoOrigen = "Mexico"
            tramoDestino = "EEUU"
            var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -7)
            fechaReserva = calendar.getTime
          
        ]
        
        reservaValida = new Reserva => [
            user = usuario0
            asiento = asiento0
            tramoOrigen = "Mexico"
            tramoDestino = "EEUU"
            var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date()) 
			calendar.add(Calendar.MINUTE, -3)
            fechaReserva = calendar.getTime
          
        ]
        
        reservaValida2 = new Reserva => [
            user = usuario1
            asiento = asiento0
            tramoOrigen = "Mexico"
            tramoDestino = "EEUU"
            var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date()) 
			calendar.add(Calendar.MINUTE, -4)
            fechaReserva = calendar.getTime
          
        ]
        
        
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(2000)
            salida = new Date(1500)
            reservas = new ArrayList
            compras = new ArrayList
        ]
        
        tramo.agregarReserva(reservaBuenosAiresBrasil)
        tramo.agregarReserva(reservaInvalida)
        tramo.agregarReserva(reservaInvalida2)
        tramo.agregarReserva(reservaValida)
        tramo.agregarReserva(reservaValida2)
        
        tramoParaHacerReserva = new Tramo => [
        	origen = "Cataluñia"
        	destino = "Madrid"
        	llegada = new Date(2000)
            salida = new Date(1500)
            reservas = new ArrayList
        ]
	}
	
	
	@Test
	def void hacerReservaTest() {	
		service.guardar(tramoParaHacerReserva)
		service.hacerReserva(tramoParaHacerReserva, usuario0, asiento0)
		var reservas = service.todasLasReservas 
		Assert.assertEquals(reservas.size, 1)
		Assert.assertEquals(reservas.get(0).asiento.nombre, "a0")
		Assert.assertEquals(reservas.get(0).user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(reservas.get(0).tramoOrigen, "Cataluñia")
		Assert.assertEquals(reservas.get(0).tramoDestino, "Madrid")
		Assert.assertEquals(reservas.get(0).asiento.user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(reservas.get(0).asiento.fechaReserva.class, java.sql.Timestamp)
	
	}
	
	@Test(expected = Exception) 
	def void hacerReservaExceptionTest() {
		service.guardar(tramoParaHacerReserva)
		service.hacerReserva(tramoParaHacerReserva, usuario0, asiento0)
		service.hacerReserva(tramoParaHacerReserva, usuario0, asiento0)
	}
	
	@Test(expected = Exception) 
	def void hacerReservaOtroUsuarioExceptionTest() {
		service.guardar(tramoParaHacerReserva)
		service.hacerReserva(tramoParaHacerReserva, usuario0, asiento0)
		service.hacerReserva(tramoParaHacerReserva, usuario1, asiento0)
	}
	
	@Test
	def void hacerReservasTest() {
		service.guardar(tramoParaHacerReserva)
		service.hacerReserva(tramoParaHacerReserva, usuario0, asiento0)
		service.hacerReserva(tramoParaHacerReserva, usuario2, asiento1)
		var asientos = new ArrayList
		asientos.add(asiento0)
		asientos.add(asiento1)
		asientos.add(asientoReservable)
		service.hacerReservas(tramoParaHacerReserva, usuario1, asientos)
		var reservas = service.todasReservasValidasDeUsuario(usuario1) 
		Assert.assertEquals(reservas.size, 1)
	}
	
	
	@Test
	def void reservasValidasTest() {
		service.guardar(tramo)
		var reservasValidas = service.todasLasReservasValidas
		Assert.assertEquals(reservasValidas.size, 3)
	}
		 
	@Test
	def void todasLasReservasValidasDeUsuarioTest() {	
		service.guardar(tramo)
		var reservas = service.todasReservasValidasDeUsuario(usuario0)
		Assert.assertEquals(reservas.size, 2)
		Assert.assertEquals(reservas.get(0).user.nombreDeUsuario, "usuario0")
	}
	
	 
	@Test
	def void esReservaValidaTest() {
		service.guardar(tramo)
		Assert.assertTrue(service.esReservaValida(reservaBuenosAiresBrasil, usuario0, tramo, asiento0))
		Assert.assertFalse(service.esReservaValida(reservaInvalida, usuario0, tramo, asiento0))
	}
	
	
	@Test
	def void comprarReservaTest() {
		service.guardar(tramo)
		service.comprarReserva(reservaBuenosAiresBrasil, usuario0, tramo, asiento0)
		var compras = serviceCompra.todasLasCompras
		Assert.assertEquals(compras.size, 1)
		Assert.assertEquals(compras.get(0).user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(compras.get(0).asiento.nombre, "a0")
		Assert.assertEquals(compras.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(compras.get(0).destinoTramo, "Brasil")
		var reservasValidas = service.todasLasReservasValidas // Una reserva valida menos que antes
		Assert.assertEquals(reservasValidas.size, 2)
		Assert.assertEquals(asiento0.user, null)
		
	}
	
	@Test
	def void comprarReservasTest() {
		service.guardar(tramoParaHacerReserva)
		var asientos = new ArrayList
		asientos.add(asiento0)
		asientos.add(asiento1)
		asientos.add(asientoReservable)
		service.hacerReservas(tramoParaHacerReserva, usuario1, asientos)
		var reservas = service.todasReservasValidasDeUsuario(usuario1)
		service.comprarReservas(reservas, usuario1, tramoParaHacerReserva, asiento0)
		var compras = serviceCompra.todasLasCompras
		Assert.assertEquals(compras.size, 1)
	}
	
	
	@After
    def void limpiar() {
       
       	baseHome.hqlTruncate('compra')
       	baseHome.hqlTruncate('reserva')
       	baseHome.hqlTruncate('tramo')
        baseHome.hqlTruncate('asiento')
        baseHome.hqlTruncate('usuario')
          
    }
    
}