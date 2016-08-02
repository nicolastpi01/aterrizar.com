package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.BaseService
import java.util.List
import org.hibernate.Query


class TramoHome extends BaseService {

    def asientosDisponiblesEnTramo(Tramo t) {
        var q = "select asientos from Tramo tramo join tramo.asientos as asientos where asientos.reservadoPorUsuario = null"
        var query = SessionManager.getSession().createQuery(q) as Query

        query.list as List<Asiento>
    }
    /* 
    def getTramosConDestino(String nombreUsuario, String destino) {
		var q = "select asientos from Tramo tramo join tramo.asientos as asientos where asientos.reservadoPorUsuario != null and tramo.destino = :destino"
		
        var query = SessionManager.getSession().createQuery(q) as Query
		query.setString("destino", destino)
        var asientosNoNull = query.list as List<Asiento>
        
        var asientos = asientosNoNull.filter[ asiento | asiento.reservadoPorUsuario.nombreDeUsuario == nombreUsuario].toList
        
        return asientos
		
	}
	*/

}