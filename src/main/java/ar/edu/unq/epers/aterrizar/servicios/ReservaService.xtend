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
    
    
    def esReservaValida(Reserva r, Usuario u) {
    	SessionManager.runInSession([
        return new ReservaHome().esReservaValida(r, u)
    ])
    }
    
    def comprarReserva(Reserva r, Usuario u) {
    	var compra = new Compra
    	if(esReservaValida(r, u)) {
    		compra = new Compra => [
            user = u
            asiento = r.asiento
            origenTramo = r.tramoOrigen
            destinoTramo = r.tramoDestino        
           	]
    	}
    	else throw new ImposibleComprarReservaException
    	guardar(compra)
    	eliminarReserva(r)
    }
    
    def eliminarReserva(Reserva r) {
    	SessionManager.runInSession([
        new ReservaHome().eliminarReserva(r)
        		null
    ])
    }  
     
}