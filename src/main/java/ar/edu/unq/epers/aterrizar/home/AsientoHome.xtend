package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import java.util.Calendar
import java.util.Date
import java.sql.Timestamp

class AsientoHome {

    def List<Asiento> todosLosAsientos() {
        var q = "from Asiento"
        var query = SessionManager.getSession().createQuery(q) as Query
        return query.list
    }

    def borrarTodosLosAsientos() {
        this.borrarCategorias
        var q = "delete from Asiento "
        SessionManager.getSession().createQuery(q) as Query
    }

    def borrarCategorias() {
        var q = "delete from Categoria "
        SessionManager.getSession().createQuery(q) as Query
    }
    
    def List<Asiento> asientosDisponibles(Tramo tramo) {
	var chequeoInicio = Calendar.getInstance()
	chequeoInicio.setTime(new Date()) /* today */
	chequeoInicio.add(Calendar.MINUTE, -5) 
	var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
    var q = "select asientos from Tramo tramo join tramo.asientos as asientos where tramo.id = :tramoId AND asientos.fechaReserva < :fechaChequeoInicio OR asientos.user IS NULL) "
        var query = SessionManager.getSession().createQuery(q) as Query
		query.setParameter("fechaChequeoInicio", fechaChequeoInicio)
		query.setString("tramoId", tramo.id.toString)
        var asientos = query.list as List<Asiento>
        	return asientos
    }

}