package ar.edu.unq.epers.aterrizar.home

import java.util.List
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import org.hibernate.Query
import java.util.Calendar
import java.util.Date
import java.sql.Timestamp

class BusquedaHome {
	
	
	def List<VueloOfertado> buscarVuelosDisponibles(Busqueda busqueda) {
		var chequeoInicio = Calendar.getInstance()
		chequeoInicio.setTime(new Date()) /* today */
		chequeoInicio.add(Calendar.MINUTE, -5) 
		var fechaChequeoInicio= new Timestamp(chequeoInicio.getTime().getTime())
		var q = "select distinct vuelo from Aerolinea aerolinea inner join aerolinea.vuelosOfertados as vuelo left outer join vuelo.tramos as tramo left outer join tramo.asientos as asiento " +  
               	busqueda.criterio.getHQL +
                "where" +
                busqueda.criterio.whereClause +
                "AND asiento.fechaReserva < :fechaChequeoInicio " +
                busqueda.orden.getOrderStatament
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setParameter("fechaChequeoInicio", fechaChequeoInicio)
        var vuelos = query.list as List<VueloOfertado>
        	return vuelos
	}
}