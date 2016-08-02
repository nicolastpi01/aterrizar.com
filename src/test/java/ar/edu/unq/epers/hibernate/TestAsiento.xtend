package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import java.sql.Date
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.model.Tramo
import java.util.Calendar
import java.util.ArrayList

class TestAsiento {
	AsientoService service
	BaseHome baseHome
	Tramo tramo
    Usuario usuario
    Asiento asientoNoReservadoDisponible
    Asiento asientoReservadoNoDisponible0
    Asiento asientoReservadoNoDisponible1
    Asiento asientoReservadoNoDisponible2
    Asiento asientoReservadoDisponible0
    Asiento asientoReservadoDisponible1
	
	
	@Before
	def void setUp() {
		service = new AsientoService
		baseHome = new BaseHome
		SessionManager::getSessionFactory().openSession()
		
		usuario = new Usuario => [
            nombreDeUsuario = "usuario"
            nombreYApellido = "usuario apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        asientoNoReservadoDisponible = new Asiento => [
        	nombre = "asientoNoReservado"
        	categoria = new Primera(1000)
        ]
                
        asientoReservadoNoDisponible0 = new Asiento => [
        	nombre = "asientoInvalido0"
        	categoria = new Primera(1000)
        	user = usuario
        	fechaReserva = new java.util.Date
        ]
                
        
        asientoReservadoNoDisponible1 = new Asiento => [
            nombre = "asientoInvalido1"
        	categoria = new Primera(1000)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -3)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoNoDisponible2 = new Asiento => [
            nombre = "asientoInvalido2"
        	categoria = new Primera(1000)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -4)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoDisponible0 = new Asiento => [
            nombre = "asientoValido0"
        	categoria = new Primera(1000)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -7)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoDisponible1 = new Asiento => [
            nombre = "asientoValido1"
        	categoria = new Primera(1000)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -10)
            fechaReserva = calendar.getTime
          
        ]
        
       
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(2000)
            salida = new Date(1500)
            reservas = new ArrayList
            compras = new ArrayList
            asientos = new ArrayList
        ]
        
        tramo.agregarAsiento(asientoReservadoNoDisponible0)
        tramo.agregarAsiento(asientoReservadoNoDisponible1)
        tramo.agregarAsiento(asientoReservadoNoDisponible2)
        tramo.agregarAsiento(asientoReservadoDisponible0)
        tramo.agregarAsiento(asientoReservadoDisponible1)
        tramo.agregarAsiento(asientoNoReservadoDisponible)
        
	}

	@Test
	def void asientosDisponiblesTest() {
		service.guardar(tramo)
		var asientos = service.asientosDisponibles(tramo)
		Assert.assertEquals(asientos.size, 3)
	}

    @After
    def void limpiar() {
        
        baseHome.hqlTruncate('asiento')
        baseHome.hqlTruncate('usuario')
        baseHome.hqlTruncate('tramo')

    }

}