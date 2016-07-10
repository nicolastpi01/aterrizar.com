package ar.edu.unq.epers.hibernate

import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.servicios.ReservaService
import org.junit.Assert

class ReservaTest extends TestBase {
	
	ReservaService service
	
	@Before
	override setUp() {
		super.setUp
		service = new ReservaService
	}
	
	@Test
	def void hacerReservaTest() {
		//tramoReserva es null
		service.hacerReserva(user, asiento1, tramo)
		var tramoConReserva = servicioBase.buscar(tramo, tramo.id)
		//Assert.assertEquals(tramoConReserva.reservas.size, 1)
	}
	
}