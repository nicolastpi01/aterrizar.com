package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.exceptions.ImposibleComprarReservaException
import ar.edu.unq.epers.aterrizar.model.Compra
import ar.edu.unq.epers.aterrizar.servicios.CompraService
import ar.edu.unq.epers.aterrizar.servicios.ReservaService

class ReservaHome {
	
	def todasReservasValidas() {
    var q = "from Reserva"
        var query = SessionManager.getSession().createQuery(q) as Query
        var reservasAux = query.list as List<Reserva>
        var reservas = reservasAux.filter[ reserva | !reserva.estaVencida].toList
        	return reservas	
    }
    
    def todasReservasValidasDeUsuario(Usuario usuario) {
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where reservas.username = :username"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("username", usuario.nombreDeUsuario)
        var reservasDeUsuario = query.list as List<Reserva>
        var reservas = reservasDeUsuario.filter[ reserva | !reserva.estaVencida].toList
        	return reservas
        	
    }
    
    def esReservaValida(Reserva reserva) {
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where reservas.id = :id"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("id", reserva.id.toString)
        var reservaAux = query.list as List<Reserva>
        	return !reservaAux.get(0).estaVencida
        	
    }
    
    def comprarReserva(Reserva reserva, Usuario u) {
    	if(esReservaValida(reserva) && reserva.username == u.nombreDeUsuario) {
    		var compra = new Compra => [
            username = "reserva.username"
            nombreAsiento = "reserva.nombreAsiento"
            origenTramo = "reserva.tramoOrigen"
            destinoTramo = "reserva.tramoDestino"
        ]
        	val compraService = new CompraService
        	compraService.guardar(compra)
        	val reservaService = new ReservaService
        	reservaService.eliminarReserva(reserva)
    	}
    	else throw new ImposibleComprarReservaException
    }
    
    def eliminarReserva(Reserva r) {
    	
    }
    
    
}