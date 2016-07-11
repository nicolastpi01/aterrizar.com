package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Reserva
import java.util.List
import ar.edu.unq.epers.aterrizar.home.ReservaHome
import ar.edu.unq.epers.aterrizar.model.Compra
import ar.edu.unq.epers.aterrizar.exceptions.ImposibleComprarReservaException

class ReservaService extends BaseService {
	
	
	def List<Reserva> todasLasReservas() {
        SessionManager.runInSession([
        return new ReservaHome().todasLasReservas()
    ])
    }
     
    def List<Reserva> todasLasReservasValidas() {
        SessionManager.runInSession([
        return new ReservaHome().todasLasReservasValidas()
    ])
    }
    
    def List<Reserva> todasReservasValidasDeUsuario(Usuario u) {
        SessionManager.runInSession([
        return new ReservaHome().todasReservasValidasDeUsuario(u)
    ])
    }
    
    
    def esReservaValida(Reserva r) {
    	SessionManager.runInSession([
        return new ReservaHome().esReservaValida(r)
    ])
    }
    
    def comprarReserva(Reserva r, Usuario u) {
    	val reservaAux = buscar(r, r.id)
    	
    	if(esReservaValida(reservaAux) && reservaAux.user.nombreDeUsuario == u.nombreDeUsuario) {
    		
    		var compra = new Compra => [
            user = reservaAux.user
            asiento = reservaAux.asiento
            origenTramo = reservaAux.tramoOrigen
            destinoTramo = reservaAux.tramoDestino
            
            ]
            guardar(compra)
            eliminarReserva(reservaAux)
            return compra
    	}
    	else throw new ImposibleComprarReservaException
    }
    
    def eliminarReserva(Reserva r) {
    	SessionManager.runInSession([
        new ReservaHome().eliminarReserva(r)
        	null
    ])
    }   
}