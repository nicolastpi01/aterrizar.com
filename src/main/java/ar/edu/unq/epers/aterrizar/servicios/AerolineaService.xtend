package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Aerolinea
import ar.edu.unq.epers.aterrizar.home.TramoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Busqueda

/**
 * Created by damian on 4/18/16.
 */
class AerolineaService {

    def guardarAerolinea(Aerolinea a){
        SessionManager.runInSession([
            val tramoHome = new TramoHome()
            tramoHome.guardarAerolinea(a)
            Aerolinea
        ]);
    }

    def buscar(Busqueda busqueda){
        SessionManager.runInSession([
            val tramoHome = new TramoHome()
            tramoHome.buscarVuelos(busqueda.getHQL)
        ]);
    }

}