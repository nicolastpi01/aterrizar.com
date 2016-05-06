package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Aerolinea
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import org.hibernate.Query
import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.servicios.BaseService

/**
 * Created by damian on 4/16/16.
 */
class TramoHome extends BaseService {

    def List<VueloOfertado> buscarVuelos(String hquery){
        var query = SessionManager.getSession().createQuery(hquery) as Query
        var List<VueloOfertado> list = query.list
        list
    }

    def asientosDisponiblesEnTramo(Tramo t){
        var q = "select asientos from Tramo tramo join tramo.asientos as asientos where asientos.reservadoPorUsuario = null"
        var query = SessionManager.getSession().createQuery(q) as Query

        query.list as List<Asiento>

    }




}