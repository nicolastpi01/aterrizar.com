package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Reserva
import java.util.Calendar
import java.util.Date
import java.sql.Timestamp
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento

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
    
    def sePuedeRealizarReserva(Tramo tramo, Asiento asiento) {
    var chequeoFin = Calendar.getInstance()
	chequeoFin.setTime(new Date()) 
	var fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) 
	chequeoInicio.add(Calendar.MINUTE, -5) 
	var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where tramo.id = :tramoId AND reservas.fechaReserva >=  :fechaChequeoInicio AND reservas.fechaReserva <= :fechaChequeoFin AND reservas.asiento.id = :asientoId "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("tramoId", tramo.id.toString)
        query.setString("asientoId", asiento.id.toString)
        query.setParameter("fechaChequeoInicio", fechaChequeoInicio)
		query.setParameter("fechaChequeoFin", fechaChequeoFin)
        var reservas = query.list as List<Reserva>
        	return reservas.size == 0
        	
    }
    
     
    
    def todasReservasValidasDeUsuario(Usuario usuario) {
    var chequeoFin = Calendar.getInstance()
	chequeoFin.setTime(new Date()) 
	var fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) 
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
    
    
    def esReservaValida(Reserva reserva, Usuario usuario, Tramo tramo, Asiento asiento) {
    var chequeoFin = Calendar.getInstance()
	chequeoFin.setTime(new Date()) 
	var fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) 
	chequeoInicio.add(Calendar.MINUTE, -5) 
	var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
    var q = "select reservas from Tramo tramo join tramo.reservas as reservas where tramo.id = :tramoId AND reservas.id = :id AND reservas.user.nombreDeUsuario = :username AND reservas.fechaReserva >=  :fechaChequeoInicio AND reservas.fechaReserva <= :fechaChequeoFin AND reservas.asiento.id = :asientoId "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("id", reserva.id.toString)
        query.setString("tramoId", tramo.id.toString)
        query.setString("asientoId", asiento.id.toString)
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