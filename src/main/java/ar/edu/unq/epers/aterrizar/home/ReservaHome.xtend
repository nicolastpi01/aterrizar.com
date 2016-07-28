package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Reserva
import java.util.Calendar
import java.util.Date
import java.sql.Timestamp
import ar.edu.unq.epers.aterrizar.model.Usuario

class ReservaHome {
	
	def todasLasReservas() {
		var q = "from Reserva"
        var query = SessionManager.getSession().createQuery(q) as Query
        return query.list as List<Reserva>
	}
	
	def todasLasReservasValidas() {
	var chequeoFin = Calendar.getInstance()
	chequeoFin.setTime(new Date()) /* today */
	var fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) /* today */
	chequeoInicio.add(Calendar.MINUTE, -5) 
	var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where reservas.fechaReserva >=  :fechaChequeoInicio AND reservas.fechaReserva <= :fechaChequeoFin "
        var query = SessionManager.getSession().createQuery(q) as Query
		query.setParameter("fechaChequeoInicio", fechaChequeoInicio)
		query.setParameter("fechaChequeoFin", fechaChequeoFin)
        var reservas = query.list as List<Reserva>
        	return reservas	
    }
    
    
     
    def todasReservasValidasDeUsuario(Usuario usuario) {
    var chequeoFin = Calendar.getInstance()
	chequeoFin.setTime(new Date()) /* today */
	var fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) /* today */
	chequeoInicio.add(Calendar.MINUTE, -5) 
	var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where reservas.user.nombreDeUsuario = :username AND reservas.fechaReserva >=  :fechaChequeoInicio AND reservas.fechaReserva <= :fechaChequeoFin"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("username", usuario.nombreDeUsuario)
        query.setParameter("fechaChequeoInicio", fechaChequeoInicio)
		query.setParameter("fechaChequeoFin", fechaChequeoFin)
        var reservas = query.list as List<Reserva>
        	return reservas
        	
    }
    
    def esReservaValida(Reserva reserva, Usuario usuario) {
    var chequeoFin = Calendar.getInstance()
	chequeoFin.setTime(new Date()) /* today */
	var fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) /* today */
	chequeoInicio.add(Calendar.MINUTE, -5) 
	var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where reservas.id = :id AND reservas.user.nombreDeUsuario = :username AND reservas.fechaReserva >=  :fechaChequeoInicio AND reservas.fechaReserva <= :fechaChequeoFin"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("id", reserva.id.toString)
        query.setString("username", usuario.nombreDeUsuario)
        query.setParameter("fechaChequeoInicio", fechaChequeoInicio)
		query.setParameter("fechaChequeoFin", fechaChequeoFin)
        var reservas = query.list as List<Reserva>
        	return reservas.size == 1
        	
    }
    
    def eliminarReserva(Reserva r) {
        SessionManager.getSession().delete(r)
    }
    
}