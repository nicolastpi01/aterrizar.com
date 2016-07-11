package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Reserva
import org.hibernate.Query
import java.util.List
import ar.edu.unq.epers.aterrizar.home.ReservaHome

class ReservaService extends BaseService {
	
     
    def List<Reserva> todasReservasValidas() {
        SessionManager.runInSession([
        return new ReservaHome().todasReservasValidas()
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
}