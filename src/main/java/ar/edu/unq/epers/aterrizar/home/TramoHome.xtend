package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import java.util.List
import org.hibernate.Query

/**
 * Created by damian on 4/16/16.
 */
class TramoHome {

	def getTramo(int idTramo){
		var q = "from Tramo as tramo where tramo.id = :idTramo"
		var query = SessionManager.getSession().createQuery(q) as Query

		query.setInteger("idTramo", idTramo)
		var tramos = query.list
		if(tramos.size == 0)
			null
		else
			return tramos.get(0) as Tramo
	}

	def guardarTramo(Tramo a) {
		SessionManager.getSession().saveOrUpdate(a)
	}


	def asientosDisponiblesEnTramo(Tramo t){
		var q = "select tramo.asientos from Tramo tramo"
		var query = SessionManager.getSession().createQuery(q) as Query

		var asientos = query.list as List<Asiento>
		asientos.filter[asiento | !asiento.estaReservado]

	}




}