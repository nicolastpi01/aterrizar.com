package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Reserva

class ReservaService extends BaseService {
	
	def void hacerReserva(Usuario user, Asiento asiento, Tramo tramo) {
    	SessionManager.runInSession([
    		var reserva = new Reserva
    		reserva.username = user.nombreDeUsuario
    		reserva.nombreAsiento = asiento.nombre
    		reserva.tramoOrigen = tramo.origen
    		reserva.tramoDestino = tramo.destino
    		//tramo.agregarReserva(reserva)
    		//guardar(tramo)
            guardar(reserva)
            null
        ])
    }
    
    def void reservasValidas(Tramo t) {
    	
    }
    
    def esReservaValida(Reserva r, Tramo t) {
    	
    }
}