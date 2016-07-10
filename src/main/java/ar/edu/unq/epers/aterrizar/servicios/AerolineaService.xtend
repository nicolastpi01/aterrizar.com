package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.TramoHome

class AerolineaService extends BaseService {

    def buscar(Busqueda busqueda) {
        SessionManager.runInSession([
            val tramoHome = new TramoHome()
            tramoHome.buscarVuelos(busqueda.getHQL)
        ])
    }

}