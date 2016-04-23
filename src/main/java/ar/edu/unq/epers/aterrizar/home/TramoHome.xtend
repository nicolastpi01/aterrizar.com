package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Aerolinea
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import org.hibernate.Query
import ar.edu.unq.epers.aterrizar.model.Busqueda

/**
 * Created by damian on 4/16/16.
 */
class TramoHome {

    def guardarBusqueda(Busqueda b){
        SessionManager.getSession().saveOrUpdate(b)
    }

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

    def List<VueloOfertado> buscarVuelos(String hquery){
        var query = SessionManager.getSession().createQuery(hquery) as Query
        var List<VueloOfertado> list = query.list
        list
    }


    def guardarTramo(Tramo a) {
        SessionManager.getSession().saveOrUpdate(a)
    }

    def guardarAerolinea(Aerolinea a){
        SessionManager.getSession().saveOrUpdate(a)
    }

    def guardarVuelo(VueloOfertado vuelo){
        SessionManager.getSession().saveOrUpdate(vuelo)
    }


    def asientosDisponiblesEnTramo(Tramo t){
        var q = "select asientos from Tramo tramo join tramo.asientos as asientos where asientos.reservadoPorUsuario = null"
        var query = SessionManager.getSession().createQuery(q) as Query

        query.list as List<Asiento>

    }




}