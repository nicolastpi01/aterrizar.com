package ar.edu.unq.epers.hibernate

import org.junit.Before
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.servicios.ReservaService
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Tramo
import org.junit.Test

class ReservaTest {
	Reserva reserva
	ReservaService service
	Asiento asiento
	BaseHome homeBase
	Usuario usuario
	Tramo tramo
	
	
	@Before
	def void setUp() {
		service = new ReservaService
		homeBase = new BaseHome
		usuario = new Usuario
		usuario.nombreDeUsuario = "nicolas"
		usuario.nombreYApellido = "nicolas garcia"
		reserva = new Reserva
		reserva.asiento = asiento
		asiento = new Asiento
		tramo = new Tramo
		tramo.reservas = #[reserva]
			
	}
	
	@Test
	def void reservarReservaTest() {
		
	}
}