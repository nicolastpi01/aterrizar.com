package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Reserva
import java.util.List
import ar.edu.unq.epers.aterrizar.home.ReservaHome
import ar.edu.unq.epers.aterrizar.model.Compra
import ar.edu.unq.epers.aterrizar.exceptions.ImposibleComprarReservaException
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.exceptions.ImposibleRealizarReservaException
import java.util.Date

class ReservaService extends BaseService {
	
	
	def List<Reserva> todasLasReservas() {
        SessionManager.runInSession([
        return new ReservaHome().todasLasReservas()
    ])
    }
    
    def hacerReserva(Tramo tramo, Usuario usuario, Asiento asiento) {
    	if(sePuedeRealizarReserva(tramo, asiento)) {
    		var reserva = new Reserva
    		reserva.user = usuario
    		reserva.asiento = asiento
    		reserva.tramoOrigen = tramo.origen
    		reserva.tramoDestino = tramo.destino
    		asiento.fechaReserva = new Date
    		asiento.user = usuario
        	tramo.agregarReserva(reserva)
        	guardar(asiento)
        	guardar(tramo)	
        		
        }
        else throw new ImposibleRealizarReservaException
    }
    
    // reserva los asientos que pueda, cuando no puede no reserva (pasa al sig)
    def hacerReservas(Tramo tramo, Usuario usuario, List<Asiento> asientos) {
    	for(Asiento asiento : asientos) {
    		if(sePuedeRealizarReserva(tramo, asiento)) hacerReserva(tramo, usuario, asiento)
    	}
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
    
    
    def esReservaValida(Reserva r, Usuario u, Tramo t, Asiento a) {
    	SessionManager.runInSession([
        return new ReservaHome().esReservaValida(r, u, t, a)
    ])
    }
    
    def sePuedeRealizarReserva(Tramo t, Asiento a) {
    	SessionManager.runInSession([
        return new ReservaHome().sePuedeRealizarReserva(t, a)
    ])
    }
    
    
    def comprarReserva(Reserva r, Usuario u, Tramo t, Asiento a) {
    	var compra = new Compra
    	if(esReservaValida(r, u, t, a)) {
    		compra = new Compra => [
            user = u
            asiento = a
            origenTramo = r.tramoOrigen
            destinoTramo = r.tramoDestino        
           	]
    	}
    	else throw new ImposibleComprarReservaException
    	t.agregarCompra(compra)
    	a.user = null
    	guardar(a)
    	guardar(t)
    	eliminarReserva(r)
    }
    
    def comprarReservas(List<Reserva> reservas, Usuario u, Tramo t, Asiento a) {
    	for(Reserva r : reservas) {
    		if(esReservaValida(r, u, t, a)) comprarReserva(r, u, t, a)
    	}
    }
    
    def private eliminarReserva(Reserva r) {
    	SessionManager.runInSession([
        new ReservaHome().eliminarReserva(r)
        		null
    ])
    }  
     
}