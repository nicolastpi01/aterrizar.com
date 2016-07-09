package ar.edu.unq.epers.aterrizar.home

import java.util.List
import ar.edu.unq.epers.aterrizar.model.Reserva
import org.hibernate.Query

class ReservaHome {
	
	
	def List<Reserva> buscarReservas() {
		//var q = "select asientos from Tramo tramo join tramo.asientos as asientos where asientos.reservadoPorUsuario = null"
		var q = "from Asiento"
        var query = SessionManager.getSession().createQuery(q) as Query
        var List<Reserva> reservas = query.list
        	return reservas
    }
}