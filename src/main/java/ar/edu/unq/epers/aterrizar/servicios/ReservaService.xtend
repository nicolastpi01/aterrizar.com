package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento

class ReservaService extends BaseService {
	
	/* 
	def void comprarReservaParaUsuario(Reserva reserva, Usuario user, Tramo tramo) {
        SessionManager.runInSession([
            reserva.comprar(user.nombreDeUsuario, tramo)
            guardar(reserva)
            guardar(tramo)
            null
        ]);
    }
    * 
    */
     
    def void hacerReserva(Usuario user, Asiento asiento) {
    	SessionManager.runInSession([
    		var Reserva reserva = new Reserva
    		reserva.username = user.nombreDeUsuario
    		reserva.nombreAsiento = asiento.nombre
            guardar(reserva)
            null
        ]);
    }
    
}